"
Handles serialization and materialization of ERD models and diagrams, converting between in-memory objects and persisted string formats.
"
Class {
	#name : 'OPErdModelSerializer',
	#superclass : 'OPModelSerializer',
	#category : 'OpenPonk-ERD-Serialization',
	#package : 'OpenPonk-ERD',
	#tag : 'Serialization'
}

{ #category : 'accessing' }
OPErdModelSerializer class >> exportVersion [

	^ 1
]

{ #category : 'formatting' }
OPErdModelSerializer class >> formatName [

	^ #'graphml-ston'
]

{ #category : 'accessing' }
OPErdModelSerializer class >> minImportVersion [

	^ 1
]

{ #category : 'formatting' }
OPErdModelSerializer >> formatName [
	^ 'ston'
]

{ #category : 'formatting' }
OPErdModelSerializer >> materializeDiagramFrom: aString [
	^ STON fromString: aString
]

{ #category : 'serialize/materialize' }
OPErdModelSerializer >> materializeModelFrom: aStream [
	^ self materializeModelFromString: aStream contents
]

{ #category : 'serialize/materialize' }
OPErdModelSerializer >> materializeModelFromString: aString [
	^ OPErdGraphML new import: aString
]

{ #category : 'formatting' }
OPErdModelSerializer >> modelExtension [
	^ 'graphml'
]

{ #category : 'formatting' }
OPErdModelSerializer >> serializeDiagram: aDiagramMemento [
	^ STON toStringPretty: aDiagramMemento
]

{ #category : 'serialize/materialize' }
OPErdModelSerializer >> serializeModel: aModel [
	^ OPErdGraphML new export: aModel
]

{ #category : 'serialize/materialize' }
OPErdModelSerializer >> serializeModel: aModel to: aStream [
	^ aStream << (self serializeModel: aModel)
]
