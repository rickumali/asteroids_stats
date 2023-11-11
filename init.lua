local exports = {
	name = 'asteroids_stats',
	version = '0.1.0',
	description = 'Asteroids Stats Plugin',
	license = 'BSD-3-Clause',
	author = { name = 'Rick Umali' } }

local asteroids_stats = exports
local frame_subscription, stop_subscription

function asteroids_stats.startplugin()
	local numShips = 0
	local numAsteroids = 0
	local waveCount = 1
	local numPlayers = 0
	local start_wave_time = nil
	local start_ship_time = nil
	local prevScore = 0
	local curScore = 0
	local flipScoreCount = 0
	local actualScore = 0
	local waves = {}
	local ships = {}

	local menu_justify_idx = 0
	local menu_justify_sel
	local menu_justify = {
		{ ["label"] = "Left", ["arrows"] = "r", ["value"] = 'left' },
		{ ["label"] = "Right", ["arrows"] = "l", ["value"] = 'right' }
	}

	local function elapsed_time_string(now, from)
		local elapsed = now - from
		local sec_elapsed = elapsed.seconds
		local msec_elapsed = (sec_elapsed * 1000) + elapsed.msec
		local msec_elapsed_str = string.format('%015d', msec_elapsed)
		return string.format(
				'%02d:%02d',
				(sec_elapsed // 60) % 60,
				sec_elapsed % 60)
	end

	local function get_settings_path()
		return manager.machine.options.entries.homepath:value():match('([^;]+)') .. '/asteroids_stats'
	end

	local function load_settings()
		-- try to open configuration file
		local cfgname = get_settings_path() .. '/plugin.cfg'
		local cfgfile = io.open(cfgname, 'r')
		if not cfgfile then
			return -- probably harmless, configuration just doesn't exist yet
		end

		-- parse settings as JSON
		local json = require('json')
		local settings = json.parse(cfgfile:read('a'))
		cfgfile:close()
		if not settings then
			emu.print_error(string.format('Error loading Asteroids Statistics settings: error parsing file "%s" as JSON', cfgname))
			return
		end

		if settings.justify == 'left' then
			menu_justify_sel = 1
		elseif settings.justify == 'right' then
			menu_justify_sel = 2
		else
			menu_justify_sel = 1
		end
	end

	local function save_settings()
		local path = get_settings_path()
		local attr = lfs.attributes(path)
		if not attr then
			lfs.mkdir(path)
		elseif attr.mode ~= 'directory' then
			emu.print_error(string.format('Error saving Asteroids Statistics settings: "%s" is not a directory', path))
			return
		end
		local json = require('json')
		local settings = { justify =  menu_justify[menu_justify_sel]['value'] }
		local data = json.stringify(settings, { indent = true })
		local cfgname = path .. '/plugin.cfg'
		local cfgfile = io.open(cfgname, 'w')
		if not cfgfile then
			emu.print_error(string.format('Error saving Asteroids Statistics settings: error opening file "%s" for writing', cfgname))
			return
		end
		cfgfile:write(data)
		cfgfile:close()
	end

	local function start()
		if (manager.machine.system.name ~= 'asteroid') then
			return
		end
		load_settings()
		local message
		message = string.format(_p('plugin-asteroids_stats', 'ASTEROIDS: %s'), 'Stats Plugin On')
		emu.print_info(message)
		message = string.format(_p('plugin-asteroids_stats', 'ASTEROIDS: %s'), 'Stats Plugin On')
		manager.machine:popmessage(message)
	end

	local function stop()
		save_settings()
		return
	end

	-- From @Luke100000 answer at https://stackoverflow.com/a/76108965/10030

	-- In a byte, this returns the leftmost nibble: XXXX----
	local function getFirstNibbleAsDecimal(num)
		return math.floor(num / 16)
	end

	-- In a byte, this returns the rightmost nibble: ----XXXX
	local function getSecondNibbleAsDecimal(num)
		return num % 16
	end

	local function getScore()
		local cpu = manager.machine.devices[":maincpu"]
		local space = cpu.spaces["program"]
		local bcd10_raw = space:read_u8(82)
		local bcd1000_raw = space:read_u8(83)
		local bcd10s = getFirstNibbleAsDecimal(bcd10_raw) * 10 + getSecondNibbleAsDecimal(bcd10_raw)
		local bcd1000s = getFirstNibbleAsDecimal(bcd1000_raw) * 10 + getSecondNibbleAsDecimal(bcd1000_raw)
		return (bcd1000s * 1000) + (bcd10s * 10)
	end

	local function process_frame()
		if (manager.machine.system.name ~= 'asteroid') then
			return
		end
		local cpu = manager.machine.devices[":maincpu"]
		local space = cpu.spaces["program"]
		numPlayers = space:read_u8(28)

		if numPlayers ~= 1 then
			numShips = 0
			numAsteroids = 0
			waveCount = 1
			start_wave_time = nil
			start_ship_time = nil
			prevScore = 0
			curScore = 0
			flipScoreCount = 0
			if actualScore ~= 0 then
				emu.print_info("Final Score: " .. actualScore)
			end
			actualScore = 0
			waves = {}
			table.insert(waves, { time = "0:00" })
			ships = {}
			table.insert(ships, { time = "0:00", score = 0})
			return
		end

		local plyrDispTimer = space:read_u8(90)
		if plyrDispTimer ~= 0 then
			return
		end

		local numAsteroidsCur = space:read_u8(758)
		if numAsteroids ~= numAsteroidsCur then
			if numAsteroidsCur == 0 then
				local end_wave_time = manager.machine.time
				local elapsed_str = elapsed_time_string(end_wave_time, start_wave_time)
				emu.print_info("Wave: " .. waveCount .. " Asteroids: DONE Elapsed: " .. elapsed_str)
				start_wave_time = nil
				table.insert(waves, { time = "0:00" })
			else
				emu.print_info("Wave: " .. waveCount .. " Asteroids: " .. numAsteroidsCur)
			end
			numAsteroids = numAsteroidsCur
			if numAsteroidsCur == 0 then
				local message
				waveCount = waveCount + 1
				message = string.format(_p('plugin-asteroids_stats', 'ASTEROIDS: %s %d Next...'), 'Wave', waveCount)
				manager.machine:popmessage(message)
			end
		end

		curScore = getScore()
		if curScore ~= prevScore then
			local diff = 0
			if prevScore > curScore then
				-- Machine flipped / Record for actual score
				flipScoreCount = flipScoreCount + 1
				diff = 100000 + curScore - prevScore
			else
				diff = curScore - prevScore
			end
			ships[#ships].score = ships[#ships].score + diff
			actualScore = curScore + (100000 * flipScoreCount)
			-- Do difference check here
			emu.print_info("Actual Score: " .. actualScore .. " Diff: " .. diff)
			prevScore = curScore
		end

		local numShipsPlayer1 = space:read_u8(87)
		if numShipsPlayer1 == 0 then
			return
		end

		if numShips ~= numShipsPlayer1 then
			emu.print_info("Number of ships changed: BEFORE: " .. numShips .. " AFTER: " .. numShipsPlayer1)
			if (numShips ~= 0) and (numShips > numShipsPlayer1) then
				start_ship_time = manager.machine.time
				table.insert(ships, { time = "0:00", score = "0"})
			end
			numShips = numShipsPlayer1
		else
			local end_ship_time = manager.machine.time
			local elapsed_str = elapsed_time_string(end_ship_time, start_ship_time)
			ships[#ships].time = elapsed_str
		end
		if start_wave_time == nil then
			start_wave_time = manager.machine.time
		end
		if start_ship_time == nil then
			start_ship_time = manager.machine.time
		end
	end

	local function draw_score_board()
		for i,s in ipairs(ships) do
			local ship_str
			if i ~= #ships then
				ship_str = string.format('Ship %d %s %d', i, s.time, s.score)
			else
				ship_str = string.format('Current %s %d', s.time, s.score)
			end
			manager.machine.render.ui_container:draw_text(0.67, i * 0.025, ship_str, 0xf00cc00c)
		end
		for i,w in ipairs(waves) do
			local wave_str
			if i ~= #waves  then
				wave_str = string.format('Wave %d %s', i, w.time)
			else
				wave_str = string.format('Current %s', w.time)
			end
			manager.machine.render.ui_container:draw_text(0.87, i * 0.025, wave_str, 0xf00cc00c)
		end
	end

	local function process_frame_done()
		local stat_str
		if (manager.machine.system.name ~= 'asteroid') then
			return
		end
		if numPlayers ~= 1 then
			return
		end
		if start_wave_time == nil then
			stat_str = string.format(_p('plugin-asteroids_stats', 'WAVE %02d ASTEROIDS %02d'), waveCount, numAsteroids)
		else
			local cur_wave_time = manager.machine.time
			local elapsed_str = elapsed_time_string(cur_wave_time, start_wave_time)
			stat_str = string.format(_p('plugin-asteroids_stats', 'WAVE %02d ASTEROIDS %02d ELAPSED %s'), waveCount, numAsteroids, elapsed_str)
			if #waves ~= 0 then
				waves[#waves] = { time = elapsed_str }
			end
		end
		manager.machine.render.ui_container:draw_text(menu_justify[menu_justify_sel]['value'], 0.96, stat_str, 0xf00cc00c)
		draw_score_board()
	end

	local function menu_callback(index, event)
		if index == menu_justify_idx then
			if event == 'select' then
				return true
			end
			if event == 'left' then
				menu_justify_sel = menu_justify_sel - 1
				if menu_justify_sel == 0 then
					menu_justify_sel = 1
				end
				return true
			end
			if event == 'right' then
				menu_justify_sel = menu_justify_sel + 1
				if menu_justify_sel == 3 then
					menu_justify_sel = 2
				end
				return true
			end
		end
		return false
	end

	local function menu_populate()
		local result = { }
		table.insert(result, { _p('plugin-asteroids_stats', 'Asteroids Statistics'), '', 'off' })
		table.insert(result, { '---', '', '' })
		table.insert(result, { _p('plugin-asteroids_stats', 'Stats HUD Position'), menu_justify[menu_justify_sel]['label'], menu_justify[menu_justify_sel]['arrows']})
		menu_justify_idx = #result
		return result
	end

	frame_subscription = emu.add_machine_frame_notifier(process_frame)
	emu.register_frame_done(process_frame_done)
	emu.register_prestart(start)
	stop_subscription = emu.add_machine_stop_notifier(stop)
	emu.register_menu(menu_callback, menu_populate, _p('plugin-asteroids_stats', 'Asteroids Statistics'))
end

return exports
