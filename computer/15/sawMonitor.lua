planksDrawer = peripheral.wrap("storagedrawers:standard_drawers_4_6")
logDrawer = peripheral.wrap("storagedrawers:standard_drawers_4_15")
saw = peripheral.wrap("create:saw_2")
depot = peripheral.wrap("create:depot_3")

shell.run("clear")
while true do
    if not planksDrawer.list()[2] or planksDrawer.list()[2].count <= 256 then
        --craft stripped logs
        print"crftn strpd lgs"
        saw.pullItems(peripheral.getName(logDrawer),2,1)
        os.sleep(0.8)
        planksDrawer.pullItems("create:depot_3",1)

    elseif not planksDrawer.list()[3] or planksDrawer.list()[3].count <= 256 then
        --craft planks
        print"crftng plnks"
        saw.pullItems("storagedrawers:standard_drawers_4_6",2,1)
        os.sleep(0.8)
        planksDrawer.pullItems("create:depot_3",1)

    elseif not planksDrawer.list()[4] or planksDrawer.list()[4].count<= 256 then
        --craft slabs
        print"crftng slbs"
        saw.pullItems("storagedrawers:standard_drawers_4_6",3,1)
        os.sleep(1.5)
        planksDrawer.pullItems("create:depot_3",1)
    end

end
