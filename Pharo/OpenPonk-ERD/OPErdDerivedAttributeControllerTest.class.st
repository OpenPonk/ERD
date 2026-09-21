Class {
	#name : 'OPErdDerivedAttributeControllerTest',
	#superclass : 'OPErdAttributeControllerTest',
	#category : 'OpenPonk-ERD-Tests',
	#package : 'OpenPonk-ERD',
	#tag : 'Tests'
}

{ #category : 'accessing' }
OPErdDerivedAttributeControllerTest >> controllerClass [
	"Answer the specialized controller class."
	^ OPErdDerivedAttributeController
]

{ #category : 'tests' }
OPErdDerivedAttributeControllerTest >> testCreateModelInCreatesDerivedAttribute [
	"Verify that createModelIn initializes a derived attribute model."
	| attrModel |
	attrModel := controller createModelIn: diagramController model.
	self assert: attrModel isDerived.
	self assert: controller model isDerived
]
