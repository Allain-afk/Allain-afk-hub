-- ALLAIN-AFK HUB // CANONICAL PUBLIC LOADER
-- Keep this root file tiny and stable. It always pulls the newest router
-- with cache-busting so existing public loadstrings never need to change.

if not game:IsLoaded() then
    game.Loaded:Wait()
end

local BASE="https://raw.githubusercontent.com/Allain-afk/Allain-afk-hub/main/"
local isMM2=game.PlaceId==142823291 or game.GameId==66654135
local isStealASeed=game.PlaceId==122216176958450 or game.GameId==10764328008
local isLiftACube=game.PlaceId==109530157755211 or game.GameId==10759860151
local isStealAnAnimeEgg=game.PlaceId==76377501906469 or game.GameId==10747748563
local isBreakAndStealAnEgg=game.PlaceId==114326934417838 or game.GameId==10765288803
local isRideAPet=game.PlaceId==124216119978534 or game.GameId==10035204815
local isStrengthGrowArm=game.PlaceId==86259628805375 or game.GameId==10310999762
local isAnimeDice=game.PlaceId==113290951185459 or game.GameId==10708913337
local isLootToForge=game.PlaceId==118805555015549 or game.GameId==10684750879
local isLiftRockForEggs=game.PlaceId==76731343328034 or game.GameId==10768316438

if isMM2 or isStealASeed or isLiftACube or isStealAnAnimeEgg or isBreakAndStealAnEgg or isRideAPet or isStrengthGrowArm or isAnimeDice or isLootToForge or isLiftRockForEggs then
    local env=(type(getgenv)=="function" and getgenv()) or _G
    env.__SERENITY_PAYLOAD_AUTHORIZED=true
    _G.__SERENITY_PAYLOAD_AUTHORIZED=true
end

local target
local chunkName

if isMM2 then
    target="dist/runtime/games/MM2.lua"
    chunkName="@AllainAfkHub/Game-MM2"
elseif isStealASeed then
    target="dist/runtime/games/stealaseed.lua"
    chunkName="@AllainAfkHub/Game-StealASeed"
elseif isLiftACube then
    target="dist/runtime/games/liftacube.lua"
    chunkName="@AllainAfkHub/Game-LiftACube"
elseif isStealAnAnimeEgg then
    target="dist/runtime/games/StealAnAnimeEgg.lua"
    chunkName="@AllainAfkHub/Game-StealAnAnimeEgg"
elseif isBreakAndStealAnEgg then
    target="dist/runtime/games/breakandstealegg.lua"
    chunkName="@AllainAfkHub/Game-BreakAndStealAnEgg"
elseif isRideAPet then
    target="dist/runtime/games/rideapet.lua"
    chunkName="@AllainAfkHub/Game-RideAPet"
elseif isStrengthGrowArm then
    target="dist/runtime/games/+1strengthgrowarm.lua"
    chunkName="@AllainAfkHub/Game-StrengthGrowArm"
elseif isAnimeDice then
    target="dist/runtime/games/animedice.lua"
    chunkName="@AllainAfkHub/Game-AnimeDice"
elseif isLootToForge then
    target="dist/runtime/games/loottoforge.lua"
    chunkName="@AllainAfkHub/Game-LootToForge"
elseif isLiftRockForEggs then
    target="dist/runtime/games/LiftRockForEggs.lua"
    chunkName="@AllainAfkHub/Game-LiftRockForEggs"
else
    target="dist/loader.lua"
    chunkName="@AllainAfkHub/CurrentLoader"
end

local url=BASE..target.."?cb="..tostring(os.time())..tostring(math.random(100000,999999))

local ok,source=pcall(function()
    return game:HttpGet(url,true)
end)

if not ok or type(source)~="string" or source=="" then
    error("[ALLAIN-AFK HUB] Current loader is unavailable. Try again in a moment.",0)
end

local fn,err=loadstring(source,chunkName)
source=nil

if not fn then
    error("[ALLAIN-AFK HUB] Loader compile failed: "..tostring(err),0)
end

-- Suppress legacy Discord auto-copy in precompiled game payloads for now.
pcall(function()
    local env=(type(getgenv)=="function" and getgenv()) or _G
    env.__SERENITY_DISCORD_NOTICE_AT=os.time()+315360000
    env.__SERENITY_DISCORD_COPIED=true
end)

-- Run the selected Allain-afk Hub payload first.
local results=table.pack(fn())

-- Rebrand any UI labels and hide legacy Discord/Community cards created by precompiled game payloads.
pcall(function()
    local function rebrandLabel(inst)
        if inst:IsA("TextLabel") or inst:IsA("TextButton") then
            local t=inst.Text
            if type(t)=="string" then
                if t=="SERENITY HUB" then
                    inst.Text="ALLAIN-AFK HUB"
                elseif t:find("SERENITY",1,true) or t:find("Serenity",1,true) then
                    inst.Text=t:gsub("SERENITY HUB","ALLAIN-AFK HUB"):gsub("Serenity Hub","Allain-afk Hub"):gsub("SERENITY","ALLAIN-AFK HUB"):gsub("Serenity","Allain-afk Hub")
                end
                if t:find("discord.gg/",1,true) or t=="Copy Discord Link" or t=="Join Discord  ↗" then
                    local card=inst.Parent
                    if card and card:IsA("GuiObject") then card.Visible=false end
                end
            end
        end
    end
    local roots={game:GetService("CoreGui")}
    if type(gethui)=="function" then
        local okHui,hui=pcall(gethui)
        if okHui and hui then table.insert(roots,hui) end
    end
    local lp=game:GetService("Players").LocalPlayer
    if lp then
        local pg=lp:FindFirstChildOfClass("PlayerGui")
        if pg then table.insert(roots,pg) end
    end
    for _,root in ipairs(roots) do
        for _,desc in ipairs(root:GetDescendants()) do
            pcall(rebrandLabel,desc)
        end
    end
end)

-- Stop shared anti-AFK left by an earlier loader execution.
-- No idle handler or simulated input is started by this loader.
pcall(function()
    local env=(type(getgenv)=="function" and getgenv()) or _G
    local previous=env.__SERENITY_IDLE_RUNTIME
    if type(previous)=="table" then
        previous.Alive=false
        if previous.Connection then
            pcall(function() previous.Connection:Disconnect() end)
        end
    end
    local legacy=env.__SERENITY_IDLE_CONNECTION
    if legacy then pcall(function() legacy:Disconnect() end) end
    env.__SERENITY_IDLE_RUNTIME=nil
    env.__SERENITY_IDLE_CONNECTION=nil
end)

--[[ TODO: Uncomment and replace with your own Discord invite URL later.
-- Copy the community invite at most once every 24 hours.
-- This shares the same timestamp marker as the V3 UI, so one execution cannot copy twice.
pcall(function()
    local invite="https://discord.gg/YOUR_INVITE_HERE"
    local env=(type(getgenv)=="function" and getgenv()) or _G
    local now=os.time()
    local cooldown=24*60*60
    local marker="Allain-afk-Hub/discord-notice-at.txt"
    local last=tonumber(env.__SERENITY_DISCORD_NOTICE_AT) or 0

    if type(readfile)=="function" then
        local ok,value=pcall(readfile,marker)
        if ok then
            last=math.max(last,tonumber(value) or 0)
        end
    end

    if last>now then last=now end
    if now-last<cooldown then return end

    local copy=type(setclipboard)=="function" and setclipboard
        or type(toclipboard)=="function" and toclipboard
        or (type(syn)=="table" and type(syn.write_clipboard)=="function" and syn.write_clipboard)

    if not copy then return end

    local ok,result=pcall(copy,invite)
    if not ok or result==false then return end

    env.__SERENITY_DISCORD_COPIED=true
    env.__SERENITY_DISCORD_NOTICE_AT=now

    if type(writefile)=="function" then
        if type(makefolder)=="function" then pcall(makefolder,"Allain-afk-Hub") end
        pcall(writefile,marker,tostring(now))
    end
end)
]]

return table.unpack(results,1,results.n)
