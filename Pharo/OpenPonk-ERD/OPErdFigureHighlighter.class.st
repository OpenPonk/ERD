Class {
	#name : 'OPErdFigureHighlighter',
	#superclass : 'Object',
	#category : 'OpenPonk-ERD-DiagramElements',
	#package : 'OpenPonk-ERD',
	#tag : 'DiagramElements'
}

{ #category : 'api - highlight' }
OPErdFigureHighlighter class >> highlight: aShapedObject with: aColor [
	aShapedObject isNode
		ifTrue: [ self highlightNode: aShapedObject with: aColor ].
	aShapedObject isLine
		ifTrue: [ self highlightLine: aShapedObject with: aColor ]
]

{ #category : 'api - highlight' }
OPErdFigureHighlighter class >> highlightLine: aLine with: aColor [

	self unhighlightNode: aLine.
	aLine propertyAt: self name put: aLine color.
	aLine color: aColor.
	aLine signalUpdate
]

{ #category : 'api - highlight' }
OPErdFigureHighlighter class >> highlightNode: aNode with: aColor [

	self unhighlightNode: aNode.
	aNode propertyAt: self name put: aNode borderColor.
	aNode borderColor: aColor.
	aNode signalUpdate
]

{ #category : 'api - highlight' }
OPErdFigureHighlighter class >> unhighlight: aShapedObject [
	aShapedObject isNode
		ifTrue: [ self unhighlightNode: aShapedObject ].
	aShapedObject isLine
		ifTrue: [ self unhighlightLine: aShapedObject ]
]

{ #category : 'api - highlight' }
OPErdFigureHighlighter class >> unhighlightLine: aLine [

	aLine shape color: (aLine propertyAt: self name ifAbsent: [ ^ self ]).
	aLine removePropertyAt: self name.
	aLine signalUpdate
]

{ #category : 'api - highlight' }
OPErdFigureHighlighter class >> unhighlightNode: aNode [

	aNode shape borderColor:
		(aNode propertyAt: self name ifAbsent: [ ^ self ]).
	aNode removePropertyAt: self name.
	aNode signalUpdate
]
