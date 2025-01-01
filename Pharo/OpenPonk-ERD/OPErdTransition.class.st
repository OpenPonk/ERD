Class {
	#name : 'OPErdTransition',
	#superclass : 'OPModelObject',
	#instVars : [
		'source',
		'target',
		'matchBlock',
		'isTotal',
		'isInheritance'
	],
	#category : 'OpenPonk-ERD-Models',
	#package : 'OpenPonk-ERD',
	#tag : 'Models'
}

{ #category : 'instance creation' }
OPErdTransition class >> from: aSource to: aTarget [
	^ self new
		source: aSource;
		target: aTarget;
		yourself
]

{ #category : 'instance creation' }
OPErdTransition class >> from: aSource to: aTarget named: aString [
	^ self new
		source: aSource;
		target: aTarget;
		name: aString;
		yourself
]

{ #category : 'comparing' }
OPErdTransition >> = otherTransition [
	^ (otherTransition respondsTo: #isTransition)
		and: [ otherTransition isTransition
				and: [ otherTransition represents: self ] ]
]

{ #category : 'comparing' }
OPErdTransition >> asTransition [
	^ self
]

{ #category : 'as yet unclassified' }
OPErdTransition >> beInheritance [
	self isInheritance: true
]

{ #category : 'accessing' }
OPErdTransition >> beNormal [
	self isTotal: false.
	self isInheritance: false.
]

{ #category : 'as yet unclassified' }
OPErdTransition >> beTotal [
	self isTotal: true
	
]

{ #category : 'comparing' }
OPErdTransition >> detach [
	super detach.
	source := nil.
	target := nil
]

{ #category : 'associating' }
OPErdTransition >> graphmlType [
	self isTotal 
		ifTrue: [ ^ #total ]
		ifFalse: [ self isInheritance
				ifTrue: [ ^ #inheritance ]
				ifFalse: [ ^ #regular ] ]
]

{ #category : 'comparing' }
OPErdTransition >> initialize [
	super initialize.
	isTotal := false.
	isInheritance := false.
	matchBlock := [ :aValue | (self name splitOn: ',') includes: aValue asString ]
]

{ #category : 'accessing' }
OPErdTransition >> isInheritance [
	^ isInheritance
]

{ #category : 'accessing' }
OPErdTransition >> isInheritance: aBoolean [
	isInheritance := aBoolean.
	self changed
]

{ #category : 'testing' }
OPErdTransition >> isNormal [
	^ (self isTotal & self isInheritance) not
]

{ #category : 'comparing' }
OPErdTransition >> isState [
	^ false
]

{ #category : 'accessing' }
OPErdTransition >> isTotal [
	^ isTotal 
]

{ #category : 'accessing' }
OPErdTransition >> isTotal: aBoolean [
	isTotal := aBoolean.
	self changed
]

{ #category : 'comparing' }
OPErdTransition >> isTransition [
	^ true
]

{ #category : 'comparing' }
OPErdTransition >> matchBlock [
	^ matchBlock
]

{ #category : 'comparing' }
OPErdTransition >> matchBlock: aOneArgBlock [
	matchBlock := aOneArgBlock.
	self changed
]

{ #category : 'comparing' }
OPErdTransition >> matches: aValue [
	^ matchBlock value: aValue
]

{ #category : 'comparing' }
OPErdTransition >> represents: otherTransition [
	^ super = otherTransition
]

{ #category : 'comparing' }
OPErdTransition >> source [
	^ source
]

{ #category : 'comparing' }
OPErdTransition >> source: aVertex [
	source := aVertex
]

{ #category : 'comparing' }
OPErdTransition >> target [
	^ target
]

{ #category : 'comparing' }
OPErdTransition >> target: aVertex [
	target := aVertex
]
