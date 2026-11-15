"
Unit tests verifying base node controller connection rules and parent model resolution without relying on specialized subclasses.
"
Class {
	#name : 'OPErdNodeControllerTest',
	#superclass : 'TestCase',
	#category : 'OpenPonk-ERD-Tests-Controllers',
	#package : 'OpenPonk-ERD-Tests',
	#tag : 'Controllers'
}

{ #category : 'tests' }
OPErdNodeControllerTest >> testCanBeSourceAndTargetForConnectionControllers [

	| nodeController regularTransition totalTransition inheritanceTransition nonTransition |
	nodeController := OPErdNodeController new.
	regularTransition := OPErdTransitionController new.
	totalTransition := OPErdTotalTransitionController new.
	inheritanceTransition := OPErdInheritanceTransitionController new.
	nonTransition := OPErdEntityController new.

	self
		assert: (nodeController canBeSourceFor: regularTransition)
		description: 'Base node controller should accept regular transition as source'.
	self
		assert: (nodeController canBeSourceFor: totalTransition)
		description: 'Base node controller should accept total transition as source'.
	self
		assert: (nodeController canBeSourceFor: inheritanceTransition)
		description: 'Base node controller should accept inheritance transition as source'.
	self
		deny: (nodeController canBeSourceFor: nonTransition)
		description: 'Base node controller must reject non-transition controller as source'.
	self
		deny: (nodeController canBeSourceFor: Object new)
		description: 'Base node controller must reject arbitrary object without modelClass'.

	self
		assert: (nodeController canBeTargetFor: regularTransition)
		description: 'Base node controller should delegate canBeTargetFor: to canBeSourceFor: for transitions'.
	self
		deny: (nodeController canBeTargetFor: nonTransition)
		description: 'Base node controller must reject non-transition controller as target'
]

{ #category : 'tests' }
OPErdNodeControllerTest >> testModelAsParentReturnsModelOwner [

	| erdModel entityModel nodeController |
	erdModel := OPErd named: 'Test ERD'.
	entityModel := OPErdEntity named: 'Customer'.
	nodeController := OPErdNodeController new.
	nodeController viewModel: (OPErdEntityViewModel new model: entityModel).

	self assert: nodeController modelAsParent identicalTo: nil.

	erdModel add: entityModel.
	self assert: nodeController modelAsParent identicalTo: erdModel
]
