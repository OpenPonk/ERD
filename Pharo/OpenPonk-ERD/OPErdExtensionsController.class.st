Class {
	#name : #OPErdExtensionsController,
	#superclass : #OPErdNodeController,
	#category : #'OpenPonk-ERD-Controllers'
}

{ #category : #forms }
OPErdExtensionsController >> buildEditorForm: aForm [
	super buildEditorForm: aForm.
	(aForm addCheckbox: 'Disjoint')
		state: self model isDisjoint;
		whenChangedDo: [ :newValue |
			self model isDisjoint: newValue.
			self model isUnion: false.
			self model isOverlapping: false.
			self diagramElement modelChanged ].
	(aForm addCheckbox: 'Union')
		state: self model isUnion;
		whenChangedDo: [ :newValue |
			self model isUnion: newValue.
			self model isDisjoint: false.
			self model isOverlapping: false.
			self diagramElement modelChanged ].
	(aForm addCheckbox: 'Overlapping')
		state: self model isOverlapping;
		whenChangedDo: [ :newValue |
			self model isOverlapping: newValue.
			self model isUnion: false.
			self model isDisjoint: false.
			self diagramElement modelChanged ].
	(aForm addSeparator).
	(aForm addLabel: 'Reselect Attribute to reset Checkboxes').
	(aForm addLabel: '- visual issue to be solved.').
	self diagramController updateCanvas
]

{ #category : #connecting }
OPErdExtensionsController >> canBeSourceFor: aController [
	^ (aController class == OPErdTransitionController) | 
	  (aController class == OPErdTotalTransitionController)
]

{ #category : #connecting }
OPErdExtensionsController >> canBeTargetFor: aController [
	^ (aController isKindOf: OPErdTransitionController)
		ifTrue: [ ^ aController source model class == OPErdEntity  ]
		ifFalse: [ ^ false ]
]

{ #category : #construction }
OPErdExtensionsController >> diagramElementClass [

	^ OPErdExtensionsShape 
]

{ #category : #accessing }
OPErdExtensionsController >> modelClass [
	^ OPErdExtensions 
]
