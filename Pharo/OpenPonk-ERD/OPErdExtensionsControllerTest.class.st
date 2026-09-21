Class {
	#name : 'OPErdExtensionsControllerTest',
	#superclass : 'OPControllerOfErdTest',
	#category : 'OpenPonk-ERD-Tests',
	#package : 'OpenPonk-ERD',
	#tag : 'Tests'
}

{ #category : 'accessing' }
OPErdExtensionsControllerTest class >> diagramElementClass [
	"Answer the shape class representing an extension state."
	^ OPErdExtensionsShape
]

{ #category : 'accessing' }
OPErdExtensionsControllerTest >> controllerClass [
	"Answer the controller class under test."
	^ OPErdExtensionsController
]

{ #category : 'accessing' }
OPErdExtensionsControllerTest >> modelClass [
	"Answer the model class under test."
	^ OPErdExtensions
]
