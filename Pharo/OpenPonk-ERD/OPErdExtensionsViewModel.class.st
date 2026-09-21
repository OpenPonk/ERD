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
	"Build declarative editor form for extension states."
	super buildEditorForm: aForm.
	aForm bindCheckbox: 'Disjoint' property: #isDisjoint.
	aForm bindCheckbox: 'Union' property: #isUnion.
	aForm bindCheckbox: 'Overlapping' property: #isOverlapping
]

{ #category : 'commands' }
OPErdExtensionsViewModel >> commandForProperty: aSymbol accessor: anAccessor oldValue: anOldValue newValue: aNewValue [
	"Answer a composite command ensuring mutual exclusion between disjoint, union, and overlapping extensions."
	| exclusiveProperties otherProperties composite |
	exclusiveProperties := #( #isDisjoint #isUnion #isOverlapping ).
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

{ #category : 'accessing' }
OPErdExtensionsViewModel >> icon [ ^ self model isDisjoint ifTrue: [ OPCoreIcons opErdDisjointExtensionIcon ] ifFalse: [ self model isOverlapping ifTrue: [ OPCoreIcons opErdOverlappingExtensionIcon ] ifFalse: [ self model isUnion ifTrue: [ OPCoreIcons opErdUnionExtensionIcon ] ifFalse: [ OPCoreIcons opFsmRegularStateIcon ] ] ]
]
