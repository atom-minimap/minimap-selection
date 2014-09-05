{View} = require 'atom'
module.exports =
class MinimapSelectionView extends View
  decorations: []
  @content: ->
    @div class: 'minimap-selection'

  initialize: (@minimapView) ->
    @subscribe @minimapView.editorView, "selection:changed", @handleSelection
    @subscribe @minimapView.editorView, "cursor-added", @handleSelection
    @subscribe @minimapView.editorView, "cursor-moved", @handleSelection
    @subscribe @minimapView.editorView, "cursor-removed", @handleSelection

  attach: ->
    @minimapView.miniUnderlayer.append(this)
    @handleSelection()

  destroy: ->
    @detach()
    @unsubscribe()
    @minimapView = null

  handleSelection: =>
    @removeDecorations()

    {editor} = @minimapView

    return if editor.getSelections().length is 1 and editor.getLastSelection().isEmpty()

    for selection in editor.getSelections()
      @decorations.push @minimapView.decorateMarker(selection.marker, type: 'highlight-under', scope: '.minimap .editor .selection .region')

  removeDecorations: ->
    return if @decorations.length is 0
    decoration.destroy() for decoration in @decorations
    @decorations = []
