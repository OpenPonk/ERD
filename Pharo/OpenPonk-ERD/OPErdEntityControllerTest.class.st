Class {
	#name : 'OPErdEntityControllerTest',
	#superclass : 'OPControllerOfErdTest',
	#category : 'OpenPonk-ERD-Tests',
	#package : 'OpenPonk-ERD',
	#tag : 'Tests'
}

{ #category : 'accessing' }
OPErdEntityControllerTest class >> diagramElementClass [
	"Answer the shape class representing an entity."
	^ OPErdEntityShape
]

{ #category : 'accessing' }
OPErdEntityControllerTest >> controllerClass [
	"Answer the controller class under test."
	^ OPErdEntityController
]

{ #category : 'accessing' }
OPErdEntityControllerTest >> modelClass [
	"Answer the model class under test."
	^ OPErdEntity
]
