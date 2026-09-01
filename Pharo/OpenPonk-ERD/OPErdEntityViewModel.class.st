"
View model for Entity-Relationship Diagram entities. 
Provides icons and form building specifications to the workbench without GUI dependencies.
"
Class {
	#name : 'OPErdEntityViewModel',
	#superclass : 'OPErdNodeViewModel',
	#category : 'OpenPonk-ERD-ViewModels',
	#package : 'OpenPonk-ERD',
	#tag : 'ViewModels'
}

{ #category : 'accessing' }
OPErdEntityViewModel class >> modelClass [ ^ OPErdEntity
]

{ #category : 'forms' }
OPErdEntityViewModel >> buildEditorForm: aForm [
	super buildEditorForm: aForm.
	(aForm addCheckbox: 'Weak')
		state: self model isWeak;
		whenChangedDo: [ :newValue |
			self model isWeak: newValue.
			self modelChanged ]
]

{ #category : 'accessing' }
OPErdEntityViewModel >> icon [ ^ self model isWeak ifTrue: [ OPCoreIcons opErdWeakEntityIcon ] ifFalse: [ OPCoreIcons opErdEntityIcon ]
]

{ #category : 'testing' }
OPErdEntityViewModel >> sourceIsValid: aModel [
	self model isWeak ifTrue: [
		(aModel class == self model class) ifTrue: [ ^ false ] ifFalse: [ ^ self validSources includes: aModel class ]
	].
	(aModel class == self model class)
		ifTrue: [ ^ aModel uuid ~~ self model uuid ]
		ifFalse: [ ^ false ]
]

{ #category : 'accessing - DirectedRelationship' }
OPErdEntityViewModel >> validSources [
	self model isWeak ifTrue: [ ^ { OPErdAttribute . OPErdExtensions } ].
	^ { OPErdRelation . OPErdAttribute . OPErdExtensions }
]
