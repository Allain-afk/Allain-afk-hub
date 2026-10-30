-- ALLAIN-AFK HUB // SELL ORES GUARDED ENTRY
local BASE="https://raw.githubusercontent.com/Allain-afk/Allain-afk-hub/main/"

if game.PlaceId~=122572082932179 and game.GameId~=10336278580 then
    error("[ALLAIN-AFK HUB] This route is only for Sell Ores.",0)
end

local source=game:HttpGet(
    BASE.."dist/access-v2/payload-guard.lua?sell_ores="..tostring(os.time())..tostring(math.random(100000,999999)),
    true
)
local fn,err=loadstring(source,"@SerenityHub/PayloadGuard")
source=nil
if not fn then
    error("[ALLAIN-AFK HUB] Payload guard compile failed: "..tostring(err),0)
end
local run=fn()
return run("dist/runtime/games/sell_ores.lua")
