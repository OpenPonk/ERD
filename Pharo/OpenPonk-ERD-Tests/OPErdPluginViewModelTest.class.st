"
Verifies ViewModel contracts across all bundled ERD example templates.
"
Class {
	#name : 'OPErdPluginViewModelTest',
	#superclass : 'OPAbstractPluginExampleViewModelTest',
	#category : 'OpenPonk-ERD-Tests-Plugin',
	#package : 'OpenPonk-ERD-Tests',
	#tag : 'Plugin'
}

{ #category : 'accessing' }
OPErdPluginViewModelTest class >> pluginClass [

	^ OPErdPlugin
]
