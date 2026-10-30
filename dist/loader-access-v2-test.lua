-- ALLAIN-AFK HUB // ACCESS V2 ENTRY

-- One-time cleanup: only Allain-afk-Hub/.access is used by the current gate.
pcall(function()
    if type(delfile)=="function" and type(isfile)=="function"
        and isfile("Allain-afk-Hub/.access-v2.dat") then
        delfile("Allain-afk-Hub/.access-v2.dat")
    end
end)

local U="https://raw.githubusercontent.com/Allain-afk/Allain-afk-hub/main/dist/access-v2/core.lua"
local source=game:HttpGet(
    U.."?v=20260824-dynamic-key-v2-i&cb="..tostring(os.time())..tostring(math.random(100000,999999)),
    true
)
local fn,err=loadstring(source,"@SerenityHub/AccessV2")
source=nil
if not fn then
    error("[ALLAIN-AFK HUB] Access V2 entry compile failed: "..tostring(err),0)
end
return fn()
