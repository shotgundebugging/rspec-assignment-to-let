{CompositeDisposable} = require 'atom'

module.exports = RSpecAssignmentToLet =
  subscriptions: null

  activate: (state) ->
    # Events subscribed to in atom's system can be easily cleaned up with a CompositeDisposable
    @subscriptions = new CompositeDisposable

    # Register command that toggles this view
    @subscriptions.add atom.commands.add 'atom-workspace', 'rspec-assignment-to-let:convert': => @convert()

  deactivate: ->
    @subscriptions.dispose()

  convert: ->
    if editor = atom.workspace.getActiveTextEditor()
      selection = editor.getSelectedText()
      selection.replace(/\s*=\s*/, ") { ")
      selection = "let(:" + selection.replace(/\s*=\s*/, ") { ") + " }"

    editor.insertText(selection);
