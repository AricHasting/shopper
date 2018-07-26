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