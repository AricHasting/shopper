# shopper

Shopper is a lightweight state manager for Moonscript and Lapis. 

It closely resembles [Redux](https://redux.js.org/) in how your code interacts with it.

## Quick Start
1. Download or clone this repository. 
2. Copy shopper.moon into your source directory.
3. Import `Shopper` from the "shopper" module.
```moonscript
import Shopper from require "shopper"
```

## Example

The example provided here is a simple shopper for name tracking.

You can add a name or select a name, and you can inspect that data.

### Running the Example
1. Download or clone this repository.
2. Change directories to the newly cloned repository.
3. Run `moon example/example.moon`

```
git clone https://github.com/AricHasting/shopper.git
cd shopper
moon example/example.moon
```

## Using Shopper
### Summary

#### Major concepts:
- Store - single table that stores all the data for the app. Should not be mutated.
- Product - unit of data to apply to the store.
- Stocker - function that applies products.
- Subscriber - callback function passed a copy of the store, called when a product is stocked.

#### Functions
| function  | params   | description                                      |
|-----------|----------|--------------------------------------------------|
| add       | function | Adds a stocker function to the shopper.          |
| stock     | table    | Submits a product to be stocked.                 |
| buy       |          | Returns the value of the store.                  |
| subscribe | function | Adds a subscriber which is called when stocking. |

### Creating the Shopper

Instantiate the Shopper class with
```moonscript
shop = Shopper!
```

There are two parts to setting up a Shopper:
1. Products
2. Stockers

#### Products
Products describe units of data to apply to the store. They serve the same purpose as [Actions](https://redux.js.org/basics/actions) in Redux.

Each product should be a function that returns a table with a type and any data to apply to the store.

Keep products simple - just a mapping of data. Any API calls, function calls, and async actions should be handled outside of them.

products.moon
```moonscript
-- Product that adds a name to a list
add_name = (name) ->
  return {
    type: "ADD_NAME"
    name: name
  }

-- Product that selects a name from the list
select_name = (name) ->
  return {
    type: "SELECT_NAME"
    name: name
  }

-- Export the products for external use
{:add_name, :select_name}
```

#### Stockers
Stockers describe how products are applied to the store.

They are passed the store and a product, and they should return a new store.

All stockers are passed the product whenever `shop\stock product` is called.

Stockers should be pure functions - no API calls, no async actions. They should not mutate the store, but return a new table with the store's data.

The following snippet uses `cmbi` from the [combine](https://github.com/AricHasting/combine#shorthand-functions) module

```moonscript
name_stocker = (store, product) ->
  if product.type == "ADD_NAME"
    -- cmbi combines table data without mutation.
    return cmbi store, {names: cmbi store.names, product.name}
  else if product.type == "SELECT_NAME"
    return cmbi store, {selected: product.name}
  else
    -- Always return the inital store as a default
    return store

-- Add the stocker to the shopper
shop\add name_stocker
```

### Accessing the Shopper

You should export your shopper from your module.
```moonscript
{:shop}
```

Externally, use the `buy` and `subscribe` functions to read the store. Use `stock` to write to the store.

#### Buy
This returns a deep copy of the store. Since this is a copy, feel free to mutate it as you'd like.

#### Subscribe
This adds a callback function to the shopper. It should take one argument (the store).

Subscribers are also passed a deep copy of the store so their arguments can be mutated as needed.

```moonscript
-- Subscriber that prints the selected name
my_subscriber = (store) ->
  print store.selected

-- Add the subscriber
shop\subscribe my_subscriber
```

#### Stock
Stock submits a product to the store. All stocker functions are called, and passed this product.

```moonscript
-- Import your products
import add_name, select_name from require "products"

with shop
  \stock add_name "Jerry"
  \stock select_name "Joe"
```

## Plans for the future
- [ ] Deeper integration with Lapis
- [ ] Full test coverage
- [ ] Better way to export the shopper
- [ ] (Maybe) Utilities to decrease boilerplate