Class {
	#name : 'OPErdIdentifyingRelationController',
	#superclass : 'OPErdRelationController',
	#category : 'OpenPonk-ERD-Controllers',
	#package : 'OpenPonk-ERD',
	#tag : 'Controllers'
}

{ #category : 'connecting' }
OPErdIdentifyingRelationController >> canBeTargetFor: aController [
	^ (aController class == OPErdTotalTransitionController) 
	  ifTrue: [ (aController source model class == OPErdEntity)
	  		ifTrue: [ ^ (aController source model isWeak) ]
			ifFalse: [ ^ false ] ]
	  ifFalse: [ (aController class == OPErdTransitionController)
		ifTrue: [ (aController source model class == OPErdAttribute)
			ifTrue: [ ^ ((aController source model isKey not) and: 
							(aController source model isDerived not)) ]
			ifFalse: [ (aController source model class == OPErdEntity)
				ifTrue: [ ^ (aController source model isWeak not) ]
				ifFalse: [ ^ false ] ] ]
		ifFalse: [ ^ false ] ]
]

{ #category : 'construction' }
OPErdIdentifyingRelationController >> createModelIn: aParentModel [

	^ (super createModelIn: aParentModel)
		  beIdentifying;
		  yourself
]
