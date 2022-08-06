shell.run("clear")
trade = peripheral.wrap("thermal:machine_press_1")
drawer = peripheral.wrap("back")
cobbleDrawer = peripheral.wrap("storagedrawers:standard_drawers_4_5")
kelpDrawer = peripheral.wrap("storagedrawers:standard_drawers_4_3")
treeDrawer = peripheral.wrap("storagedrawers:standard_drawers_4_2")
trade = peripheral.wrap("thermal:machine_press_0")
crafter = peripheral.wrap("turtle_0")
modem = peripheral.wrap("back")
mill = peripheral.wrap("create:millstone_0")

function requestSedimentStrainer()
    rednet.open("back")
    rednet.send(0,{"craft","sedimentStrainer"})
end

shell.run("monitor scale top 0.5")
shell.run("monitor scale left 0.5")
shell.run("monitor scale right 0.5")
shell.run("monitor scale monitor_1 0.5")
shell.run("monitor scale monitor_4 0.5")
shell.run("monitor scale monitor_6 0.5")

shell.openTab"monitor monitor_1 sawMonitor"
shell.openTab"monitor top mntr"
shell.openTab"monitor left mntrStrainer"
shell.openTab"monitor right millstone"
shell.openTab"monitor monitor_4 mixerMonitor"
shell.openTab"monitor monitor_6 deployedMonitor"

while true do
  os.pullEvent("redstone")
  shell.run("reboot")
end
