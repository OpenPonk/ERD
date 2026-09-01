"
I am the controller responsible for the lifecycle and diagram interactions of ERD relationships.
I manage rules regarding which elements can be connected as sources and targets.
"
Class {
	#name : 'OPErdRelationController',
	#superclass : 'OPErdNodeController',
	#category : 'OpenPonk-ERD-Controllers',
	#package : 'OpenPonk-ERD',
	#tag : 'Controllers'
}

{ #category : 'construction' }
OPErdRelationController class >> diagramElementClass [

	^ OPErdRelationShape
]

{ #category : 'accessing' }
OPErdRelationController class >> viewModelClass [
	^ OPErdRelationViewModel
]

{ #category : 'connecting' }
OPErdRelationController >> canBeSourceFor: aController [
	^ (aController class == OPErdTransitionController) |
	  (aController class == OPErdTotalTransitionController)
]

{ #category : 'connecting' }
OPErdRelationController >> canBeTargetFor: aController [
	^ (aController class == OPErdTotalTransitionController) 
	  ifTrue: [ (aController source model class == OPErdEntity)
	  		ifTrue: [ ^ aController source model isWeak ]
			ifFalse: [ ^ false ] ]
	  ifFalse: [ (aController class == OPErdTransitionController)
		ifTrue: [ (aController source model class == OPErdEntity)
			ifTrue: [ ^ (aController source model isWeak not) ]
			ifFalse: [ (aController source model class == OPErdAttribute)
				ifTrue: [ ^ ((aController source model isKey not) and: 
							   (aController source model isDerived not)) ]
				ifFalse: [ ^ false ] ] ]
		ifFalse: [ ^ false ] ]
]
