"
Tests controller logic and visual indicators for union specialization extensions in ERD.
"
Class {
	#name : 'OPErdUnionExtensionControllerTest',
	#superclass : 'OPErdExtensionsControllerTest',
	#category : 'OpenPonk-ERD-Tests-Controllers',
	#package : 'OpenPonk-ERD-Tests',
	#tag : 'Controllers'
}

{ #category : 'accessing' }
OPErdUnionExtensionControllerTest >> controllerClass [
	"Answer the specialized controller class."
	^ OPErdUnionExtensionController
]

{ #category : 'tests' }
OPErdUnionExtensionControllerTest >> testCreateModelInCreatesUnionExtension [
	"Verify that createModelIn initializes a union extension model."

	| extensionModel |
	extensionModel := controller createModelIn: diagramController model.
	self assert: controller model identicalTo: extensionModel.
	self assert: extensionModel isUnion description: 'Created extension model must be marked as union'.
	self deny: extensionModel isNormal description: 'Union extension model must not report as normal'
]
