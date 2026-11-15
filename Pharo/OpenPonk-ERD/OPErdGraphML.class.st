"
Handles the import and export of Entity-Relationship Diagrams to and from GraphML format, including coordinate mapping for nodes.
"
Class {
	#name : 'OPErdGraphML',
	#superclass : 'Object',
	#classVars : [
		'xPositions',
		'yPositions'
	],
	#category : 'OpenPonk-ERD-Serialization',
	#package : 'OpenPonk-ERD',
	#tag : 'Serialization'
}

{ #category : 'exporting' }
OPErdGraphML class >> exportPackage: aModel [
	| baseName |
	baseName := (aModel respondsTo: #name)
		ifTrue: [ aModel name ]
		ifFalse: [ nil ].
	(baseName isNil or: [ baseName trimBoth isEmpty ]) ifTrue: [ baseName := 'export' ].
	OPExportFileDialog
		exportBlock: [ self new export: aModel ]
		defaultFileName: (FileNameSanitizer sanitize: baseName trimBoth) , '.graphml'
		extensions: #( graphml xml )
		named: 'GraphML files'
		title: 'Choose a GraphML file to export to'
]

{ #category : 'importing' }
OPErdGraphML class >> importToModel: aModel inEditor: anEditor [
	"Imports GraphML model data into aModel and refreshes the diagram controller and layout in anEditor."

	StOpenFilePresenter new
		title: 'Choose a GraphML file to import from';
		okAction: [ :file |
				self new import: file into: aModel.
				InformativeNotification signal: 'Imported from ' , file fullName.
				self updateModelAfterImport: anEditor ];
		extensions: #( graphml xml ) named: 'GraphML files';
		open
]

{ #category : 'importing' }
OPErdGraphML class >> updateModelAfterImport: anEditor [
	"Refreshes the project tree, shows imported diagram elements, and restores node positions or runs default layout."

	anEditor workbench projectTree refresh.
	anEditor diagramController showAllElements.
	(xPositions isNotNil and: [ yPositions isNotNil and: [ xPositions isNotEmpty ] ])
		ifTrue: [ self updateNodePositionsof: anEditor ]
		ifFalse: [ anEditor diagramController layouter defaultLayout ]
]

{ #category : 'importing' }
OPErdGraphML class >> updateNodePositionsof: anEditor [
	"Translates rendered diagram node shapes to the coordinates recorded during the last GraphML import."

	| xLookup yLookup diagramController |
	xLookup := xPositions ifNil: [ ^ self ].
	yLookup := yPositions ifNil: [ ^ self ].
	diagramController := anEditor diagramController.
	diagramController diagramElement ownedElements do: [ :eachElement |
			(eachElement isNode and: [ eachElement roassalShape isNotNil ]) ifTrue: [
					eachElement modelElement ifNotNil: [ :eachModelElement |
							xLookup at: eachModelElement uuid ifPresent: [ :xValue |
									yLookup at: eachModelElement uuid ifPresent: [ :yValue |
											eachElement roassalShape translateTo: xValue asNumber @ yValue asNumber.
											eachElement updateFromRender ] ] ] ] ].
	diagramController updateCanvas
]

{ #category : 'importing' }
OPErdGraphML >> edgeForType: aType [

	aType = #regular ifTrue: [
			^ OPErdTransition new
				  beNormal;
				  yourself ].
	aType = #total ifTrue: [
			^ OPErdTransition new
				  beTotal;
				  yourself ].
	aType = #inheritance ifTrue: [
			^ OPErdTransition new
				  beInheritance;
				  yourself ]
]

{ #category : 'exporting' }
OPErdGraphML >> export: aModel [
	^ (MustacheTemplate on: self template)
		value:
			{(#dateTime -> DateAndTime now truncated).
			(#model -> aModel).
			(#states
				->
					(aModel states
						collect: [ :each | 
							Dictionary
								with: #uuid -> each uuid
								with: #name -> each name
								with: #graphmlType -> each graphmlType ]))} asDictionary
]

{ #category : 'importing' }
OPErdGraphML >> import: aXml [

	^ self import: aXml into: OPErd new
]

{ #category : 'import' }
OPErdGraphML >> import: aXml into: model [

	| doc graph graphData node nodeData edge edgeData nodes |
	doc := XMLDOMParser parse: aXml.
	graph := (doc root / #graph) first.
	graphData := (graph / #data collect: [ :each | (each attributeAt: #key) -> each stringValue ]) asDictionary.
	model uuid: (UUID fromString: (graph attributeAt: #id)).
	model name: (graphData at: #name).
	nodes := Dictionary new.
	xPositions := Dictionary new.
	yPositions := Dictionary new.
	graph / #node do: [ :each |
			nodeData := (each / #data collect: [ :data | (data attributeAt: #key) -> data stringValue ]) asDictionary.
			node := self nodeForType: (nodeData at: #'node-type').
			node uuid: (UUID fromString: (each attributeAt: #id)).
			node name: (nodeData at: #name).
			nodeData at: #xPosition ifPresent: [ :xValue |
					nodeData at: #yPosition ifPresent: [ :yValue |
							xPositions at: node uuid put: xValue.
							yPositions at: node uuid put: yValue ] ].
			nodes at: node uuid put: node.
			model add: node ].
	graph / #edge do: [ :each |
			edgeData := (each / #data collect: [ :data | (data attributeAt: #key) -> data stringValue ]) asDictionary.
			edge := self edgeForType: (edgeData at: #'edge-type').
			edge
				uuid: (UUID fromString: (each attributeAt: #id));
				name: (edgeData at: #name);
				source: (nodes at: (UUID fromString: (each attributeAt: #source)));
				target: (nodes at: (UUID fromString: (each attributeAt: #target))).
			model add: edge ].
	^ model
]

{ #category : 'import' }
OPErdGraphML >> nodeForType: aType [
	aType = #derived
		ifTrue: [ ^ OPErdAttribute new
				beDerived;
				yourself ].
	aType = #multivalued
		ifTrue: [ ^ OPErdAttribute new
				beMultivalued;
				yourself ].
	aType = #key
		ifTrue: [ ^ OPErdAttribute new
				beKey;
				yourself ].
	aType = #regularAttribute
		ifTrue: [ ^ OPErdAttribute new
				beNormal;
				yourself ].
	aType = #weak
		ifTrue: [ ^ OPErdEntity new
				beWeak;
				yourself ].
	aType = #regularEntity
		ifTrue: [ ^ OPErdEntity new
				beNormal;
				yourself ].
	aType = #union
		ifTrue: [ ^ OPErdExtensions new
				beUnion;
				yourself ].
	aType = #overlapping
		ifTrue: [ ^ OPErdExtensions new
				beOverlapping;
				yourself ].
	aType = #disjoint
		ifTrue: [ ^ OPErdExtensions new
				beDisjoint;
				yourself ].
	aType = #regularExtensions
		ifTrue: [ ^ OPErdExtensions new
				beNormal;
				yourself ].
	aType = #identifying
		ifTrue: [ ^ OPErdRelation new
				beIdentifying;
				yourself ].
	aType = #regularRelation
		ifTrue: [ ^ OPErdRelation new
				beNormal;
				yourself ].
]

{ #category : 'accessing' }
OPErdGraphML >> template [
	^ '<?xml version="1.0" encoding="UTF-8"?>
<graphml
    xmlns="http://graphml.graphdrawing.org/xmlns"  
    xmlns:xsi="http://www.w3.org/2001/XMLSchema-instance"
    xsi:schemaLocation="http://graphml.graphdrawing.org/xmlns
    http://graphml.graphdrawing.org/xmlns/1.0/graphml.xsd">

    <key id="name" attr.name="element name" attr.type="string" for="all" />
    <key id="generated" attr.name="generation datetime" attr.type="string" for="graph" />
    <key id="node-type" attr.name="node type" attr.type="string" for="node" />
    <key id="edge-type" attr.name="edge type" attr.type="string" for="edge" />

    <graph id="{{model.uuid}}" edgedefault="directed">
        <data key="name">{{model.name}}</data>
        <data key="generated">{{dateTime}}</data>
        {{# states }}
        <node id="{{uuid}}">
            <data key="name">{{name}}</data>
            <data key="node-type">{{graphmlType}}</data>
        </node>
        {{/ states }}
        {{# model.transitions }}
        <edge id="{{uuid}}" source="{{source.uuid}}" target="{{target.uuid}}">
            <data key="name">{{name}}</data>
            <data key="edge-type">{{graphmlType}}</data>
        </edge>
        {{/ model.transitions }}
    </graph>
</graphml>'
]
