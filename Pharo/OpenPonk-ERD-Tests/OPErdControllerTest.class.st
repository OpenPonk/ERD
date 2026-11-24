"
Tests diagram-level controller operations, entity placement, and relationship creation for ERD diagrams.
"
Class {
	#name : 'OPErdControllerTest',
	#superclass : 'OPAbstractDiagramControllerTest',
	#category : 'OpenPonk-ERD-Tests-Controllers',
	#package : 'OpenPonk-ERD-Tests',
	#tag : 'Controllers'
}

{ #category : 'constants' }
OPErdControllerTest >> controllerClass [
	"Answer the diagram controller class under test."

	^ OPErdController
]

{ #category : 'accessing' }
OPErdControllerTest >> diagramModelClass [
	"Answer the diagram model container class."
	^ OPErd
]

{ #category : 'constants' }
OPErdControllerTest >> modelClass [
	"Answer the model class managed by the diagram controller."

	^ OPErd
]

{ #category : 'initialization' }
OPErdControllerTest >> newModel [
	"Answer a new instance of the model container."

	^ OPErd new
]

{ #category : 'tests' }
OPErdControllerTest >> testCanBeTargetFor [
	"Verify valid and invalid target acceptance rules for the diagram controller."

	self
		assert: (controller canBeTargetFor: OPErdEntityController new)
		description: 'ERD diagram controller must accept entity controller as target'.
	self
		assert: (controller canBeTargetFor: OPErdRelationController new)
		description: 'ERD diagram controller must accept relation controller as target'.
	self
		assert: (controller canBeTargetFor: OPErdAttributeController new)
		description: 'ERD diagram controller must accept attribute controller as target'.
	self
		assert: (controller canBeTargetFor: OPErdExtensionsController new)
		description: 'ERD diagram controller must accept extensions controller as target'.
	self
		deny: (controller canBeTargetFor: OPErdTransitionController new)
		description: 'ERD diagram controller must reject transition controller as target'
]

{ #category : 'tests' }
OPErdControllerTest >> testControllerFactory [
	"Verify that the controller factory registers all core ERD model classes."

	| factory |
	factory := controller controllerFactory.
	self assert: (factory hasControllerFor: OPErdEntity new) description: 'Controller factory must register OPErdEntity'.
	self assert: (factory hasControllerFor: OPErdRelation new) description: 'Controller factory must register OPErdRelation'.
	self assert: (factory hasControllerFor: OPErdAttribute new) description: 'Controller factory must register OPErdAttribute'.
	self assert: (factory hasControllerFor: OPErdExtensions new) description: 'Controller factory must register OPErdExtensions'.
	self assert: (factory hasControllerFor: OPErdTransition new) description: 'Controller factory must register OPErdTransition'
]

{ #category : 'tests' }
OPErdControllerTest >> testInitializePalette [
	"Verify that the palette is populated with all expected ERD tools, types, and controller factories."

	| palette entries expectedSpecs |
	palette := OPPalette new.
	controller initializePalette: palette.
	self assert: palette items size equals: 21.

	entries := palette items select: [ :eachItem | eachItem isKindOf: OPPaletteEntry ].
	expectedSpecs := {
		                 {
			                 'Regular Entity'.
			                 OPNodeCreationTool.
			                 OPErdEntityController }.
		                 {
			                 'Weak Entity'.
			                 OPNodeCreationTool.
			                 OPErdWeakEntityController }.
		                 {
			                 'Regular Relation'.
			                 OPNodeCreationTool.
			                 OPErdRelationController }.
		                 {
			                 'Identifying Relation'.
			                 OPNodeCreationTool.
			                 OPErdIdentifyingRelationController }.
		                 {
			                 'Regular Attribute'.
			                 OPNodeCreationTool.
			                 OPErdAttributeController }.
		                 {
			                 'Derived Attribute'.
			                 OPNodeCreationTool.
			                 OPErdDerivedAttributeController }.
		                 {
			                 'Multivalued Attribute'.
			                 OPNodeCreationTool.
			                 OPErdMultivaluedAttributeController }.
		                 {
			                 'Key Attribute'.
			                 OPNodeCreationTool.
			                 OPErdKeyAttributeController }.
		                 {
			                 'Regular Connection'.
			                 OPConnectionCreationTool.
			                 OPErdTransitionController }.
		                 {
			                 'Total Connection'.
			                 OPConnectionCreationTool.
			                 OPErdTotalTransitionController }.
		                 {
			                 'Inheritance Connection'.
			                 OPConnectionCreationTool.
			                 OPErdInheritanceTransitionController }.
		                 {
			                 'Custom State'.
			                 OPNodeCreationTool.
			                 OPErdExtensionsController }.
		                 {
			                 'Union'.
			                 OPNodeCreationTool.
			                 OPErdUnionExtensionController }.
		                 {
			                 'Disjoint'.
			                 OPNodeCreationTool.
			                 OPErdDisjointExtensionController }.
		                 {
			                 'Overlapping'.
			                 OPNodeCreationTool.
			                 OPErdOverlappingExtensionController } }.

	self assertCollection: (entries collect: #label) includesAll: (expectedSpecs collect: #first).
	expectedSpecs do: [ :eachSpec |
			| entry |
			entry := entries detect: [ :eachEntry | eachEntry label = eachSpec first ].
			entry click.
			self assert: palette selectedTool class identicalTo: eachSpec second.
			self assert: (palette selectedTool instVarNamed: #factory) value class identicalTo: eachSpec third ]
]
