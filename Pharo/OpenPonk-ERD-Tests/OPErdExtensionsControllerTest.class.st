"
Tests diagram controller operations for extended ERD relationships and generalizations.
"
Class {
	#name : 'OPErdExtensionsControllerTest',
	#superclass : 'OPControllerOfErdTest',
	#category : 'OpenPonk-ERD-Tests-Controllers',
	#package : 'OpenPonk-ERD-Tests',
	#tag : 'Controllers'
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
