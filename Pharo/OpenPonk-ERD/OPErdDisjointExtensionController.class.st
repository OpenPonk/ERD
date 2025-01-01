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
