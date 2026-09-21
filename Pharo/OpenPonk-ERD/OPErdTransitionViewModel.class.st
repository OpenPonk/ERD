"
I am the view model for ERD transitions.
I handle domain logic for attaching models between source and target, and expose properties for UI form construction.
"
Class {
	#name : 'OPErdTransitionViewModel',
	#superclass : 'OPDirectedAssociationViewModel',
	#category : 'OpenPonk-ERD-ViewModels',
	#package : 'OpenPonk-ERD',
	#tag : 'ViewModels'
}

{ #category : 'accessing' }
OPErdTransitionViewModel class >> modelClass [ ^ OPErdTransition
]

{ #category : 'construction' }
OPErdTransitionViewModel >> attachModelFrom: sourceViewModel to: targetViewModel [
	self model source: sourceViewModel model.
	self model target: targetViewModel model.
]

{ #category : 'forms' }
OPErdTransitionViewModel >> buildEditorForm: aForm [
	"Build declarative editor form for transition connection states."
	super buildEditorForm: aForm.
	aForm bindCheckbox: 'Total' property: #isTotal.
	aForm bindCheckbox: 'Inheritance' property: #isInheritance
]

{ #category : 'commands' }
OPErdTransitionViewModel >> commandForProperty: aSymbol accessor: anAccessor oldValue: anOldValue newValue: aNewValue [
	"Answer a composite command ensuring mutual exclusion between total and inheritance transitions."
	| exclusiveProperties otherProperties composite |
	exclusiveProperties := #( #isTotal #isInheritance ).
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
OPErdTransitionViewModel >> icon [ ^ self model isInheritance ifTrue: [ OPCoreIcons opErdInheritanceConnectionIcon ] ifFalse: [ self model isTotal ifTrue: [ OPCoreIcons opErdTotalConnectionIcon ] ifFalse: [ OPCoreIcons opErdConnectionIcon ] ]
]
