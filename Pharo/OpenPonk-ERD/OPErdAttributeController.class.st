"
Controller for an Entity-Relationship Diagram attribute. 
Manages the diagram lifecycle, valid connections, and validation rules for attributes.
"
Class {
	#name : 'OPErdAttributeController',
	#superclass : 'OPErdNodeController',
	#category : 'OpenPonk-ERD-Controllers',
	#package : 'OpenPonk-ERD',
	#tag : 'Controllers'
}

{ #category : 'construction' }
OPErdAttributeController class >> diagramElementClass [

	^ OPErdAttributeShape
]

{ #category : 'accessing' }
OPErdAttributeController class >> viewModelClass [
	^ OPErdAttributeViewModel
]

{ #category : 'connecting' }
OPErdAttributeController >> canBeSourceFor: aController [
	^ (aController class == OPErdTransitionController)

]

{ #category : 'connecting' }
OPErdAttributeController >> canBeTargetFor: aController [

	^ aController class == OPErdTransitionController
		  ifTrue: [ self viewModel sourceIsValid: aController source model ]
		  ifFalse: [ false ]
]
