Class {
	#name : #OPErdExtensionsShape,
	#superclass : #OPErdAbstractNodeShape,
	#instVars : [
		'label'
	],
	#category : #'OpenPonk-ERD-DiagramElements'
}

{ #category : #rendering }
OPErdExtensionsShape >> renderBasicShape [

	^ RSEllipse new
		width: 42;
		height: 42;
		color: Color white;
		border: (RSBorder new
				   color: Color black;
				   width: 1.5;
				   yourself);
		  yourself
]

{ #category : #rendering }
OPErdExtensionsShape >> renderShapeDetails [

	super renderShapeDetails.

	label := RSLabel new
		         color: Color black;
		         height: (self roassalShape height / 4);
					width: (self roassalShape width);
					fontSize: (self roassalShape height / 4);
		         model: self;
		         yourself.
	RSLocation new 
		stick: label on: self roassalShape;
		center.
	self canvas
		add: label.
	self roassalShape when: RSShapeRemovedEvent do: [ 
		label remove]
]

{ #category : #'as yet unclassified' }
OPErdExtensionsShape >> updateDetails [
	self updateLabel
]

{ #category : #updating }
OPErdExtensionsShape >> updateLabel [
	label
		height: (self roassalShape height / 4);
		width: (self roassalShape width).
	((self roassalShape height \\ 10) <= 1)
		ifTrue: [ label fontSize: (self roassalShape width / 4) ]
]

{ #category : #rendering }
OPErdExtensionsShape >> updateRenderFromModel [
	
	(self modelElement isUnion
			 ifTrue: [ label text: 'U'. ]
			 ifFalse: [ self modelElement isDisjoint
								ifTrue: [ label text: 'd'.]
								ifFalse: [ self modelElement isOverlapping
												ifTrue: [ label text: 'O'. ]
												ifFalse: [ label text: self modelElement name ] ] ]).
	self roassalShape width: (self roassalShape height).
	self updateDetails.
	super updateRenderFromModel.
	roassalShape signalUpdate
]
