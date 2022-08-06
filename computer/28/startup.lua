-- basin = peripheral.wrap("create:basin_17")
-- basinS = peripheral.getName(basin)
singularityDrawer = peripheral.wrap("storagedrawers:standard_drawers_1_16")
singularity = "appliedenergistics2:singularity"
enderDrawer = peripheral.wrap("storagedrawers:standard_drawers_4_14")
ender = "appliedenergistics2:ender_dust"

function craftSingularity()
    enderDrawer.pushItems("create:chute_3",4,1)
    os.sleep(0.5)
    singularityDrawer.pushItems("create:chute_3",2,1)
    turtle.select(1)
    turtle.drop(1)
    turtle.select(2)
    turtle.drop(1)
    os.sleep(0.1)
    redstone.setOutput("left",true)
    os.sleep(0.5)
    redstone.setOutput("left",false)
    redstone.setOutput("right",true)
    os.sleep(0.1)
    redstone.setOutput("right",false)
end

while true do

    if singularityDrawer.list()[2] and singularityDrawer.list()[2].name == singularity then
        if enderDrawer.list()[4] and enderDrawer.list()[4].name == ender then
            craftSingularity()
        end
    end

    os.sleep(1)
end
