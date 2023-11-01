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

	local menu_justify_idx = 0
	local menu_justify_sel
	local menu_justify = {
		{ ["label"] = "Left", ["arrows"] = "r", ["value"] = 'left' },
		{ ["label"] = "Right", ["arrows"] = "l", ["value"] = 'right' }
	}

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
			return
		end

		local plyrDispTimer = space:read_u8(90)
		if plyrDispTimer ~= 0 then
			return
		end

		local numShipsPlayer1 = space:read_u8(87)
		if numShipsPlayer1 == 0 then
			return
		end
		if numShips ~= numShipsPlayer1 then
			emu.print_info("Number of ships: " .. numShipsPlayer1)
			numShips = numShipsPlayer1
		end
		if start_wave_time == nil then
			start_wave_time = manager.machine.time
		end

		local numAsteroidsCur = space:read_u8(758)
		if numAsteroids ~= numAsteroidsCur then
			if numAsteroidsCur == 0 then
				local end_wave_time = manager.machine.time
				local elapsed = end_wave_time - start_wave_time
				local sec_elapsed = elapsed.seconds
				local msec_elapsed = (sec_elapsed * 1000) + elapsed.msec
				local msec_elapsed_str = string.format('%015d', msec_elapsed)
				local elapsed_str = string.format(
						'%02d:%02d:%02d.%03d',
						sec_elapsed // (60 * 60),
						(sec_elapsed // 60) % 60,
						sec_elapsed % 60,
						msec_elapsed % 1000)
				emu.print_info("Wave: " .. waveCount .. " Asteroids: DONE Elapsed: " .. elapsed_str)
				start_wave_time = nil
			else
				emu.print_info("Wave: " .. waveCount .. " Asteroids: " .. numAsteroidsCur)
			end
			numAsteroids = numAsteroidsCur
			if numAsteroidsCur == 0 then
				waveCount = waveCount + 1
				message = string.format(_p('plugin-asteroids_stats', 'ASTEROIDS: %s %d Next...'), 'Wave', waveCount)
				manager.machine:popmessage(message)
			end
		end
	end

	local function process_frame_done()
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
			local elapsed = cur_wave_time - start_wave_time
			local sec_elapsed = elapsed.seconds
			local msec_elapsed = (sec_elapsed * 1000) + elapsed.msec
			local msec_elapsed_str = string.format('%015d', msec_elapsed)
			local elapsed_str = string.format(
					'%02d:%02d',
					(sec_elapsed // 60) % 60,
					sec_elapsed % 60)
			stat_str = string.format(_p('plugin-asteroids_stats', 'WAVE %02d ASTEROIDS %02d ELAPSED %s'), waveCount, numAsteroids, elapsed_str)
		end
		manager.machine.render.ui_container:draw_text(menu_justify[menu_justify_sel]['value'], 0.96, stat_str, 0xf00cc00c)
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
