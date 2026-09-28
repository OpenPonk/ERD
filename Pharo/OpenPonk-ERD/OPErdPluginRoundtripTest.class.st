"
Verifies the serialization and deserialization roundtrip persistence for ERD models and diagrams.
"
Class {
	#name : 'OPErdPluginRoundtripTest',
	#superclass : 'OPAbstractPluginExampleRoundtripTest',
	#category : 'OpenPonk-ERD-Tests',
	#package : 'OpenPonk-ERD',
	#tag : 'Tests'
}

{ #category : 'accessing' }
OPErdPluginRoundtripTest class >> pluginClass [
	^ OPErdPlugin
]
