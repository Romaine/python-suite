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

  activate: (state) ->
    @pythonSuiteView = new PythonSuiteView()
    @pythonSuiteView.attach()
    console.log "made view"
    @child = undefined

    @spawnChild()

    # Events subscribed to in atom's system can be easily cleaned up with a CompositeDisposable
    @subscriptions = new CompositeDisposable

    # Register command that toggles this view
    @subscriptions.add atom.commands.add 'atom-workspace', 'python-suite:toggle': => @toggle()


  updateOutline: (data) ->
    console.log(data.toString())
    reply = JSON.parse(data.toString())
    console.log reply
    exports.data = ->
      return reply

    console.log "export"
    console.log exports.data
    console.log "bang"
    @pythonSuiteView.updateView()


  spawnChild: ->
    @child = spawn("python3", [pyname])
    @child.stdin.setEncoding = "utf-8"

    @child.stdin.write "names\n"

    @child.stdout.on('data', (data) ->
      PythonSuite.updateOutline(data)
      console.log()
    )

    @child.stderr.on('data', (data) ->
      console.log data.toString()
      )



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
