{WorkspaceView} = require 'atom'
MinimapSelection = require '../lib/minimap-selection'

# Use the command `window:run-package-specs` (cmd-alt-ctrl-p) to run specs.
#
# To run a specific `it` or `describe` block add an `f` to the front (e.g. `fit`
# or `fdescribe`). Remove the `f` to unfocus the block.

describe "MinimapSelection", ->
  activationPromise = null

  beforeEach ->
    atom.workspaceView = new WorkspaceView
    activationPromise = atom.packages.activatePackage('minimap-selection')

  describe "when the minimap-selection:toggle event is triggered", ->
    it "attaches and then detaches the view", ->
      waitsForPromise -> activationPromise
