Class {
	#name : 'OPErdInheritanceTransitionController',
	#superclass : 'OPErdTransitionController',
	#category : 'OpenPonk-ERD-Controllers',
	#package : 'OpenPonk-ERD',
	#tag : 'Controllers'
}

{ #category : 'construction' }
OPErdInheritanceTransitionController >> createModelIn: aParentModel [

	^ (super createModelIn: aParentModel)
		  beInheritance;
		  yourself
]
