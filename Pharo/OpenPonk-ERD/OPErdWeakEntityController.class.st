"
I am a specialized controller that initializes and handles weak entity models in an ERD diagram.
I enforce connection rules, such as valid targets for weak entities.
"
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
