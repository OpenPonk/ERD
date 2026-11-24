"
Verifies label rendering, font sizing, and canvas cleanup for entity-relationship extension shapes.
"
Class {
	#name : 'OPErdExtensionsShapeTest',
	#superclass : 'TestCase',
	#category : 'OpenPonk-ERD-Tests-DiagramElements',
	#package : 'OpenPonk-ERD-Tests',
	#tag : 'DiagramElements'
}

{ #category : 'tests' }
OPErdExtensionsShapeTest >> testRemoveRenderCleansUpLabelFromCanvas [

	| canvas extensionModel extensionShape |
	canvas := RSCanvas new.
	extensionModel := OPErdExtensions named: 'ISA'.
	extensionShape := OPErdExtensionsShape forModelElement: extensionModel.
	extensionShape renderIn: canvas.
	self assert: canvas shapes size equals: 2.

	extensionShape removeRender.
	self assertEmpty: canvas shapes
]

{ #category : 'tests' }
OPErdExtensionsShapeTest >> testUpdateLabelAdjustsFontSizeWhenHeightRemainderAtMostOne [

	| canvas extensionModel extensionShape labelShape |
	canvas := RSCanvas new.
	extensionModel := (OPErdExtensions named: 'ISA')
		                  beDisjoint;
		                  yourself.
	extensionShape := OPErdExtensionsShape forModelElement: extensionModel.
	extensionShape renderIn: canvas.
	labelShape := extensionShape attachedShapes first.

	extensionShape roassalShape height: 50.
	extensionShape updateRenderFromModel.
	self assert: extensionShape roassalShape width equals: 50.
	self assert: labelShape fontSize equals: 50 / 4
]

{ #category : 'tests' }
OPErdExtensionsShapeTest >> testUpdateRenderFromModelCoversAllExtensionVariants [

	| canvas extensionModel extensionShape labelShape |
	canvas := RSCanvas new.
	extensionModel := OPErdExtensions named: 'CustomExt'.
	extensionShape := OPErdExtensionsShape forModelElement: extensionModel.
	extensionShape renderIn: canvas.
	labelShape := extensionShape attachedShapes first.
	self assert: labelShape text equals: 'CustomExt'.

	extensionModel beUnion.
	extensionShape updateRenderFromModel.
	self assert: labelShape text equals: 'U'.

	extensionModel
		beNormal;
		beDisjoint.
	extensionShape updateRenderFromModel.
	self assert: labelShape text equals: 'd'.

	extensionModel
		beNormal;
		beOverlapping.
	extensionShape updateRenderFromModel.
	self assert: labelShape text equals: 'O'.

	extensionModel beNormal.
	extensionShape updateRenderFromModel.
	self assert: labelShape text equals: 'CustomExt'
]
