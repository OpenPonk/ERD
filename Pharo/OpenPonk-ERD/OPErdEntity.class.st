Class {
	#name : #OPErdEntity,
	#superclass : #OPErdNode,
	#instVars : [
		'isWeak'
	],
	#category : #'OpenPonk-ERD-Models'
}

{ #category : #accessing }
OPErdEntity >> beNormal [
	self isWeak: false
]

{ #category : #'as yet unclassified' }
OPErdEntity >> beWeak [
	self isWeak: true
]

{ #category : #accessing }
OPErdEntity >> diagramElement [
	^ OPErdEntityShape
]

{ #category : #associating }
OPErdEntity >> graphmlType [
	self isWeak 
		ifTrue: [ ^ #weak ]
		ifFalse: [ ^ #regularEntity ]
]

{ #category : #initialization }
OPErdEntity >> initialize [
	super initialize.
	isWeak := false
]

{ #category : #associating }
OPErdEntity >> isNormal [
	^ isWeak not
]

{ #category : #accessing }
OPErdEntity >> isWeak [
	^ isWeak 
]

{ #category : #accessing }
OPErdEntity >> isWeak: aBoolean [
	isWeak := aBoolean.
	self changed
]
