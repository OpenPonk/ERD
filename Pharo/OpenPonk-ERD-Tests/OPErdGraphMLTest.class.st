"
Verifies GraphML export, import, node and edge type mapping, and node position import behavior for entity-relationship models.
"
Class {
	#name : 'OPErdGraphMLTest',
	#superclass : 'TestCase',
	#instVars : [
		'graphML',
		'previousXPositions',
		'previousYPositions'
	],
	#category : 'OpenPonk-ERD-Tests-Serialization',
	#package : 'OpenPonk-ERD-Tests',
	#tag : 'Serialization'
}

{ #category : 'helpers' }
OPErdGraphMLTest >> appendEdge: aTransition on: aStream [

	aStream nextPutAll: '<edge id="'.
	aStream nextPutAll: aTransition uuid asString.
	aStream nextPutAll: '" source="'.
	aStream nextPutAll: aTransition source uuid asString.
	aStream nextPutAll: '" target="'.
	aStream nextPutAll: aTransition target uuid asString.
	aStream nextPutAll: '">'.
	self appendXmlDataKey: 'name' value: aTransition name on: aStream.
	self appendXmlDataKey: 'edge-type' value: aTransition graphmlType on: aStream.
	aStream nextPutAll: '</edge>'
]

{ #category : 'helpers' }
OPErdGraphMLTest >> appendPositionedNode: aNode position: aPoint on: aStream [

	aStream nextPutAll: '<node id="'.
	aStream nextPutAll: aNode uuid asString.
	aStream nextPutAll: '">'.
	self appendXmlDataKey: 'name' value: aNode name on: aStream.
	self appendXmlDataKey: 'node-type' value: aNode graphmlType on: aStream.
	self appendXmlDataKey: 'xPosition' value: aPoint x on: aStream.
	self appendXmlDataKey: 'yPosition' value: aPoint y on: aStream.
	aStream nextPutAll: '</node>'
]

{ #category : 'helpers' }
OPErdGraphMLTest >> appendXmlDataKey: aKey value: aValue on: aStream [

	aStream nextPutAll: '<data key="'.
	aStream nextPutAll: aKey.
	aStream nextPutAll: '">'.
	aStream nextPutAll: aValue asString.
	aStream nextPutAll: '</data>'
]

{ #category : 'helpers' }
OPErdGraphMLTest >> assertImportedAttributeFlagsIn: importedByName [

	self assert: (importedByName at: 'derived_age') isDerived description: 'Derived attribute flag must roundtrip'.
	self deny: (importedByName at: 'derived_age') isMultivalued description: 'Derived attribute must not be multivalued'.
	self deny: (importedByName at: 'derived_age') isKey description: 'Derived attribute must not be key'.
	self assert: (importedByName at: 'phone_numbers') isMultivalued description: 'Multivalued attribute flag must roundtrip'.
	self assert: (importedByName at: 'employee_id') isKey description: 'Key attribute flag must roundtrip'.
	self deny: (importedByName at: 'full_name') isDerived description: 'Regular attribute must not be derived'.
	self deny: (importedByName at: 'full_name') isMultivalued description: 'Regular attribute must not be multivalued'.
	self deny: (importedByName at: 'full_name') isKey description: 'Regular attribute must not be key'
]

{ #category : 'helpers' }
OPErdGraphMLTest >> assertImportedNodesIn: importedModel matchOriginal: originalModel [

	| importedByName |
	importedByName := (importedModel states collect: [ :eachNode | eachNode name -> eachNode ]) asDictionary.
	originalModel states do: [ :eachOriginal |
			| importedNode |
			importedNode := importedByName at: eachOriginal name.
			self assert: importedNode class identicalTo: eachOriginal class.
			self assert: importedNode uuid equals: eachOriginal uuid.
			self assert: importedNode graphmlType equals: eachOriginal graphmlType.
			self assert: importedNode owner identicalTo: importedModel ].

	self assertImportedAttributeFlagsIn: importedByName.
	self assertImportedNonAttributeFlagsIn: importedByName
]

{ #category : 'helpers' }
OPErdGraphMLTest >> assertImportedNonAttributeFlagsIn: importedByName [

	self assert: (importedByName at: 'Dependent') isWeak description: 'Weak entity flag must roundtrip'.
	self deny: (importedByName at: 'Employee') isWeak description: 'Regular entity must not be weak'.
	self assert: (importedByName at: 'UnionExt') isUnion description: 'Union extension flag must roundtrip'.
	self assert: (importedByName at: 'OverlappingExt') isOverlapping description: 'Overlapping extension flag must roundtrip'.
	self assert: (importedByName at: 'DisjointExt') isDisjoint description: 'Disjoint extension flag must roundtrip'.
	self deny: (importedByName at: 'RegularExt') isUnion description: 'Regular extension must not be union'.
	self deny: (importedByName at: 'RegularExt') isOverlapping description: 'Regular extension must not be overlapping'.
	self deny: (importedByName at: 'RegularExt') isDisjoint description: 'Regular extension must not be disjoint'.
	self assert: (importedByName at: 'supports') isIdentifying description: 'Identifying relation flag must roundtrip'.
	self deny: (importedByName at: 'works_in') isIdentifying description: 'Regular relation must not be identifying'
]

{ #category : 'helpers' }
OPErdGraphMLTest >> assertImportedTransitionFlagsIn: importedTransitionsByName [

	self deny: (importedTransitionsByName at: '1') isTotal description: 'Regular transition must not be total'.
	self deny: (importedTransitionsByName at: '1') isInheritance description: 'Regular transition must not be inheritance'.
	self assert: (importedTransitionsByName at: '1..N') isTotal description: 'Total transition flag must roundtrip'.
	self deny: (importedTransitionsByName at: '1..N') isInheritance description: 'Total transition must not be inheritance'.
	self assert: (importedTransitionsByName at: 'isa') isInheritance description: 'Inheritance transition flag must roundtrip'.
	self deny: (importedTransitionsByName at: 'isa') isTotal description: 'Inheritance transition must not be total'
]

{ #category : 'helpers' }
OPErdGraphMLTest >> assertImportedTransitionsIn: importedModel matchOriginal: originalModel [

	| importedNodesByName importedTransitionsByName originalTransitionsByName |
	importedNodesByName := (importedModel states collect: [ :eachNode | eachNode name -> eachNode ]) asDictionary.
	importedTransitionsByName := (importedModel transitions collect: [ :eachTransition | eachTransition name -> eachTransition ])
		                             asDictionary.
	originalTransitionsByName := (originalModel transitions collect: [ :eachTransition | eachTransition name -> eachTransition ])
		                             asDictionary.

	originalTransitionsByName keysAndValuesDo: [ :transitionName :originalTransition |
			| importedTransition |
			importedTransition := importedTransitionsByName at: transitionName.
			self assert: importedTransition class identicalTo: OPErdTransition.
			self assert: importedTransition uuid equals: originalTransition uuid.
			self assert: importedTransition graphmlType equals: originalTransition graphmlType.
			self assert: importedTransition owner identicalTo: importedModel.
			self assert: importedTransition source identicalTo: (importedNodesByName at: originalTransition source name).
			self assert: importedTransition target identicalTo: (importedNodesByName at: originalTransition target name) ].

	self assertImportedTransitionFlagsIn: importedTransitionsByName
]

{ #category : 'helpers' }
OPErdGraphMLTest >> buildComprehensiveModel [

	| erdModel derivedAttribute multivaluedAttribute keyAttribute regularAttribute weakEntity regularEntity unionExtensions overlappingExtensions disjointExtensions regularExtensions identifyingRelation regularRelation regularTransition totalTransition inheritanceTransition |
	erdModel := OPErd new name: 'Comprehensive ERD'.

	derivedAttribute := OPErdAttribute new
		                    name: 'derived_age';
		                    beDerived;
		                    yourself.
	multivaluedAttribute := OPErdAttribute new
		                        name: 'phone_numbers';
		                        beMultivalued;
		                        yourself.
	keyAttribute := OPErdAttribute new
		                name: 'employee_id';
		                beKey;
		                yourself.
	regularAttribute := OPErdAttribute new
		                    name: 'full_name';
		                    yourself.

	weakEntity := OPErdEntity new
		              name: 'Dependent';
		              beWeak;
		              yourself.
	regularEntity := OPErdEntity new
		                 name: 'Employee';
		                 yourself.

	unionExtensions := OPErdExtensions new
		                   name: 'UnionExt';
		                   beUnion;
		                   yourself.
	overlappingExtensions := OPErdExtensions new
		                         name: 'OverlappingExt';
		                         beOverlapping;
		                         yourself.
	disjointExtensions := OPErdExtensions new
		                      name: 'DisjointExt';
		                      beDisjoint;
		                      yourself.
	regularExtensions := OPErdExtensions new
		                     name: 'RegularExt';
		                     yourself.

	identifyingRelation := OPErdRelation new
		                       name: 'supports';
		                       beIdentifying;
		                       yourself.
	regularRelation := OPErdRelation new
		                   name: 'works_in';
		                   yourself.

	regularTransition := OPErdTransition from: regularEntity to: regularAttribute named: '1'.
	totalTransition := (OPErdTransition from: weakEntity to: identifyingRelation named: '1..N')
		                   beTotal;
		                   yourself.
	inheritanceTransition := (OPErdTransition from: regularEntity to: disjointExtensions named: 'isa')
		                         beInheritance;
		                         yourself.

	erdModel addAll: {
			derivedAttribute.
			multivaluedAttribute.
			keyAttribute.
			regularAttribute.
			weakEntity.
			regularEntity.
			unionExtensions.
			overlappingExtensions.
			disjointExtensions.
			regularExtensions.
			identifyingRelation.
			regularRelation.
			regularTransition.
			totalTransition.
			inheritanceTransition }.

	^ erdModel
]

{ #category : 'helpers' }
OPErdGraphMLTest >> positionedGraphMlXmlForModel: anErdModel positionsByUuid: positionsByUuid [

	^ String streamContents: [ :stream |
			  stream nextPutAll: '<?xml version="1.0" encoding="UTF-8"?>'.
			  stream nextPutAll: '<graphml xmlns="http://graphml.graphdrawing.org/xmlns">'.
			  stream nextPutAll: '<graph id="'.
			  stream nextPutAll: anErdModel uuid asString.
			  stream nextPutAll: '" edgedefault="directed">'.
			  self appendXmlDataKey: 'name' value: anErdModel name on: stream.
			  anErdModel states do: [ :eachNode |
				  self appendPositionedNode: eachNode position: (positionsByUuid at: eachNode uuid) on: stream ].
			  anErdModel transitions do: [ :eachTransition | self appendEdge: eachTransition on: stream ].
			  stream nextPutAll: '</graph></graphml>' ]
]

{ #category : 'running' }
OPErdGraphMLTest >> setUp [

	super setUp.
	graphML := OPErdGraphML new.
	previousXPositions := OPErdGraphML classPool at: #xPositions.
	previousYPositions := OPErdGraphML classPool at: #yPositions
]

{ #category : 'running' }
OPErdGraphMLTest >> tearDown [

	OPErdGraphML classPool at: #xPositions put: previousXPositions.
	OPErdGraphML classPool at: #yPositions put: previousYPositions.
	previousXPositions := nil.
	previousYPositions := nil.
	graphML := nil.
	super tearDown
]

{ #category : 'tests' }
OPErdGraphMLTest >> testBeNormalAndGraphmlTypeOnDomainElements [

	| attribute entity extensions relation transition |
	attribute := OPErdAttribute new.
	attribute beKey.
	self assert: attribute graphmlType equals: #key.
	attribute beMultivalued.
	self assert: attribute graphmlType equals: #multivalued.
	attribute beDerived.
	self assert: attribute graphmlType equals: #derived.
	attribute beNormal.
	self deny: attribute isDerived description: 'beNormal must clear isDerived'.
	self deny: attribute isMultivalued description: 'beNormal must clear isMultivalued'.
	self deny: attribute isKey description: 'beNormal must clear isKey'.
	self assert: attribute graphmlType equals: #regularAttribute.

	entity := OPErdEntity new.
	entity beWeak.
	self assert: entity graphmlType equals: #weak.
	entity beNormal.
	self deny: entity isWeak description: 'beNormal must clear isWeak'.
	self assert: entity graphmlType equals: #regularEntity.

	extensions := OPErdExtensions new.
	extensions beDisjoint.
	self assert: extensions graphmlType equals: #disjoint.
	extensions beOverlapping.
	self assert: extensions graphmlType equals: #overlapping.
	extensions beUnion.
	self assert: extensions graphmlType equals: #union.
	extensions beNormal.
	self deny: extensions isUnion description: 'beNormal must clear isUnion'.
	self deny: extensions isOverlapping description: 'beNormal must clear isOverlapping'.
	self deny: extensions isDisjoint description: 'beNormal must clear isDisjoint'.
	self assert: extensions graphmlType equals: #regularExtensions.

	relation := OPErdRelation new.
	relation beIdentifying.
	self assert: relation graphmlType equals: #identifying.
	relation beNormal.
	self deny: relation isIdentifying description: 'beNormal must clear isIdentifying'.
	self assert: relation graphmlType equals: #regularRelation.

	transition := OPErdTransition new.
	transition beInheritance.
	self assert: transition graphmlType equals: #inheritance.
	transition beTotal.
	self assert: transition graphmlType equals: #total.
	transition beNormal.
	self deny: transition isTotal description: 'beNormal must clear isTotal'.
	self deny: transition isInheritance description: 'beNormal must clear isInheritance'.
	self assert: transition graphmlType equals: #regular
]

{ #category : 'tests' }
OPErdGraphMLTest >> testEdgeForTypeMapsAllThreeVariantsAndRejectsUnknown [

	| regularTransition totalTransition inheritanceTransition stringTotalTransition |
	regularTransition := graphML edgeForType: #regular.
	self assert: regularTransition class identicalTo: OPErdTransition.
	self deny: regularTransition isTotal description: 'Regular edge must not be total'.
	self deny: regularTransition isInheritance description: 'Regular edge must not be inheritance'.
	self assert: regularTransition graphmlType equals: #regular.

	totalTransition := graphML edgeForType: #total.
	self assert: totalTransition class identicalTo: OPErdTransition.
	self assert: totalTransition isTotal description: 'Total edge must set isTotal'.
	self deny: totalTransition isInheritance description: 'Total edge must not set isInheritance'.
	self assert: totalTransition graphmlType equals: #total.

	inheritanceTransition := graphML edgeForType: #inheritance.
	self assert: inheritanceTransition class identicalTo: OPErdTransition.
	self assert: inheritanceTransition isInheritance description: 'Inheritance edge must set isInheritance'.
	self deny: inheritanceTransition isTotal description: 'Inheritance edge must not set isTotal'.
	self assert: inheritanceTransition graphmlType equals: #inheritance.

	stringTotalTransition := graphML edgeForType: 'total'.
	self assert: stringTotalTransition isTotal description: 'String edge type must resolve to total transition'.
	self assert: (graphML edgeForType: #unknownEdgeType) identicalTo: graphML
]

{ #category : 'tests' }
OPErdGraphMLTest >> testExportAndImportEmptyModelAndSpecialXmlCharacters [

	| emptyModel importedEmpty specialModel entity unnamedAttribute transition importedSpecial importedEntity importedAttribute |
	emptyModel := OPErd new name: 'Empty ERD'.
	importedEmpty := graphML import: (graphML export: emptyModel).
	self assert: importedEmpty uuid equals: emptyModel uuid.
	self assert: importedEmpty name equals: 'Empty ERD'.
	self assertEmpty: importedEmpty states.
	self assertEmpty: importedEmpty transitions.
	self assertEmpty: importedEmpty elements.

	specialModel := OPErd new name: 'Orders & Items <v1>'.
	entity := OPErdEntity new name: 'Customer & Partner > VIP'.
	unnamedAttribute := OPErdAttribute new name: ''.
	transition := OPErdTransition from: entity to: unnamedAttribute named: '0..* & 1'.
	specialModel addAll: {
			entity.
			unnamedAttribute.
			transition }.

	importedSpecial := graphML import: (graphML export: specialModel).
	self assert: importedSpecial name equals: 'Orders & Items <v1>'.
	importedEntity := importedSpecial states detect: [ :eachNode | eachNode class = OPErdEntity ].
	importedAttribute := importedSpecial states detect: [ :eachNode | eachNode class = OPErdAttribute ].
	self assert: importedEntity name equals: 'Customer & Partner > VIP'.
	self assert: importedAttribute name equals: ''.
	self assert: importedSpecial transitions first name equals: '0..* & 1'
]

{ #category : 'tests' }
OPErdGraphMLTest >> testExportAndImportIntoTargetModelWithoutPositionsSucceeds [

	| sourceModel exportedXml targetModel returnedModel importedViaImport |
	sourceModel := OPErdExamples exampleUniversityERD.
	exportedXml := graphML export: sourceModel.

	OPErdGraphML classPool at: #xPositions put: (Dictionary with: UUID new -> '999').
	OPErdGraphML classPool at: #yPositions put: (Dictionary with: UUID new -> '888').

	targetModel := OPErd new name: 'Empty Target'.
	returnedModel := graphML import: exportedXml into: targetModel.

	self assert: returnedModel identicalTo: targetModel.
	self assert: targetModel uuid equals: sourceModel uuid.
	self assert: targetModel name equals: sourceModel name.
	self assert: targetModel states size equals: sourceModel states size.
	self assert: targetModel transitions size equals: sourceModel transitions size.
	self assertEmpty: (OPErdGraphML classPool at: #xPositions).
	self assertEmpty: (OPErdGraphML classPool at: #yPositions).

	OPErdGraphML classPool at: #xPositions put: (Dictionary with: UUID new -> '777').
	OPErdGraphML classPool at: #yPositions put: (Dictionary with: UUID new -> '666').

	importedViaImport := graphML import: exportedXml.
	self assert: importedViaImport uuid equals: sourceModel uuid.
	self assert: importedViaImport name equals: sourceModel name.
	self assert: importedViaImport states size equals: sourceModel states size.
	self assert: importedViaImport transitions size equals: sourceModel transitions size.
	self assertEmpty: (OPErdGraphML classPool at: #xPositions).
	self assertEmpty: (OPErdGraphML classPool at: #yPositions)
]

{ #category : 'tests' }
OPErdGraphMLTest >> testExportAndImportRoundtripAllTwelveNodeAndThreeEdgeTypes [

	| originalModel xmlString parsedDocument graphElement importedModel |
	originalModel := self buildComprehensiveModel.
	xmlString := graphML export: originalModel.
	parsedDocument := XMLDOMParser parse: xmlString.
	graphElement := (parsedDocument root / #graph) first.

	self assert: (graphElement / #node) size equals: 12.
	self assert: (graphElement / #edge) size equals: 3.

	importedModel := graphML import: xmlString.
	self deny: importedModel identicalTo: originalModel.
	self assert: importedModel class identicalTo: OPErd.
	self assert: importedModel uuid equals: originalModel uuid.
	self assert: importedModel name equals: 'Comprehensive ERD'.
	self assert: importedModel states size equals: 12.
	self assert: importedModel transitions size equals: 3.

	self assertImportedNodesIn: importedModel matchOriginal: originalModel.
	self assertImportedTransitionsIn: importedModel matchOriginal: originalModel
]

{ #category : 'tests' }
OPErdGraphMLTest >> testExportPackagePassesGraphMLExtensionsAndTitleToExportDialog [

	| modelWithSpecialName capturedBlock capturedFileName capturedExtensions capturedFilterName capturedTitle exportedXml |
	capturedBlock := nil.
	capturedFileName := nil.
	capturedExtensions := nil.
	capturedFilterName := nil.
	capturedTitle := nil.
	modelWithSpecialName := OPErd new name: 'My / Schema'.
	(OPExportFileDialog stub
		 exportBlock: Any
		 defaultFileName: Any
		 extensions: Any
		 named: Any
		 title: Any) will: [ :exportBlock :defaultFileName :extensions :filterName :dialogTitle |
			capturedBlock := exportBlock.
			capturedFileName := defaultFileName.
			capturedExtensions := extensions.
			capturedFilterName := filterName.
			capturedTitle := dialogTitle ].

	OPErdGraphML exportPackage: modelWithSpecialName.

	self assert: capturedFileName equals: (FileNameSanitizer sanitize: 'My / Schema') , '.graphml'.
	self assert: capturedExtensions equals: #( graphml xml ).
	self assert: capturedFilterName equals: 'GraphML files'.
	self assert: capturedTitle equals: 'Choose a GraphML file to export to'.
	exportedXml := capturedBlock value.
	self assert: (exportedXml includesSubstring: '<graphml') description: 'Export block must generate GraphML XML'.
	self assert: (exportedXml includesSubstring: 'My / Schema') description: 'Export block must include model name'
]

{ #category : 'tests' }
OPErdGraphMLTest >> testImportErrorBoundaryCases [

	| danglingEdgeXml missingNodeTypeXml missingEdgeTypeXml existingNodeUuid |
	self should: [ graphML import: '<graphml><broken' ] raise: XMLWellFormednessException.

	existingNodeUuid := UUID new.
	missingNodeTypeXml := String streamContents: [ :stream |
			                      stream nextPutAll: '<?xml version="1.0" encoding="UTF-8"?>'.
			                      stream nextPutAll: '<graphml xmlns="http://graphml.graphdrawing.org/xmlns">'.
			                      stream nextPutAll: '<graph id="'.
			                      stream nextPutAll: UUID new asString.
			                      stream nextPutAll: '" edgedefault="directed">'.
			                      stream nextPutAll: '<data key="name">MissingNodeType</data>'.
			                      stream nextPutAll: '<node id="'.
			                      stream nextPutAll: existingNodeUuid asString.
			                      stream nextPutAll: '"><data key="name">Broken</data></node>'.
			                      stream nextPutAll: '</graph></graphml>' ].
	self should: [ graphML import: missingNodeTypeXml into: OPErd new ] raise: KeyNotFound.

	missingEdgeTypeXml := String streamContents: [ :stream |
			                      stream nextPutAll: '<?xml version="1.0" encoding="UTF-8"?>'.
			                      stream nextPutAll: '<graphml xmlns="http://graphml.graphdrawing.org/xmlns">'.
			                      stream nextPutAll: '<graph id="'.
			                      stream nextPutAll: UUID new asString.
			                      stream nextPutAll: '" edgedefault="directed">'.
			                      stream nextPutAll: '<data key="name">MissingEdgeType</data>'.
			                      stream nextPutAll: '<node id="'.
			                      stream nextPutAll: existingNodeUuid asString.
			                      stream nextPutAll: '"><data key="name">Broken</data><data key="node-type">regularEntity</data></node>'.
			                      stream nextPutAll: '<edge id="'.
			                      stream nextPutAll: UUID new asString.
			                      stream nextPutAll: '" source="'.
			                      stream nextPutAll: existingNodeUuid asString.
			                      stream nextPutAll: '" target="'.
			                      stream nextPutAll: existingNodeUuid asString.
			                      stream nextPutAll: '"><data key="name">bad</data></edge>'.
			                      stream nextPutAll: '</graph></graphml>' ].
	self should: [ graphML import: missingEdgeTypeXml into: OPErd new ] raise: KeyNotFound.

	danglingEdgeXml := String streamContents: [ :stream |
			                   stream nextPutAll: '<?xml version="1.0" encoding="UTF-8"?>'.
			                   stream nextPutAll: '<graphml xmlns="http://graphml.graphdrawing.org/xmlns">'.
			                   stream nextPutAll: '<graph id="'.
			                   stream nextPutAll: UUID new asString.
			                   stream nextPutAll: '" edgedefault="directed">'.
			                   stream nextPutAll: '<data key="name">Broken</data>'.
			                   stream nextPutAll: '<edge id="'.
			                   stream nextPutAll: UUID new asString.
			                   stream nextPutAll: '" source="'.
			                   stream nextPutAll: UUID new asString.
			                   stream nextPutAll: '" target="'.
			                   stream nextPutAll: UUID new asString.
			                   stream nextPutAll: '">'.
			                   stream nextPutAll: '<data key="name">bad</data>'.
			                   stream nextPutAll: '<data key="edge-type">regular</data>'.
			                   stream nextPutAll: '</edge></graph></graphml>' ].
	self should: [ graphML import: danglingEdgeXml ] raise: KeyNotFound.
	self should: [ graphML import: danglingEdgeXml into: OPErd new ] raise: KeyNotFound
]

{ #category : 'tests' }
OPErdGraphMLTest >> testImportIntoTargetModelFromStringAndMemoryFilePopulatesPositions [

	| sourceModel personEntity idAttribute transition positionsByUuid xmlString targetModel returnedModel xMap yMap memoryFile fileTargetModel importedTransition |
	sourceModel := OPErd new name: 'Imported University'.
	personEntity := OPErdEntity new name: 'Person'.
	idAttribute := OPErdAttribute new
		               name: 'person_id';
		               beKey;
		               yourself.
	transition := (OPErdTransition from: personEntity to: idAttribute named: 'has')
		              beTotal;
		              yourself.
	sourceModel addAll: {
			personEntity.
			idAttribute.
			transition }.

	positionsByUuid := Dictionary new.
	positionsByUuid at: personEntity uuid put: 120 @ 240.
	positionsByUuid at: idAttribute uuid put: 360 @ 480.
	xmlString := self positionedGraphMlXmlForModel: sourceModel positionsByUuid: positionsByUuid.

	targetModel := OPErd new.
	returnedModel := graphML import: xmlString into: targetModel.

	self assert: returnedModel identicalTo: targetModel.
	self assert: targetModel uuid equals: sourceModel uuid.
	self assert: targetModel name equals: 'Imported University'.
	self assert: targetModel states size equals: 2.
	self assert: targetModel transitions size equals: 1.
	importedTransition := targetModel transitions first.
	self assert: importedTransition isTotal description: 'Total transition must be preserved by import:into:'.
	self assert: importedTransition source uuid equals: personEntity uuid.
	self assert: importedTransition target uuid equals: idAttribute uuid.

	xMap := OPErdGraphML classPool at: #xPositions.
	yMap := OPErdGraphML classPool at: #yPositions.
	self assert: (xMap at: personEntity uuid) equals: '120'.
	self assert: (yMap at: personEntity uuid) equals: '240'.
	self assert: (xMap at: idAttribute uuid) equals: '360'.
	self assert: (yMap at: idAttribute uuid) equals: '480'.

	memoryFile := FileSystem memory / 'positioned-erd.graphml'.
	memoryFile writeStreamDo: [ :stream | stream nextPutAll: xmlString ].
	fileTargetModel := OPErd new.
	graphML import: memoryFile into: fileTargetModel.
	self assert: fileTargetModel uuid equals: sourceModel uuid.
	self assert: fileTargetModel states size equals: 2.
	self assert: fileTargetModel transitions size equals: 1
]

{ #category : 'tests' }
OPErdGraphMLTest >> testImportToModelInEditorUsesGraphMLFilterAndAppliesDefaultLayoutWhenUnpositioned [

	| sourceModel memoryFile targetModel mockOpenDialog capturedTitle capturedExtensions capturedFilterName capturedOkAction openCalled mockEditor mockWorkbench mockProjectTree mockDiagramController mockLayouter refreshedAll showedAll appliedLayout capturedNotifications |
	sourceModel := OPErdExamples exampleUniversityERD.
	memoryFile := FileSystem memory root / 'import-dialog.graphml'.
	memoryFile writeStreamDo: [ :stream | stream nextPutAll: (graphML export: sourceModel) ].
	targetModel := OPErd new name: 'Initial Target'.

	capturedTitle := nil.
	capturedExtensions := nil.
	capturedFilterName := nil.
	capturedOkAction := nil.
	openCalled := false.
	capturedNotifications := OrderedCollection new.
	mockOpenDialog := Mock new.
	StOpenFilePresenter stub new willReturn: mockOpenDialog.
	(mockOpenDialog stub title: Any) will: [ :dialogTitle | capturedTitle := dialogTitle ].
	(mockOpenDialog stub extensions: Any named: Any) will: [ :extensions :filterName |
			capturedExtensions := extensions.
			capturedFilterName := filterName ].
	(mockOpenDialog stub okAction: Any) will: [ :actionBlock | capturedOkAction := actionBlock ].
	mockOpenDialog stub open will: [ openCalled := true ].

	refreshedAll := false.
	showedAll := false.
	appliedLayout := false.
	mockProjectTree := Mock new.
	mockProjectTree stub refresh will: [ refreshedAll := true ].
	mockWorkbench := Mock new.
	mockWorkbench stub projectTree willReturn: mockProjectTree.
	mockLayouter := Mock new.
	mockLayouter stub defaultLayout will: [ appliedLayout := true ].
	mockDiagramController := Mock new.
	mockDiagramController stub showAllElements will: [ showedAll := true ].
	mockDiagramController stub layouter willReturn: mockLayouter.
	mockEditor := Mock new.
	mockEditor stub workbench willReturn: mockWorkbench.
	mockEditor stub diagramController willReturn: mockDiagramController.

	OPErdGraphML importToModel: targetModel inEditor: mockEditor.

	self assert: openCalled description: 'importToModel:inEditor: must open the file dialog'.
	self assert: capturedTitle equals: 'Choose a GraphML file to import from'.
	self assert: capturedExtensions equals: #( graphml xml ).
	self assert: capturedFilterName equals: 'GraphML files'.

	[ capturedOkAction value: memoryFile ]
		on: InformativeNotification
		do: [ :notification |
				capturedNotifications add: notification messageText.
				notification resume ].

	self assertCollection: capturedNotifications hasSameElements: { ('Imported from ' , memoryFile fullName) }.
	self assert: targetModel uuid equals: sourceModel uuid.
	self assert: targetModel name equals: sourceModel name.
	self assert: targetModel states size equals: sourceModel states size.
	self assert: targetModel transitions size equals: sourceModel transitions size.
	self assert: refreshedAll description: 'updateModelAfterImport: must refresh the project tree'.
	self assert: showedAll description: 'updateModelAfterImport: must show all diagram elements'.
	self assert: appliedLayout description: 'updateModelAfterImport: must apply default layout when positions are absent'
]

{ #category : 'tests' }
OPErdGraphMLTest >> testNodeForTypeMapsAllTwelveVariantsAndRejectsUnknown [

	| expectedMappings |
	expectedMappings := {
		                    (#derived -> OPErdAttribute).
		                    (#multivalued -> OPErdAttribute).
		                    (#key -> OPErdAttribute).
		                    (#regularAttribute -> OPErdAttribute).
		                    (#weak -> OPErdEntity).
		                    (#regularEntity -> OPErdEntity).
		                    (#union -> OPErdExtensions).
		                    (#overlapping -> OPErdExtensions).
		                    (#disjoint -> OPErdExtensions).
		                    (#regularExtensions -> OPErdExtensions).
		                    (#identifying -> OPErdRelation).
		                    (#regularRelation -> OPErdRelation) }.

	expectedMappings do: [ :eachMapping |
			| createdNode |
			createdNode := graphML nodeForType: eachMapping key.
			self assert: createdNode class identicalTo: eachMapping value.
			self assert: createdNode graphmlType equals: eachMapping key ].

	self assert: (graphML nodeForType: 'derived') class identicalTo: OPErdAttribute.
	self assert: (graphML nodeForType: 'derived') isDerived description: 'String type name must resolve to derived attribute'.
	self assert: (graphML nodeForType: #unknownNodeType) identicalTo: graphML
]

{ #category : 'tests' }
OPErdGraphMLTest >> testTemplateContainsGraphMlSchemaAndPlaceholders [

	| templateString |
	templateString := graphML template.
	self
		assert: (templateString includesSubstring: 'http://graphml.graphdrawing.org/xmlns')
		description: 'Template must declare GraphML XML namespace'.
	self assert: (templateString includesSubstring: '<key id="name"') description: 'Template must declare name key'.
	self
		assert: (templateString includesSubstring: '<key id="generated"')
		description: 'Template must declare generated timestamp key'.
	self assert: (templateString includesSubstring: '<key id="node-type"') description: 'Template must declare node-type key'.
	self assert: (templateString includesSubstring: '<key id="edge-type"') description: 'Template must declare edge-type key'.
	self assert: (templateString includesSubstring: '{{model.uuid}}') description: 'Template must render model uuid'.
	self assert: (templateString includesSubstring: '{{graphmlType}}') description: 'Template must render element graphmlType'
]

{ #category : 'tests' }
OPErdGraphMLTest >> testUpdateModelAfterImportAppliesPositionsAndUpdatesBoundsWhenPresent [

	| sourceModel personEntity idAttribute transition positionsByUuid positionedXml targetModel project projectController diagramController mockProjectTree mockWorkbench mockEditor refreshedAll personShape attributeShape |
	sourceModel := OPErd new name: 'Positioned Import'.
	personEntity := OPErdEntity new name: 'Person'.
	idAttribute := OPErdAttribute new
		               name: 'person_id';
		               beKey;
		               yourself.
	transition := OPErdTransition from: personEntity to: idAttribute named: 'has'.
	sourceModel addAll: {
			personEntity.
			idAttribute.
			transition }.

	positionsByUuid := Dictionary new.
	positionsByUuid at: personEntity uuid put: 180 @ 260.
	positionsByUuid at: idAttribute uuid put: 340 @ 420.
	positionedXml := self positionedGraphMlXmlForModel: sourceModel positionsByUuid: positionsByUuid.

	targetModel := OPErd new.
	graphML import: positionedXml into: targetModel.

	project := OPProject new.
	project addModel: targetModel.
	projectController := OPProjectController forProject: project.
	diagramController := OPErdController new.
	projectController addDiagramController: diagramController.
	diagramController model: targetModel.
	diagramController diagramElement: (OPOpenPonkDiagram forModelElement: targetModel).
	diagramController canvasPresenter: (OPHeadlessCanvasPresenter new
			 canvas: RSCanvas new;
			 yourself).

	refreshedAll := false.
	mockProjectTree := Mock new.
	mockProjectTree stub refresh will: [ refreshedAll := true ].
	mockWorkbench := Mock new.
	mockWorkbench stub projectTree willReturn: mockProjectTree.
	mockEditor := Mock new.
	mockEditor stub workbench willReturn: mockWorkbench.
	mockEditor stub diagramController willReturn: diagramController.

	OPErdGraphML updateModelAfterImport: mockEditor.

	self assert: refreshedAll description: 'updateModelAfterImport: must refresh the project tree'.
	personShape := diagramController diagramElement ownedElements detect: [ :eachElement |
		               eachElement modelElement uuid = personEntity uuid ].
	attributeShape := diagramController diagramElement ownedElements detect: [ :eachElement |
		                  eachElement modelElement uuid = idAttribute uuid ].
	self assert: personShape roassalShape position equals: 180 @ 260.
	self assert: personShape bounds isNotNil description: 'updateNodePositionsof: must populate entity bounds via updateFromRender'.
	self assert: personShape bounds position equals: 180 @ 260.
	self assert: attributeShape roassalShape position equals: 340 @ 420.
	self
		assert: attributeShape bounds isNotNil
		description: 'updateNodePositionsof: must populate attribute bounds via updateFromRender'.
	self assert: attributeShape bounds position equals: 340 @ 420.

	OPErdGraphML classPool at: #xPositions put: (Dictionary with: personEntity uuid -> '10').
	OPErdGraphML classPool at: #yPositions put: nil.
	OPErdGraphML updateNodePositionsof: mockEditor.
	self assert: personShape bounds position equals: 180 @ 260.

	OPErdGraphML classPool at: #xPositions put: nil.
	OPErdGraphML updateNodePositionsof: mockEditor.
	self assert: personShape bounds position equals: 180 @ 260
]
