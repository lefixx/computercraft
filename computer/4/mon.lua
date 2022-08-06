while true do
    shell.run("clear")
    cobbleDrawer = peripheral.wrap("storagedrawers:standard_drawers_4_1")
    kelpDrawer = peripheral.wrap("storagedrawers:standard_drawers_1_0")
    treeDrawer = peripheral.wrap("storagedrawers:standard_drawers_4_2")

    print(kelpDrawer.getItemDetail(2).displayName,kelpDrawer.list()[2].count)
    print(cobbleDrawer.getItemDetail(4).displayName ,cobbleDrawer.getItemDetail(4).count)
    print(treeDrawer.getItemDetail(2).displayName ,treeDrawer.getItemDetail(2).count)
    os.sleep(1)

end
