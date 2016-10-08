View = require('space-pen').View

module.exports =
class NameView extends View
  @content: (data) ->
    @span class: data.type, =>
      @div class: "line", data.line

  initialize:() ->

  # Returns an object that can be retrieved when package is activated
  serialize: ->

  # Tear down any state and detach
  destroy: ->
    @element.remove()

  getElement: ->
    @element
