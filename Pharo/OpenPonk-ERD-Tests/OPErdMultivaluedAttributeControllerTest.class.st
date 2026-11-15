"
Tests controller behaviors and visual presentation for ERD multivalued attributes.
"
Class {
	#name : 'OPErdMultivaluedAttributeControllerTest',
	#superclass : 'OPErdAttributeControllerTest',
	#category : 'OpenPonk-ERD-Tests-Controllers',
	#package : 'OpenPonk-ERD-Tests',
	#tag : 'Controllers'
}

{ #category : 'accessing' }
OPErdMultivaluedAttributeControllerTest >> controllerClass [
	"Answer the specialized controller class."
	^ OPErdMultivaluedAttributeController
]

{ #category : 'tests' }
OPErdMultivaluedAttributeControllerTest >> testCreateModelInCreatesMultivaluedAttribute [
	"Verify that createModelIn initializes a multivalued attribute model."

	| attributeModel |
	attributeModel := controller createModelIn: diagramController model.
	self assert: controller model identicalTo: attributeModel.
	self assert: attributeModel isMultivalued description: 'Created attribute model must be marked as multivalued'.
	self deny: attributeModel isNormal description: 'Multivalued attribute model must not report as normal'
]
