Class {
	#name : 'OPErdPluginLifecycleTest',
	#superclass : 'OPAbstractPluginExampleLifecycleTest',
	#category : 'OpenPonk-ERD-Tests',
	#package : 'OpenPonk-ERD',
	#tag : 'Tests'
}

{ #category : 'accessing' }
OPErdPluginLifecycleTest class >> pluginClass [
	"Answers the OPPlugin class under test."
	^ OPErdPlugin
]
