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
	^ (aController class == OPErdTransitionController)
		ifTrue: [ ^ self sourceIsValid: aController source model  ]
		ifFalse: [ ^ false ]

]

{ #category : 'deprecation' }
OPErdAttributeController >> derivedValidation [
	self deprecated: 'Use viewModel instead' transformWith: '`@receiver derivedValidation' -> '`@receiver viewModel derivedValidation'.
	^ self viewModel derivedValidation
]

{ #category : 'deprecation' }
OPErdAttributeController >> sourceIsValid: aModel [
	self deprecated: 'Use viewModel instead' transformWith: '`@receiver sourceIsValid: `@arg1' -> '`@receiver viewModel sourceIsValid: `@arg1'.
	^ self viewModel sourceIsValid: aModel
]

{ #category : 'deprecation' }
OPErdAttributeController >> validDerivedSources [
	self deprecated: 'Use viewModel instead'.
	^ self viewModel validDerivedSources
]

{ #category : 'deprecation' }
OPErdAttributeController >> validDerivedTargets [
	self deprecated: 'Use viewModel instead'.
	^ self viewModel validDerivedTargets
]

{ #category : 'deprecation' }
OPErdAttributeController >> validSources [
	self deprecated: 'Use viewModel instead'.
	^ self viewModel validSources
]
