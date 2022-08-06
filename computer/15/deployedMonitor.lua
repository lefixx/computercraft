andesiteDrawer = peripheral.wrap("storagedrawers:standard_drawers_4_10")
depot          = peripheral.wrap("create:depot_5")
deployer       = peripheral.wrap("create:deployer_0")
planksDrawer   = peripheral.wrap("storagedrawers:standard_drawers_4_6")
mechDrawer     = peripheral.wrap("storagedrawers:standard_drawers_1_1")


function clear()
    deployer.pushItems("storagedrawers:standard_drawers_4_10",1)
    deployer.pushItems("storagedrawers:standard_drawers_4_6",1)
    depot.pushItems("storagedrawers:standard_drawers_4_10",1)
    depot.pushItems("storagedrawers:standard_drawers_4_6",1)
end

while true do
    shell.run("clear")
    clear()
    print("start")
    print"slab"

    if not depot.list()[1] then -- if depot is empy
        if andesiteDrawer.list()[4] and andesiteDrawer.list()[4].count >= 2 then -- if there is andesites
            if planksDrawer.list()[4] then-- if there is a planks
                if planksDrawer.list()[5] then -- if there is a saw
                    depot.pullItems("storagedrawers:standard_drawers_4_6",4,1)
                    print"andesites"
                    deployer.pullItems("storagedrawers:standard_drawers_4_10",4,2)
                    os.sleep(1.3)

                    print"saw"
                    deployer.pullItems("storagedrawers:standard_drawers_4_6",5,1)
                    os.sleep(1)

                    deployer.pushItems("storagedrawers:standard_drawers_4_6",1)
                    -- os.sleep(0.5)
                    depot.pushItems("storagedrawers:standard_drawers_1_1",1)
                end
            end
        end
    elseif depot.list()[1].name == "kubejs:incomplete_kinetic_mechanism" then
        print"incomplete"
        if not deployer.list()[1] then -- if deployer is not empty
            if not (depot.getItemDetail(1).durability < 0.34) then -- if mechanism only needs saawing
                print"andesite"
                deployer.pullItems("storagedrawers:standard_drawers_4_10",4,1)
                os.sleep(1.5)
                andesiteDrawer.pullItems("create:deployer_0",1)
            end
            print"saw"
            if deployer.pushItems(peripheral.getName(andesiteDrawer),1) == 0 and deployer.list()[1] then print"TOO MUCH ANDESITE" end
            deployer.pullItems("storagedrawers:standard_drawers_4_6",5,1)
            os.sleep(1)
            planksDrawer.pullItems("create:deployer_0",1)
            depot.pushItems("storagedrawers:standard_drawers_1_1",1)
        end
    elseif depot.list()[1].name == "kubejs:kinetic_mechanism" then
        depot.pushItems("storagedrawers:standard_drawers_1_1",1)
    end --if depot is not empty
    print"loop"
    -- os.sleep(1)
end
