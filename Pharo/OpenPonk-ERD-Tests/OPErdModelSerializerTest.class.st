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

	| matchingInfo mismatchedFormatInfo mismatchedVersionInfo deprecatedInfo |
	self assert: OPErdModelSerializer formatName equals: #graphml.
	self assert: OPErdModelSerializer exportVersion equals: 1.
	self assert: OPErdModelSerializer minImportVersion equals: 1.
	self assert: OPErdModelSerializer exportSubject equals: #model.
	self assertCollection: OPErdModelSerializer fileExtensions hasSameElements: #( #xml ).

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
		                         format: #graphml;
		                         version: 2;
		                         yourself.
	self
		deny: (OPErdModelSerializer supportsExportInfo: mismatchedVersionInfo)
		description: 'Serializer must reject an unsupported version'.

	self assert: serializer formatName equals: #graphml.
	self assert: serializer fileExtension equals: #xml.
	self assert: OPErdModelDeprecatedSerializer formatName equals: #'graphml-ston'.
	self assertCollection: OPErdModelDeprecatedSerializer fileExtensions hasSameElements: #( #'graphml-ston' #ston #graphml ).
	deprecatedInfo := OPErdModelDeprecatedSerializer exportInfo.
	self assert: (OPErdModelSerializer forExportInfo: deprecatedInfo) class identicalTo: OPErdModelDeprecatedSerializer.
	self assert: (OPErdModelSerializer forExportInfo: matchingInfo) class identicalTo: OPErdModelSerializer
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
OPErdModelSerializerTest >> testSaveUsesGraphmlXmlAndLoadSupportsLegacyExtensions [

	| directorySerializer serializedModel xmlContent exportFolder exportInfo loadedModel legacyCases |
	directorySerializer := OPMementoDirectorySerializer forPlugin: OPErdPlugin new.
	serializedModel := OPErdExamples exampleUniversityERD.
	xmlContent := serializer serializeModel: serializedModel.

	exportFolder := FileSystem memory root / 'erd-new-export'.
	exportFolder ensureCreateDirectory.
	directorySerializer saveModelOf: (OPMemento model: serializedModel diagrams: #(  )) to: exportFolder.
	self assert: (exportFolder / 'model.xml') exists description: 'New ERD export must write model.xml without ston in filename'.
	self deny: (exportFolder / 'model.graphml-ston') exists description: 'New ERD export must not write legacy model.graphml-ston'.
	self deny: (exportFolder / 'model.ston') exists description: 'New ERD export must not write legacy model.ston'.
	exportInfo := exportFolder / OPExportInfo fileName readStreamDo: [ :readStream |
		              (NeoJSONReader on: readStream) nextAs: OPExportInfo ].
	self assert: exportInfo format equals: #graphml.
	self
		assert: (OPErdModelSerializer forExportInfoFile: exportFolder / OPExportInfo fileName) class
		identicalTo: OPErdModelSerializer.

	loadedModel := directorySerializer loadModelFrom: exportFolder.
	self assert: loadedModel uuid equals: serializedModel uuid.
	self assert: loadedModel name equals: serializedModel name.

	legacyCases := {
		               #( 'erd-legacy-graphml-ston' 'model.graphml-ston' ).
		               #( 'erd-legacy-ston' 'model.ston' ).
		               #( 'erd-legacy-graphml' 'model.graphml' ) }.
	legacyCases do: [ :eachCase |
			| legacyFolder legacyInfo restoredLegacyModel |
			legacyFolder := FileSystem memory root / eachCase first.
			legacyFolder ensureCreateDirectory.
			legacyInfo := OPExportInfo new
				              subject: #model;
				              format: #'graphml-ston';
				              version: 1;
				              yourself.
			legacyFolder / OPExportInfo fileName writeStreamDo: [ :writeStream | (OPJsonWriter on: writeStream) nextPut: legacyInfo ].
			legacyFolder / eachCase second writeStreamDo: [ :writeStream | writeStream nextPutAll: xmlContent ].
			self
				assert: (OPErdModelSerializer forExportInfoFile: legacyFolder / OPExportInfo fileName) class
				identicalTo: OPErdModelDeprecatedSerializer.
			restoredLegacyModel := directorySerializer loadModelFrom: legacyFolder.
			self assert: restoredLegacyModel uuid equals: serializedModel uuid.
			self assert: restoredLegacyModel name equals: serializedModel name.
			self assert: restoredLegacyModel states size equals: serializedModel states size.
			self assert: restoredLegacyModel transitions size equals: serializedModel transitions size ]
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
