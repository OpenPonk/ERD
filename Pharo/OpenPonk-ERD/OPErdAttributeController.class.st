Class {
	#name : 'OPErdAttributeController',
	#superclass : 'OPErdNodeController',
	#category : 'OpenPonk-ERD-Controllers',
	#package : 'OpenPonk-ERD',
	#tag : 'Controllers'
}

{ #category : 'forms' }
OPErdAttributeController >> buildEditorForm: aForm [

	super buildEditorForm: aForm.
	(aForm addCheckbox: 'Derived')
		state: self model isDerived;
		enabled: self derivedValidation;
		whenChangedDo: [ :newValue |
			self updateCheckboxOf: aForm named: 'Multivalued'.
			self updateCheckboxOf: aForm named: 'Key Value'.
			self model isDerived: newValue.
			self model isMultivalued: false.
			self model isKey: false.
			self diagramElement modelChanged. ].
	(aForm addCheckbox: 'Multivalued')
		state: self model isMultivalued;
		whenChangedDo: [ :newValue |
			self updateCheckboxOf: aForm named: 'Derived'.
			self updateCheckboxOf: aForm named: 'Key Value'.
			self model isMultivalued: newValue.
			self model isDerived: false.
			self model isKey: false.
			self diagramElement modelChanged. ].
	(aForm addCheckbox: 'Key Value')
		state: self model isKey;
		whenChangedDo: [ :newValue |
			self updateCheckboxOf: aForm named: 'Derived'.
			self updateCheckboxOf: aForm named: 'Multivalued'.
			self model isKey: newValue.
			self model isDerived: false.
			self model isMultivalued: false.
			self diagramElement modelChanged. ].
	self diagramController updateCanvas.
]

{ #category : 'connecting' }
OPErdAttributeController >> canBeSourceFor: aController [
	^ (aController class == OPErdTransitionController)

]

{ #category : 'connecting' }
OPErdAttributeController >> canBeTargetFor: aController [
	^ (aController class == OPErdTransitionController)
		ifTrue: [ ^ self sourceIsValid: aController source model  ]
		ifFalse: [ ^ false ]

]

{ #category : 'as yet unclassified' }
OPErdAttributeController >> derivedValidation [

	| inc out |
	inc := self model incoming isEmpty
		       ifTrue: [ true ]
		       ifFalse: [
			       self model incoming allSatisfy: [ :each |
				       self validDerivedSources includes: each source class ] ].
	out := self model outgoing isEmpty
		       ifTrue: [ true ]
		       ifFalse: [
		       self model outgoing includesAny: self validDerivedTargets ].
	inc & out ifTrue: [ ^ true ].
	^ false
]

{ #category : 'construction' }
OPErdAttributeController >> diagramElementClass [

	^ OPErdAttributeShape
]

{ #category : 'accessing' }
OPErdAttributeController >> modelClass [
	^ OPErdAttribute
]

{ #category : 'as yet unclassified' }
OPErdAttributeController >> sourceIsValid: aModel [
	(aModel class == self modelClass)
		ifTrue: [ ^ ((aModel uuid ~~ self model uuid) and: 
			((aModel isDerived ) |
				aModel isKey ) not) ]
		ifFalse: [ ^ self validSources includes: aModel class ]
]

{ #category : 'as yet unclassified' }
OPErdAttributeController >> validDerivedSources [
	^ { OPErdEntity.
		 OPErdRelation. }
]

{ #category : 'as yet unclassified' }
OPErdAttributeController >> validDerivedTargets [
	^ { OPErdEntity. }
]

{ #category : 'accessing - DirectedRelationship' }
OPErdAttributeController >> validSources [
"does not include self to avoid self -> self connections if not allowed"
	^ { OPErdEntity.
		 OPErdRelation }

]
