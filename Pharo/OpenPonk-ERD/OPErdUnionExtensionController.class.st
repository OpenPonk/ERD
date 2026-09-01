"
I am a specialized controller that initializes and handles union extension models in an ERD diagram.
"
Class {
	#name : 'OPErdUnionExtensionController',
	#superclass : 'OPErdExtensionsController',
	#category : 'OpenPonk-ERD-Controllers',
	#package : 'OpenPonk-ERD',
	#tag : 'Controllers'
}

{ #category : 'construction' }
OPErdUnionExtensionController >> createModelIn: aParentModel [
	^ (super createModelIn: aParentModel)
		  beUnion;
		  yourself
]
