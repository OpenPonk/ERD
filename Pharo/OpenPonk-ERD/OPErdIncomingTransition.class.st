Class {
	#name : 'OPErdIncomingTransition',
	#superclass : 'OPErdTransition',
	#instVars : [
		'transition'
	],
	#category : 'OpenPonk-ERD-Adapters',
	#package : 'OpenPonk-ERD',
	#tag : 'Adapters'
}

{ #category : 'testing' }
OPErdIncomingTransition class >> isDeprecated [

	^ true
]

{ #category : 'instance creation' }
OPErdIncomingTransition class >> new [

	^ self superclass new
]

{ #category : 'accessing' }
OPErdIncomingTransition >> isInheritance [

	^ super isInheritance ifNil: [ ^ transition isInheritance ]
]

{ #category : 'accessing' }
OPErdIncomingTransition >> isTotal [

	^ super isTotal ifNil: [ ^ transition isTotal ]
]

{ #category : 'comparing' }
OPErdIncomingTransition >> source [

	^ super source ifNil: [ ^ transition source ]
]

{ #category : 'comparing' }
OPErdIncomingTransition >> target [

	^ super target ifNil: [ ^ transition target ]
]
