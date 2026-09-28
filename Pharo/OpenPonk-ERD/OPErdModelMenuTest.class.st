"
Verifies the population, state, and execution of Commander 1 model commands within the ERD editor toolbar menu.
"
Class {
	#name : 'OPErdModelMenuTest',
	#superclass : 'TestCase',
	#instVars : [
		'toolbarPresenter',
		'mockWorkbench'
	],
	#category : 'OpenPonk-ERD-Tests',
	#package : 'OpenPonk-ERD',
	#tag : 'Tests'
}

{ #category : 'running' }
OPErdModelMenuTest >> setUp [
	| mockProjectController |
	super setUp.
	mockWorkbench := Mock new.
	mockProjectController := Mock new.
	mockProjectController stub undoManager willReturn: OPUndoManager new.
	mockWorkbench stub projectController willReturn: mockProjectController.
	mockWorkbench stub workbench willReturn: mockWorkbench.
	toolbarPresenter := OPWorkbenchToolbar newApplication: SpApplication defaultApplication.
	toolbarPresenter owner: mockWorkbench
]

{ #category : 'running' }
OPErdModelMenuTest >> tearDown [
	toolbarPresenter := nil.
	mockWorkbench := nil.
	super tearDown
]

{ #category : 'tests' }
OPErdModelMenuTest >> testModelMenuContainsErdCommanderActivationsWhenErdEditorFocused [
	"Verifies that the Model menu contains ERD Commander 1 commands when an ERD editor is focused."
	| erdPlugin testEditor modelMenuItem subMenuLabels |
	erdPlugin := OPPluginRegistry default plugins
		detect: [ :eachPluginCandidate | eachPluginCandidate isKindOf: OPErdPlugin ].
	testEditor := (OPEditor on: erdPlugin)
		workbench: mockWorkbench;
		yourself.

	toolbarPresenter focusedEditor: testEditor.
	modelMenuItem := toolbarPresenter menu menuGroups first menuItems
		detect: [ :eachMenuItem | eachMenuItem name = 'Model' ].
	subMenuLabels := modelMenuItem subMenu menuGroups
		flatCollect: [ :eachGroup | eachGroup menuItems collect: [ :eachItem | eachItem name ] ].

	self assertCollection: subMenuLabels includesAll: #( 'Export as xmi' 'Import as xmi' )
]
