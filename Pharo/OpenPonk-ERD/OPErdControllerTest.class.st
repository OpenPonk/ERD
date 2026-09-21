Class {
	#name : 'OPErdControllerTest',
	#superclass : 'OPAbstractDiagramControllerTest',
	#category : 'OpenPonk-ERD-Tests',
	#package : 'OpenPonk-ERD',
	#tag : 'Tests'
}

{ #category : 'accessing' }
OPErdControllerTest >> controllerClass [
	"Answer the diagram controller class under test."
	^ OPErdController
]

{ #category : 'accessing' }
OPErdControllerTest >> diagramModelClass [
	"Answer the diagram model container class."
	^ OPErd
]

{ #category : 'accessing' }
OPErdControllerTest >> modelClass [
	"Answer the model class managed by the diagram controller."
	^ OPErd
]

{ #category : 'accessing' }
OPErdControllerTest >> newModel [
	"Answer a new instance of the model container."
	^ OPErd new
]

{ #category : 'tests' }
OPErdControllerTest >> testCanBeTargetFor [
	"Verify valid and invalid target acceptance rules for the diagram controller."
	self assert: (controller canBeTargetFor: OPErdEntityController new).
	self assert: (controller canBeTargetFor: OPErdRelationController new).
	self assert: (controller canBeTargetFor: OPErdAttributeController new).
	self assert: (controller canBeTargetFor: OPErdExtensionsController new).
	self deny: (controller canBeTargetFor: OPErdTransitionController new)
]

{ #category : 'tests' }
OPErdControllerTest >> testControllerFactory [
	"Verify that the controller factory registers all core ERD model classes."
	| factory |
	factory := controller controllerFactory.
	self assert: (factory hasControllerFor: OPErdEntity new).
	self assert: (factory hasControllerFor: OPErdRelation new).
	self assert: (factory hasControllerFor: OPErdAttribute new).
	self assert: (factory hasControllerFor: OPErdExtensions new).
	self assert: (factory hasControllerFor: OPErdTransition new)
]

{ #category : 'tests' }
OPErdControllerTest >> testInitializePalette [
	"Verify that the palette is correctly populated with tools and separators (2 default + 19 ERD items = 21)."
	| palette |
	palette := OPPalette new.
	controller initializePalette: palette.
	self assert: palette items size equals: 21
]
