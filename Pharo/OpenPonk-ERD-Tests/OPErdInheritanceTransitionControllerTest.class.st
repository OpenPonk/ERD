"
Tests controller interactions and rendering for ERD inheritance transitions.
"
Class {
	#name : 'OPErdInheritanceTransitionControllerTest',
	#superclass : 'OPErdTransitionControllerTest',
	#category : 'OpenPonk-ERD-Tests-Controllers',
	#package : 'OpenPonk-ERD-Tests',
	#tag : 'Controllers'
}

{ #category : 'accessing' }
OPErdInheritanceTransitionControllerTest >> controllerClass [
	"Answer the specialized controller class."
	^ OPErdInheritanceTransitionController
]

{ #category : 'accessing' }
OPErdInheritanceTransitionControllerTest >> targetControllerClass [
	^ OPErdExtensionsController
]

{ #category : 'tests' }
OPErdInheritanceTransitionControllerTest >> testCreateModelInCreatesInheritanceTransition [
	"Verify that createModelIn initializes an inheritance transition model."

	| transitionModel customSourceController customTargetController |
	customSourceController := diagramController newControllerFor: OPErdEntity new.
	customTargetController := diagramController newControllerFor: OPErdEntity new.
	controller source: customSourceController.
	controller target: customTargetController.
	transitionModel := controller createModelIn: diagramController model.
	self assert: controller model identicalTo: transitionModel.
	self assert: transitionModel isInheritance description: 'Created transition model must be marked as inheritance'.
	self deny: transitionModel isNormal description: 'Inheritance transition model must not report as normal'
]
