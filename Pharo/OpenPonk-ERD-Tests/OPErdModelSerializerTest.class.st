"
Verifies GraphML model roundtrip persistence, STON diagram serialization, and serializer format metadata for entity-relationship models.
"
Class {
	#name : 'OPErdModelSerializerTest',
	#superclass : 'OPModelSerializerTest',
	#category : 'OpenPonk-ERD-Tests-Serialization',
	#package : 'OpenPonk-ERD-Tests',
	#tag : 'Serialization'
}

{ #category : 'accessing' }
OPErdModelSerializerTest >> newModel [

	^ OPErdExamples exampleUniversityERD
]

{ #category : 'accessing' }
OPErdModelSerializerTest >> serializerClass [

	^ OPErdModelSerializer
]

{ #category : 'running' }
OPErdModelSerializerTest >> tearDown [

	model := nil.
	serializer := nil.
	stream := nil.
	super tearDown
]

{ #category : 'tests' }
OPErdModelSerializerTest >> testMetadataAndFormatIdentifiers [

	| matchingInfo mismatchedFormatInfo mismatchedVersionInfo |
	self assert: OPErdModelSerializer formatName equals: #'graphml-ston'.
	self assert: OPErdModelSerializer exportVersion equals: 1.
	self assert: OPErdModelSerializer minImportVersion equals: 1.
	self assert: OPErdModelSerializer exportSubject equals: #model.
	self assertCollection: OPErdModelSerializer fileExtensions hasSameElements: #( #'graphml-ston' ).

	matchingInfo := OPErdModelSerializer exportInfo.
	self
		assert: (OPErdModelSerializer supportsExportInfo: matchingInfo)
		description: 'Serializer must support its own export metadata'.

	mismatchedFormatInfo := OPExportInfo new
		                        subject: #model;
		                        format: #ston;
		                        version: 1;
		                        yourself.
	self
		deny: (OPErdModelSerializer supportsExportInfo: mismatchedFormatInfo)
		description: 'Serializer must reject a different format name'.

	mismatchedVersionInfo := OPExportInfo new
		                         subject: #model;
		                         format: #'graphml-ston';
		                         version: 2;
		                         yourself.
	self
		deny: (OPErdModelSerializer supportsExportInfo: mismatchedVersionInfo)
		description: 'Serializer must reject an unsupported version'.

	self assert: serializer formatName equals: 'ston'.
	self assert: serializer modelExtension equals: 'graphml'
]

{ #category : 'tests' }
OPErdModelSerializerTest >> testRoundtrip [

	| newModel isaExtension keyAttribute |
	serializer serializeModel: model to: stream.
	self assert: (stream contents includesSubstring: '<graphml') description: 'Serialized stream must contain GraphML XML'.

	newModel := serializer materializeModelFrom: stream.
	self deny: newModel identicalTo: model.
	self assert: newModel class identicalTo: OPErd.
	self assert: newModel uuid equals: model uuid.
	self assert: newModel name equals: model name.
	self
		assertCollection: (newModel states collect: [ :eachNode | eachNode uuid -> eachNode name ])
		hasSameElements: (model states collect: [ :eachNode | eachNode uuid -> eachNode name ]).
	self
		assertCollection: (newModel transitions collect: [ :eachTransition |
				 eachTransition uuid -> (eachTransition source uuid -> eachTransition target uuid) ])
		hasSameElements:
		(model transitions collect: [ :eachTransition |
			 eachTransition uuid -> (eachTransition source uuid -> eachTransition target uuid) ]).

	isaExtension := newModel states detect: [ :eachNode | eachNode name = 'ISA' ].
	self assert: isaExtension class identicalTo: OPErdExtensions.
	self assert: isaExtension isDisjoint description: 'Disjoint ISA extension must survive serializer roundtrip'.

	keyAttribute := newModel states detect: [ :eachNode | eachNode name = 'person_id' ].
	self assert: keyAttribute class identicalTo: OPErdAttribute.
	self assert: keyAttribute isKey description: 'Key attribute must survive serializer roundtrip'
]

{ #category : 'tests' }
OPErdModelSerializerTest >> testSerializeAndMaterializeDiagram [

	| personEntity diagram entityShape expectedBounds stonString restoredDiagram restoredShape |
	personEntity := model states detect: [ :eachNode | eachNode name = 'Person' ].
	diagram := OPOpenPonkDiagram forModelElement: model.
	diagram
		name: 'University Diagram';
		isOpen: true;
		isSelected: false.
	entityShape := OPErdEntityShape forModelElement: personEntity.
	entityShape owningElement: diagram.
	diagram ownedElements add: entityShape.
	expectedBounds := OPNodeBounds withPosition: 120 @ 80 extent: 100 @ 50.
	entityShape bounds: expectedBounds.

	stonString := serializer serializeDiagram: diagram.
	self assert: (stonString includesSubstring: 'OPOpenPonkDiagram') description: 'Serialized diagram must encode OPOpenPonkDiagram'.
	self assert: (stonString includesSubstring: 'OPErdEntityShape') description: 'Serialized diagram must encode owned entity shape'.

	restoredDiagram := serializer materializeDiagramFrom: stonString.
	self deny: restoredDiagram identicalTo: diagram.
	self assert: restoredDiagram class identicalTo: OPOpenPonkDiagram.
	self assert: restoredDiagram name equals: 'University Diagram'.
	self assert: restoredDiagram isOpen description: 'Serialized diagram must preserve isOpen'.
	self deny: restoredDiagram isSelected description: 'Serialized diagram must preserve isSelected'.

	restoredDiagram resolveAllModelElements: (model elements asArray copyWith: model).
	self assert: restoredDiagram modelElement identicalTo: model.
	self assert: restoredDiagram ownedElements size equals: 1.
	restoredShape := restoredDiagram ownedElements first.
	self assert: restoredShape class identicalTo: OPErdEntityShape.
	self assert: restoredShape modelElement identicalTo: personEntity.
	self assert: restoredShape bounds equals: expectedBounds
]

{ #category : 'tests' }
OPErdModelSerializerTest >> testSerializeAndMaterializeModelString [

	| sourceModel xmlString restoredModel keyNames regularNames |
	sourceModel := OPErdExamples exampleERDModel.
	xmlString := serializer serializeModel: sourceModel.
	restoredModel := serializer materializeModelFromString: xmlString.

	self deny: restoredModel identicalTo: sourceModel.
	self assert: restoredModel class identicalTo: OPErd.
	self assert: restoredModel uuid equals: sourceModel uuid.
	self assert: restoredModel name equals: 'Order Management ERD'.
	self assert: restoredModel states size equals: 11.
	self assert: restoredModel transitions size equals: 10.

	keyNames := (restoredModel states
		             select: [ :eachNode | eachNode isKindOf: OPErdAttribute ]
		             thenCollect: [ :eachAttribute | eachAttribute ])
		            select: [ :eachAttribute | eachAttribute isKey ]
		            thenCollect: [ :eachAttribute | eachAttribute name ].
	regularNames := (restoredModel states
		                 select: [ :eachNode | eachNode isKindOf: OPErdAttribute ]
		                 thenCollect: [ :eachAttribute | eachAttribute ])
		                reject: [ :eachAttribute | eachAttribute isKey ]
		                thenCollect: [ :eachAttribute | eachAttribute name ].
	self assertCollection: keyNames hasSameElements: #( 'customer_id' 'order_id' 'item_id' ).
	self assertCollection: regularNames hasSameElements: #( 'name' 'created_at' 'name' )
]
