"
Tests controller logic and visual markers for overlapping specialization extensions in ERD.
"
Class {
	#name : 'OPErdOverlappingExtensionControllerTest',
	#superclass : 'OPErdExtensionsControllerTest',
	#category : 'OpenPonk-ERD-Tests-Controllers',
	#package : 'OpenPonk-ERD-Tests',
	#tag : 'Controllers'
}

{ #category : 'constants' }
OPErdOverlappingExtensionControllerTest >> controllerClass [
	"Answer the specialized controller class."

	^ OPErdOverlappingExtensionController
]

{ #category : 'tests' }
OPErdOverlappingExtensionControllerTest >> testCreateModelInCreatesOverlappingExtension [
	"Verify that createModelIn initializes an overlapping extension model."

	| extensionModel |
	extensionModel := controller createModelIn: diagramController model.
	self assert: controller model identicalTo: extensionModel.
	self assert: extensionModel isOverlapping description: 'Created extension model must be marked as overlapping'.
	self deny: extensionModel isNormal description: 'Overlapping extension model must not report as normal'
]
