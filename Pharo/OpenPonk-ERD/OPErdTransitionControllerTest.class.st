Class {
	#name : 'OPErdTransitionControllerTest',
	#superclass : 'OPAbstractDirectionalRelationshipControllerTest',
	#category : 'OpenPonk-ERD-Tests',
	#package : 'OpenPonk-ERD',
	#tag : 'Tests'
}

{ #category : 'accessing' }
OPErdTransitionControllerTest class >> diagramElementClass [
	"Answer the edge shape class representing an ERD transition."
	^ OPErdTransitionShape
]

{ #category : 'accessing' }
OPErdTransitionControllerTest >> controllerClass [
	"Answer the relationship controller class under test."
	^ OPErdTransitionController
]

{ #category : 'accessing' }
OPErdTransitionControllerTest >> diagramControllerClass [
	"Answer the top-level diagram controller class."
	^ OPErdController
]

{ #category : 'accessing' }
OPErdTransitionControllerTest >> diagramModelClass [
	"Answer the diagram model container class."
	^ OPErd
]

{ #category : 'accessing' }
OPErdTransitionControllerTest >> modelClass [
	"Answer the transition model class."
	^ OPErdTransition
]

{ #category : 'accessing' }
OPErdTransitionControllerTest >> sourceControllerClass [
	"In ERD, standard transition connects from an Entity."
	^ OPErdEntityController
]

{ #category : 'accessing' }
OPErdTransitionControllerTest >> sourceModelClass [
	"Answer the source model class."
	^ OPErdEntity
]

{ #category : 'accessing' }
OPErdTransitionControllerTest >> targetControllerClass [
	"In ERD, standard transition connects to a Relation."
	^ OPErdRelationController
]

{ #category : 'accessing' }
OPErdTransitionControllerTest >> targetModelClass [
	"Answer the target model class."
	^ OPErdRelation
]
