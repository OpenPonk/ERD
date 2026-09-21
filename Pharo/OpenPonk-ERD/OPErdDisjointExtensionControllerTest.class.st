Class {
	#name : 'OPErdDisjointExtensionControllerTest',
	#superclass : 'OPErdExtensionsControllerTest',
	#category : 'OpenPonk-ERD-Tests',
	#package : 'OpenPonk-ERD',
	#tag : 'Tests'
}

{ #category : 'accessing' }
OPErdDisjointExtensionControllerTest >> controllerClass [
	"Answer the specialized controller class."
	^ OPErdDisjointExtensionController
]

{ #category : 'tests' }
OPErdDisjointExtensionControllerTest >> testCreateModelInCreatesDisjointExtension [
	"Verify that createModelIn initializes a disjoint extension model."
	| extModel |
	extModel := controller createModelIn: diagramController model.
	self assert: extModel isDisjoint.
	self assert: controller model isDisjoint
]
