"
Tests controller logic and visual markers for disjoint specialization extensions in ERD.
"
Class {
	#name : 'OPErdDisjointExtensionControllerTest',
	#superclass : 'OPErdExtensionsControllerTest',
	#category : 'OpenPonk-ERD-Tests-Controllers',
	#package : 'OpenPonk-ERD-Tests',
	#tag : 'Controllers'
}

{ #category : 'constants' }
OPErdDisjointExtensionControllerTest >> controllerClass [
	"Answer the specialized controller class."

	^ OPErdDisjointExtensionController
]

{ #category : 'tests' }
OPErdDisjointExtensionControllerTest >> testCreateModelInCreatesDisjointExtension [
	"Verify that createModelIn initializes a disjoint extension model."

	| extensionModel |
	extensionModel := controller createModelIn: diagramController model.
	self assert: controller model identicalTo: extensionModel.
	self assert: extensionModel isDisjoint description: 'Created extension model must be marked as disjoint'.
	self deny: extensionModel isNormal description: 'Disjoint extension model must not report as normal'
]
