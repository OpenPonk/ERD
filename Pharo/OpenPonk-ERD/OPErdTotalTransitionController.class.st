Class {
	#name : 'OPErdTotalTransitionController',
	#superclass : 'OPErdTransitionController',
	#category : 'OpenPonk-ERD-Controllers',
	#package : 'OpenPonk-ERD',
	#tag : 'Controllers'
}

{ #category : 'construction' }
OPErdTotalTransitionController >> createModelIn: aParentModel [

	^ (super createModelIn: aParentModel)
		  beTotal;
		  yourself
]
