View = require('space-pen').View

module.exports =
#  data: null
class NameView extends View
  @content: (data) ->
    @data = data
    exports.data = data
    @span class: data.type + " element", click: "moveCursor", =>
      if data.type == "import"
        @div class: "type row", "i"
      else if data.type == "class"
        @div class: "type row", "c"
      else if data.type == "function"
        @div class: "type row", "f"
      @div class: "name" + " row", data.name

  initialize:(data) ->
    if data?
      @data = data

  # Returns an object that can be retrieved when package is activated
  serialize: ->

  moveCursor: () ->
    atom.workspace.getActiveTextEditor().setCursorBufferPosition(@data.pos)
  #noobrisis
  # Tear down any state and detach
  destroy: ->
    @element.remove()

  getElement: ->
    @element
