"
Tests controller behaviors, name editing, and rectangular rendering for ERD regular entities.
"
Class {
	#name : 'OPErdEntityControllerTest',
	#superclass : 'OPControllerOfErdTest',
	#category : 'OpenPonk-ERD-Tests-Controllers',
	#package : 'OpenPonk-ERD-Tests',
	#tag : 'Controllers'
}

{ #category : 'constants' }
OPErdEntityControllerTest class >> diagramElementClass [
	"Answer the shape class representing an entity."

	^ OPErdEntityShape
]

{ #category : 'constants' }
OPErdEntityControllerTest >> controllerClass [
	"Answer the controller class under test."

	^ OPErdEntityController
]

{ #category : 'constants' }
OPErdEntityControllerTest >> modelClass [
	"Answer the model class under test."

	^ OPErdEntity
]

{ #category : 'tests' }
OPErdEntityControllerTest >> testCanBeSourceFor [

	self
		assert: (controller canBeSourceFor: OPErdTransitionController new)
		description: 'Entity controller should accept regular transition as source'.
	self
		assert: (controller canBeSourceFor: OPErdTotalTransitionController new)
		description: 'Entity controller should accept total transition as source'.
	self
		assert: (controller canBeSourceFor: OPErdInheritanceTransitionController new)
		description: 'Entity controller should accept inheritance transition as source'.
	self
		deny: (controller canBeSourceFor: OPErdEntityController new)
		description: 'Entity controller must reject non-transition controller as source'
]

{ #category : 'tests' }
OPErdEntityControllerTest >> testCanBeTargetFor [

	| otherEntityController regularRelationController identifyingRelationController attributeController extensionController weakViaFactoryController |
	self prepareToShow.
	otherEntityController := self showNewModelInDiagram: (OPErdEntity named: 'Order').
	regularRelationController := self showNewModelInDiagram: (OPErdRelation named: 'places').
	identifyingRelationController := self showNewModelInDiagram: ((OPErdRelation named: 'contains')
			                                  beIdentifying;
			                                  yourself).
	attributeController := self showNewModelInDiagram: (OPErdAttribute named: 'name').
	extensionController := self showNewModelInDiagram: (OPErdExtensions named: 'ISA').

	self
		assert: (controller canBeTargetFor: (self connection: OPErdTransitionController from: regularRelationController))
		description: 'Regular entity should accept regular transition from relation'.
	self
		assert: (controller canBeTargetFor: (self connection: OPErdTransitionController from: attributeController))
		description: 'Regular entity should accept regular transition from attribute'.
	self
		assert: (controller canBeTargetFor: (self connection: OPErdTransitionController from: extensionController))
		description: 'Regular entity should accept regular transition from extension'.
	self
		deny: (controller canBeTargetFor: (self connection: OPErdTransitionController from: otherEntityController))
		description: 'Regular entity must reject regular transition from another entity'.

	self
		assert: (controller canBeTargetFor: (self connection: OPErdTotalTransitionController from: regularRelationController))
		description: 'Regular entity should accept total transition from non-identifying relation'.
	self
		deny: (controller canBeTargetFor: (self connection: OPErdTotalTransitionController from: identifyingRelationController))
		description: 'Regular entity must reject total transition from identifying relation'.
	self
		assert: (controller canBeTargetFor: (self connection: OPErdTotalTransitionController from: extensionController))
		description: 'Regular entity should accept total transition from extension'.
	self
		deny: (controller canBeTargetFor: (self connection: OPErdTotalTransitionController from: otherEntityController))
		description: 'Regular entity must reject total transition from another entity'.
	self
		deny: (controller canBeTargetFor: (self connection: OPErdTotalTransitionController from: attributeController))
		description: 'Regular entity must reject total transition from attribute'.

	self
		assert: (controller canBeTargetFor: (self connection: OPErdInheritanceTransitionController from: otherEntityController))
		description: 'Regular entity should accept inheritance transition from another entity'.
	self
		deny: (controller canBeTargetFor: (self connection: OPErdInheritanceTransitionController from: controller))
		description: 'Regular entity must reject inheritance self-loop'.
	self
		deny: (controller canBeTargetFor: (self connection: OPErdInheritanceTransitionController from: regularRelationController))
		description: 'Regular entity must reject inheritance transition from relation'.
	self
		deny: (controller canBeTargetFor: attributeController)
		description: 'Regular entity must reject non-transition controller as target'.

	weakViaFactoryController := self showNewModelInDiagram: ((OPErdEntity named: 'Item')
			                             beWeak;
			                             yourself).
	self
		assert: (weakViaFactoryController canBeTargetFor: (self connection: OPErdTransitionController from: attributeController))
		description: 'Weak entity via factory controller should accept regular transition from attribute'.
	self
		deny: (weakViaFactoryController canBeTargetFor: (self connection: OPErdTransitionController from: regularRelationController))
		description: 'Weak entity via factory controller must reject regular transition from relation'
]
