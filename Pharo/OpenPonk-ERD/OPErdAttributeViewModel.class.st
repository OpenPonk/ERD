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
	"Build declarative editor form for attribute properties with validation on derived state."
	super buildEditorForm: aForm.
	(aForm bindCheckbox: 'Derived' property: #isDerived)
		enabled: self derivedValidation.
	aForm bindCheckbox: 'Multivalued' property: #isMultivalued.
	aForm bindCheckbox: 'Key Value' property: #isKey
]

{ #category : 'commands' }
OPErdAttributeViewModel >> commandForProperty: aSymbol accessor: anAccessor oldValue: anOldValue newValue: aNewValue [
	"Answer a composite command ensuring mutual exclusion between key, derived, and multivalued attributes."
	| exclusiveProperties otherProperties composite |
	exclusiveProperties := #( #isKey #isDerived #isMultivalued ).
	((exclusiveProperties includes: aSymbol) and: [ aNewValue = true ]) ifFalse: [
		^ super commandForProperty: aSymbol accessor: anAccessor oldValue: anOldValue newValue: aNewValue ].
	otherProperties := exclusiveProperties reject: [ :each | each = aSymbol ].
	composite := OPCompositeCommand new.
	composite add: (OPPropertyChangeCommand
		viewModel: self
		selector: aSymbol
		accessor: anAccessor
		oldValue: anOldValue
		newValue: aNewValue).
	otherProperties do: [ :eachProperty |
		| currentPropertyValue |
		currentPropertyValue := self model perform: eachProperty.
		currentPropertyValue ifTrue: [
			composite add: (OPPropertyChangeCommand
				viewModel: self
				selector: eachProperty
				accessor: (OPModelPropertyAccessor on: eachProperty)
				oldValue: currentPropertyValue
				newValue: false) ] ].
	composite commands size = 1 ifTrue: [ ^ composite commands first ].
	^ composite
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
