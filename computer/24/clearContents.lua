turtle.turnLeft()
for i = 1,16 do
    turtle.select(i)
    turtle.drop()
end
turtle.select(1) -- to cover leftovers from the chute
turtle.drop()
turtle.turnRight()

