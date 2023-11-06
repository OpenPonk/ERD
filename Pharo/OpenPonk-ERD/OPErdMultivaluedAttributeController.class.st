Class {
	#name : #OPErdMultivaluedAttributeController,
	#superclass : #OPErdAttributeController,
	#category : #'OpenPonk-ERD-Controllers'
}

{ #category : #construction }
OPErdMultivaluedAttributeController >> createModelIn: aParentModel [

	^ (super createModelIn: aParentModel)
		  beMultivalued;
		  yourself
]
