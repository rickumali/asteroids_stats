local exports = {
	name = 'asteroids_stats',
	version = '0.1.0',
	description = 'Asteroids Stats Plugin',
	license = 'BSD-3-Clause',
	author = { name = 'Rick Umali' } }

local asteroids_stats = exports
local frame_subscription, stop_subscription
local numShips = 0

function asteroids_stats.startplugin()

	local function start()
		local message
		message = string.format(_p('plugin-asteroids_stats', 'ASTEROIDS: %s'), 'Stats Plugin On')
		emu.print_info(message)
		message = string.format(_p('plugin-asteroids_stats', 'ASTEROIDS: %s'), 'Stats Plugin On')
		manager.machine:popmessage(message)
	end

	local function stop()
		return
	end

	local function process_frame_done()
		local cpu = manager.machine.devices[":maincpu"]
		local space = cpu.spaces["program"]
		local numShipsPlayer1 = space:read_u8(87)
		if numShips ~= numShipsPlayer1 then
			emu.print_info("Number of ships: " .. numShipsPlayer1)
			numShips = numShipsPlayer1
		end
        end

	frame_subscription = emu.add_machine_frame_notifier(process_frame_done)
	emu.register_prestart(start)
	stop_subscription = emu.add_machine_stop_notifier(stop)
end

return exports
