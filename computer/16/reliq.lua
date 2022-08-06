storage = peripheral.wrap("left")
trader = peripheral.wrap("back")

local stuff = {
    {"xreliquary:zombie_heart",      0, "zombieheart",  10, "thermal:silver_coin", "kubejs:trade_card_"},
    {"xreliquary:catalyzing_gland",  3, "creepr heart", 48, "thermal:silver_coin", "kubejs:trade_card_catalyzing_gland"},
    {"xreliquary:chelicerae",        1, "chelicerae",   10, "thermal:silver_coin", "kubejs:trade_card_"},
    {"xreliquary:slime_pearl",       3, "slime pearl",  48, "thermal:silver_coin", "kubejs:trade_card_slime_pearl"},
    {"xreliquary:bat_wing",          2, "bat_wing",     2,  "thermal:gold_coin",   "kubejs:trade_card_bat_wing"},
    {"xreliquary:molten_core",       1, "molten_core",  48, "thermal:silver_coin", "kubejs:trade_card_molten_core"},
    {"xreliquary:eye_of_the_storm",  1, "eye",          2,  "thermal:gold_coin",   "kubejs:trade_card_eye_of_the_storm"},
    {"xreliquary:nebulous_heart",    2, "nebulous",     1,  "thermal:gold_coin", "kubejs:trade_card_nebulous_heart"},

}

local cardToEquip = "kubejs:trade_card_"

function inv(tofind)
    local count = 0
    for i, v in pairs(storage.list()) do
        if v.name == tofind then
            count = count + storage.list()[i].count
        end
    end
    return count
end

function equip(card)
    print("looking for card")
    for i,v in pairs(storage.list()) do
        if v.name == card then
            print"card found"
            trader.pullItems("left",i)
            return
        end
    end
    error"CARD NOT FOUND"
end

function pay(coins, coinType)
    for i = 1,coins do
        for i,v in pairs(storage.list()) do
            if v.name == coinType then
                trader.pullItems("left",i,1)
                break
            end
        end
    end
    if not trader.list()[1] or trader.list()[1].count ~= coins then error"Money error" end
end

function buy(thing,amount)
    trader.pushItems("left",2) -- unequip previus card

    for i,v in pairs(stuff) do
        if v[1] == thing then
            print("using", v[6])
            cardToEquip = v[6]
            pay(v[4],v[5])
        end
    end
    equip(cardToEquip)
    os.sleep(3)
    if trader.pushItems("left",3) == true then print "success" end
    trader.pushItems("left",2)
    trader.pushItems("left",1)

end




print"start"
shell.run("clear")
print("moneys:",inv("thermal:silver_coin"))

for i,v in pairs(stuff) do
    print(v[3],inv(v[1]),"/",v[2])
end

for i,v in pairs(stuff) do
    if inv(v[1]) < v[2] then
        print("buying",(v[2])-inv(v[1]),v[3])
        buy(v[1],(v[2])-inv(v[1]))
    end
end
