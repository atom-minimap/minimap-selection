{View} = require 'atom'
MarkerView = require './marker-view'
module.exports =
class MinimapSelectionView extends View
  markers: []
  @content: ->
    @div class: 'minimap-selection'

  initialize: (@minimapView) ->
    @subscribe @minimapView.editorView, "selection:changed", @handleSelection

  attach: ->
    @minimapView.miniUnderlayer.append(this)
    @handleSelection()

  destroy: ->
    @detach()
    @unsubscribe()
    @minimapView = null

  handleSelection: =>
    @removeMarkers()

    {editor} = @minimapView

    return if editor.getSelection().isEmpty()

    for selection in editor.getSelections()
      marker = new MarkerView(editorView: @minimapView, marker: selection.marker)
      @markers.push marker
      @append marker.element

  removeMarkers: ->
    return unless @markers?
    return if @markers.length is 0
    marker.element.remove() for marker in @markers
    marker = null
    @markers = []
