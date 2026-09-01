"
Controller for an Entity-Relationship Diagram entity. 
Manages the diagram lifecycle, valid connections, and interactions for entity nodes.
"
Class {
	#name : 'OPErdEntityController',
	#superclass : 'OPErdNodeController',
	#category : 'OpenPonk-ERD-Controllers',
	#package : 'OpenPonk-ERD',
	#tag : 'Controllers'
}

{ #category : 'construction' }
OPErdEntityController class >> diagramElementClass [

	^ OPErdEntityShape
]

{ #category : 'accessing' }
OPErdEntityController class >> viewModelClass [
	^ OPErdEntityViewModel
]

{ #category : 'connecting' }
OPErdEntityController >> canBeSourceFor: aController [
	^ (aController isKindOf: OPErdTransitionController)
]

{ #category : 'connecting' }
OPErdEntityController >> canBeTargetFor: aController [
	^ (aController class == OPErdInheritanceTransitionController)
		ifTrue: [ ^ self sourceIsValid: aController source model ]
		ifFalse: [ (aController class == OPErdTotalTransitionController) 
			ifTrue: [ (aController source model class == OPErdRelation)
					ifTrue: [ ^ aController source model isIdentifying not ]
					ifFalse: [ ^ (aController source model class == OPErdExtensions) ] ]  
			ifFalse: [ (aController class == OPErdTransitionController)
				ifTrue: [ ^ self validSources includes: aController source model class ]
				ifFalse: [ ^ false ] ] ]
]

{ #category : 'deprecation' }
OPErdEntityController >> sourceIsValid: aModel [
	self deprecated: 'Use viewModel instead' transformWith: '`@receiver sourceIsValid: `@arg1' -> '`@receiver viewModel sourceIsValid: `@arg1'.
	^ self viewModel sourceIsValid: aModel
]

{ #category : 'deprecation' }
OPErdEntityController >> validSources [
	self deprecated: 'Use viewModel instead'.
	^ self viewModel validSources
]
