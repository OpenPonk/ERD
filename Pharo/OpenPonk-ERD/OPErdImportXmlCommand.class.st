"
A model command that imports an Entity-Relationship model structure from an XML document.
"
Class {
	#name : 'OPErdImportXmlCommand',
	#superclass : 'OPErdCommand',
	#category : 'OpenPonk-ERD-Commands',
	#package : 'OpenPonk-ERD',
	#tag : 'Commands'
}

{ #category : 'activation' }
OPErdImportXmlCommand class >> modelMenuActivation [
	<classAnnotation>
	^ OPModelMenuActivation
		byItemOf: OPModelBasicMenuGroup
		order: 20
		for: OPEditor
]

{ #category : 'accessing' }
OPErdImportXmlCommand >> defaultMenuIcon [
	"Answers the icon form for the ERD import command."
	^ OPCoreIcons opDiagramIcon
]

{ #category : 'accessing' }
OPErdImportXmlCommand >> defaultMenuItemName [
	"Answers the display name of the ERD import command."
	^ 'Import as xmi'
]

{ #category : 'execution' }
OPErdImportXmlCommand >> execute [
	"Imports XMI model data into the active ERD domain model and updates diagram."
	OPErdGraphML importToModel: self model inEditor: self editor
]
