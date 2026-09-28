"
A model command that exports the current Entity-Relationship model to an XML representation.
"
Class {
	#name : 'OPErdExportXmlCommand',
	#superclass : 'OPErdCommand',
	#category : 'OpenPonk-ERD-Commands',
	#package : 'OpenPonk-ERD',
	#tag : 'Commands'
}

{ #category : 'activation' }
OPErdExportXmlCommand class >> modelMenuActivation [
	<classAnnotation>
	^ OPModelMenuActivation
		byItemOf: OPModelBasicMenuGroup
		order: 10
		for: OPEditor
]

{ #category : 'accessing' }
OPErdExportXmlCommand >> defaultMenuIcon [
	"Answers the icon form for the ERD export command."
	^ OPCoreIcons opDiagramIcon
]

{ #category : 'accessing' }
OPErdExportXmlCommand >> defaultMenuItemName [
	"Answers the display name of the ERD export command."
	^ 'Export as xmi'
]

{ #category : 'execution' }
OPErdExportXmlCommand >> execute [
	"Exports the ERD domain model to an XMI file."
	OPErdGraphML exportPackage: self model
]
