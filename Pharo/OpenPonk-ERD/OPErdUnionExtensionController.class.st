Class {
	#name : #OPErdUnionExtensionController,
	#superclass : #OPErdExtensionsController,
	#category : #'OpenPonk-ERD-Controllers'
}

{ #category : #construction }
OPErdUnionExtensionController >> createModelIn: aParentModel [

	^ (super createModelIn: aParentModel)
		  beUnion;
		  yourself
]
