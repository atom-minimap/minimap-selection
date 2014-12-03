{View} = require 'atom-space-pen-views'
{CompositeDisposable} = require 'event-kit'

module.exports =
class MinimapSelectionView extends View
  decorations: []
  @content: ->
    @div class: 'minimap-selection'

  initialize: (@minimapView) ->
    @subscriptions = new CompositeDisposable
    @subscriptions.add @minimapView.editor.onDidChangeSelectionRange @handleSelection
    @subscriptions.add @minimapView.editor.onDidAddCursor @handleSelection
    @subscriptions.add @minimapView.editor.onDidChangeCursorPosition @handleSelection
    @subscriptions.add @minimapView.editor.onDidRemoveCursor @handleSelection

  attach: ->
    @minimapView.miniUnderlayer.append(this)
    @handleSelection()

  destroy: ->
    @detach()
    @subscriptions.dispose()
    @minimapView = null

  handleSelection: =>
    @removeDecorations()

    {editor} = @minimapView

    for selection in editor.getSelections()
      unless selection.isEmpty()
        decoration = @minimapView.decorateMarker(selection.marker, type: 'highlight-under', scope: '.minimap .minimap-selection .region')
        @decorations.push decoration if decoration?

  removeDecorations: ->
    return if @decorations.length is 0
    decoration?.destroy() for decoration in @decorations
    @decorations = []
