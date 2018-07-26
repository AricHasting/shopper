add_name = (name) ->
  return {
    type: "ADD_NAME"
    name: name
  }

select_name = (name) ->
  return {
    type: "SELECT_NAME"
    name: name
  }

{:add_name, :select_name}