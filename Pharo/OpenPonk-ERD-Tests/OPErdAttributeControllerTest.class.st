"
Tests controller logic, connection lines, and oval shape rendering for ERD attributes.
"
Class {
	#name : 'OPErdAttributeControllerTest',
	#superclass : 'OPControllerOfErdTest',
	#category : 'OpenPonk-ERD-Tests-Controllers',
	#package : 'OpenPonk-ERD-Tests',
	#tag : 'Controllers'
}

{ #category : 'constants' }
OPErdAttributeControllerTest class >> diagramElementClass [
	"Answer the shape class representing an attribute."

	^ OPErdAttributeShape
]

{ #category : 'constants' }
OPErdAttributeControllerTest >> controllerClass [
	"Answer the controller class under test."

	^ OPErdAttributeController
]

{ #category : 'constants' }
OPErdAttributeControllerTest >> modelClass [
	"Answer the model class under test."

	^ OPErdAttribute
]

{ #category : 'tests' }
OPErdAttributeControllerTest >> testCanBeSourceFor [

	self
		assert: (controller canBeSourceFor: OPErdTransitionController new)
		description: 'Attribute controller should accept regular transition as source'.
	self
		deny: (controller canBeSourceFor: OPErdTotalTransitionController new)
		description: 'Attribute controller must reject total transition as source'.
	self
		deny: (controller canBeSourceFor: OPErdInheritanceTransitionController new)
		description: 'Attribute controller must reject inheritance transition as source'.
	self
		deny: (controller canBeSourceFor: OPErdEntityController new)
		description: 'Attribute controller must reject non-transition controller as source'
]

{ #category : 'tests' }
OPErdAttributeControllerTest >> testCanBeTargetFor [

	| entityController relationController extensionController otherAttributeController multivaluedAttributeController derivedAttributeController keyAttributeController targetKeyController targetDerivedController |
	self prepareToShow.
	entityController := self showNewModelInDiagram: (OPErdEntity named: 'Customer').
	relationController := self showNewModelInDiagram: (OPErdRelation named: 'places').
	extensionController := self showNewModelInDiagram: (OPErdExtensions named: 'ISA').
	otherAttributeController := self showNewModelInDiagram: (OPErdAttribute named: 'city').
	multivaluedAttributeController := self showNewModelInDiagram: ((OPErdAttribute named: 'phones')
			                                   beMultivalued;
			                                   yourself).
	derivedAttributeController := self showNewModelInDiagram: ((OPErdAttribute named: 'age')
			                               beDerived;
			                               yourself).
	keyAttributeController := self showNewModelInDiagram: ((OPErdAttribute named: 'id')
			                           beKey;
			                           yourself).

	self
		assert: (controller canBeTargetFor: (self connection: OPErdTransitionController from: entityController))
		description: 'Normal attribute should accept regular transition from entity'.
	self
		assert: (controller canBeTargetFor: (self connection: OPErdTransitionController from: relationController))
		description: 'Normal attribute should accept regular transition from relation'.
	self
		assert: (controller canBeTargetFor: (self connection: OPErdTransitionController from: otherAttributeController))
		description: 'Normal attribute should accept regular transition from another normal attribute'.
	self
		assert: (controller canBeTargetFor: (self connection: OPErdTransitionController from: multivaluedAttributeController))
		description: 'Normal attribute should accept regular transition from multivalued attribute'.
	self
		deny: (controller canBeTargetFor: (self connection: OPErdTransitionController from: controller))
		description: 'Attribute must reject self-loop regular transition'.
	self
		deny: (controller canBeTargetFor: (self connection: OPErdTransitionController from: derivedAttributeController))
		description: 'Normal attribute must reject regular transition from derived attribute'.
	self
		deny: (controller canBeTargetFor: (self connection: OPErdTransitionController from: keyAttributeController))
		description: 'Normal attribute must reject regular transition from key attribute'.
	self
		deny: (controller canBeTargetFor: (self connection: OPErdTransitionController from: extensionController))
		description: 'Attribute must reject regular transition from extension'.
	self
		deny: (controller canBeTargetFor: (self connection: OPErdTotalTransitionController from: entityController))
		description: 'Attribute must reject total transition'.
	self
		deny: (controller canBeTargetFor: (self connection: OPErdInheritanceTransitionController from: entityController))
		description: 'Attribute must reject inheritance transition'.
	self deny: (controller canBeTargetFor: entityController) description: 'Attribute must reject non-transition controller as target'.

	targetKeyController := self showNewModelInDiagram: ((OPErdAttribute named: 'ssn')
			                        beKey;
			                        yourself).
	targetDerivedController := self showNewModelInDiagram: ((OPErdAttribute named: 'total')
			                            beDerived;
			                            yourself).
	{
		targetKeyController.
		targetDerivedController } do: [ :eachSpecialAttributeController |
			self
				assert: (eachSpecialAttributeController canBeTargetFor: (self connection: OPErdTransitionController from: entityController))
				description: 'Key or derived attribute should accept regular transition from entity'.
			self
				deny: (eachSpecialAttributeController canBeTargetFor: (self connection: OPErdTransitionController from: relationController))
				description: 'Key or derived attribute must reject regular transition from relation'.
			self
				deny:
				(eachSpecialAttributeController canBeTargetFor: (self connection: OPErdTransitionController from: otherAttributeController))
				description: 'Key or derived attribute must reject regular transition from another attribute' ]
]
