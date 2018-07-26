import Shopper from require "shopper"
import cmbi from require "combine/combine"

-- Create shopper
shop = Shopper!

-- Create stocker
name_stocker = (store, product) ->
  if product.type == "ADD_NAME"
    return cmbi store, {names: cmbi store.names, product.name}
  else if product.type == "SELECT_NAME"
    return cmbi store, {selected: product.name}
  else
    return store

shop\add name_stocker

-- Export the shop
{:shop}