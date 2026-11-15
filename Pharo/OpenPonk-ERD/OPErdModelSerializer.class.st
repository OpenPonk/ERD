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

{ #category : 'accessing' }
OPErdModelSerializer class >> fileExtensions [

	^ #( #xml )
]

{ #category : 'formatting' }
OPErdModelSerializer class >> formatName [

	^ #graphml
]

{ #category : 'accessing' }
OPErdModelSerializer class >> minImportVersion [

	^ 1
]

{ #category : 'serialize/materialize' }
OPErdModelSerializer >> materializeModelFrom: aStream [
	^ self materializeModelFromString: aStream contents
]

{ #category : 'serialize/materialize' }
OPErdModelSerializer >> materializeModelFromString: aString [
	^ OPErdGraphML new import: aString
]

{ #category : 'serialize/materialize' }
OPErdModelSerializer >> serializeModel: aModel [
	^ OPErdGraphML new export: aModel
]

{ #category : 'serialize/materialize' }
OPErdModelSerializer >> serializeModel: aModel to: aStream [
	^ aStream << (self serializeModel: aModel)
]
