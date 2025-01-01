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

{ #category : 'toolbar' }
OPErdGraphML class >> exportPackage: aModel [

	StFBSaveFileDialog new
		title: 'Choose a XMI file to export to';
		okAction: [ :file | 
			file
				ensureDelete;
				writeStreamDo: [ :stream | 
					stream << (OPErdGraphML new export: aModel) ].
			UIManager default
				inform: (String streamContents: [ :s | 
						 s << 'Exported to ' << file pathString.
						 s
							 cr;
							 cr.
						 s << 'Click to open location' ])
				actionOnClick: [ file openInOSFileBrowser ] ];
		extensions: #( xmi xml uml ) named: 'XMI files';
		open
]

{ #category : 'toolbar' }
OPErdGraphML class >> importToModel: aModel withBuilder: aBuilder [

	StFBOpenFileDialog new
		title: 'Choose a XMI export of UML model';
		okAction: [ :file | 
			OPErdGraphML new import: file into: aModel.
			self inform: 'Imported from ' , file fullName.
			self updateModelAfterImport: (aBuilder model)];
		extensions: #( xmi xml ) named: 'XMI files';
		open.
]

{ #category : 'toolbar' }
OPErdGraphML class >> toolbarMenu: aBuilder [

	<opEditorToolbarMenu: #OPErdPlugin>
	(aBuilder item: 'Export as xmi')
		icon: OPCoreIcons opFsmDiagramIcon;
		action: [ self exportPackage: aBuilder model diagramController model ].
	(aBuilder item: 'Import as xmi')
		icon: OPCoreIcons opFsmDiagramIcon;
		action: [ self importToModel: aBuilder model diagramController model withBuilder: aBuilder ].
]

{ #category : 'as yet unclassified' }
OPErdGraphML class >> updateModelAfterImport: aModel [
	aModel workbench projectTree refresh.
	aModel diagramController showAllElements.
	self updateNodePositionsof: aModel.
]

{ #category : 'as yet unclassified' }
OPErdGraphML class >> updateNodePositionsof: aModel [
	aModel diagramController diagramElement ownedElements
		do: [ :each | 
			each modelElement isState
				ifTrue: [ 
					each roassalShape translateTo:
						(xPositions at: each modelElement uuid) asInteger
						@ (yPositions at: each modelElement uuid) asInteger ] ]
]

{ #category : 'as yet unclassified' }
OPErdGraphML >> edgeForType: aType [
	aType = #regular
		ifTrue: [ ^ OPErdTransition new
			beNormal;
			yourself ].
	aType = #total
		ifTrue: [ ^ OPErdTransition new
			beTotal;
			yourself ].
	aType = #inheritance
		ifTrue: [ ^ OPErdTransition new
			beInheritance;
			yourself ]
]

{ #category : 'public-exporting' }
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
								with: #graphmlType -> each graphmlType 
								with: #xPosition -> (self xPositionOfNode: each)
								with: #yPosition -> (self yPositionOfNode: each)]))} asDictionary
			"(#transitions
				->
					(aModel transitions
						collect: [ :each | 
							Dictionary
								with: #uuid -> each uuid
								with: #name -> each name
								with: #graphmlType -> each graphmlType ]))} asDictionary"
]

{ #category : 'import' }
OPErdGraphML >> import: aXml [
	| model doc graph graphData node nodeData edge edgeData nodes |
	doc := XMLDOMParser parse: aXml.
	graph := (doc root / #graph) first.
	graphData := (graph / #data
		collect: [ :each | (each attributeAt: #key) -> each stringValue ])
		asDictionary.
	model := OPErd new.
	model uuid: (UUID fromString: (graph attributeAt: #id)).
	model name: (graphData at: #name).
	nodes := Dictionary new.
	xPositions := Dictionary new.
	yPositions := Dictionary new.
	graph / #node
		do: [ :each | 
			nodeData := (each / #data
				collect: [ :data | (data attributeAt: #key) -> data stringValue ])
				asDictionary.
			node := self nodeForType: (nodeData at: #'node-type').
			node uuid: (UUID fromString: (each attributeAt: #id)).
			node name: (nodeData at: #name).
			"node position x: (nodeData at: #xPosition) y: (nodeData at: #yPosition)."
			xPositions at: node uuid put: (nodeData at: #xPosition).
			yPositions at: node uuid put: (nodeData at: #yPosition).
			nodes at: node uuid put: node.
			model add: node ].
	graph / #edge
		do: [ :each | 
			edgeData := (each / #data
				collect: [ :data | (data attributeAt: #key) -> data stringValue ])
				asDictionary.
			(edge := "OPErdTransition new" self edgeForType: (edgeData at: #'edge-type'))
				uuid: (UUID fromString: (each attributeAt: #id));
				name: (edgeData at: #name);
				source: (nodes at: (UUID fromString: (each attributeAt: #source)));
				target: (nodes at: (UUID fromString: (each attributeAt: #target))).
			model add: edge ].
	^ model
]

{ #category : 'import' }
OPErdGraphML >> import: aXml into: model [
	| doc graph graphData node nodeData edge edgeData nodes |
	doc := XMLDOMParser parse: aXml.
	graph := (doc root / #graph) first.
	graphData := (graph / #data
		collect: [ :each | (each attributeAt: #key) -> each stringValue ])
		asDictionary.
	model uuid: (UUID fromString: (graph attributeAt: #id)).
	model name: (graphData at: #name).
	nodes := Dictionary new.
	xPositions := Dictionary new.
	yPositions := Dictionary new.
	graph / #node
		do: [ :each | 
			nodeData := (each / #data
				collect: [ :data | (data attributeAt: #key) -> data stringValue ])
				asDictionary.
			node := self nodeForType: (nodeData at: #'node-type').
			node uuid: (UUID fromString: (each attributeAt: #id)).
			node name: (nodeData at: #name).
			xPositions at: node uuid put: (nodeData at: #xPosition).
			yPositions at: node uuid put: (nodeData at: #yPosition).
			nodes at: node uuid put: node.
			model add: node ].
	graph / #edge
		do: [ :each | 
			edgeData := (each / #data
				collect: [ :data | (data attributeAt: #key) -> data stringValue ])
				asDictionary.
			(edge := self edgeForType: (edgeData at: #'edge-type'))
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

{ #category : 'as yet unclassified' }
OPErdGraphML >> positionOfNode: aNode [
	aNode announcer subscriptions subscriptions 
		do: 	[ :subs | subs subscriber class == OPErd
			ifFalse: [ subs subscriber model uuid == aNode uuid
				ifTrue: [ ^ subs subscriber diagramElement position X ] ] ].
	^ 'position not found'
]

{ #category : 'as yet unclassified' }
OPErdGraphML >> setXPositionOfNode: aNode position: xPosition [
	aNode announcer subscriptions subscriptions 
		do: 	[ :subs | subs subscriber class == OPErd
			ifFalse: [ subs subscriber model uuid == aNode uuid
				ifTrue: [ subs subscriber diagramElement position x: xPosition ] ] ]
]

{ #category : 'as yet unclassified' }
OPErdGraphML >> setYPositionOfNode: aNode position: yPosition [
	aNode announcer subscriptions subscriptions 
		do: 	[ :subs | subs subscriber class == OPErd
			ifFalse: [ subs subscriber model uuid == aNode uuid
				ifTrue: [ subs subscriber diagramElement position y: yPosition ] ] ]
]

{ #category : 'accessing - TemplateSignature' }
OPErdGraphML >> template [
	<script: '(XMLDOMParser parse: self new template) inspect'>
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
			<data key="xPosition">{{xPosition}}</data>
			<data key="yPosition">{{yPosition}}</data>
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

{ #category : 'as yet unclassified' }
OPErdGraphML >> xPositionOfNode: aNode [
	aNode announcer subscriptions subscriptions 
		do: 	[ :subs | subs subscriber class == OPErd
			ifFalse: [ subs subscriber model uuid == aNode uuid
				ifTrue: [ ^ subs subscriber diagramElement position x ] ] ].
	^ 'position not found'
]

{ #category : 'as yet unclassified' }
OPErdGraphML >> yPositionOfNode: aNode [
	aNode announcer subscriptions subscriptions 
		do: 	[ :subs | subs subscriber class == OPErd
			ifFalse: [ subs subscriber model uuid == aNode uuid
				ifTrue: [ ^ subs subscriber diagramElement position y ] ] ].
	^ 'position not found'
]
