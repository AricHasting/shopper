class Shopper
  new: =>
    @store = {}
    @appliers = {}
    @subs = {}
  
  apply: (store) =>
    @store = store
    for fn in *@subs
      fn @store
  
  add: (fn) =>
    table.insert(@appliers, fn)
  
  stock: (product) =>
    for fn in *@appliers
      @apply fn(@store, product)
  
  subscribe: (fn, value) =>
    table.insert(@subs, fn)
  
  buy: (value) =>
    @store[value]

{:Shopper}