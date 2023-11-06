Class {
	#name : #OPErdOverlappingExtensionController,
	#superclass : #OPErdExtensionsController,
	#category : #'OpenPonk-ERD-Controllers'
}

{ #category : #construction }
OPErdOverlappingExtensionController >> createModelIn: aParentModel [

	^ (super createModelIn: aParentModel)
		  beOverlapping;
		  yourself
]
