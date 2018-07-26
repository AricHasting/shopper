import Shopper from require "shopper"

describe 'Shopper', ->
    it 'initializes', ->
      s = Shopper!
      assert.truthy s.store
      assert.truthy s.appliers
      assert.truthy s.subs