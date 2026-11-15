"
Tests controller interactions and line routing for directional connections in ERD.
"
Class {
	#name : 'OPErdTransitionControllerTest',
	#superclass : 'OPAbstractDirectionalRelationshipControllerTest',
	#category : 'OpenPonk-ERD-Tests-Controllers',
	#package : 'OpenPonk-ERD-Tests',
	#tag : 'Controllers'
}

{ #category : 'constants' }
OPErdTransitionControllerTest class >> diagramElementClass [
	"Answer the edge shape class representing an ERD transition."

	^ OPErdTransitionShape
]

{ #category : 'constants' }
OPErdTransitionControllerTest >> controllerClass [
	"Answer the relationship controller class under test."

	^ OPErdTransitionController
]

{ #category : 'constants' }
OPErdTransitionControllerTest >> diagramControllerClass [
	"Answer the top-level diagram controller class."

	^ OPErdController
]

{ #category : 'constants' }
OPErdTransitionControllerTest >> diagramModelClass [
	"Answer the diagram model container class."

	^ OPErd
]

{ #category : 'constants' }
OPErdTransitionControllerTest >> modelClass [
	"Answer the transition model class."

	^ OPErdTransition
]

{ #category : 'constants' }
OPErdTransitionControllerTest >> sourceControllerClass [
	"In ERD, standard transition connects from an Entity."

	^ OPErdEntityController
]

{ #category : 'constants' }
OPErdTransitionControllerTest >> sourceModelClass [
	"Answer the source model class."

	^ OPErdEntity
]

{ #category : 'constants' }
OPErdTransitionControllerTest >> targetControllerClass [
	"In ERD, standard transition connects to a Relation."

	^ OPErdRelationController
]

{ #category : 'constants' }
OPErdTransitionControllerTest >> targetModelClass [
	"Answer the target model class."

	^ OPErdRelation
]
