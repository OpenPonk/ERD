"
Verifies the serialization and deserialization roundtrip persistence for ERD models and diagrams.
"
Class {
	#name : 'OPErdPluginRoundtripTest',
	#superclass : 'OPAbstractPluginExampleRoundtripTest',
	#category : 'OpenPonk-ERD-Tests-Plugin',
	#package : 'OpenPonk-ERD-Tests',
	#tag : 'Plugin'
}

{ #category : 'accessing' }
OPErdPluginRoundtripTest class >> pluginClass [
	^ OPErdPlugin
]
