Class {
	#name : 'OPErdOverlappingExtensionControllerTest',
	#superclass : 'OPErdExtensionsControllerTest',
	#category : 'OpenPonk-ERD-Tests',
	#package : 'OpenPonk-ERD',
	#tag : 'Tests'
}

{ #category : 'accessing' }
OPErdOverlappingExtensionControllerTest >> controllerClass [
	"Answer the specialized controller class."
	^ OPErdOverlappingExtensionController
]

{ #category : 'tests' }
OPErdOverlappingExtensionControllerTest >> testCreateModelInCreatesOverlappingExtension [
	"Verify that createModelIn initializes an overlapping extension model."
	| extModel |
	extModel := controller createModelIn: diagramController model.
	self assert: extModel isOverlapping.
	self assert: controller model isOverlapping
]
