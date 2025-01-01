Class {
	#name : 'OPErdNode',
	#superclass : 'OPModelObject',
	#category : 'OpenPonk-ERD-Models',
	#package : 'OpenPonk-ERD',
	#tag : 'Models'
}

{ #category : 'associating' }
OPErdNode >> -> aVertex [
	^ OPErdTransition from: self to: aVertex
]

{ #category : 'associating' }
OPErdNode >> graphmlType [
	^ self subclassResponsibility
]

{ #category : 'associating' }
OPErdNode >> incoming [
	owner ifNil: [ ^ #() ].
	^ owner transitions select: [ :each | each target = self ]
]

{ #category : 'associating' }
OPErdNode >> isDerived [
	^ false
]

{ #category : 'associating' }
OPErdNode >> isNormal [
	^ false
]

{ #category : 'associating' }
OPErdNode >> isState [
	^ true
]

{ #category : 'associating' }
OPErdNode >> isTransition [
	^ false
]

{ #category : 'associating' }
OPErdNode >> outgoing [
	owner ifNil: [ ^ #() ].
	^ owner transitions select: [ :each | each source = self ]
]

{ #category : 'associating' }
OPErdNode >> relatedElements [
	^ (self incoming , self outgoing) asSet asOrderedCollection
]

{ #category : 'associating' }
OPErdNode >> removedFrom: aDiagram [
	self
		removedFrom: aDiagram
		do: [ 
			self incoming do: [ :each | aDiagram remove: each ].
			self outgoing do: [ :each | aDiagram remove: each ] ]
]
