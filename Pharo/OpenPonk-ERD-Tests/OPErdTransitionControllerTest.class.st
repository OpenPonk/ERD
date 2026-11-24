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

{ #category : 'tests' }
OPErdTransitionControllerTest >> testShowInDiagramEnsuresSourceAndTarget [

	| sourceEntity targetRelation transitionModel shownController |
	sourceEntity := OPErdEntity named: 'Customer'.
	targetRelation := OPErdRelation named: 'places'.
	transitionModel := OPErdTransition from: sourceEntity to: targetRelation named: '1'.
	diagramController model addAll: {
			sourceEntity.
			targetRelation.
			transitionModel }.

	shownController := diagramController showInDiagramModel: transitionModel.
	self assert: shownController model identicalTo: transitionModel.
	self assert: shownController source model identicalTo: sourceEntity.
	self assert: shownController target model identicalTo: targetRelation.
	self
		assert: (diagramController hasControllerForModel: sourceEntity)
		description: 'Showing transition must also show its source entity'.
	self
		assert: (diagramController hasControllerForModel: targetRelation)
		description: 'Showing transition must also show its target relation'
]
