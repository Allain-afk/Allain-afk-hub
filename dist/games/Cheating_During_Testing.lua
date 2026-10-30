-- ALLAIN-AFK HUB // CHEATING DURING TESTING GUARDED ENTRY
local BASE="https://raw.githubusercontent.com/Allain-afk/Allain-afk-hub/main/"

if game.PlaceId~=98894876188248 and game.GameId~=9780429221 then
    error("[ALLAIN-AFK HUB] This route is only for Cheating During Testing.",0)
end

local source=game:HttpGet(
    BASE.."dist/access-v2/payload-guard.lua?cdt="..tostring(os.time())..tostring(math.random(100000,999999)),
    true
)
local fn,err=loadstring(source,"@SerenityHub/PayloadGuard")
source=nil
if not fn then
    error("[ALLAIN-AFK HUB] Payload guard compile failed: "..tostring(err),0)
end
local run=fn()
return run("dist/runtime/games/Cheating_During_Testing.lua")
