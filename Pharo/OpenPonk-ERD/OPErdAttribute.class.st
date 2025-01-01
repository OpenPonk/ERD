Class {
	#name : 'OPErdAttribute',
	#superclass : 'OPErdNode',
	#instVars : [
		'isDerived',
		'isMultivalued',
		'isKey'
	],
	#category : 'OpenPonk-ERD-Models',
	#package : 'OpenPonk-ERD',
	#tag : 'Models'
}

{ #category : 'associating' }
OPErdAttribute >> beDerived [
	self isDerived: true
]

{ #category : 'associating' }
OPErdAttribute >> beKey [
	self isKey: true
]

{ #category : 'associating' }
OPErdAttribute >> beMultivalued [
	self isMultivalued: true
]

{ #category : 'accessing' }
OPErdAttribute >> beNormal [
	self isDerived: false.
	self isMultivalued: false.
	self isKey: false
]

{ #category : 'associating' }
OPErdAttribute >> graphmlType [
	self isDerived 
		ifTrue: [ ^ #derived ]
		ifFalse: [ self isMultivalued 
						ifTrue: [ ^ #multivalued ]
						ifFalse: [ self isKey
										ifTrue: [ ^ #key ]
										ifFalse: [ ^ #regularAttribute ] ] ]
]

{ #category : 'associating' }
OPErdAttribute >> initialize [
	super initialize.
	isDerived := false.
	isMultivalued := false.
	isKey := false
]

{ #category : 'associating' }
OPErdAttribute >> isDerived [
	^ isDerived 
]

{ #category : 'accessing' }
OPErdAttribute >> isDerived: aBoolean [
	isDerived := aBoolean.
	self changed
]

{ #category : 'associating' }
OPErdAttribute >> isKey [
	^ isKey 
]

{ #category : 'accessing' }
OPErdAttribute >> isKey: aBoolean [
	isKey := aBoolean.
	self changed
]

{ #category : 'associating' }
OPErdAttribute >> isMultivalued [
	^ isMultivalued 
]

{ #category : 'accessing' }
OPErdAttribute >> isMultivalued: aBoolean [
	isMultivalued := aBoolean.
	self changed
]

{ #category : 'associating' }
OPErdAttribute >> isNormal [
	^ (isDerived & isMultivalued & isKey) not
]
