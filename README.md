# EventSignal
A module to create event signals on roblox

Author: El3ctrox\n
Created: 11/03/2020

--// EXAMPLE

    -- SCRIPT 1

    --// SERVICES
    local Players = game:GetService("Players")

    --// UTILS
    local EventSignal = require(EventSignal)

    --// MODULE
    local module = {
      PlayerJoined = EventSignal:new()
    }

    --// EVENT
    Players.PlayerAdded:Connect(function(player)

      EventSignal:call( module.PlayerJoined, player)
    end)
    
    -- SCRIPT 2
    local module = require(Module)
    
    local connection = module.PlayerJoined:Connect(function(player)
    
      print(player.Name,"joined the game")
    end)
    
    local firstPlayerJoined = module.PlayerJoined:Wait()
    connection:Disconnect()
