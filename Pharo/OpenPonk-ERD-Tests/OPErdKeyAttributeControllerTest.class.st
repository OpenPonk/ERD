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

{ #category : 'accessing' }
OPErdKeyAttributeControllerTest >> controllerClass [
	"Answer the specialized controller class."
	^ OPErdKeyAttributeController
]

{ #category : 'tests' }
OPErdKeyAttributeControllerTest >> testCreateModelInCreatesKeyAttribute [
	"Verify that createModelIn initializes a key attribute model."
	| attrModel |
	attrModel := controller createModelIn: diagramController model.
	self assert: attrModel isKey.
	self assert: controller model isKey
]
