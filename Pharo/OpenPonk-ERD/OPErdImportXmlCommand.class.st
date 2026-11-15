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
	"Answers the display name of the ERD GraphML import command."

	^ 'Import from GraphML...'
]

{ #category : 'execution' }
OPErdImportXmlCommand >> execute [
	"Imports GraphML model data into the active ERD domain model and updates the diagram."

	OPErdGraphML importToModel: self model inEditor: self editor
]
