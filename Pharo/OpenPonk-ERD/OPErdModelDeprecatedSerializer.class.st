"
Deprecated serializer for older versions of Entity-Relationship Diagram models.
Maintained for backward compatibility with legacy format identifiers and extensions.
"
Class {
	#name : 'OPErdModelDeprecatedSerializer',
	#superclass : 'OPErdModelSerializer',
	#category : 'OpenPonk-ERD-Serialization',
	#package : 'OpenPonk-ERD',
	#tag : 'Serialization'
}

{ #category : 'accessing' }
OPErdModelDeprecatedSerializer class >> fileExtensions [

	^ #( #'graphml-ston' #ston #graphml )
]

{ #category : 'formatting' }
OPErdModelDeprecatedSerializer class >> formatName [

	^ #'graphml-ston'
]
