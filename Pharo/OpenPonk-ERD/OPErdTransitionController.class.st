"
I am the controller for ERD transitions (edges).
I handle the creation, display, and visibility toggling of transitions between ERD nodes, including managing dependent elements in the diagram.
"
Class {
	#name : 'OPErdTransitionController',
	#superclass : 'OPDirectionalRelationshipController',
	#category : 'OpenPonk-ERD-Controllers',
	#package : 'OpenPonk-ERD',
	#tag : 'Controllers'
}

{ #category : 'construction' }
OPErdTransitionController class >> diagramElementClass [

	^ OPErdTransitionShape
]

{ #category : 'accessing' }
OPErdTransitionController class >> viewModelClass [
	^ OPErdTransitionViewModel
]

{ #category : 'testing' }
OPErdTransitionController >> isHideable [
	^ true
]
