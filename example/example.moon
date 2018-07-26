import shop from require "example/shop"
import add_name, select_name from require "example/products"

-- Add a subscriber
nameAddSub = (store) ->
  str = ""
  for name in *store.names
    str = str .. name .. " "
  print str

shop\subscribe nameAddSub

-- Stock products
shop\stock add_name "John"
shop\stock add_name "Jane"
shop\stock add_name "Jack"

shop\stock select_name "Jane"

-- Buy the selected name
print "Selected: ", (shop\buy!).selected