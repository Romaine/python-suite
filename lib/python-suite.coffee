PythonSuiteView = require './python-suite-view'
NameView = require './name-view'
spawn = require('child_process').spawn
pyname = __dirname + "/outline.py"
{CompositeDisposable} = require 'atom'



module.exports = PythonSuite =
  pythonSuiteView: null
  panel: null
  subscriptions: null
  child: null
  data: null
  toggle: null

  activate: (state) ->
    @pythonSuiteView = new PythonSuiteView()

    @attach()

    @spawnChild()
    @subscriptions = new CompositeDisposable
    @subscriptions.add atom.workspace.onDidChangeActivePaneItem(@checkGrammar)

  checkGrammar: () ->
    editor = atom.workspace.getActiveTextEditor()
    if editor
      console.log editor.getGrammar().name.toString()
      if editor.getGrammar().name == "Python"
        editor.getText()
        PythonSuite.attach()
      else
        PythonSuite.panel.destroy()




  updateOutline: (data) ->
    console.log(data.toString())
    reply = JSON.parse(data.toString())
    console.log reply
    exports.data = ->
      return reply

    console.log exports.data
    @pythonSuiteView.updateView()


  spawnChild: ->
    @child = spawn("python3", [pyname])
    @child.stdin.setEncoding = "utf-8"

    @child.stdin.write "names\n"

    @child.stdout.on('data', (data) ->
      PythonSuite.updateOutline(data)
    )

    @child.stderr.on('data', (data) ->
      console.log data.toString()
      )

  attach: ->
    @panel = atom.workspace.addBottomPanel(item: @pythonSuiteView, visible: true)

    console.log atom.workspace.getLeftPanels()

  deactivate: ->
    @panel.destroy()
    @subscriptions.dispose()
    @pythonSuiteView.destroy()

  toggle: ->
    console.log 'PythonSuite was toggled!'

    if @panel.isVisible()
      @panel.hide()
    else
      @panel.show()
