Class {
	#name : #OPErdDerivedAttributeController,
	#superclass : #OPErdAttributeController,
	#category : #'OpenPonk-ERD-Controllers'
}

{ #category : #connecting }
OPErdDerivedAttributeController >> canBeTargetFor: aController [
	^ (aController class == OPErdTransitionController)
		ifTrue: [ ^ self sourceIsValid: aController source model  ]
		ifFalse: [ ^ false ]
]

{ #category : #construction }
OPErdDerivedAttributeController >> createModelIn: aParentModel [

	^ (super createModelIn: aParentModel)
		  beDerived; "generates dashed border"
		  yourself
]

{ #category : #'as yet unclassified' }
OPErdDerivedAttributeController >> sourceIsValid: aModel [
	^ self validSources includes: aModel class 
]

{ #category : #'accessing - DirectedRelationship' }
OPErdDerivedAttributeController >> validSources [
"does not include self to avoid self -> self connections if not allowed"
	^ { OPErdEntity }
]
