Class {
	#name : 'OPErdExtensions',
	#superclass : 'OPErdNode',
	#instVars : [
		'isOverlapping',
		'isDisjoint',
		'isUnion'
	],
	#category : 'OpenPonk-ERD-Models',
	#package : 'OpenPonk-ERD',
	#tag : 'Models'
}

{ #category : 'as yet unclassified' }
OPErdExtensions >> beDisjoint [
	self isDisjoint: true
	
]

{ #category : 'accessing' }
OPErdExtensions >> beNormal [
	self isOverlapping: false.
	self isUnion: false.
	self isDisjoint: false.
]

{ #category : 'as yet unclassified' }
OPErdExtensions >> beOverlapping [
	self isOverlapping: true
]

{ #category : 'as yet unclassified' }
OPErdExtensions >> beUnion [
	self isUnion: true
]

{ #category : 'associating' }
OPErdExtensions >> graphmlType [
	self isUnion 
		ifTrue: [ ^ #union ]
		ifFalse: [ self isOverlapping 
						ifTrue: [ ^ #overlapping ]
						ifFalse: [ self isDisjoint
										ifTrue: [ ^ #disjoint ]
										ifFalse: [ ^ #regularExtensions ] ] ]
]

{ #category : 'initialization' }
OPErdExtensions >> initialize [
	super initialize.
	isDisjoint := false.
	isUnion := false.
	isOverlapping := false
]

{ #category : 'accessing' }
OPErdExtensions >> isDisjoint [
	^ isDisjoint 
]

{ #category : 'accessing' }
OPErdExtensions >> isDisjoint: aBoolean [
	isDisjoint := aBoolean.
	self changed
]

{ #category : 'associating' }
OPErdExtensions >> isNormal [
	^ (isUnion & isDisjoint & isOverlapping) not
]

{ #category : 'accessing' }
OPErdExtensions >> isOverlapping [
	^ isOverlapping
]

{ #category : 'accessing' }
OPErdExtensions >> isOverlapping: aBoolean [
	isOverlapping := aBoolean.
	self changed
]

{ #category : 'accessing' }
OPErdExtensions >> isUnion [
	^ isUnion
]

{ #category : 'accessing' }
OPErdExtensions >> isUnion: aBoolean [
	isUnion := aBoolean.
	self changed
]
