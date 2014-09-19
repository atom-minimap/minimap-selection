MinimapSelectionView = require './minimap-selection-view'

module.exports =

  active: false
  views: {}

  activate: (state) ->
    minimapPackage = atom.packages.getLoadedPackage('minimap')
    return @deactivate() unless minimapPackage?

    @minimap = require minimapPackage.path
    return @deactivate() unless @minimap.versionMatch('3.x')

    @minimap.registerPlugin 'selection', this

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
