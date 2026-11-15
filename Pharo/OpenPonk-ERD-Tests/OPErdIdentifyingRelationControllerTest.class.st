"
Tests controller behaviors and double-diamond visual presentation for ERD identifying relationships.
"
Class {
	#name : 'OPErdIdentifyingRelationControllerTest',
	#superclass : 'OPErdRelationControllerTest',
	#category : 'OpenPonk-ERD-Tests-Controllers',
	#package : 'OpenPonk-ERD-Tests',
	#tag : 'Controllers'
}

{ #category : 'accessing' }
OPErdIdentifyingRelationControllerTest >> controllerClass [
	"Answer the specialized controller class."
	^ OPErdIdentifyingRelationController
]

{ #category : 'tests' }
OPErdIdentifyingRelationControllerTest >> testCanBeTargetForConnectionRules [

	| regularEntityController weakEntityController normalAttributeController multivaluedAttributeController keyAttributeController derivedAttributeController otherRelationController |
	controller createModelIn: diagramController model.
	regularEntityController := self showNewModelInDiagram: (OPErdEntity named: 'Customer').
	weakEntityController := self showNewModelInDiagram: ((OPErdEntity named: 'OrderItem')
			                         beWeak;
			                         yourself).
	normalAttributeController := self showNewModelInDiagram: (OPErdAttribute named: 'date').
	multivaluedAttributeController := self showNewModelInDiagram: ((OPErdAttribute named: 'tags')
			                                   beMultivalued;
			                                   yourself).
	keyAttributeController := self showNewModelInDiagram: ((OPErdAttribute named: 'id')
			                           beKey;
			                           yourself).
	derivedAttributeController := self showNewModelInDiagram: ((OPErdAttribute named: 'total')
			                               beDerived;
			                               yourself).
	otherRelationController := self showNewModelInDiagram: (OPErdRelation named: 'other').

	self
		assert: (controller canBeTargetFor: (self connection: OPErdTotalTransitionController from: weakEntityController))
		description: 'Identifying relation should accept total transition from weak entity'.
	self
		deny: (controller canBeTargetFor: (self connection: OPErdTotalTransitionController from: regularEntityController))
		description: 'Identifying relation must reject total transition from regular entity'.
	self
		deny: (controller canBeTargetFor: (self connection: OPErdTotalTransitionController from: normalAttributeController))
		description: 'Identifying relation must reject total transition from attribute'.

	self
		assert: (controller canBeTargetFor: (self connection: OPErdTransitionController from: normalAttributeController))
		description: 'Identifying relation should accept regular transition from normal attribute'.
	self
		assert: (controller canBeTargetFor: (self connection: OPErdTransitionController from: multivaluedAttributeController))
		description: 'Identifying relation should accept regular transition from multivalued attribute'.
	self
		deny: (controller canBeTargetFor: (self connection: OPErdTransitionController from: keyAttributeController))
		description: 'Identifying relation must reject regular transition from key attribute'.
	self
		deny: (controller canBeTargetFor: (self connection: OPErdTransitionController from: derivedAttributeController))
		description: 'Identifying relation must reject regular transition from derived attribute'.
	self
		assert: (controller canBeTargetFor: (self connection: OPErdTransitionController from: regularEntityController))
		description: 'Identifying relation should accept regular transition from regular entity'.
	self
		deny: (controller canBeTargetFor: (self connection: OPErdTransitionController from: weakEntityController))
		description: 'Identifying relation must reject regular transition from weak entity'.
	self
		deny: (controller canBeTargetFor: (self connection: OPErdTransitionController from: otherRelationController))
		description: 'Identifying relation must reject regular transition from another relation'.
	self
		deny: (controller canBeTargetFor: (self connection: OPErdInheritanceTransitionController from: regularEntityController))
		description: 'Identifying relation must reject inheritance transition'.
	self
		deny: (controller canBeTargetFor: regularEntityController)
		description: 'Identifying relation must reject non-transition controller as target'
]

{ #category : 'tests' }
OPErdIdentifyingRelationControllerTest >> testCreateModelInCreatesIdentifyingRelation [
	"Verify that createModelIn initializes an identifying relation model."

	| relationModel |
	relationModel := controller createModelIn: diagramController model.
	self assert: controller model identicalTo: relationModel.
	self assert: relationModel isIdentifying description: 'Created relation model must be marked as identifying'.
	self deny: relationModel isNormal description: 'Identifying relation model must not report as normal'
]
