View = require('space-pen').View
NameView = require './name-view'
PythonSuite = require './python-suite'
{$, $$} = require 'space-pen'

module.exports =
class PythonSuiteView extends View

  panel: null
  @content: ->
    @div class: "python-suite", =>
      @h4 "outliner"
      @div class: "outline", outlet: "outline", =>
      

  initialize: () ->



  updateView: ->
    if PythonSuite.data()?
      for e in PythonSuite.data()
        console.log(e)
        nameView = new NameView(e)
        @outline.append(nameView)
      console.log atom.workspace.getLeftPanels()[0].getItem()[0].appendChild()





  # Returns an object that can be retrieved when package is activated
  serialize: ->

  # Tear down any state and detach
  destroy: ->
    @content.remove()

  attach: ->
    @panel = atom.workspace.addBottomPanel(item: this, visible: true)

    console.log atom.workspace.getLeftPanels()
