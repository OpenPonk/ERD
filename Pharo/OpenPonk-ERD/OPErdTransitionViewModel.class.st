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

	super buildEditorForm: aForm.
	(aForm addCheckbox: 'Total')
		state: self model isTotal;
		whenChangedDo: [ :newValue |
			self updateCheckboxOf: aForm named: 'Inheritance'. 
			self model isTotal: newValue.
			self model isInheritance: false.
			self modelChanged.
			
			].
	(aForm addCheckbox: 'Inheritance')
		state: self model isInheritance;
		whenChangedDo: [ :newValue |
			self updateCheckboxOf: aForm named: 'Total'. 
			self model isInheritance: newValue.
			self model isTotal: false.
			self modelChanged ].
]

{ #category : 'accessing' }
OPErdTransitionViewModel >> icon [ ^ self model isInheritance ifTrue: [ OPCoreIcons opErdInheritanceConnectionIcon ] ifFalse: [ self model isTotal ifTrue: [ OPCoreIcons opErdTotalConnectionIcon ] ifFalse: [ OPCoreIcons opErdConnectionIcon ] ]
]

{ #category : 'forms' }
OPErdTransitionViewModel >> updateCheckboxOf: aForm named: aLabel [
	aForm focusOrder do: [ :comp |
		(comp className asString = 'SpCheckBoxPresenter')
			ifTrue: [ (comp label asString = aLabel asString)
							ifTrue: [ comp state: false ] ] ]
]
