"
View model for Entity-Relationship Diagram attributes. 
Provides icons, derived validation logic, and form building specifications to the workbench.
"
Class {
	#name : 'OPErdAttributeViewModel',
	#superclass : 'OPErdNodeViewModel',
	#category : 'OpenPonk-ERD-ViewModels',
	#package : 'OpenPonk-ERD',
	#tag : 'ViewModels'
}

{ #category : 'accessing' }
OPErdAttributeViewModel class >> modelClass [ ^ OPErdAttribute
]

{ #category : 'forms' }
OPErdAttributeViewModel >> buildEditorForm: aForm [

	super buildEditorForm: aForm.
	(aForm addCheckbox: 'Derived')
		state: self model isDerived;
		enabled: self derivedValidation;
		whenChangedDo: [ :newValue |
			self updateCheckboxOf: aForm named: 'Multivalued'.
			self updateCheckboxOf: aForm named: 'Key Value'.
			self model isDerived: newValue.
			self model isMultivalued: false.
			self model isKey: false.
			self modelChanged. ].
	(aForm addCheckbox: 'Multivalued')
		state: self model isMultivalued;
		whenChangedDo: [ :newValue |
			self updateCheckboxOf: aForm named: 'Derived'.
			self updateCheckboxOf: aForm named: 'Key Value'.
			self model isMultivalued: newValue.
			self model isDerived: false.
			self model isKey: false.
			self modelChanged. ].
	(aForm addCheckbox: 'Key Value')
		state: self model isKey;
		whenChangedDo: [ :newValue |
			self updateCheckboxOf: aForm named: 'Derived'.
			self updateCheckboxOf: aForm named: 'Multivalued'.
			self model isKey: newValue.
			self model isDerived: false.
			self model isMultivalued: false.
			self modelChanged. ].
	
]

{ #category : 'validation' }
OPErdAttributeViewModel >> derivedValidation [
	| inc out |
	inc := self model incoming isEmpty
		       ifTrue: [ true ]
		       ifFalse: [
			       self model incoming allSatisfy: [ :each |
				       self validDerivedSources includes: each source class ] ].
	out := self model outgoing isEmpty
		       ifTrue: [ true ]
		       ifFalse: [
		       self model outgoing includesAny: self validDerivedTargets ].
	inc & out ifTrue: [ ^ true ].
	^ false
]

{ #category : 'accessing' }
OPErdAttributeViewModel >> icon [ ^ self model isDerived ifTrue: [ OPCoreIcons opErdDerivedAttributeIcon ] ifFalse: [ self model isMultivalued ifTrue: [ OPCoreIcons opErdMultivaluedAttributeIcon ] ifFalse: [ self model isKey ifTrue: [ OPCoreIcons opErdKeyAttributeIcon ] ifFalse: [ OPCoreIcons opErdAttributeIcon ] ] ]
]

{ #category : 'testing' }
OPErdAttributeViewModel >> sourceIsValid: aModel [
	(self model isDerived or: [ self model isKey ])
		ifTrue: [ ^ self validSources includes: aModel class ].
	(aModel class == self model class)
		ifTrue: [ ^ ((aModel uuid ~~ self model uuid) and: ((aModel isDerived) | aModel isKey) not) ]
		ifFalse: [ ^ self validSources includes: aModel class ]
]

{ #category : 'accessing - DirectedRelationship' }
OPErdAttributeViewModel >> validDerivedSources [
	^ { OPErdEntity. OPErdRelation. }
]

{ #category : 'accessing - DirectedRelationship' }
OPErdAttributeViewModel >> validDerivedTargets [
	^ { OPErdEntity. }
]

{ #category : 'accessing - DirectedRelationship' }
OPErdAttributeViewModel >> validSources [
	self model isKey ifTrue: [ ^ { OPErdEntity } ].
	self model isDerived ifTrue: [ ^ { OPErdEntity } ].
	^ { OPErdEntity . OPErdRelation }
]
