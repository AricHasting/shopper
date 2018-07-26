class Shopper
  new: =>
    @store = {}
    @appliers = {}
    @subs = {}
  
  _apply: (store) =>
    @store = store
    for fn in *@subs
      fn @_copy @store
  
  _copy: (t) =>
    {k, v for k, v in pairs t}
  
  add: (fn) =>
    table.insert(@appliers, fn)
  
  stock: (product) =>
    for fn in *@appliers
      @_apply fn(@store, product)
  
  subscribe: (fn, value) =>
    table.insert(@subs, fn)
  
  buy: =>
    @_copy @store

{:Shopper}