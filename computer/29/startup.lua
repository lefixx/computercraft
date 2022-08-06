
photo = peripheral.wrap("bottom")
barrel = peripheral.wrap("top")

function waitUntilPhotoIsEmpty()
    local finished = false
    repeat
        sleep(1)
        if not photo.list()[1] then finished = true end
    until finished
    print"finished"
end

function checkIfPhotoIsEmpty()
    if not photo.list()[1] then return true else error"photo not empty" end
end

function craftTallPoiseBush(amount)
    checkIfPhotoIsEmpty()
    for i = 1, amount do
        local poiseBushLocation
        for k,v in pairs(barrel.list()) do
            if v.name == "endergetic:poise_bush" then
                poiseBushLocation = k
            end
        end
        if not poiseBushLocation then error"no poise bush found" end
        photo.pullItems("top",poiseBushLocation,1)
    end
    waitUntilPhotoIsEmpty()
    barrel.pullItems("bottom",3)
end

function craftPoiseCluster(amount)
    checkIfPhotoIsEmpty()
    for i = 1, amount do
        local tallPoiseBushLocation
        for k,v in pairs(barrel.list()) do
            if v.name == "endergetic:tall_poise_bush" then
                tallPoiseBushLocation = k
            end
        end
        if not tallPoiseBushLocation then error"no tall poise bush found" end
        photo.pullItems("top",tallPoiseBushLocation,1)
    end
    waitUntilPhotoIsEmpty()
    barrel.pullItems("bottom",3)
end

function craftPoiseBush(amount)
    checkIfPhotoIsEmpty()
    for i = 1, amount do
        local poiseClusterLocation
        for k,v in pairs(barrel.list()) do
            if v.name == "endergetic:poise_cluster" then
                poiseClusterLocation = k
            end
        end
        if not poiseClusterLocation then error"no poise cluster found" end
        photo.pullItems("top",poiseClusterLocation,1)
    end
    waitUntilPhotoIsEmpty()
    barrel.pullItems("bottom",3)
    barrel.pullItems("bottom",4)
end

function countAndPushTallPoiseBush()
    while true do
        local count = 0
        for i,v in pairs(barrel.list()) do
            if v.name == "endergetic:tall_poise_bush" then
                count = count + v.count
            end
        end
        print("current tall poise bushes:",count)

        local lastTallPoiseBushLocation
        if count > 1 then
            for i,v in pairs(barrel.list()) do
                if v.name == "endergetic:tall_poise_bush" then
                    lastTallPoiseBushLocation = i
                end
            end
            barrel.pushItems("right",lastTallPoiseBushLocation,1)
        end

    sleep(5)
    end
end


function craftStuff()
    while true do
        craftTallPoiseBush(2)
        craftPoiseCluster(1)
        craftPoiseBush(1)
    end
end


parallel.waitForAll(craftStuff,countAndPushTallPoiseBush)
