"
Verifies the initialization, registration, and shutdown lifecycle of the ERD plugin.
"
Class {
	#name : 'OPErdPluginLifecycleTest',
	#superclass : 'OPAbstractPluginExampleLifecycleTest',
	#category : 'OpenPonk-ERD-Tests-Plugin',
	#package : 'OpenPonk-ERD-Tests',
	#tag : 'Plugin'
}

{ #category : 'accessing' }
OPErdPluginLifecycleTest class >> pluginClass [
	"Answers the OPPlugin class under test."
	^ OPErdPlugin
]

{ #category : 'tests' }
OPErdPluginLifecycleTest >> testPluginMetadataAndRepositoryName [

	| pluginInstance |
	self assert: OPErdPlugin repositoryName equals: #ERD.
	self deny: OPErdPlugin isTestingOnly description: 'ERD plugin class must not be marked as testing only'.

	pluginInstance := self plugin.
	self assert: pluginInstance name equals: 'ER Diagram'.
	self assert: pluginInstance modelClass identicalTo: OPErd.
	self assert: pluginInstance diagramControllerClass identicalTo: OPErdController.
	self assert: pluginInstance layouterClass identicalTo: OPErdLayouter.
	self assert: pluginInstance modelSerializerClass identicalTo: OPErdModelSerializer.
	self assert: pluginInstance supportsHidingElements description: 'ERD plugin must support hiding elements'.
	self assert: pluginInstance icon bits equals: OPERDIcons opErdDiagramIcon bits
]
