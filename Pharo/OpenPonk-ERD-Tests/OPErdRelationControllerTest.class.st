"
Tests controller logic, connection routing, and diamond shape rendering for ERD relationships.
"
Class {
	#name : 'OPErdRelationControllerTest',
	#superclass : 'OPControllerOfErdTest',
	#category : 'OpenPonk-ERD-Tests-Controllers',
	#package : 'OpenPonk-ERD-Tests',
	#tag : 'Controllers'
}

{ #category : 'accessing' }
OPErdRelationControllerTest class >> diagramElementClass [
	"Answer the shape class representing a relation."
	^ OPErdRelationShape
]

{ #category : 'accessing' }
OPErdRelationControllerTest >> controllerClass [
	"Answer the controller class under test."
	^ OPErdRelationController
]

{ #category : 'accessing' }
OPErdRelationControllerTest >> modelClass [
	"Answer the model class under test."
	^ OPErdRelation
]

{ #category : 'tests' }
OPErdRelationControllerTest >> testCanBeSourceFor [

	self
		assert: (controller canBeSourceFor: OPErdTransitionController new)
		description: 'Relation controller should accept regular transition as source'.
	self
		assert: (controller canBeSourceFor: OPErdTotalTransitionController new)
		description: 'Relation controller should accept total transition as source'.
	self
		deny: (controller canBeSourceFor: OPErdInheritanceTransitionController new)
		description: 'Relation controller must reject inheritance transition as source'.
	self
		deny: (controller canBeSourceFor: OPErdEntityController new)
		description: 'Relation controller must reject non-transition controller as source'
]

{ #category : 'tests' }
OPErdRelationControllerTest >> testCanBeTargetFor [

	| regularEntityController weakEntityController normalAttributeController multivaluedAttributeController keyAttributeController derivedAttributeController otherRelationController extensionController |
	self prepareToShow.
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
	extensionController := self showNewModelInDiagram: (OPErdExtensions named: 'ISA').

	self
		assert: (controller canBeTargetFor: (self connection: OPErdTotalTransitionController from: weakEntityController))
		description: 'Relation should accept total transition from weak entity'.
	self
		deny: (controller canBeTargetFor: (self connection: OPErdTotalTransitionController from: regularEntityController))
		description: 'Relation must reject total transition from regular entity'.
	self
		deny: (controller canBeTargetFor: (self connection: OPErdTotalTransitionController from: normalAttributeController))
		description: 'Relation must reject total transition from attribute'.

	self
		assert: (controller canBeTargetFor: (self connection: OPErdTransitionController from: regularEntityController))
		description: 'Relation should accept regular transition from regular entity'.
	self
		deny: (controller canBeTargetFor: (self connection: OPErdTransitionController from: weakEntityController))
		description: 'Relation must reject regular transition from weak entity'.
	self
		assert: (controller canBeTargetFor: (self connection: OPErdTransitionController from: normalAttributeController))
		description: 'Relation should accept regular transition from normal attribute'.
	self
		assert: (controller canBeTargetFor: (self connection: OPErdTransitionController from: multivaluedAttributeController))
		description: 'Relation should accept regular transition from multivalued attribute'.
	self
		deny: (controller canBeTargetFor: (self connection: OPErdTransitionController from: keyAttributeController))
		description: 'Relation must reject regular transition from key attribute'.
	self
		deny: (controller canBeTargetFor: (self connection: OPErdTransitionController from: derivedAttributeController))
		description: 'Relation must reject regular transition from derived attribute'.
	self
		deny: (controller canBeTargetFor: (self connection: OPErdTransitionController from: otherRelationController))
		description: 'Relation must reject regular transition from another relation'.
	self
		deny: (controller canBeTargetFor: (self connection: OPErdTransitionController from: extensionController))
		description: 'Relation must reject regular transition from extension'.
	self
		deny: (controller canBeTargetFor: (self connection: OPErdInheritanceTransitionController from: regularEntityController))
		description: 'Relation must reject inheritance transition'.
	self
		deny: (controller canBeTargetFor: regularEntityController)
		description: 'Relation must reject non-transition controller as target'
]
