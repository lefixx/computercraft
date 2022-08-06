
while true do
    for i,v in pairs(peripheral.wrap("bottom").list()) do
        if v.name == "thermal:silver_ingot" then
            peripheral.wrap("top").pullItems("bottom",i)
        end
    end
sleep(5)
end
