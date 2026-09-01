"
I am the view model for OPErdRelation.
I provide icons and form-building specifications to the workbench and UI layers without direct GUI dependencies.
"
Class {
	#name : 'OPErdRelationViewModel',
	#superclass : 'OPErdNodeViewModel',
	#category : 'OpenPonk-ERD-ViewModels',
	#package : 'OpenPonk-ERD',
	#tag : 'ViewModels'
}

{ #category : 'accessing' }
OPErdRelationViewModel class >> modelClass [ ^ OPErdRelation
]

{ #category : 'forms' }
OPErdRelationViewModel >> buildEditorForm: aForm [
	super buildEditorForm: aForm.
	(aForm addCheckbox: 'Identifying')
		state: self model isIdentifying;
		whenChangedDo: [ :newValue |
			self model isIdentifying: newValue.
			self modelChanged]
]

{ #category : 'accessing' }
OPErdRelationViewModel >> icon [ ^ self model isIdentifying ifTrue: [ OPCoreIcons opErdIdentifyingRelationIcon ] ifFalse: [ OPCoreIcons opErdRelationIcon ]
]
