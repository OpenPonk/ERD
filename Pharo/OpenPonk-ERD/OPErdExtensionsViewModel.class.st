"
I am the view model for OPErdExtensions.
I provide icons and form-building specifications to the workbench and UI layers without direct GUI dependencies.
"
Class {
	#name : 'OPErdExtensionsViewModel',
	#superclass : 'OPErdNodeViewModel',
	#category : 'OpenPonk-ERD-ViewModels',
	#package : 'OpenPonk-ERD',
	#tag : 'ViewModels'
}

{ #category : 'accessing' }
OPErdExtensionsViewModel class >> modelClass [ ^ OPErdExtensions
]

{ #category : 'forms' }
OPErdExtensionsViewModel >> buildEditorForm: aForm [
	super buildEditorForm: aForm.
	(aForm addCheckbox: 'Disjoint')
		state: self model isDisjoint;
		whenChangedDo: [ :newValue |
			self model isDisjoint: newValue.
			self model isUnion: false.
			self model isOverlapping: false.
			self modelChanged ].
	(aForm addCheckbox: 'Union')
		state: self model isUnion;
		whenChangedDo: [ :newValue |
			self model isUnion: newValue.
			self model isDisjoint: false.
			self model isOverlapping: false.
			self modelChanged ].
	(aForm addCheckbox: 'Overlapping')
		state: self model isOverlapping;
		whenChangedDo: [ :newValue |
			self model isOverlapping: newValue.
			self model isUnion: false.
			self model isDisjoint: false.
			self modelChanged ].
	(aForm addSeparator).
	(aForm addLabel: 'Reselect Attribute to reset Checkboxes').
	(aForm addLabel: '- visual issue to be solved.').
	
]

{ #category : 'accessing' }
OPErdExtensionsViewModel >> icon [ ^ self model isDisjoint ifTrue: [ OPCoreIcons opErdDisjointExtensionIcon ] ifFalse: [ self model isOverlapping ifTrue: [ OPCoreIcons opErdOverlappingExtensionIcon ] ifFalse: [ self model isUnion ifTrue: [ OPCoreIcons opErdUnionExtensionIcon ] ifFalse: [ OPCoreIcons opFsmRegularStateIcon ] ] ]
]
