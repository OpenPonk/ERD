Class {
	#name : #OPErdDisjointExtensionController,
	#superclass : #OPErdExtensionsController,
	#category : #'OpenPonk-ERD-Controllers'
}

{ #category : #construction }
OPErdDisjointExtensionController >> createModelIn: aParentModel [

	^ (super createModelIn: aParentModel)
		  beDisjoint;
		  yourself
]
