Class {
	#name : 'OPErdAttributeControllerTest',
	#superclass : 'OPControllerOfErdTest',
	#category : 'OpenPonk-ERD-Tests',
	#package : 'OpenPonk-ERD',
	#tag : 'Tests'
}

{ #category : 'accessing' }
OPErdAttributeControllerTest class >> diagramElementClass [
	"Answer the shape class representing an attribute."
	^ OPErdAttributeShape
]

{ #category : 'accessing' }
OPErdAttributeControllerTest >> controllerClass [
	"Answer the controller class under test."
	^ OPErdAttributeController
]

{ #category : 'accessing' }
OPErdAttributeControllerTest >> modelClass [
	"Answer the model class under test."
	^ OPErdAttribute
]
