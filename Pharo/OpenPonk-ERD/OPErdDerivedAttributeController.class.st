"
I am a specialized controller that initializes and handles derived attribute models within the ERD diagram.
"
Class {
	#name : 'OPErdDerivedAttributeController',
	#superclass : 'OPErdAttributeController',
	#category : 'OpenPonk-ERD-Controllers',
	#package : 'OpenPonk-ERD',
	#tag : 'Controllers'
}

{ #category : 'construction' }
OPErdDerivedAttributeController >> createModelIn: aParentModel [
	^ (super createModelIn: aParentModel)
		  beDerived;
		  yourself
]
