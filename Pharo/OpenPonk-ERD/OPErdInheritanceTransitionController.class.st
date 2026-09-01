"
I am a specialized controller that initializes and handles inheritance transitions between entities and extensions in an ERD diagram.
"
Class {
	#name : 'OPErdInheritanceTransitionController',
	#superclass : 'OPErdTransitionController',
	#category : 'OpenPonk-ERD-Controllers',
	#package : 'OpenPonk-ERD',
	#tag : 'Controllers'
}

{ #category : 'construction' }
OPErdInheritanceTransitionController >> createModelIn: aParentModel [
	^ (super createModelIn: aParentModel)
		  beInheritance;
		  yourself
]
