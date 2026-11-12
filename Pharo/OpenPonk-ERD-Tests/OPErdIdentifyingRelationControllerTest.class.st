"
Tests controller behaviors and double-diamond visual presentation for ERD identifying relationships.
"
Class {
	#name : 'OPErdIdentifyingRelationControllerTest',
	#superclass : 'OPErdRelationControllerTest',
	#category : 'OpenPonk-ERD-Tests-Controllers',
	#package : 'OpenPonk-ERD-Tests',
	#tag : 'Controllers'
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
