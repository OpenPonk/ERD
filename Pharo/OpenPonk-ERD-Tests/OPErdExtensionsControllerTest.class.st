"
Tests diagram controller operations for extended ERD relationships and generalizations.
"
Class {
	#name : 'OPErdExtensionsControllerTest',
	#superclass : 'OPControllerOfErdTest',
	#category : 'OpenPonk-ERD-Tests-Controllers',
	#package : 'OpenPonk-ERD-Tests',
	#tag : 'Controllers'
}

{ #category : 'constants' }
OPErdExtensionsControllerTest class >> diagramElementClass [
	"Answer the shape class representing an extension state."

	^ OPErdExtensionsShape
]

{ #category : 'constants' }
OPErdExtensionsControllerTest >> controllerClass [
	"Answer the controller class under test."

	^ OPErdExtensionsController
]

{ #category : 'constants' }
OPErdExtensionsControllerTest >> modelClass [
	"Answer the model class under test."

	^ OPErdExtensions
]

{ #category : 'tests' }
OPErdExtensionsControllerTest >> testCanBeSourceFor [

	self
		assert: (controller canBeSourceFor: OPErdTransitionController new)
		description: 'Extensions controller should accept regular transition as source'.
	self
		assert: (controller canBeSourceFor: OPErdTotalTransitionController new)
		description: 'Extensions controller should accept total transition as source'.
	self
		deny: (controller canBeSourceFor: OPErdInheritanceTransitionController new)
		description: 'Extensions controller must reject inheritance transition as source'.
	self
		deny: (controller canBeSourceFor: OPErdEntityController new)
		description: 'Extensions controller must reject non-transition controller as source'
]

{ #category : 'tests' }
OPErdExtensionsControllerTest >> testCanBeTargetFor [

	| entityController relationController attributeController otherExtensionController |
	self prepareToShow.
	entityController := self showNewModelInDiagram: (OPErdEntity named: 'Person').
	relationController := self showNewModelInDiagram: (OPErdRelation named: 'places').
	attributeController := self showNewModelInDiagram: (OPErdAttribute named: 'name').
	otherExtensionController := self showNewModelInDiagram: (OPErdExtensions named: 'OtherISA').

	self
		assert: (controller canBeTargetFor: (self connection: OPErdTransitionController from: entityController))
		description: 'Extensions should accept regular transition from entity'.
	self
		assert: (controller canBeTargetFor: (self connection: OPErdTotalTransitionController from: entityController))
		description: 'Extensions should accept total transition from entity'.
	self
		assert: (controller canBeTargetFor: (self connection: OPErdInheritanceTransitionController from: entityController))
		description: 'Extensions should accept inheritance transition from entity'.
	self
		deny: (controller canBeTargetFor: (self connection: OPErdTransitionController from: relationController))
		description: 'Extensions must reject transition from relation'.
	self
		deny: (controller canBeTargetFor: (self connection: OPErdTransitionController from: attributeController))
		description: 'Extensions must reject transition from attribute'.
	self
		deny: (controller canBeTargetFor: (self connection: OPErdTransitionController from: otherExtensionController))
		description: 'Extensions must reject transition from another extension'.
	self
		deny: (controller canBeTargetFor: entityController)
		description: 'Extensions must reject non-transition controller as target'
]
