Class {
	#name : 'OPErdPlugin',
	#superclass : 'OPPlugin',
	#category : 'OpenPonk-ERD-Plugin',
	#package : 'OpenPonk-ERD',
	#tag : 'Plugin'
}

{ #category : 'accessing' }
OPErdPlugin >> diagramControllerClass [
	^ OPErdController
]

{ #category : 'accessing' }
OPErdPlugin >> icon [
	^ OPCoreIcons opErdDiagramIcon
]

{ #category : 'accessing' }
OPErdPlugin >> layouterClass [
	^ OPErdLayouter
]

{ #category : 'accessing' }
OPErdPlugin >> modelClass [
	^ OPErd
]

{ #category : 'accessing' }
OPErdPlugin >> modelSerializerClass [
	^ OPErdModelSerializer
]

{ #category : 'accessing' }
OPErdPlugin >> name [
	^ 'ER Diagram'
]

{ #category : 'accessing' }
OPErdPlugin >> supportsHidingElements [
	^ true
]
