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
