Class {
	#name : 'OPErdRelationController',
	#superclass : 'OPErdNodeController',
	#category : 'OpenPonk-ERD-Controllers',
	#package : 'OpenPonk-ERD',
	#tag : 'Controllers'
}

{ #category : 'forms' }
OPErdRelationController >> buildEditorForm: aForm [
	super buildEditorForm: aForm.
	(aForm addCheckbox: 'Identifying')
		state: self model isIdentifying;
		whenChangedDo: [ :newValue |
			self model isIdentifying: newValue.
			self diagramElement modelChanged]
]

{ #category : 'connecting' }
OPErdRelationController >> canBeSourceFor: aController [
	^ (aController class == OPErdTransitionController) |
	  (aController class == OPErdTotalTransitionController)
]

{ #category : 'connecting' }
OPErdRelationController >> canBeTargetFor: aController [
	^ (aController class == OPErdTotalTransitionController) 
	  ifTrue: [ (aController source model class == OPErdEntity)
	  		ifTrue: [ ^ aController source model isWeak ]
			ifFalse: [ ^ false ] ]
	  ifFalse: [ (aController class == OPErdTransitionController)
		ifTrue: [ (aController source model class == OPErdEntity)
			ifTrue: [ ^ (aController source model isWeak not) ]
			ifFalse: [ (aController source model class == OPErdAttribute)
				ifTrue: [ ^ ((aController source model isKey not) and: 
							   (aController source model isDerived not)) ]
				ifFalse: [ ^ false ] ] ]
		ifFalse: [ ^ false ] ]
]

{ #category : 'construction' }
OPErdRelationController >> diagramElementClass [

	^ OPErdRelationShape
]

{ #category : 'accessing' }
OPErdRelationController >> modelClass [
	^ OPErdRelation
]
