{CompositeDisposable} = require 'event-kit'

module.exports =
class MinimapSelectionView
  decorations: []

  constructor: (@minimap) ->
    editor = @minimap.getTextEditor()

    @subscriptions = new CompositeDisposable

    @subscriptions.add editor.onDidAddCursor @handleSelection
    @subscriptions.add editor.onDidChangeCursorPosition @handleSelection
    @subscriptions.add editor.onDidRemoveCursor @handleSelection

    @handleSelection()

  destroy: ->
    @removeDecorations()
    @subscriptions.dispose()
    @minimap = null

  handleSelection: =>
    @removeDecorations()

    for selection in @minimap.getTextEditor().getSelections()
      unless selection.isEmpty()
        decoration = @minimap.decorateMarker(selection.marker, type: 'highlight-under', scope: '.minimap .minimap-selection .region')
        @decorations.push decoration if decoration?

  removeDecorations: ->
    return if @decorations.length is 0
    decoration?.destroy() for decoration in @decorations
    @decorations = []
