Class {
	#name : 'OPErdKeyAttributeControllerTest',
	#superclass : 'OPErdAttributeControllerTest',
	#category : 'OpenPonk-ERD-Tests',
	#package : 'OpenPonk-ERD',
	#tag : 'Tests'
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
