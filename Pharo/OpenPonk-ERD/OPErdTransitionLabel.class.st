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

{ #category : 'adding' }
OPErdTransitionLabel >> defaultText [

	^ self modelElement name
]

{ #category : 'adding' }
OPErdTransitionLabel >> renderShapeDetails [

	super renderShapeDetails.
	self roassalShape
		when: RSMouseDoubleClick
		do: [ :evt | OPRenameElementCommand executeOn: self modelElement ]
		for: self
]
