"
I am a specialized controller that initializes and handles disjoint extension models within the ERD diagram.
"
Class {
	#name : 'OPErdDisjointExtensionController',
	#superclass : 'OPErdExtensionsController',
	#category : 'OpenPonk-ERD-Controllers',
	#package : 'OpenPonk-ERD',
	#tag : 'Controllers'
}

{ #category : 'construction' }
OPErdDisjointExtensionController >> createModelIn: aParentModel [
	^ (super createModelIn: aParentModel)
		  beDisjoint;
		  yourself
]
