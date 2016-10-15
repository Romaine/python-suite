View = require('space-pen').View
NameView = require './name-view'
PythonSuite = require './python-suite'
{$, $$} = require 'space-pen'
{CompositeDisposable} = require 'atom'

module.exports =
class PythonSuiteView extends View
  panel: null

  @content: ->
    @div class: "python-suite", =>
      @h4 "outliner"
      @div class: "outline", outlet: "outline", =>


  initialize: () ->


  updateOutline: (data) ->
    console.log(data.toString())
    reply = JSON.parse(data.toString())
    console.log reply
    exports.data = ->
      return reply

    console.log exports.data
    @pythonSuiteView.updateView()


  updateView: ->
    if PythonSuite.data()?
      data = PythonSuite.data()
      editor = atom.workspace.getActiveTextEditor()
      path = editor.getPath()
      console.log data
      console.log data[path]
      for e in data[path]
        console.log(e)
        nameView = new NameView(e)
        @outline.append(nameView)




  # Returns an object that can be retrieved when package is activated
  serialize: ->

  # Tear down any state and detach
  destroy: ->
    @content.remove()
