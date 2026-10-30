-- ALLAIN-AFK HUB // +1 PHONK EVOLUTION ACCESS V2
-- Dedicated provider-fixed route based on the maintained Superhero Access V2 source.

local BASE="https://raw.githubusercontent.com/Allain-afk/Allain-afk-hub/main/"
local TEMPLATE=BASE.."dist/access-v2/superhero-provider-base.lua"

if not game:IsLoaded() then game.Loaded:Wait() end
if game.PlaceId~=104809044319701 and game.GameId~=10544327471 then error("[ALLAIN-AFK HUB] This route is only for +1 Phonk Evolution.",0) end

local url=TEMPLATE.."?phonk_provider_v1="..tostring(os.time())..tostring(math.random(100000,999999))
local ok,source=pcall(function() return game:HttpGet(url,true) end)
url=nil
if not ok or type(source)~="string" or source=="" then error("[ALLAIN-AFK HUB] Access V2 route is unavailable.",0) end

local function replaceExact(old,new,label)
    local p=string.find(source,old,1,true)
    if not p then error("[ALLAIN-AFK HUB] Phonk Evolution access template mismatch: "..tostring(label),0) end
    source=string.sub(source,1,p-1)..new..string.sub(source,p+#old)
end

replaceExact('local GAME_ENTRY=BASE.."dist/games/plus-1-superhero-evolution.lua"','local GAME_ENTRY=BASE.."dist/games/phonkevolution.lua"',"game entry")
replaceExact('local TARGET_PLACE=97824450589417','local TARGET_PLACE=104809044319701',"place id")
replaceExact('local TARGET_GAME=10577588270','local TARGET_GAME=10544327471',"game id")
replaceExact('[ALLAIN-AFK HUB] This route is only for +1 Superhero Evolution.','[ALLAIN-AFK HUB] This route is only for +1 Phonk Evolution.',"route message")
replaceExact('{name="Game",value="+1 Superhero Evolution",inline=true}','{name="Game",value="+1 Phonk Evolution",inline=true}',"webhook game")
replaceExact('[ALLAIN-AFK HUB] +1 Superhero Evolution payload is unavailable.','[ALLAIN-AFK HUB] +1 Phonk Evolution payload is unavailable.',"payload message")
replaceExact('"@Serenity/Games/Plus1SuperheroEvolution"','"@Serenity/Games/PhonkEvolution"',"payload chunk")
replaceExact('"@SerenityHub/AccessV2-Superhero-Direct"','"@SerenityHub/AccessV2-PhonkEvolution-Direct"',"access chunk")
replaceExact('https://lootdest.org/s?a51Wabb2','https://loot-link.com/s?jbyyXFuO',"LootLabs provider")

local fn,err=loadstring(source,"@SerenityHub/AccessV2-PhonkEvolution-ProviderV1")
source=nil
if not fn then error("[ALLAIN-AFK HUB] +1 Phonk Evolution Access V2 compile failed: "..tostring(err),0) end
return fn()
