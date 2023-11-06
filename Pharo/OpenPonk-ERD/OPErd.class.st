Class {
	#name : #OPErd,
	#superclass : #OPModelObject,
	#category : #'OpenPonk-ERD-Models'
}

{ #category : #testing }
OPErd >> isState [
	^ false
]

{ #category : #testing }
OPErd >> isTransition [
	^ false
]

{ #category : #testing }
OPErd >> states [
	^ elements select: [ :each | each isState ]
]

{ #category : #testing }
OPErd >> transitions [
	^ elements select: [ :each | each isTransition ]
]
