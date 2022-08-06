storage = peripheral.wrap("left")
trader = peripheral.wrap("back")


function pay(coins, coinType)
    if coinType == "thermal:silver_coin" then
        local count = 0
        for i = 1,coins do
            for i,v in pairs(storage.list()) do
                if v.name == coinType then
                    trader.pullItems("left",i,1)
                    count = count + 1
                    break
                end
            end
        end
        print("found",count,"coins")
    elseif coinType=="thermal:gold_coin" then
        local count = 0
        for i = 1, coins do
            for i,v in pairs(storage.list()) do
                if v.name == coinType then
                    trader.pullItems("left",i,1)
                    count = count + 1
                    break
                end
            end
        end
    else error("invalid coin type")
    end

    if not trader.list()[1] then
        error"no moneys found"
    elseif trader.list()[1].count ~= coins then
        error"different amount of money"
    elseif trader.list()[1].name ~= coinType then
        error"coin type error"
    else
        print("payed ok")
    end
end

function inv(tofind)
    local count = 0
    for i, v in pairs(storage.list()) do
        if v.name == tofind then
            count = count + storage.list()[i].count
        end
    end
    return count
end

function clear()
    for i,v in pairs(trader.list()) do
        storage.pullItems(peripheral.getName(trader),i)
    end
    print("cleared trader")
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

function reliq()
    clear()
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
end

function buyRedstone()
    print"buying Redstone"
    -- 8 coins for 16 redstone
    -- 32 coins for a stack
    clear()
    pay(32,"thermal:silver_coin")
    equip("kubejs:trade_card_redstone_dust")
    os.sleep(11)
    clear()
end

function buyFeathers()
    print"buying Feathers"
    -- 6 coins for 4 feathers
    -- 96 coins for a stack
    clear()
    pay(60,"thermal:silver_coin")
    equip("kubejs:trade_card_feather")
    os.sleep(24)
    clear()
end

function buyBrass()
    print"buying brass"
    clear()
    pay(48,"thermal:silver_coin")
    equip("kubejs:trade_card_brass_ingot")
    os.sleep(5)
    clear()
end
function buyCopper()
    print"buying copper"
    clear()
    pay(32,"thermal:silver_coin")
    equip("kubejs:trade_card_copper_ingot")
    os.sleep(6)
    clear()
end

while true do
    shell.run("clear")
    print("WATCHU WANT?\n1.refill reliquary crap\n2.buy redstone\n3.buy feathers\n4.buy brass\n5.copper")

    local event, key, is_held = os.pullEvent("key")
    print(key)

    if key == 49 then reliq() end
    if key == 50 then buyRedstone() end
    if key == 51 then buyFeathers() end
    if key == 52 then buyBrass() end
    if key == 53 then buyCopper() end
    os.sleep(2)
end
