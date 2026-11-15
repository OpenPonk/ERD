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
	#category : 'OpenPonk-ERD-Tests-Commands',
	#package : 'OpenPonk-ERD-Tests',
	#tag : 'Commands'
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
	erdPlugin := OPPluginRegistry default plugins detect: [ :eachPluginCandidate | eachPluginCandidate isKindOf: OPErdPlugin ].
	testEditor := (OPEditor on: erdPlugin)
		              workbench: mockWorkbench;
		              yourself.

	toolbarPresenter focusedEditor: testEditor.
	modelMenuItem := toolbarPresenter menu menuGroups first menuItems detect: [ :eachMenuItem | eachMenuItem name = 'Model' ].
	subMenuLabels := modelMenuItem subMenu menuGroups flatCollect: [ :eachGroup |
		                 eachGroup menuItems collect: [ :eachItem | eachItem name ] ].

	self assertCollection: subMenuLabels includesAll: #( 'Export as GraphML...' 'Import from GraphML...' )
]

{ #category : 'tests' }
OPErdModelMenuTest >> testXmlCommandsExecuteDelegatesToErdGraphML [
	"Verifies menu names and execution delegation of ERD GraphML export and import commands."

	| targetModel mockDiagramController mockEditor toolContext exportedModel importedModel importedEditor exportCommand importCommand |
	targetModel := OPErd new name: 'Menu Command Chain'.
	mockDiagramController := Mock new.
	mockDiagramController stub model willReturn: targetModel.
	mockEditor := Mock new.
	mockEditor stub diagramController willReturn: mockDiagramController.

	exportedModel := nil.
	importedModel := nil.
	importedEditor := nil.
	(OPErdGraphML stub exportPackage: Any) will: [ :aModel | exportedModel := aModel ].
	(OPErdGraphML stub importToModel: Any inEditor: Any) will: [ :aModel :anEditor |
			importedModel := aModel.
			importedEditor := anEditor ].

	exportCommand := OPErdExportXmlCommand new.
	self assert: exportCommand defaultMenuItemName equals: 'Export as GraphML...'.
	importCommand := OPErdImportXmlCommand new.
	self assert: importCommand defaultMenuItemName equals: 'Import from GraphML...'.

	toolContext := CmdSimpleToolContext for: mockEditor.
	CmdCommandActivator new
		command: exportCommand;
		context: toolContext;
		executeCommand.
	self assert: exportedModel identicalTo: targetModel.

	CmdCommandActivator new
		command: importCommand;
		context: toolContext;
		executeCommand.
	self assert: importedModel identicalTo: targetModel.
	self assert: importedEditor identicalTo: mockEditor
]
