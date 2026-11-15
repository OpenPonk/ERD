"
Tests controller behaviors and double-border rendering for ERD weak entities.
"
Class {
	#name : 'OPErdWeakEntityControllerTest',
	#superclass : 'OPErdEntityControllerTest',
	#category : 'OpenPonk-ERD-Tests-Controllers',
	#package : 'OpenPonk-ERD-Tests',
	#tag : 'Controllers'
}

{ #category : 'accessing' }
OPErdWeakEntityControllerTest >> controllerClass [
	"Answer the specialized controller class."
	^ OPErdWeakEntityController
]

{ #category : 'tests' }
OPErdWeakEntityControllerTest >> testCanBeTargetForConnectionRules [

	| otherEntityController regularRelationController identifyingRelationController attributeController extensionController bareRelationSourceController |
	controller createModelIn: diagramController model.
	otherEntityController := self showNewModelInDiagram: (OPErdEntity named: 'Owner').
	regularRelationController := self showNewModelInDiagram: (OPErdRelation named: 'has').
	identifyingRelationController := self showNewModelInDiagram: ((OPErdRelation named: 'owns')
			                                  beIdentifying;
			                                  yourself).
	attributeController := self showNewModelInDiagram: (OPErdAttribute named: 'number').
	extensionController := self showNewModelInDiagram: (OPErdExtensions named: 'ISA').
	bareRelationSourceController := OPErdRelationController new.

	self
		assert: (controller canBeTargetFor: (self connection: OPErdTotalTransitionController from: regularRelationController))
		description: 'Weak entity should accept total transition from regular relation'.
	self
		assert: (controller canBeTargetFor: (self connection: OPErdTotalTransitionController from: identifyingRelationController))
		description: 'Weak entity should accept total transition from identifying relation'.
	self
		assert: (controller canBeTargetFor: (self connection: OPErdTotalTransitionController from: extensionController))
		description: 'Weak entity should accept total transition from extension'.
	self
		deny: (controller canBeTargetFor: (self connection: OPErdTotalTransitionController from: otherEntityController))
		description: 'Weak entity must reject total transition from entity'.
	self
		deny: (controller canBeTargetFor: (self connection: OPErdTotalTransitionController from: attributeController))
		description: 'Weak entity must reject total transition from attribute'.

	self
		assert: (controller canBeTargetFor: (self connection: OPErdInheritanceTransitionController from: otherEntityController))
		description: 'Weak entity should accept inheritance transition from another entity'.
	self
		deny: (controller canBeTargetFor: (self connection: OPErdInheritanceTransitionController from: controller))
		description: 'Weak entity must reject inheritance self-loop'.
	self
		deny: (controller canBeTargetFor: (self connection: OPErdInheritanceTransitionController from: bareRelationSourceController))
		description: 'Weak entity must short-circuit and reject inheritance from non-entity source'.

	self
		assert: (controller canBeTargetFor: (self connection: OPErdTransitionController from: attributeController))
		description: 'Weak entity should accept regular transition from attribute'.
	self
		assert: (controller canBeTargetFor: (self connection: OPErdTransitionController from: extensionController))
		description: 'Weak entity should accept regular transition from extension'.
	self
		deny: (controller canBeTargetFor: (self connection: OPErdTransitionController from: regularRelationController))
		description: 'Weak entity must reject regular transition from relation'.
	self
		deny: (controller canBeTargetFor: (self connection: OPErdTransitionController from: otherEntityController))
		description: 'Weak entity must reject regular transition from another entity'.
	self
		deny: (controller canBeTargetFor: attributeController)
		description: 'Weak entity must reject non-transition controller as target'
]

{ #category : 'tests' }
OPErdWeakEntityControllerTest >> testCanBeTargetForTotalTransitionFromRelation [
	"Verify that weak entity can be targeted by a total transition from a relation."

	| transitionController relationController |
	controller createModelIn: diagramController model.
	transitionController := OPErdTotalTransitionController new.
	relationController := diagramController newControllerFor: OPErdRelation new.
	transitionController source: relationController.
	self
		assert: (controller canBeTargetFor: transitionController)
		description: 'Weak entity must accept total transition from a relation'
]

{ #category : 'tests' }
OPErdWeakEntityControllerTest >> testCreateModelInCreatesWeakEntity [
	"Verify that createModelIn initializes a weak entity model."

	| entityModel |
	entityModel := controller createModelIn: diagramController model.
	self assert: controller model identicalTo: entityModel.
	self assert: entityModel isWeak description: 'Created entity model must be marked as weak'.
	self deny: entityModel isNormal description: 'Weak entity model must not report as normal'
]
