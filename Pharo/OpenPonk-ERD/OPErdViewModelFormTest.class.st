Class {
	#name : 'OPErdViewModelFormTest',
	#superclass : 'TestCase',
	#instVars : [
		'undoManager',
		'form'
	],
	#category : 'OpenPonk-ERD-Tests',
	#package : 'OpenPonk-ERD',
	#tag : 'Tests'
}

{ #category : 'running' }
OPErdViewModelFormTest >> setUp [
	"Prepare isolated test fixture with dedicated undo manager and dynamic form."
	super setUp.
	undoManager := OPUndoManager new.
	form := OPPropertiesForm new.
	form undoManager: undoManager
]

{ #category : 'running' }
OPErdViewModelFormTest >> tearDown [
	"Clean up isolated test fixture."
	form := nil.
	undoManager := nil.
	super tearDown
]

{ #category : 'tests' }
OPErdViewModelFormTest >> testAttributeViewModelFormBindingsAndUndo [
	"Verify declarative bindings and reversible mutual exclusion for attribute properties."
	| model viewModel keyBinding derivedBinding |
	model := OPErdAttribute new name: 'attr'; isKey: false; isDerived: false; isMultivalued: false.
	viewModel := OPErdAttributeViewModel new model: model.
	form viewModel: viewModel.

	self assert: (form bindings anySatisfy: [ :each | each selector = #name ]).
	self assert: (form bindings anySatisfy: [ :each | each selector = #isKey ]).
	self assert: (form bindings anySatisfy: [ :each | each selector = #isDerived ]).
	self assert: (form bindings anySatisfy: [ :each | each selector = #isMultivalued ]).

	keyBinding := form bindings detect: [ :each | each selector = #isKey ].
	derivedBinding := form bindings detect: [ :each | each selector = #isDerived ].

	keyBinding writeModelValue: true.
	self assert: model isKey.
	self deny: model isDerived.
	self deny: model isMultivalued.

	derivedBinding writeModelValue: true.
	self assert: model isDerived.
	self deny: model isKey.
	self deny: model isMultivalued.

	undoManager undo.
	self assert: model isKey.
	self deny: model isDerived.

	undoManager redo.
	self assert: model isDerived.
	self deny: model isKey
]

{ #category : 'tests' }
OPErdViewModelFormTest >> testEntityViewModelFormBindingsAndUndo [
	"Verify declarative bindings and reversible state change for weak entity property."
	| model viewModel weakBinding |
	model := OPErdEntity new name: 'Entity1'; isWeak: false.
	viewModel := OPErdEntityViewModel new model: model.
	form viewModel: viewModel.

	self assert: (form bindings anySatisfy: [ :each | each selector = #name ]).
	self assert: (form bindings anySatisfy: [ :each | each selector = #isWeak ]).

	weakBinding := form bindings detect: [ :each | each selector = #isWeak ].
	weakBinding writeModelValue: true.
	self assert: model isWeak.

	undoManager undo.
	self deny: model isWeak.

	undoManager redo.
	self assert: model isWeak
]

{ #category : 'tests' }
OPErdViewModelFormTest >> testExtensionsViewModelFormBindingsAndUndo [
	"Verify declarative bindings and reversible mutual exclusion for extension properties."
	| model viewModel disjointBinding unionBinding |
	model := OPErdExtensions new name: 'Ext1'; isDisjoint: false; isUnion: false; isOverlapping: false.
	viewModel := OPErdExtensionsViewModel new model: model.
	form viewModel: viewModel.

	self assert: (form bindings anySatisfy: [ :each | each selector = #name ]).
	self assert: (form bindings anySatisfy: [ :each | each selector = #isDisjoint ]).
	self assert: (form bindings anySatisfy: [ :each | each selector = #isUnion ]).
	self assert: (form bindings anySatisfy: [ :each | each selector = #isOverlapping ]).

	disjointBinding := form bindings detect: [ :each | each selector = #isDisjoint ].
	unionBinding := form bindings detect: [ :each | each selector = #isUnion ].

	disjointBinding writeModelValue: true.
	self assert: model isDisjoint.
	self deny: model isUnion.
	self deny: model isOverlapping.

	unionBinding writeModelValue: true.
	self assert: model isUnion.
	self deny: model isDisjoint.
	self deny: model isOverlapping.

	undoManager undo.
	self assert: model isDisjoint.
	self deny: model isUnion.

	undoManager redo.
	self assert: model isUnion.
	self deny: model isDisjoint
]

{ #category : 'tests' }
OPErdViewModelFormTest >> testRelationViewModelFormBindingsAndUndo [
	"Verify declarative bindings and reversible state change for identifying relation property."
	| model viewModel identifyingBinding |
	model := OPErdRelation new name: 'Relation1'; isIdentifying: false.
	viewModel := OPErdRelationViewModel new model: model.
	form viewModel: viewModel.

	self assert: (form bindings anySatisfy: [ :each | each selector = #name ]).
	self assert: (form bindings anySatisfy: [ :each | each selector = #isIdentifying ]).

	identifyingBinding := form bindings detect: [ :each | each selector = #isIdentifying ].
	identifyingBinding writeModelValue: true.
	self assert: model isIdentifying.

	undoManager undo.
	self deny: model isIdentifying.

	undoManager redo.
	self assert: model isIdentifying
]

{ #category : 'tests' }
OPErdViewModelFormTest >> testTransitionViewModelFormBindingsAndUndo [
	"Verify declarative bindings and reversible mutual exclusion for transition properties."
	| model viewModel totalBinding inheritanceBinding |
	model := OPErdTransition new isTotal: false; isInheritance: false.
	viewModel := OPErdTransitionViewModel new model: model.
	form viewModel: viewModel.

	self assert: (form bindings anySatisfy: [ :each | each selector = #isTotal ]).
	self assert: (form bindings anySatisfy: [ :each | each selector = #isInheritance ]).

	totalBinding := form bindings detect: [ :each | each selector = #isTotal ].
	inheritanceBinding := form bindings detect: [ :each | each selector = #isInheritance ].

	totalBinding writeModelValue: true.
	self assert: model isTotal.
	self deny: model isInheritance.

	inheritanceBinding writeModelValue: true.
	self assert: model isInheritance.
	self deny: model isTotal.

	undoManager undo.
	self assert: model isTotal.
	self deny: model isInheritance.

	undoManager redo.
	self assert: model isInheritance.
	self deny: model isTotal
]
