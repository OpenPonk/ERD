"
I verify visual cleanup of ERD relation shapes and their attached canvas elements.
"
Class {
	#name : 'OPErdRelationShapeTest',
	#superclass : 'TestCase',
	#category : 'OpenPonk-ERD-Tests',
	#package : 'OpenPonk-ERD',
	#tag : 'Tests'
}

{ #category : 'tests' }
OPErdRelationShapeTest >> testRemoveRenderCleansUpAttachedShapesFromCanvas [
	| canvas relation shape |
	canvas := RSCanvas new.
	relation := OPErdRelation new name: 'Places'.
	shape := OPErdRelationShape forModelElement: relation.
	shape renderIn: canvas.

	self assert: (canvas shapes anySatisfy: [ :eachShape | eachShape isKindOf: RSLabel ]).
	self assert: (canvas shapes anySatisfy: [ :eachShape | eachShape isKindOf: RSPolygon ]).

	shape removeRender.

	self assert: (canvas shapes noneSatisfy: [ :eachShape | eachShape isKindOf: RSLabel ])
		description: 'RSLabel must be removed from canvas on removeRender'.
	self assert: (canvas shapes noneSatisfy: [ :eachShape | eachShape isKindOf: RSPolygon ])
		description: 'RSPolygon must be removed from canvas on removeRender'.
	self assert: canvas shapes isEmpty
		description: 'Canvas must be empty after removeRender'
]
