Class {
	#name : 'OPErdInheritanceTransitionControllerTest',
	#superclass : 'OPErdTransitionControllerTest',
	#category : 'OpenPonk-ERD-Tests',
	#package : 'OpenPonk-ERD',
	#tag : 'Tests'
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
	| transModel sourceCtrl targetCtrl |
	sourceCtrl := diagramController newControllerFor: OPErdEntity new.
	targetCtrl := diagramController newControllerFor: OPErdEntity new.
	controller source: sourceCtrl.
	controller target: targetCtrl.
	transModel := controller createModelIn: diagramController model.
	self assert: transModel isInheritance.
	self assert: controller model isInheritance
]
