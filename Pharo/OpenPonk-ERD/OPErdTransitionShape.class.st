Class {
	#name : 'OPErdTransitionShape',
	#superclass : 'OPEdge',
	#instVars : [
		'total',
		'inheritance'
	],
	#category : 'OpenPonk-ERD-DiagramElements',
	#package : 'OpenPonk-ERD',
	#tag : 'DiagramElements'
}

{ #category : 'initialization' }
OPErdTransitionShape >> createOwnedElementsWithoutController [

	self ownedElements ifNotEmpty: [ ^ self ].
	OPErdTransitionLabel in: self
]

{ #category : 'as yet unclassified' }
OPErdTransitionShape >> inheritanceMarker [
	^ (RSMarker new
				shape: (RSPolygon new
					points: { 10@ -10 . 10@ 0 . 0@ 5 . -10@0 .
					-10@ -10 . -9@ -10 . -9@0 . 0@ 4 . 9@0 . 9@ -10 };
					border: (RSBorder new color: Color black; width: 1);
					color: Color black;
					cornerRadii: 10;
					yourself);
				offsetRatio: 0.45;
				offset: 10;
				yourself)
]

{ #category : 'as yet unclassified' }
OPErdTransitionShape >> inheritanceMarkerNil [
	^ RSMarker new
				shape: (RSPolygon new
					points: { 0@0 };
					yourself);
				yourself
]

{ #category : 'initialization' }
OPErdTransitionShape >> renderBasicShape [
	^ (self source = self target
		   ifTrue: [ OPRSBezier ]
		   ifFalse: [ OPRSPolyline ]) new
		  attachPoint: (RSBorderAttachPoint new offset: 3);
		  controlPointsController: OPRSDraggableCPController new;
		  addInteraction: OPRSDraggableControlPoints;
		  color: Color black;
		  from: self source roassalShape;
		  to: self target roassalShape;
		  yourself
]

{ #category : 'rendering' }
OPErdTransitionShape >> renderShapeDetails [

	super renderShapeDetails.
	total := (self source = self target
		          ifTrue: [ OPRSBezier ]
		          ifFalse: [ OPRSPolyline ]) new
		         attachPoint: (RSBorderAttachPoint new offset: 3);
		         controlPointsController: OPRSDraggableCPController new;
		         addInteraction: OPRSDraggableControlPoints;
		         color: Color transparent;
		         from: self source roassalShape;
		         to: self target roassalShape;
		         yourself.
	RSLocation new stick: total on: self roassalShape.
	self canvas add: total.
	self roassalShape
		when: RSShapeRemovedEvent
		do: [ total remove ]
		for: self
]

{ #category : 'accessing' }
OPErdTransitionShape >> total [
	^ total
]

{ #category : 'rendering' }
OPErdTransitionShape >> updateRenderFromModel [

	total color: (self modelElement isTotal 
			 ifTrue: [ Color black ]
			 ifFalse: [ Color transparent ]).
	self roassalShape markerEnd: (self modelElement isInheritance 
			 ifTrue: [ self inheritanceMarker ]
			 ifFalse: [ self inheritanceMarkerNil ]).
	total basicTranslateBy: 2.
	self roassalShape update.
	total update.
	super updateRenderFromModel.
	roassalShape signalUpdate
]
