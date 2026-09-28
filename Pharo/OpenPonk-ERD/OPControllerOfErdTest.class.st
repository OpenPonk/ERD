"
Abstract base test suite providing shared fixtures and assertions for ERD element controllers.
"
Class {
	#name : 'OPControllerOfErdTest',
	#superclass : 'OPAbstractElementControllerTest',
	#category : 'OpenPonk-ERD-Tests',
	#package : 'OpenPonk-ERD',
	#tag : 'Tests'
}

{ #category : 'testing' }
OPControllerOfErdTest class >> isAbstract [
	"Answer whether this test case is abstract."
	^ self = OPControllerOfErdTest
]

{ #category : 'accessing' }
OPControllerOfErdTest >> diagramControllerClass [
	"Answer the top-level diagram controller class for ERD."
	^ OPErdController
]

{ #category : 'accessing' }
OPControllerOfErdTest >> diagramModelClass [
	"Answer the top-level diagram model container class for ERD."
	^ OPErd
]
