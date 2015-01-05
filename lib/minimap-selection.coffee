MinimapSelectionView = require './minimap-selection-view'

module.exports =

  active: false
  views: {}

  activate: (state) ->
    try
      atom.packages.activatePackage('minimap').then (minimapPackage) =>
        @minimap = minimapPackage.mainModule
        return @deactivate() unless @minimap.versionMatch('>= 3.0.0')

        @minimap.registerPlugin 'selection', this
    catch
      @deactivate

  deactivate: ->
    @minimap.unregisterPlugin 'selection'
    @minimap = null

  isActive: -> @active

  activatePlugin: ->
    return if @active
    @active = true

    @subscription = @minimap.observeMinimaps (o) =>
      minimap = o.view ? o
      selectionView = new MinimapSelectionView(minimap)

      @views[minimap.getTextEditor().id] = selectionView

  deactivatePlugin: ->
    return unless @active
    view.destroy() for id,view of @views
    @active = false
    @views = {}

    @subscription.off()
