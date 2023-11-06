"
Please describe the package using the class comment of the included manifest class. The manifest class also includes other additional metadata for the package. These meta data are used by other tools such as the SmalllintManifestChecker and the critics Browser
"
Class {
	#name : #ManifestOpenPonkERD,
	#superclass : #PackageManifest,
	#category : #'OpenPonk-ERD-Manifest'
}

{ #category : #'code-critics' }
ManifestOpenPonkERD class >> ruleBadMessageRule2V1FalsePositive [

	<ignoreForCoverage>
	^ #(#(#(#RGMethodDefinition #(#OPErdNodeController #canBeSourceFor: #false)) #'2023-07-25T22:26:04.578+02:00') )
]
