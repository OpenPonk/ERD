"
Tests controller behaviors and underlined label rendering for ERD primary key attributes.
"
Class {
	#name : 'OPErdKeyAttributeControllerTest',
	#superclass : 'OPErdAttributeControllerTest',
	#category : 'OpenPonk-ERD-Tests-Controllers',
	#package : 'OpenPonk-ERD-Tests',
	#tag : 'Controllers'
}

{ #category : 'constants' }
OPErdKeyAttributeControllerTest >> controllerClass [
	"Answer the specialized controller class."

	^ OPErdKeyAttributeController
]

{ #category : 'tests' }
OPErdKeyAttributeControllerTest >> testCreateModelInCreatesKeyAttribute [
	"Verify that createModelIn initializes a key attribute model."

	| attributeModel |
	attributeModel := controller createModelIn: diagramController model.
	self assert: controller model identicalTo: attributeModel.
	self assert: attributeModel isKey description: 'Created attribute model must be marked as key'.
	self deny: attributeModel isNormal description: 'Key attribute model must not report as normal'
]
