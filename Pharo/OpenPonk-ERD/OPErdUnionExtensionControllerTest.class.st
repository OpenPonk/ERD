Class {
	#name : 'OPErdUnionExtensionControllerTest',
	#superclass : 'OPErdExtensionsControllerTest',
	#category : 'OpenPonk-ERD-Tests',
	#package : 'OpenPonk-ERD',
	#tag : 'Tests'
}

{ #category : 'accessing' }
OPErdUnionExtensionControllerTest >> controllerClass [
	"Answer the specialized controller class."
	^ OPErdUnionExtensionController
]

{ #category : 'tests' }
OPErdUnionExtensionControllerTest >> testCreateModelInCreatesUnionExtension [
	"Verify that createModelIn initializes a union extension model."
	| extModel |
	extModel := controller createModelIn: diagramController model.
	self assert: extModel isUnion.
	self assert: controller model isUnion
]
