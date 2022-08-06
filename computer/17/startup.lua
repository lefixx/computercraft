shell.run("clear")
local PeripheralNames = peripheral.getNames()
extractors = {}
tank = peripheral.wrap("thermal:fluid_cell_8")
local startingLava
local currentLava


local count = 0
for i,v in pairs(PeripheralNames) do
    if string.sub(v,0,17) == "thermal:device_tr" then
        count = count+1
        extractors[count]=peripheral.wrap(v)
    end
end

print("Found",count,"Arboreal Extractors")

function loopFunc(func)
    while true do
        func()
        os.sleep(1)
    end
end

function pumpLava()
    while true do
        for i,v in pairs(extractors) do
            tank.pullFluid(peripheral.getName(v))
        end
        os.sleep(1)
    end
end

function calculateLavaPerMinute()
    startingLava = tank.tanks()[1].amount
    print("starting lava:",startingLava)
    local sec = 0
    while true do
        os.sleep(1)
        currentLava = tank.tanks()[1].amount
        print("lava:", currentLava)
        dif = currentLava - startingLava
        print(dif)
        sec=sec+1
        print("lava per second:",math.floor(dif/sec),"mb")
    end
end

parallel.waitForAll(pumpLava,calculateLavaPerMinute)
-- calculateLavaPerMinute()
-- pumpLava()


-- count = count + 1
--
-- -- print(string.sub(v,0,2))
--
-- if not string.sub(v,0,2) == "th" then
--     print(v)
-- end
