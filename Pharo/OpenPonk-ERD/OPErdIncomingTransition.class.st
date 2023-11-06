Class {
	#name : #OPErdIncomingTransition,
	#superclass : #Object,
	#instVars : [
		'transition'
	],
	#category : #'OpenPonk-ERD-Adapters'
}

{ #category : #'instance creation' }
OPErdIncomingTransition class >> of: aTransition [
	^ self ofTransition: aTransition
]

{ #category : #'instance creation' }
OPErdIncomingTransition class >> ofTransition: aTransition [
	^ self new
		transition: aTransition;
		yourself
]

{ #category : #comparing }
OPErdIncomingTransition >> = otherTransition [
	^ self represents: otherTransition
]

{ #category : #comparing }
OPErdIncomingTransition >> asTransition [
	^ transition
]

{ #category : #comparing }
OPErdIncomingTransition >> changed [
	^ transition changed
]

{ #category : #comparing }
OPErdIncomingTransition >> doesNotUnderstand: aMessage [
	^ aMessage sendTo: transition
]

{ #category : #comparing }
OPErdIncomingTransition >> hash [
	^ transition hash
]

{ #category : #comparing }
OPErdIncomingTransition >> isTransition [

	^ true
]

{ #category : #comparing }
OPErdIncomingTransition >> printOn: aStream [
	^ transition printOn: aStream
]

{ #category : #comparing }
OPErdIncomingTransition >> represents: otherTransition [

	^ super = otherTransition or: [ 
		  transition == otherTransition or: [ transition = otherTransition ] ]
]

{ #category : #comparing }
OPErdIncomingTransition >> transition: aTransition [
	transition := aTransition
]

{ #category : #comparing }
OPErdIncomingTransition >> when: anAnnouncementClass send: aSelector to: anObject [
	^ transition when: anAnnouncementClass send: aSelector to: anObject
]
