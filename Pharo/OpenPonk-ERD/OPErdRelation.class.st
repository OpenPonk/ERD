Class {
	#name : #OPErdRelation,
	#superclass : #OPErdNode,
	#instVars : [
		'isIdentifying'
	],
	#category : #'OpenPonk-ERD-Models'
}

{ #category : #'as yet unclassified' }
OPErdRelation >> beIdentifying [
	self isIdentifying: true
]

{ #category : #accessing }
OPErdRelation >> beNormal [
	self isIdentifying: false
]

{ #category : #associating }
OPErdRelation >> graphmlType [
	self isIdentifying
		ifTrue: [ ^ #identifying ]
		ifFalse: [ ^ #regularRelation ]
]

{ #category : #initialization }
OPErdRelation >> initialize [
	super initialize.
	isIdentifying := false
]

{ #category : #accessing }
OPErdRelation >> isIdentifying [
	^ isIdentifying 
]

{ #category : #accessing }
OPErdRelation >> isIdentifying: aBoolean [
	isIdentifying := aBoolean.
	self changed
]

{ #category : #associating }
OPErdRelation >> isNormal [
	^ isIdentifying not
]
