"
I am the controller responsible for the lifecycle and diagram interactions of ERD extensions.
I determine valid sources and targets for connections to/from extension nodes.
"
Class {
	#name : 'OPErdExtensionsController',
	#superclass : 'OPErdNodeController',
	#category : 'OpenPonk-ERD-Controllers',
	#package : 'OpenPonk-ERD',
	#tag : 'Controllers'
}

{ #category : 'construction' }
OPErdExtensionsController class >> diagramElementClass [

	^ OPErdExtensionsShape 
]

{ #category : 'accessing' }
OPErdExtensionsController class >> viewModelClass [
	^ OPErdExtensionsViewModel
]

{ #category : 'connecting' }
OPErdExtensionsController >> canBeSourceFor: aController [
	^ (aController class == OPErdTransitionController) | 
	  (aController class == OPErdTotalTransitionController)
]

{ #category : 'connecting' }
OPErdExtensionsController >> canBeTargetFor: aController [
	^ (aController isKindOf: OPErdTransitionController)
		ifTrue: [ ^ aController source model class == OPErdEntity  ]
		ifFalse: [ ^ false ]
]
