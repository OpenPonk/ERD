"
I verify visual cleanup of ERD relation shapes and their attached canvas elements.
"
Class {
	#name : 'OPErdRelationShapeTest',
	#superclass : 'TestCase',
	#category : 'OpenPonk-ERD-Tests-DiagramElements',
	#package : 'OpenPonk-ERD-Tests',
	#tag : 'DiagramElements'
}

{ #category : 'tests' }
OPErdRelationShapeTest >> testRemoveRenderCleansUpAttachedShapesFromCanvas [

	| canvas relation shape |
	canvas := RSCanvas new.
	relation := OPErdRelation new name: 'Places'.
	shape := OPErdRelationShape forModelElement: relation.
	shape renderIn: canvas.

	self assertCollection: (canvas shapes collect: #class) includesAll: {
			RSLabel.
			RSPolygon }.

	shape removeRender.

	self denyCollection: (canvas shapes collect: #class) includesAny: {
			RSLabel.
			RSPolygon }.
	self assertEmpty: canvas shapes
]
