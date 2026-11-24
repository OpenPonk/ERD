"
Verifies rendering, visual styles, self-loop geometry, and canvas cleanup for entity-relationship transition edge shapes.
"
Class {
	#name : 'OPErdTransitionShapeTest',
	#superclass : 'TestCase',
	#category : 'OpenPonk-ERD-Tests-DiagramElements',
	#package : 'OpenPonk-ERD-Tests',
	#tag : 'DiagramElements'
}

{ #category : 'tests' }
OPErdTransitionShapeTest >> testRemoveRenderRemovesTotalShapeFromCanvas [

	| canvas sourceShape targetShape transitionModel transitionShape initialCanvasShapeCount |
	canvas := RSCanvas new.
	sourceShape := OPErdEntityShape forModelElement: (OPErdEntity named: 'Customer').
	targetShape := OPErdRelationShape forModelElement: (OPErdRelation named: 'places').
	sourceShape renderIn: canvas.
	targetShape renderIn: canvas.
	initialCanvasShapeCount := canvas shapes size.

	transitionModel := (OPErdTransition from: sourceShape modelElement to: targetShape modelElement named: '1..N')
		                   beTotal;
		                   yourself.
	transitionShape := OPErdTransitionShape forModelElement: transitionModel.
	transitionShape
		source: sourceShape;
		target: targetShape;
		renderIn: canvas.

	self
		assert: (canvas shapes includes: transitionShape total)
		description: 'Rendered transition shape must add its total line to the canvas'.

	transitionShape removeRender.

	self
		deny: (canvas shapes includes: transitionShape total)
		description: 'removeRender must remove the attached total line from the canvas'.
	self assert: canvas shapes size equals: initialCanvasShapeCount
]

{ #category : 'tests' }
OPErdTransitionShapeTest >> testRenderStylesForRegularTotalAndInheritance [

	| canvas sourceShape targetShape transitionModel transitionShape |
	canvas := RSCanvas new.
	sourceShape := OPErdEntityShape forModelElement: (OPErdEntity named: 'Customer').
	targetShape := OPErdRelationShape forModelElement: (OPErdRelation named: 'places').
	sourceShape renderIn: canvas.
	targetShape renderIn: canvas.

	transitionModel := OPErdTransition from: sourceShape modelElement to: targetShape modelElement named: '1'.
	transitionShape := OPErdTransitionShape forModelElement: transitionModel.
	transitionShape
		source: sourceShape;
		target: targetShape;
		renderIn: canvas.

	self assert: transitionShape roassalShape class identicalTo: OPRSPolyline.
	self assert: transitionShape total class identicalTo: OPRSPolyline.
	self assert: transitionShape total color equals: Color transparent.
	self assert: transitionShape roassalShape markerEnd shape points size equals: 1.

	transitionModel beTotal.
	transitionShape updateRenderFromModel.
	self assert: transitionShape total color equals: Color black.
	self assert: transitionShape roassalShape markerEnd shape points size equals: 1.

	transitionModel
		beNormal;
		beInheritance.
	transitionShape updateRenderFromModel.
	self assert: transitionShape total color equals: Color transparent.
	self assert: transitionShape roassalShape markerEnd shape points size equals: 10.
	self assert: transitionShape roassalShape markerEnd offset equals: 10
]

{ #category : 'tests' }
OPErdTransitionShapeTest >> testSelfLoopRendersBezierForMainAndTotalShapes [

	| canvas nodeShape transitionModel transitionShape |
	canvas := RSCanvas new.
	nodeShape := OPErdEntityShape forModelElement: (OPErdEntity named: 'Node').
	nodeShape renderIn: canvas.

	transitionModel := OPErdTransition from: nodeShape modelElement to: nodeShape modelElement named: 'self'.
	transitionShape := OPErdTransitionShape forModelElement: transitionModel.
	transitionShape
		source: nodeShape;
		target: nodeShape;
		renderIn: canvas.

	self assert: transitionShape roassalShape class identicalTo: OPRSBezier.
	self assert: transitionShape total class identicalTo: OPRSBezier
]
