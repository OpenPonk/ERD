"
View model for the top-level Entity-Relationship Diagram model. 
Provides essential child models and icon definitions for the workbench tree and UI integration.
"
Class {
	#name : 'OPErdViewModel',
	#superclass : 'OPModelObjectViewModel',
	#category : 'OpenPonk-ERD-ViewModels',
	#package : 'OpenPonk-ERD',
	#tag : 'ViewModels'
}

{ #category : 'accessing' }
OPErdViewModel class >> commonModelClassPrefix [

	^ 'OPErd'
]

{ #category : 'accessing' }
OPErdViewModel class >> modelClass [ ^ OPErd
]

{ #category : 'accessing' }
OPErdViewModel >> childrenModels [ ^ self model states
]

{ #category : 'accessing' }
OPErdViewModel >> essentialChildrenModels [
			^ self model elements asArray
]

{ #category : 'accessing' }
OPErdViewModel >> icon [ ^ OPCoreIcons opErdDiagramIcon
]

{ #category : 'accessing' }
OPErdViewModel >> modelRootViewModel [

	^ self
]
