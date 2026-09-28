"
Tests controller logic, connection routing, and diamond shape rendering for ERD relationships.
"
Class {
	#name : 'OPErdRelationControllerTest',
	#superclass : 'OPControllerOfErdTest',
	#category : 'OpenPonk-ERD-Tests',
	#package : 'OpenPonk-ERD',
	#tag : 'Tests'
}

{ #category : 'accessing' }
OPErdRelationControllerTest class >> diagramElementClass [
	"Answer the shape class representing a relation."
	^ OPErdRelationShape
]

{ #category : 'accessing' }
OPErdRelationControllerTest >> controllerClass [
	"Answer the controller class under test."
	^ OPErdRelationController
]

{ #category : 'accessing' }
OPErdRelationControllerTest >> modelClass [
	"Answer the model class under test."
	^ OPErdRelation
]
