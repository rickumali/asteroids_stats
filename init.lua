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

	local function start()
		if (manager.machine.system.name ~= 'asteroid') then
			return
		end
		local message
		message = string.format(_p('plugin-asteroids_stats', 'ASTEROIDS: %s'), 'Stats Plugin On')
		emu.print_info(message)
		message = string.format(_p('plugin-asteroids_stats', 'ASTEROIDS: %s'), 'Stats Plugin On')
		manager.machine:popmessage(message)
	end

	local function stop()
		return
	end

	local function process_frame()
		if (manager.machine.system.name ~= 'asteroid') then
			return
		end
		local cpu = manager.machine.devices[":maincpu"]
		local space = cpu.spaces["program"]
		local numPlayers = space:read_u8(28)

		if numPlayers ~= 1 then
			numShips = 0
			numAsteroids = 0
			waveCount = 1
			return
		end

		local plyrDispTimer = space:read_u8(90)
		if plyrDispTimer ~=0 then
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

		local numAsteroidsCur = space:read_u8(758)
		if numAsteroids ~= numAsteroidsCur then
			emu.print_info("Wave: " .. waveCount .. " Asteroids: " .. numAsteroidsCur)
			numAsteroids = numAsteroidsCur
			if numAsteroidsCur == 0 then
				waveCount = waveCount + 1
				message = string.format(_p('plugin-asteroids_stats', 'ASTEROIDS: %s %d Next...'), 'Wave', waveCount)
				manager.machine:popmessage(message)
			end
		end
        end

	frame_subscription = emu.add_machine_frame_notifier(process_frame)
	emu.register_prestart(start)
	stop_subscription = emu.add_machine_stop_notifier(stop)
end

return exports
