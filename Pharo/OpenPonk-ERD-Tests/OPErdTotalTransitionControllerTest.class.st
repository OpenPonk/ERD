"
Tests controller interactions and visual double-line semantics for total specialization transitions in ERD.
"
Class {
	#name : 'OPErdTotalTransitionControllerTest',
	#superclass : 'OPErdTransitionControllerTest',
	#category : 'OpenPonk-ERD-Tests-Controllers',
	#package : 'OpenPonk-ERD-Tests',
	#tag : 'Controllers'
}

{ #category : 'accessing' }
OPErdTotalTransitionControllerTest >> controllerClass [
	"Answer the specialized controller class."
	^ OPErdTotalTransitionController
]

{ #category : 'accessing' }
OPErdTotalTransitionControllerTest >> sourceControllerClass [
	^ OPErdWeakEntityController
]

{ #category : 'tests' }
OPErdTotalTransitionControllerTest >> testCreateModelInCreatesTotalTransition [
	"Verify that createModelIn initializes a total transition model."

	| transitionModel customSourceController customTargetController |
	customSourceController := diagramController newControllerFor: OPErdEntity new.
	customTargetController := diagramController newControllerFor: OPErdRelation new.
	controller source: customSourceController.
	controller target: customTargetController.
	transitionModel := controller createModelIn: diagramController model.
	self assert: controller model identicalTo: transitionModel.
	self assert: transitionModel isTotal description: 'Created transition model must be marked as total'.
	self deny: transitionModel isNormal description: 'Total transition model must not report as normal'
]
