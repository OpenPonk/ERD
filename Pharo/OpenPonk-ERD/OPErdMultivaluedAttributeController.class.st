Class {
	#name : 'OPErdMultivaluedAttributeController',
	#superclass : 'OPErdAttributeController',
	#category : 'OpenPonk-ERD-Controllers',
	#package : 'OpenPonk-ERD',
	#tag : 'Controllers'
}

{ #category : 'construction' }
OPErdMultivaluedAttributeController >> createModelIn: aParentModel [

	^ (super createModelIn: aParentModel)
		  beMultivalued;
		  yourself
]
