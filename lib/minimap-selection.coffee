MinimapSelectionView = require './minimap-selection-view'

module.exports =

  active: false
  views: {}

  activate: (state) ->
    try
      atom.packages.activatePackage('minimap').then (minimapPackage) =>
        @minimap = require minimapPackage.path
        return @deactivate() unless @minimap.versionMatch('3.x')

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

    @subscription = @minimap.eachMinimapView ({view}) =>
      selectionView = new MinimapSelectionView(view)
      selectionView.attach()

      @views[view.editor.id] = selectionView

  deactivatePlugin: ->
    view.destroy() for id,view of @views
    return unless @active
    @active = false
    @views = {}

    @subscription.off()
