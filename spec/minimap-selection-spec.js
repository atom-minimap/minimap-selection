// const MinimapSelection = require('../lib/minimap-selection')

describe('MinimapSelection', () => {
	let workspace, editor, minimap, decorationManagement

	beforeEach(async () => {
		workspace = atom.views.getView(atom.workspace)
		jasmine.attachToDOM(workspace)

		editor = await atom.workspace.open('sample.js')

		// Package activation will be deferred to the configured, activation hook, which is then triggered
		// Activate activation hook
		atom.packages.triggerDeferredActivationHooks()
		atom.packages.triggerActivationHook('core:loaded-shell-environment')

		const minimapPkg = await atom.packages.activatePackage('minimap')
		minimap = minimapPkg.mainModule.minimapForEditor(editor)

		await atom.packages.activatePackage('minimap-selection')

		decorationManagement = minimap.getDecorationManagement()
		spyOn(decorationManagement, 'decorateMarker').and.callThrough()
		spyOn(decorationManagement, 'removeDecoration').and.callThrough()
	})

	describe('when a selection is made in the text editor', () => {
		it('adds a decoration for the selection in the minimap', () => {
			editor.setSelectedBufferRange([[1, 0], [2, 10]])
			console.log(minimap.getDecorations())
			expect(decorationManagement.decorateMarker).toHaveBeenCalled()
		})

		it('removes the previously added decoration', () => {
			editor.setSelectedBufferRange([[1, 0], [2, 10]])
			editor.setSelectedBufferRange([[0, 0], [0, 0]])
			expect(decorationManagement.removeDecoration).toHaveBeenCalled()
		})
	})
})
