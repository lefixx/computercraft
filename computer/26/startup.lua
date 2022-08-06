shell.run("clear")
drawer          = peripheral.wrap("storagedrawers:standard_drawers_4_14")
chute           = peripheral.wrap("create:chute_2")
purpleCutting   = peripheral.wrap("create:depot_23")
blueCutting     = peripheral.wrap("create:depot_24")
greenCutting    = peripheral.wrap("create:depot_25")
vacuum          = peripheral.wrap("thermal:device_collector_0")
purpleDeployer  = peripheral.wrap("create:deployer_5")
blueDeployer    = peripheral.wrap("create:deployer_6")
greenDeployer   = peripheral.wrap("create:deployer_7")
crushingWheel   = peripheral.wrap("create:crushing_wheel_controller_1")
enderDustChest  = peripheral.wrap("enderstorage:ender_chest_1")

function ender()
    while true do
        for i,v in pairs(vacuum.list()) do
            if v.name == "tconstruct:ender_slime_fern" then
                    purpleCutting.pullItems(peripheral.getName(vacuum),i,1)
            elseif v.name == "tconstruct:sky_slime_fern" then
                    blueCutting.pullItems(peripheral.getName(vacuum),i,1)
            elseif v.name == "tconstruct:earth_slime_fern" then
                    greenCutting.pullItems(peripheral.getName(vacuum),i,1)
            end
        end
    end
end

function countSlimyFerns()
    slimyFerns = {0,0,0}
    for i,v in pairs(vacuum.list()) do
        if v.name == "tconstruct:ender_slime_fern" then
            slimyFerns[1] = slimyFerns[1] + v.count
        elseif v.name == "tconstruct:sky_slime_fern" then
            slimyFerns[2] = slimyFerns[2] + v.count
        elseif v.name == "tconstruct:earth_slime_fern" then
            slimyFerns[3] = slimyFerns[3] + v.count
        end
    end
    return slimyFerns
end

function chuteDropper()
    while true do
        for i,v in pairs(vacuum.list()) do
            if v.name == "kubejs:ender_slimy_fern_leaf" then
                if countSlimyFerns()[1] >= 64 then
                    crushingWheel.pullItems(peripheral.getName(vacuum),i)
                else
                    chute.pullItems(peripheral.getName(vacuum),i)
                end
            end

            if v.name == "kubejs:sky_slimy_fern_leaf" then
                if countSlimyFerns()[2] >= 64 then
                    crushingWheel.pullItems(peripheral.getName(vacuum),i)
                else
                    chute.pullItems(peripheral.getName(vacuum),i)
                end
            end

            if v.name == "kubejs:earth_slimy_fern_leaf" then
                if countSlimyFerns()[3] >= 64 then
                    crushingWheel.pullItems(peripheral.getName(vacuum),i)
                else
                    chute.pullItems(peripheral.getName(vacuum),i)
                end
            end

            os.sleep(0.2)
        end
    end
end

function useBlends()
    while true do
        for i,v in pairs(vacuum.list()) do
            if v.name == "kubejs:ender_slime_fern_paste" then
                purpleDeployer.pullItems(peripheral.getName(vacuum),i)
            elseif v.name == "kubejs:sky_slime_fern_paste" then
                blueDeployer.pullItems(peripheral.getName(vacuum),i)
            elseif v.name == "kubejs:earth_slime_fern_paste" then
                greenDeployer.pullItems(peripheral.getName(vacuum),i)
            end
        end
        os.sleep(1)
    end
end

function storeProducts()
    while true do
        for i,v in pairs(vacuum.list()) do
            if v.name == "minecraft:bone_meal" then
                drawer.pullItems(peripheral.getName(vacuum),i,64,2)
            elseif v.name == "minecraft:gunpowder" then
                drawer.pullItems(peripheral.getName(vacuum),i,64,3)
            elseif v.name == "appliedenergistics2:ender_dust" then
                drawer.pullItems(peripheral.getName(vacuum),i,64,4)
            end
        end
        os.sleep(1)
    end
end

function emptyDepots()
    while true do
        if purpleCutting.list()[1] and purpleCutting.list()[1].name == "kubejs:ender_slimy_fern_leaf" then
            if countSlimyFerns()[1] <= 64 then
                purpleCutting.pushItems(peripheral.getName(chute),1,1)
            else
                purpleCutting.pushItems(peripheral.getName(crushingWheel),1,1)
            end
        end
        if blueCutting.list()[1] and blueCutting.list()[1].name == "kubejs:sky_slimy_fern_leaf" then
            if countSlimyFerns()[2] <= 64 then
                blueCutting.pushItems(peripheral.getName(chute),1,1)
            else
                blueCutting.pushItems(peripheral.getName(crushingWheel),1,1)
            end
        end
        if greenCutting.list()[1] and greenCutting.list()[1].name == "kubejs:earth_slimy_fern_leaf" then
            if countSlimyFerns()[3] <= 64 then
                greenCutting.pushItems(peripheral.getName(chute),1,1)
            else
                greenCutting.pushItems(peripheral.getName(crushingWheel),1,1)
            end
        end
    os.sleep(0.1)
    end
end

function moveEnderDustToChest()
    while true do 
        enderDustChest.pullItems(peripheral.getName(drawer),4)
    os.sleep(5)
    end
end

parallel.waitForAll(
    chuteDropper,
    ender,
    useBlends,
    storeProducts,
    emptyDepots,
    moveEnderDustToChest
)
