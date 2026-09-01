"
I am a diagram element representing a label attached to an ERD transition edge.
I manage the creation of its underlying Roassal shape, including textual rendering, anchoring, and positioning along the transition line.
"
Class {
	#name : 'OPErdTransitionLabel',
	#superclass : 'OPEdgeLabel',
	#category : 'OpenPonk-ERD-DiagramElements',
	#package : 'OpenPonk-ERD',
	#tag : 'DiagramElements'
}

{ #category : 'adding' }
OPErdTransitionLabel >> defaultAnchorConstraintPosition [

	^ OPRSAnchorConstraintBalanceReference balance: 0.2
]

{ #category : 'adding' }
OPErdTransitionLabel >> defaultMinDistance [

	^ 5
]

{ #category : 'accessing' }
OPErdTransitionLabel >> defaultText [

	^ self modelElement name
]

{ #category : 'rendering' }
OPErdTransitionLabel >> renderShapeDetails [

	super renderShapeDetails.
	self roassalShape
		when: RSMouseDoubleClick
		do: [ :evt | OPRenameElementCommand executeOn: self modelElement ]
		for: self
]
