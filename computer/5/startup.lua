shell.run("clear")
toKeep = 2000
tradeStation = peripheral.wrap("top")

function table_to_string(tbl)
    local result = "{"
    if tbl == nil then print"tts error" return end
    for k, v in pairs(tbl) do
        -- Check the key type (ignore any numerical keys - assume its an array)
        if type(k) == "string" then
            result = result.."[\""..k.."\"]".."="
        end

        -- Check the value type
        if type(v) == "table" then
            result = result..table_to_string(v)
        elseif type(v) == "boolean" then
            result = result..tostring(v)
        else
            result = result.."\""..v.."\""
        end
        result = result..","
    end
    -- Remove leading commas from the result
    if result ~= "" then
        result = result:sub(1, result:len()-1)
    end
    return result.."}"
end

while true do
    local event, side = os.pullEvent("peripheral")
    kelpBarrel = peripheral.wrap("left")
    barrel = peripheral.wrap("right")
    kelps = kelpBarrel.list()[1].count
    print(kelps)
    print(kelpBarrel.pushItems("right",1))

    -- toSell = kelps - toKeep
    -- barrel.pullItems("left",1,64)
    os.sleep(2)

end
