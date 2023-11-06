Class {
	#name : #OPErdEntityController,
	#superclass : #OPErdNodeController,
	#category : #'OpenPonk-ERD-Controllers'
}

{ #category : #forms }
OPErdEntityController >> buildEditorForm: aForm [
	super buildEditorForm: aForm.
	(aForm addCheckbox: 'Weak')
		state: self model isWeak;
		whenChangedDo: [ :newValue |
			self model isWeak: newValue.
			self diagramElement modelChanged ]
]

{ #category : #connecting }
OPErdEntityController >> canBeSourceFor: aController [
	^ (aController isKindOf: OPErdTransitionController)
]

{ #category : #connecting }
OPErdEntityController >> canBeTargetFor: aController [
	^ (aController class == OPErdInheritanceTransitionController)
		ifTrue: [ ^ self sourceIsValid: aController source model ]
		ifFalse: [ (aController class == OPErdTotalTransitionController) 
			ifTrue: [ (aController source model class == OPErdRelation)
					ifTrue: [ ^ aController source model isIdentifying not ]
					ifFalse: [ ^ (aController source model class == OPErdExtensions) ] ]  
			ifFalse: [ (aController class == OPErdTransitionController)
				ifTrue: [ ^ self validSources includes: aController source model class ]
				ifFalse: [ ^ false ] ] ]
]

{ #category : #forms }
OPErdEntityController >> diagramElementClass [

	^ OPErdEntityShape
]

{ #category : #forms }
OPErdEntityController >> modelClass [
	^ OPErdEntity
]

{ #category : #'as yet unclassified' }
OPErdEntityController >> sourceIsValid: aModel [
	(aModel class == self modelClass)
		ifTrue: [ ^ (aModel uuid ~~ self model uuid) ]
		ifFalse: [ ^ false ]
]

{ #category : #'accessing - DirectedRelationship' }
OPErdEntityController >> validSources [
"does not include self to avoid self -> self connections if not allowed"
	^ { OPErdRelation.
		 OPErdAttribute.
		 OPErdExtensions }
]
