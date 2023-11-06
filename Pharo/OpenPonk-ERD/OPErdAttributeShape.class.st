Class {
	#name : #OPErdAttributeShape,
	#superclass : #OPErdAbstractNodeShape,
	#instVars : [
		'label',
		'border',
		'innerEllipse'
	],
	#category : #'OpenPonk-ERD-DiagramElements'
}

{ #category : #rendering }
OPErdAttributeShape >> renderBasicShape [

	^ RSEllipse new
		  radius: 20;
		  width: 70;
		  color: Color white;
		  border: (RSBorder new
				   color: Color black;
				   width: 1.5;
				   yourself);
		  yourself.
]

{ #category : #rendering }
OPErdAttributeShape >> renderShapeDetails [

	super renderShapeDetails.

	label := RSLabel new
		         color: Color black;
		         height: 11;
		         width: 10;
		         model: self;
		         yourself.
	RSLocation new stick: label on: self roassalShape.
	border := RSEllipse new
		          radius: self roassalShape radius;
		          width: self roassalShape width;
		          height: self roassalShape height;
		          color: Color transparent;
		          border: (RSBorder new
				           dashArray: #( 10 10 );
				           width: 1.5;
				           yourself);
		          model: self;
		          yourself.
	RSLocation new stick: border on: self roassalShape.
	innerEllipse := RSEllipse new
		                radius: self roassalShape radius - 3;
		                width: self roassalShape width - 7;
		                height: self roassalShape height - 7;
		                color: Color transparent;
		                border: (RSBorder new
				                 color: Color transparent;
				                 width: 1.5;
				                 yourself);
		                yourself.
	RSLocation new stick: innerEllipse on: self roassalShape.
	self canvas
		add: border;
		add: label;
		add: innerEllipse.
	self roassalShape
		when: RSShapeRemovedEvent
		do: [
			label remove.
			border remove.
			innerEllipse remove ]
		for: self
]

{ #category : #'as yet unclassified' }
OPErdAttributeShape >> updateBorder [
	border 	
		radius: (self roassalShape radius);
		height: (self roassalShape height);
		width: (self roassalShape width).
]

{ #category : #'as yet unclassified' }
OPErdAttributeShape >> updateDetails [
	self updateBorder.
	self updateInnerEllipse.
	self updateLabel
]

{ #category : #'as yet unclassified' }
OPErdAttributeShape >> updateInnerEllipse [
	innerEllipse 	
		radius: (self roassalShape radius - 3);
		width: (self roassalShape width - 7);
		height: (self roassalShape height - 7).
]

{ #category : #'as yet unclassified' }
OPErdAttributeShape >> updateLabel [
	label 
		width: self roassalShape width.
]

{ #category : #rendering }
OPErdAttributeShape >> updateRenderFromModel [

	label text: self modelElement name.
	"Derived Attribute - Dashed Border"
	border borderColor: (self modelElement isDerived 
			 ifTrue: [ Color white ]
			 ifFalse: [ Color transparent ]).
	"Multivalued Attribute - Doubled Border"
	innerEllipse borderColor: (self modelElement isMultivalued 
			 ifTrue: [ Color black ]
			 ifFalse: [ Color transparent ]).
	"Key Attribute - Corresponding Label underlined"
	(self modelElement isKey
		ifTrue: [ label underline ]
		ifFalse: [ label normal ]).
	self updateDetails.
	super updateRenderFromModel.
	roassalShape signalUpdate
]
