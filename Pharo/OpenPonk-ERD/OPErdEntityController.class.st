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

	^ aController class == OPErdInheritanceTransitionController
		  ifTrue: [ self viewModel sourceIsValid: aController source model ]
		  ifFalse: [
				  aController class == OPErdTotalTransitionController
					  ifTrue: [
							  aController source model class == OPErdRelation
								  ifTrue: [ aController source model isIdentifying not ]
								  ifFalse: [ aController source model class == OPErdExtensions ] ]
					  ifFalse: [
							  aController class == OPErdTransitionController
								  ifTrue: [ self viewModel validSources includes: aController source model class ]
								  ifFalse: [ false ] ] ]
]
