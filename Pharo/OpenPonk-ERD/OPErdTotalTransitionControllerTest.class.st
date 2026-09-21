Class {
	#name : 'OPErdTotalTransitionControllerTest',
	#superclass : 'OPErdTransitionControllerTest',
	#category : 'OpenPonk-ERD-Tests',
	#package : 'OpenPonk-ERD',
	#tag : 'Tests'
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
	| transModel sourceCtrl targetCtrl |
	sourceCtrl := diagramController newControllerFor: OPErdEntity new.
	targetCtrl := diagramController newControllerFor: OPErdRelation new.
	controller source: sourceCtrl.
	controller target: targetCtrl.
	transModel := controller createModelIn: diagramController model.
	self assert: transModel isTotal.
	self assert: controller model isTotal
]
