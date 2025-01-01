Class {
	#name : 'OPErdRelationShape',
	#superclass : 'OPErdAbstractNodeShape',
	#instVars : [
		'label',
		'identifying'
	],
	#category : 'OpenPonk-ERD-DiagramElements',
	#package : 'OpenPonk-ERD',
	#tag : 'DiagramElements'
}

{ #category : 'rendering' }
OPErdRelationShape >> renderBasicShape [

	^  RSPolygon new
		points: { 0@24. 35@0. 0@(-24). -35@0. };
		color: Color white;
		borderColor: Color black;
		yourself.
]

{ #category : 'rendering' }
OPErdRelationShape >> renderShapeDetails [

	super renderShapeDetails.

	label := RSLabel new
		         color: Color black;
		         height: 11;
		         model: self;
		         yourself.
	RSLocation new stick: label on: self roassalShape.
	identifying := RSPolygon new
		               points: {
				               ((self roassalShape points at: 1) asPoint x
				                @ ((self roassalShape points at: 1) asPoint y - 3)).
				               ((self roassalShape points at: 2) asPoint x - 4
				                @ (self roassalShape points at: 2) asPoint y).
				               ((self roassalShape points at: 3) asPoint x
				                @ ((self roassalShape points at: 3) asPoint y + 3)).
				               ((self roassalShape points at: 4) asPoint x + 4
				                @ (self roassalShape points at: 4) asPoint y) };
		               color: Color transparent;
		               borderColor: Color transparent;
		               yourself. "{ 0@21. 31@0. 0@(-21). -31@0. }"
		
	self addEventForwardingFrom: identifying to: self roassalShape.
	
	RSLocation new stick: identifying on: self roassalShape.
	self canvas
		add: label;
		add: identifying.
	self roassalShape
		when: RSShapeRemovedEvent
		do: [
			label remove.
			identifying remove ]
		for: self
]

{ #category : 'rendering' }
OPErdRelationShape >> updateRenderFromModel [

	label text: self modelElement name.
	identifying borderColor: (self modelElement isIdentifying
			 ifTrue: [ Color black ]
			 ifFalse: [ Color transparent ]).
	identifying points: 
		{ 	((self roassalShape points at: 1) asPoint x)
			@((self roassalShape points at: 1) asPoint y - 3).
			((self roassalShape points at: 2) asPoint x - 4)
			@((self roassalShape points at: 2) asPoint y).
			((self roassalShape points at: 3) asPoint x)
			@((self roassalShape points at: 3) asPoint y + 3).
			((self roassalShape points at: 4) asPoint x + 4)
			@((self roassalShape points at: 4) asPoint y).}.
	RSLocation new stick: identifying on: self roassalShape. 
	super updateRenderFromModel.
	roassalShape signalUpdate
]
