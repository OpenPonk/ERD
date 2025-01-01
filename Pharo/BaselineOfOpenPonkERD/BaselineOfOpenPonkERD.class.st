Class {
	#name : 'BaselineOfOpenPonkERD',
	#superclass : 'BaselineOf',
	#category : 'BaselineOfOpenPonkERD',
	#package : 'BaselineOfOpenPonkERD'
}

{ #category : 'baselines' }
BaselineOfOpenPonkERD >> baseline: spec [

	<baseline>
	spec for: #common do: [
		spec
			baseline: 'Mustache'
			with: [ spec repository: 'github://noha/mustache:a8db6a2' ].
		spec
			baseline: 'OpenPonk'
			with: [ spec repository: 'github://openponk/openponk' ].
		spec
			baseline: 'OpenPonkModel'
			with: [ spec repository: 'github://OpenPonk/openponk-model' ].
		spec
			package: 'OpenPonk-ERD'
			with: [
			spec requires: #( 'OpenPonkModel' 'Mustache' ) ].
		spec group: 'plugin' with: #( 'OpenPonk-ERD' ).
		spec group: 'default' with: #( 'OpenPonk' 'plugin' ) ]
]
