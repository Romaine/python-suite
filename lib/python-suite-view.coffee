View = require('space-pen').View
NameView = require './name-view'
PythonSuite = require './python-suite'
{$, $$} = require 'space-pen'
{CompositeDisposable} = require 'atom'

module.exports =
class PythonSuiteView extends View
  panel: null

  @content: ->
    @div class: "python-suite tree-view", =>
      @h4 "outliner"
      @div class: "outline", outlet: "outline", =>


  initialize: () ->


  updateView: ->
    @outline.empty()
    if PythonSuite.data()?
      data = PythonSuite.data()
      editor = atom.workspace.getActiveTextEditor()
      path = editor.getPath()
      console.log data
      console.log data[path]
      if data?
        for e in data[path]
          console.log(e)
          nameView = new NameView(e)
          @outline.append(nameView)





  # Returns an object that can be retrieved when package is activated
  serialize: ->

  # Tear down any state and detach
  destroy: ->
    @content.remove()
