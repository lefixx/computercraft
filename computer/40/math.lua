print("-=math=-")


first  = peripheral.wrap("create:mechanical_crafter_19")
second = peripheral.wrap("create:mechanical_crafter_20")
third  = peripheral.wrap("create:mechanical_crafter_21")

castingTables = { 
    peripheral.wrap("tconstruct:table_2"),
    peripheral.wrap("tconstruct:table_3"),
    peripheral.wrap("tconstruct:table_4"),
    peripheral.wrap("tconstruct:table_5"),
    peripheral.wrap("tconstruct:table_6"),
    peripheral.wrap("tconstruct:table_7")

}

function placeNumber(number,slot)
    for i,v in pairs(castingTables) do
        if castingTables[i].list()[2].name == number then
            print("found "..number)
            
        end
    end
end


placeNumber("kubejs:three")