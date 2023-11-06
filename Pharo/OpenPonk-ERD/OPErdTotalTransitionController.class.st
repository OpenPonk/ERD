Class {
	#name : #OPErdTotalTransitionController,
	#superclass : #OPErdTransitionController,
	#category : #'OpenPonk-ERD-Controllers'
}

{ #category : #construction }
OPErdTotalTransitionController >> createModelIn: aParentModel [

	^ (super createModelIn: aParentModel)
		  beTotal;
		  yourself
]
