"
Abstract view model for Entity-Relationship Diagram nodes. 
Manages hierarchy logic and child dependencies for the workbench integration.
"
Class {
	#name : 'OPErdNodeViewModel',
	#superclass : 'OPModelObjectViewModel',
	#category : 'OpenPonk-ERD-ViewModels',
	#package : 'OpenPonk-ERD',
	#tag : 'ViewModels'
}

{ #category : 'testing' }
OPErdNodeViewModel class >> isAbstract [

	^ self = OPErdNodeViewModel
]

{ #category : 'accessing' }
OPErdNodeViewModel class >> modelClass [ ^ OPErdNode
]

{ #category : 'accessing' }
OPErdNodeViewModel >> childrenModels [ ^ self model outgoing asArray , self model incoming asArray
]

{ #category : 'accessing' }
OPErdNodeViewModel >> dependentElements [
	^ (self model incoming , self model outgoing) asSet
]

{ #category : 'forms' }
OPErdNodeViewModel >> updateCheckboxOf: aForm named: aLabel [
	aForm focusOrder do: [ :comp |
		(comp className asString = 'SpCheckBoxPresenter')
			ifTrue: [ (comp label asString = aLabel asString)
							ifTrue: [ comp state: false ] ] ]
]
