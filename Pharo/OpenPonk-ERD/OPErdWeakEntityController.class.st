Class {
	#name : 'OPErdWeakEntityController',
	#superclass : 'OPErdEntityController',
	#category : 'OpenPonk-ERD-Controllers',
	#package : 'OpenPonk-ERD',
	#tag : 'Controllers'
}

{ #category : 'connecting' }
OPErdWeakEntityController >> canBeTargetFor: aController [
	^ (aController class == OPErdTotalTransitionController)
		ifTrue: [ (aController source modelClass == OPErdRelation)
			ifTrue: [ ^ true ]
			ifFalse: [ ^ (aController source model class == OPErdExtensions) ]  ]
		ifFalse: [ (aController class == OPErdInheritanceTransitionController)
			ifTrue: [ ^ (aController source modelClass == OPErdEntity) and: 
							(aController source model uuid ~~ self model uuid) ]
			ifFalse: [ (aController class == OPErdTransitionController)
				ifTrue: [ ^ self sourceIsValid: aController source model ]
				ifFalse: [ ^ false ] ] ]
]

{ #category : 'construction' }
OPErdWeakEntityController >> createModelIn: aParentModel [

	^ (super createModelIn: aParentModel)
		  beWeak;
		  yourself
]

{ #category : 'as yet unclassified' }
OPErdWeakEntityController >> sourceIsValid: aModel [
	(aModel class == self modelClass)
		ifTrue: [ ^ false ]
		ifFalse: [ ^ self validSources includes: aModel class ]
]

{ #category : 'accessing - DirectedRelationship' }
OPErdWeakEntityController >> validSources [
"does not include self to avoid self -> self connections if not allowed"
	^ { OPErdAttribute.
		 OPErdExtensions.
		 "OPErdRelation" }
]
