Class {
	#name : #OPErdEntityShape,
	#superclass : #OPErdAbstractNodeShape,
	#instVars : [
		'label',
		'weak'
	],
	#category : #'OpenPonk-ERD-DiagramElements'
}

{ #category : #rendering }
OPErdEntityShape >> renderBasicShape [
	^ RSBox new
		height: 50;
		width: 70;
		color: Color white;
		border: (RSBorder new
				   color: Color black;
				   width: 1.5;
				   yourself);
		yourself
]

{ #category : #rendering }
OPErdEntityShape >> renderShapeDetails [

	super renderShapeDetails.
	label := RSLabel new
		         color: Color black;
		         height: 11;
		         model: self;
		         yourself.
	RSLocation new stick: label on: self roassalShape.
	weak := RSBox new
				"Size changing according to main shape"
				height: (self roassalShape height - 7);
				width: (self roassalShape width - 7);
				color: Color transparent;
				border: (RSBorder new
				   				color: Color transparent;
				   				width: 1.5;
				   				yourself);
		yourself.
	RSLocation new stick: weak on: self roassalShape.
	self canvas
		add: label;
		add: weak.
	self roassalShape when: RSShapeRemovedEvent do: [ 
		label remove.
		weak remove ]
]

{ #category : #rendering }
OPErdEntityShape >> setupHighlight: aHighlightable [

	super setupHighlight: aHighlightable.
	aHighlightable highlightBorderColor: Color blue
]

{ #category : #rendering }
OPErdEntityShape >> updateRenderFromModel [

	label text: self modelElement name.
	weak borderColor: (self modelElement isWeak
			 ifTrue: [ Color black ]
			 ifFalse: [ Color transparent ]).
	weak height: (self roassalShape height - 7).
	weak width: (self roassalShape width - 7).
	self roassalShape width: (self roassalShape height * 1.4).
	super updateRenderFromModel.
	roassalShape signalUpdate
]
