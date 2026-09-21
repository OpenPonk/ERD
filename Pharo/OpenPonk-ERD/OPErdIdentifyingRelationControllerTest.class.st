Class {
	#name : 'OPErdIdentifyingRelationControllerTest',
	#superclass : 'OPErdRelationControllerTest',
	#category : 'OpenPonk-ERD-Tests',
	#package : 'OpenPonk-ERD',
	#tag : 'Tests'
}

{ #category : 'accessing' }
OPErdIdentifyingRelationControllerTest >> controllerClass [
	"Answer the specialized controller class."
	^ OPErdIdentifyingRelationController
]

{ #category : 'tests' }
OPErdIdentifyingRelationControllerTest >> testCreateModelInCreatesIdentifyingRelation [
	"Verify that createModelIn initializes an identifying relation model."
	| relModel |
	relModel := controller createModelIn: diagramController model.
	self assert: relModel isIdentifying.
	self assert: controller model isIdentifying
]
