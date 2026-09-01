"
I am a specialized controller that initializes and handles total participation transitions (typically rendered as double lines) in an ERD diagram.
"
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
