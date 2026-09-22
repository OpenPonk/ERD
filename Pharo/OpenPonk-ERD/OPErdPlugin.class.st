"
Defines the plugin configuration for Entity-Relationship Diagrams. 
Maps top-level controllers, models, view models, and serializers for the OpenPonk framework.
"
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

{ #category : 'templates' }
OPErdPlugin >> exampleProjectTemplates [
	"Answers example project templates for Entity Relationship Diagrams."

	^ { 
		(OPProjectTemplate
			named: 'Order Management ERD'
			icon: self icon
			modelFactory: [ OPErdExamples exampleERDModel ]
			isExample: true) }
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

{ #category : 'testing' }
OPErdPlugin >> supportsHidingElements [
	^ true
]
