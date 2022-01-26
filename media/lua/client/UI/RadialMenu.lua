if HSMUG.UI == nil then HSMUG.UI = {} end

function HSMUG.UI.GetKeycode(key)
    if key == "v" then
        return 47
    elseif key == "x" then
        return 45
    elseif key == "z" then
        return 44
    end
end

--Spawn Radial menu for Smugglers Crate
function HSMUG.UI.CrateRadialMenu(playerNum)

    local crateID = HSMUG.UI.GetNearestHSMUGCrate(playerNum)
    if crateID ~= nil then
        local menu = getPlayerRadialMenu(playerNum)
        menu:clear()
        menu:addSlice(getText("UI_Action"), getTexture("media/textures/Item_HeliSmugglersCrate.png"), HSMUG.UI
                .ClickTest, playerNum, crateID )
        menu:addToUIManager()
    end
end

function HSMUG.UI.ClickTest(playerNum, crateID)
    local playerObj = getSpecificPlayer(playerNum)
    local inv = playerObj:getInventory();

    --print(playerNum, crateID)
    local HSMUG_crate = HSMUG.UI.GetNearestHSMUGCrateByID(playerNum, crateID)

    if HSMUG_crate ~= nil then
        local HSMUG_crate_inventory = HSMUG_crate.inventory

        local itemIter = HSMUG_crate_inventory:getItems();
        local items = {};
        for i = 0, itemIter:size()-1 do
            local item = itemIter:get(i);

            playerObj:Say("There is a " .. item:getCategory() .. " here!")
            table.insert(items, item);
        end
        playerObj:Say("Let's put some AXE into this")
        HSMUG_crate_inventory:AddItem("Base.Axe");
    end
end

function HSMUG.UI.KeyPressedHandler(key)

    local playerNum = 0
    if HSMUG.UI.GetKeycode("x") == key then
        HSMUG.UI.CrateRadialMenu(playerNum)
    elseif HSMUG.UI.GetKeycode("z") == key then
        HSMUG.debug()
    end
end


---@public
---@param playerNum int
---@return int or nil
function HSMUG.UI.GetNearestHSMUGCrate(playerNum)

    local loot = getPlayerLoot(playerNum)

    for _,container in ipairs(loot.backpacks) do
        local inv = container.inventory
        if (inv:getType() == HSMUG.ContainerName) then
            return container.ID -- @todo ID is not UNIQUE!!! Need to find a workaround
        end
    end

    return nil

end

-- Get the Nearest HSMUG Crate by its ID
---@public
---@param playerNum int
---@return ItemContainer
function HSMUG.UI.GetNearestHSMUGCrateByID(playerNum, crateID)

    local loot = getPlayerLoot(playerNum)

    for _,container in ipairs(loot.backpacks) do
        if container.ID == crateID then
            local inv = container.inventory
            if (inv:getType() == HSMUG.ContainerName) then
                return container
            end
        end
    end

    return nil

end

Events.OnKeyPressed.Add(HSMUG.UI.KeyPressedHandler)
--Events.OnFillWorldObjectContextMenu.Add(HSMUG.UI.RadialMenu)