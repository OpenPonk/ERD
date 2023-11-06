Class {
	#name : #OPErdAbstractNodeShape,
	#superclass : #OPShape,
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

	| selectable |
	selectable := OPRSSelectable new.
	self setupHighlight: selectable.
	self roassalShape @ selectable.
	self roassalShape @ OPRSSelectionDraggable.
	self roassalShape @ OPRSResizable.
	self roassalShape
		when: RSPositionChangedEvent do: [ self updateRenderFromModel ];
		when: RSExtentChangedEvent do: [ self updateRenderFromModel ]
]

{ #category : #hooks }
OPErdAbstractNodeShape >> setupHighlight: aHighlightable [

	aHighlightable highlightAdornments: [ :builder | 
		builder horizontalLocation
			outer;
			right.
		builder verticalLocation
			inner;
			middle.
		builder directionDown.
		adornmentCreationBlock value: builder ]
]
