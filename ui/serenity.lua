-- ALLAIN-AFK HUB // SHARED UI COMPATIBILITY ALIAS
-- Canonical public library: dist/ui/serenity.lua

local URL = "https://raw.githubusercontent.com/Allain-afk/Allain-afk-hub/main/dist/ui/serenity.lua"

local source = game:HttpGet(
    URL .. "?compat=" .. tostring(os.time()),
    true
)

local chunk, compileError = loadstring(
    source,
    "@SerenityHub/dist/ui/serenity.lua"
)

if not chunk then
    error(
        "[ALLAIN-AFK HUB] Shared UI compatibility load failed: "
            .. tostring(compileError),
        0
    )
end

return chunk()
