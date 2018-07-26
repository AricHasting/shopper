import Shopper from require "shopper"
import cmbi from require "combine/combine"
import add_name, select_name from require "example/products"

-- Create shopper
shopper = Shopper!

-- Create stocker
name_stocker = (store, product) ->
  if product.type == "ADD_NAME"
    return cmbi store, {names: cmbi store.names, product.name}
  else if product.type == "SELECT_NAME"
    return cmbi store, {selected: product.name}
  else
    return store

shopper\add name_stocker

-- Add a subscriber
nameAddSub = (store) ->
  str = ""
  for name in *store.names
    str = str .. name .. " "
  print str

shopper\subscribe nameAddSub

-- Stock products
shopper\stock add_name "Venny"
shopper\stock add_name "Clove"
shopper\stock add_name "Tasla"

shopper\stock select_name "Clove"

-- Buy the selected name
print shopper\buy "selected"