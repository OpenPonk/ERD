"
I am a specialized controller that initializes and handles overlapping extension models in an ERD diagram.
"
Class {
	#name : 'OPErdOverlappingExtensionController',
	#superclass : 'OPErdExtensionsController',
	#category : 'OpenPonk-ERD-Controllers',
	#package : 'OpenPonk-ERD',
	#tag : 'Controllers'
}

{ #category : 'construction' }
OPErdOverlappingExtensionController >> createModelIn: aParentModel [
	^ (super createModelIn: aParentModel)
		  beOverlapping;
		  yourself
]
