Class {
	#name : 'OPErdMultivaluedAttributeControllerTest',
	#superclass : 'OPErdAttributeControllerTest',
	#category : 'OpenPonk-ERD-Tests',
	#package : 'OpenPonk-ERD',
	#tag : 'Tests'
}

{ #category : 'accessing' }
OPErdMultivaluedAttributeControllerTest >> controllerClass [
	"Answer the specialized controller class."
	^ OPErdMultivaluedAttributeController
]

{ #category : 'tests' }
OPErdMultivaluedAttributeControllerTest >> testCreateModelInCreatesMultivaluedAttribute [
	"Verify that createModelIn initializes a multivalued attribute model."
	| attrModel |
	attrModel := controller createModelIn: diagramController model.
	self assert: attrModel isMultivalued.
	self assert: controller model isMultivalued
]
