"
Model representing an entity node in an Entity-Relationship Diagram. 
Tracks properties such as being a weak entity.
"
Class {
	#name : 'OPErdEntity',
	#superclass : 'OPErdNode',
	#instVars : [
		'isWeak'
	],
	#category : 'OpenPonk-ERD-Models',
	#package : 'OpenPonk-ERD',
	#tag : 'Models'
}

{ #category : 'actions' }
OPErdEntity >> beNormal [
	self isWeak: false
]

{ #category : 'actions' }
OPErdEntity >> beWeak [

	self isWeak: true
]

{ #category : 'associating' }
OPErdEntity >> graphmlType [
	self isWeak 
		ifTrue: [ ^ #weak ]
		ifFalse: [ ^ #regularEntity ]
]

{ #category : 'initialization' }
OPErdEntity >> initialize [
	super initialize.
	isWeak := false
]

{ #category : 'associating' }
OPErdEntity >> isNormal [
	^ isWeak not
]

{ #category : 'accessing' }
OPErdEntity >> isWeak [
	^ isWeak 
]

{ #category : 'accessing' }
OPErdEntity >> isWeak: aBoolean [
	isWeak := aBoolean.
	self changed
]
