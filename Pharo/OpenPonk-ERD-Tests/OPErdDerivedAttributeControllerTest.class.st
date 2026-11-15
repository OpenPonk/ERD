"
Tests controller behaviors and dashed-border presentation for ERD derived attributes.
"
Class {
	#name : 'OPErdDerivedAttributeControllerTest',
	#superclass : 'OPErdAttributeControllerTest',
	#category : 'OpenPonk-ERD-Tests-Controllers',
	#package : 'OpenPonk-ERD-Tests',
	#tag : 'Controllers'
}

{ #category : 'constants' }
OPErdDerivedAttributeControllerTest >> controllerClass [
	"Answer the specialized controller class."

	^ OPErdDerivedAttributeController
]

{ #category : 'tests' }
OPErdDerivedAttributeControllerTest >> testCreateModelInCreatesDerivedAttribute [
	"Verify that createModelIn initializes a derived attribute model."

	| attributeModel |
	attributeModel := controller createModelIn: diagramController model.
	self assert: controller model identicalTo: attributeModel.
	self assert: attributeModel isDerived description: 'Created attribute model must be marked as derived'.
	self deny: attributeModel isNormal description: 'Derived attribute model must not report as normal'
]
