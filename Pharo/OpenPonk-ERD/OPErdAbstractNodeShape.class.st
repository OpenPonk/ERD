Class {
	#name : #OPErdAbstractNodeShape,
	#superclass : #OPBoundNode,
	#instVars : [
		'adornmentCreationBlock'
	],
	#category : #'OpenPonk-ERD-DiagramElements'
}

{ #category : #accessing }
OPErdAbstractNodeShape >> adornmentCreationBlock: aBlock [

	adornmentCreationBlock := aBlock
]

{ #category : #rendering }
OPErdAbstractNodeShape >> renderShapeDetails [

	self roassalShape
		when: RSPositionChangedEvent do: [ self updateRenderFromModel ];
		when: RSExtentChangedEvent do: [ self updateRenderFromModel ]
]

{ #category : #interactions }
OPErdAbstractNodeShape >> selectableInteraction [

	| selectableInteraction |
	selectableInteraction := OPRSSelectable highlightBorderColorBlue.
	adornmentCreationBlock ifNil: [ ^ selectableInteraction ].
	selectableInteraction highlightAdornments: [ :builder |
		builder horizontalLocation
			outer;
			right.
		builder verticalLocation
			inner;
			top.
		builder directionDown.
		adornmentCreationBlock value: builder ].
	^ selectableInteraction
]

{ #category : #interactions }
OPErdAbstractNodeShape >> shouldBePositionableByUser [

	^ true
]

{ #category : #interactions }
OPErdAbstractNodeShape >> shouldBeResizableByUser [

	^ true
]
