
import(".cocos.init")
local gamemodel = cc.import("#gamemodel")
local WorldCls = gamemodel.World
local WebSocketConnectBase = require("server.base.WebSocketConnectBase")
local WebSocketConnect = class("WebSocketConnect", WebSocketConnectBase)

function WebSocketConnect:ctor(config)
    WebSocketConnect.super.ctor(self, config)

    local mapFile = self.config.appRootPath .. "/maps/world_server.json"
    World = WorldCls.new(self)
    World:setMapPath(mapFile)
    World:initMapIf()
end

function WebSocketConnect:afterConnectReady()
    World:subscribeChannel()
end

function WebSocketConnect:beforeConnectClose()
    World:playerQuit()
    World:unsubscribeChannel()
    -- cleanup
    -- self.battle:quit()
end

return WebSocketConnect
