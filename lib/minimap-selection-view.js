const { CompositeDisposable } = require('atom')

class MinimapSelectionView {
	constructor (minimap) {
		this.decorations = []
		this.handleSelection = this.handleSelection.bind(this)
		this.minimap = minimap
		const editor = this.minimap.getTextEditor()

		this.subscriptions = new CompositeDisposable()

		this.subscriptions.add(editor.onDidAddCursor(this.handleSelection))
		this.subscriptions.add(editor.onDidChangeCursorPosition(this.handleSelection))
		this.subscriptions.add(editor.onDidRemoveCursor(this.handleSelection))
		this.subscriptions.add(atom.config.observe('minimap-selection.outlineSelection', this.handleSelection))

		this.handleSelection()
	}

	destroy () {
		this.removeDecorations()
		this.subscriptions.dispose()
		this.minimap = null
	}

	handleSelection () {
		this.removeDecorations()

		const textEditor = this.minimap.getTextEditor()
		if (!textEditor.selections || textEditor.selections.length === 0) { return }

		for (const selection of textEditor.getSelections()) {
			let decoration
			if (!selection.isEmpty()) {
				decoration = this.minimap.decorateMarker(selection.marker, { type: 'highlight-under', scope: '.minimap .minimap-selection .region', plugin: 'selection' })
				if (decoration) {
					this.decorations.push(decoration)
				}

				if (atom.config.get('minimap-selection.outlineSelection')) {
					decoration = this.minimap.decorateMarker(selection.marker, { type: 'highlight-outline', scope: '.minimap .minimap-selection .region-outline', plugin: 'selection' })
					if (decoration) {
						this.decorations.push(decoration)
					}
				}
			} else if (atom.config.get('minimap-selection.highlightCursorsLines')) {
				decoration = this.minimap.decorateMarker(selection.marker, { type: 'line', scope: '.minimap .minimap-selection .cursor-line', plugin: 'selection' })
				if (decoration) {
					this.decorations.push(decoration)
				}
			}
		}
	}

	removeDecorations () {
		if (this.decorations.length === 0) { return }
		for (const decoration of this.decorations) {
			if (decoration) {
				decoration.destroy()
			}
		}
		this.decorations = []
	}
}

module.exports = MinimapSelectionView
