Class {
	#name : 'OPErdKeyAttributeController',
	#superclass : 'OPErdAttributeController',
	#category : 'OpenPonk-ERD-Controllers',
	#package : 'OpenPonk-ERD',
	#tag : 'Controllers'
}

{ #category : 'connecting' }
OPErdKeyAttributeController >> canBeTargetFor: aController [
	^ (aController class == OPErdTransitionController)
		ifTrue: [ ^ self sourceIsValid: aController source model  ]
		ifFalse: [ ^ false ]
]

{ #category : 'construction' }
OPErdKeyAttributeController >> createModelIn: aParentModel [

	^ (super createModelIn: aParentModel)
		  beKey;
		  yourself
]

{ #category : 'as yet unclassified' }
OPErdKeyAttributeController >> sourceIsValid: aModel [
	^ self validSources includes: aModel class 
]

{ #category : 'accessing - DirectedRelationship' }
OPErdKeyAttributeController >> validSources [
"does not include self to avoid self -> self connections if not allowed"
	^ { OPErdEntity }
]
