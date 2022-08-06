basin = peripheral.wrap("create:basin_23")
drawer = peripheral.wrap("storagedrawers:standard_drawers_2_6")
depot = peripheral.wrap("create:depot_32")


extractorNames = {
    "thermal:device_tree_extractor_58",
    "thermal:device_tree_extractor_59",
    "thermal:device_tree_extractor_56",
    "thermal:device_tree_extractor_57",
    "thermal:device_tree_extractor_54",
    "thermal:device_tree_extractor_55",
    "thermal:device_tree_extractor_52",
    "thermal:device_tree_extractor_53",
}

extractors = {
}


for i,v in pairs(extractorNames) do
    extractors[i] = peripheral.wrap(v)
end



while true do
    for i,v in pairs(extractors) do
        print(basin.pullFluid(extractorNames[i]))
    end

    print("from basin",drawer.pullItems(peripheral.getName(basin),10,64,2))
    print("to bake",depot.pullItems(peripheral.getName(drawer),2))
    print("baked",drawer.pullItems(peripheral.getName(depot),1,64,3))
    os.sleep(2)

end
