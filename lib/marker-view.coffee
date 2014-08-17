{View, $} = require 'atom'
{Subscriber} = require 'emissary'

module.exports =
class MarkerView
  Subscriber.includeInto(this)

  constructor: ({@editorView, @marker}) ->
    @regions = []
    @editor = @editorView.editor
    @element = document.createElement('div')
    @element.className = 'marker'
    @updateNeeded = true

    @subscribeToMarker()
    @updateDisplay()

  updateDisplay: =>
    return unless @isUpdateNeeded()

    @updateNeeded = false
    @clearRegions()
    range = @getScreenRange()
    return if range.isEmpty()

    rowSpan = range.end.row - range.start.row

    if rowSpan == 0
      @appendRegion(1, range.start, range.end)
    else
      @appendRegion(1, range.start, {row: range.start.row, column: Infinity})
      if rowSpan > 1
        @appendRegion(rowSpan - 1, { row: range.start.row + 1, column: 0}, {row: range.start.row + 1, column: Infinity})
      @appendRegion(1, { row: range.end.row, column: 0 }, range.end)

  appendRegion: (rows, start, end) ->
    { lineHeight, charWidth } = @editorView
    bufferRange = @editor.bufferRangeForScreenRange({start, end})

    css = @editorView.pixelPositionForScreenPosition(start)
    css.height = lineHeight * rows
    if end
      css.width = @editorView.pixelPositionForScreenPosition(end).left - css.left
    else
      css.right = 0

    region = document.createElement('div')
    region.className = 'region'
    for name, value of css
      region.style[name] = value + 'px'

    @element.appendChild(region)
    @regions.push(region)

  clearRegions: ->
    region.remove() for region in @regions
    @regions = []

  remove: ->
    @unsubscribe()
    @marker = null
    @editorView = null
    @editor = null
    @element.remove()

  subscribeToMarker: ->
    @subscribe @marker, 'changed', (e) => @onMarkerChanged(e)
    @subscribe @marker, 'destroyed', (e) => @remove(e)
    @subscribe @editorView, 'editor:display-updated', (e) => @updateDisplay(e)

  onMarkerChanged: ({isValid}) ->
    @updateNeeded = isValid

  isUpdateNeeded: ->
    return false unless @updateNeeded and @editor is @editorView.editor

    oldScreenRange = @oldScreenRange
    newScreenRange = @getScreenRange()
    @oldScreenRange = newScreenRange

    return true unless oldScreenRange?

    @intersectsRenderedScreenRows(oldScreenRange) or @intersectsRenderedScreenRows(newScreenRange)

  intersectsRenderedScreenRows: (range) ->
    range.intersectsRowRange(@editorView.firstRenderedScreenRow, @editorView.lastRenderedScreenRow)

  getScreenRange: -> @marker.getScreenRange()
  getBufferRange: -> @marker.getBufferRange()
