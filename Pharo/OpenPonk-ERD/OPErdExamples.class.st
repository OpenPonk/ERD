Class {
	#name : 'OPErdExamples',
	#superclass : 'Object',
	#category : 'OpenPonk-ERD-Examples',
	#package : 'OpenPonk-ERD',
	#tag : 'Examples'
}

{ #category : 'world menu' }
OPErdExamples class >> exampleERDsample [
	| project erd |
	project := OPProject new name: 'Entity Relationship Diagram'''.
	erd := OPErd new name: 'New ER Diagram'.
	project addModel: erd.
	(OPWorkbench openProject: project) showAllElementsInAllDiagrams
]

{ #category : 'world menu' }
OPErdExamples class >> exampleEmpty [
	| project erd |
	project := OPProject new name: 'Entity Relationship Diagram'.
	erd := OPErd new name: 'New ER Diagram'.
	project addModel: erd.
	(OPWorkbench openProject: project) showAllElementsInAllDiagrams
]

{ #category : 'world menu' }
OPErdExamples class >> menuCommandOn: aBuilder [

	<worldMenu>
	(aBuilder item: #OPERD)
		label: 'Entity Relationship Diagrams';
		icon: OPCoreIcons opErdDiagramIcon;
		action: [ self exampleEmpty ];
		parent: #MostUsedTools;
		order: 220;
		with: [ 
			(aBuilder item: #'ERD Example')
				parent: #OPERD;
				label: 'Entity Relationship sample';
				icon: OPCoreIcons opErdDiagramIcon;
				action: [ self exampleERDsample  ]. ]
]
