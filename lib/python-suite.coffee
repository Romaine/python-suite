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

    #@attach(

    @spawnChild()
    @subscriptions = new CompositeDisposable
    @subscriptions.add atom.workspace.onDidChangeActivePaneItem(@checkGrammar)

  checkGrammar: () ->
    editor = atom.workspace.getActiveTextEditor()
    if editor
      if editor.getGrammar().name == "Python"
        text = editor.getText()
        path = editor.getPath()
        PythonSuite.child.stdin.write(JSON.stringify({
          command: "names"
          path: path
          source: text
        }) + "\n")

        PythonSuite.pythonSuiteView.show()

      else
        PythonSuite.pythonSuiteView.hide()


  updateOutline: (data) ->
    console.log(data.toString())
    reply = JSON.parse(data.toString())
    console.log reply
    exports.data = ->
      return reply
    console.log atom.workspace.getLeftPanels()[0].item.element.spacePenView.append(@pythonSuiteView)

    @pythonSuiteView.updateView()


  spawnChild: ->
    @child = spawn("python3", [pyname])
    @child.stdin.setEncoding = "utf-8"


    exports.stdin = @child.stdin.write

    @child.stdout.on('data', (data) ->
      console.log data
      exports.data = ->
        return data
      PythonSuite.updateOutline(data)
    )

    @child.stderr.on('data', (data) ->
      console.log data.toString()
      )


  attach: ->
    @panel = atom.workspace.addBottomPanel(item: @pythonSuiteView, visible: true)

    #  console.log atom.workspace.getLeftPanels()[0]#getPanel().addItem(item: @pythonSuiteView)
    #  Figure out how to add the outliner/navigator to the bottom of tree view

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
