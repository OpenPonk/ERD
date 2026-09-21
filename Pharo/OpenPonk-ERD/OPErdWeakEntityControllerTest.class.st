Class {
	#name : 'OPErdWeakEntityControllerTest',
	#superclass : 'OPErdEntityControllerTest',
	#category : 'OpenPonk-ERD-Tests',
	#package : 'OpenPonk-ERD',
	#tag : 'Tests'
}

{ #category : 'accessing' }
OPErdWeakEntityControllerTest >> controllerClass [
	"Answer the specialized controller class."
	^ OPErdWeakEntityController
]

{ #category : 'tests' }
OPErdWeakEntityControllerTest >> testCanBeTargetForTotalTransitionFromRelation [
	"Verify that weak entity can be targeted by a total transition from a relation."
	| transitionCtrl relCtrl |
	transitionCtrl := OPErdTotalTransitionController new.
	relCtrl := diagramController newControllerFor: OPErdRelation new.
	transitionCtrl source: relCtrl.
	self assert: (controller canBeTargetFor: transitionCtrl)
]

{ #category : 'tests' }
OPErdWeakEntityControllerTest >> testCreateModelInCreatesWeakEntity [
	"Verify that createModelIn initializes a weak entity model."
	| entityModel |
	entityModel := controller createModelIn: diagramController model.
	self assert: entityModel isWeak.
	self assert: controller model isWeak
]
