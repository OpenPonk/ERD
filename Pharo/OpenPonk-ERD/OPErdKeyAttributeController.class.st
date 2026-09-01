"
I am a specialized controller that initializes and handles key attribute models in an ERD diagram.
"
Class {
	#name : 'OPErdKeyAttributeController',
	#superclass : 'OPErdAttributeController',
	#category : 'OpenPonk-ERD-Controllers',
	#package : 'OpenPonk-ERD',
	#tag : 'Controllers'
}

{ #category : 'construction' }
OPErdKeyAttributeController >> createModelIn: aParentModel [
	^ (super createModelIn: aParentModel)
		  beKey;
		  yourself
]
