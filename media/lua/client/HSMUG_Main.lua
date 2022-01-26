HSMUG = {}
HSMUG.version = "0.1"
HSMUG.author = "megastruktur"
HSMUG.modName = "HeliSmugglers"

HSMUG.ContainerName = "HeliSmugglersCrate"

function HSMUG.init()
    print("Mod Loaded: " .. HSMUG.modName .. " by " .. HSMUG.author .. " (v" .. HSMUG.version ..")");
end

function HSMUG.debug()

end

Events.OnGameBoot.Add(HSMUG.init)