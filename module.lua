--// FUNCTIONS
local function Disconnect(self)
	table.remove( self.Signal.Callbacks, table.find( self.Signal.Callbacks, self.Callback) )
end
local function Connect(self,callback)
	self.Callbacks[ #self.Callbacks+1] = callback

	return {
		Signal = self,
		Callback = callback,

		Disconnect = Disconnect,
	}
end

local function Wait(self)
	local thread = coroutine.running()
	self.Waiting[ #self.Waiting+1] = thread

	coroutine.yield()

	return table.unpack( self.LastTriggedArgs)
end


--// MODULE
local EventSignalConstructor = {}


--// MODULE FUNCTIONS
function EventSignalConstructor:new()
	return {
		Waiting = {},
		Callbacks = {},

		Connect = Connect,
		Wait = Wait,
	}
end
function EventSignalConstructor:call(signal,...)
	signal.LastTriggedArgs = {...}

	for _,thread in next,signal.Waiting do
		coroutine.resume(thread)
	end
	signal.Waiting = {}
	signal.LastTriggedArgs = nil

	for _,callback in next,signal.Callbacks do
		callback(...)
	end
end


--// END
return EventSignalConstructor
