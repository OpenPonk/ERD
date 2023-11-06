Class {
	#name : #OPErdModelSerializer,
	#superclass : #OPModelSerializer,
	#category : #'OpenPonk-ERD-Serialization'
}

{ #category : #'as yet unclassified' }
OPErdModelSerializer class >> exportVersion [

	^ 1
]

{ #category : #'as yet unclassified' }
OPErdModelSerializer class >> formatName [

	^ #'graphml-ston'
]

{ #category : #'as yet unclassified' }
OPErdModelSerializer class >> minImportVersion [

	^ 1
]

{ #category : #formatting }
OPErdModelSerializer >> formatName [
	^ 'ston'
]

{ #category : #formatting }
OPErdModelSerializer >> materializeDiagramFrom: aString [
	^ STON fromString: aString
]

{ #category : #formatting }
OPErdModelSerializer >> materializeModelFrom: aStream [
	^ self materializeModelFromString: aStream contents
]

{ #category : #formatting }
OPErdModelSerializer >> materializeModelFromString: aString [
	^ OPErdGraphML new import: aString
]

{ #category : #formatting }
OPErdModelSerializer >> modelExtension [
	^ 'graphml'
]

{ #category : #formatting }
OPErdModelSerializer >> serializeDiagram: aDiagramMemento [
	^ STON toStringPretty: aDiagramMemento
]

{ #category : #formatting }
OPErdModelSerializer >> serializeModel: aModel [
	^ OPErdGraphML new export: aModel
]

{ #category : #formatting }
OPErdModelSerializer >> serializeModel: aModel to: aStream [
	^ aStream << (self serializeModel: aModel)
]
