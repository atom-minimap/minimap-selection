const MinimapSelectionView = require('./minimap-selection-view')

module.exports = {
	config: {
		highlightCursorsLines: {
			type: 'boolean',
			default: false,
			description: 'When true, the lines with cursors are highlighted in the minimap.',
		},
		outlineSelection: {
			type: 'boolean',
			default: false,
			description: 'When true, the selections will also be rendered with outline decorations.',
		},
	},

	activate () {
		this.active = false
		this.views = new Map()
		require('atom-package-deps').install('minimap-selection')
	},

	consumeMinimapServiceV1 (minimap) {
		this.minimap = minimap
		this.minimap.registerPlugin('selection', this)
	},

	deactivate () {
		this.minimap.unregisterPlugin('selection')
		this.minimap = null
	},

	isActive () {
		return this.active
	},

	activatePlugin () {
		if (this.active) { return }
		this.active = true

		this.subscription = this.minimap.observeMinimaps(o => {
			const minimap = o.view ? o.view : o
			const selectionView = new MinimapSelectionView(minimap)

			this.views.set(minimap.id, selectionView)

			const disposable = minimap.onDidDestroy(() => {
				selectionView.destroy()
				this.views.delete(minimap.id)
				disposable.dispose()
			})
		})
	},

	deactivatePlugin () {
		if (!this.active) { return }
		const views = this.views.values()
		for (const view of views) { view.destroy() }
		this.active = false
		this.views.clear()
		this.subscription.dispose()
	},
}
