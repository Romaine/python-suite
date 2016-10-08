View = require('space-pen').View

module.exports =
class NameView extends View
  @content: (data) ->
    @span class: data.type + " element", =>
      if data.type == "import"
        @div class: "type row", "i"
      else if data.type == "class"
        @div class: "type row", "c"
      else if data.type == "function"
        @div class: "type row", "f"
      @div class: "name" + " row", data.name

  initialize:() ->

  # Returns an object that can be retrieved when package is activated
  serialize: ->

  # Tear down any state and detach
  destroy: ->
    @element.remove()

  getElement: ->
    @element
