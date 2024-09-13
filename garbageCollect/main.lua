mytable = {"apple", "orange", "banana"}

print(collectgarbage("count"))

mytable = nil

print(collectgarbage("count"))

collectgarbage("collect")

print(collectgarbage("count"))