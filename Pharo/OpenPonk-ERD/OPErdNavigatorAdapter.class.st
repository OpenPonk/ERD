Class {
	#name : #OPErdNavigatorAdapter,
	#superclass : #OPNavigatorAdapter,
	#category : #'OpenPonk-ERD-Adapters'
}

{ #category : #accessing }
OPErdNavigatorAdapter class >> priority [

	^ 10
]

{ #category : #'widget API' }
OPErdNavigatorAdapter >> childrenMapping [
	^ {(OPErd -> #states). 
	(OPErdNode
		-> [ :o | 
			o outgoing
				, (o incoming collect: [ :each | OPErdIncomingTransition of: each ]) ]).
	(OPErdIncomingTransition -> #()).
	(OPErdTransition -> #()) }
]

{ #category : #'widget API' }
OPErdNavigatorAdapter >> displayMapping [
	^ {(OPErd -> 'Diagram').
	(OPErdAttribute -> 
		[ :o | 
		o isDerived
			ifTrue: [ 'Attribute Derived'  ]
			ifFalse: [ o isMultivalued
				ifTrue: [ 'Attribute MultiValued' ]
				ifFalse: [ o isKey
					ifTrue: [ 'Attribute Key' ]
					ifFalse: [ 'Attribute' ] ] ] ]).
	(OPErdTransition -> 
		[ :o |
		o isInheritance
			ifTrue: [ 'Connection Inheritance' ]
			ifFalse: [ o isTotal 
				ifTrue: [ 'Connection Total' ]
				ifFalse: [ 'Connection' ] ] ]).
	(OPErdIncomingTransition -> 
		[ :o |
		o isInheritance
			ifTrue: [ 'Inc. Connection Inheritance' ]
			ifFalse: [ o isTotal 
				ifTrue: [ 'Inc. Connection Total' ]
				ifFalse: [ 'Inc. Connection' ] ] ]).
	(OPErdEntity -> 
		[ :o |
		o isWeak
			ifTrue: [ 'Entity Weak' ]
			ifFalse: [ 'Entity' ] ]).
	(OPErdRelation -> 
		[ :o |
		o isIdentifying  
			ifTrue: [ 'Relation Identifying' ]
			ifFalse: [ 'Relation' ] ]).
	(OPErdExtensions -> 
		[ :o |
		o isDisjoint 
			ifTrue: [ 'Disjoint' ]
			ifFalse: [ o isOverlapping
				ifTrue: [ 'Overlapping' ]
				ifFalse: [ o isUnion
					ifTrue: [ 'Union' ]
					ifFalse: [ 'Extension State' ] ] ] ])}
]

{ #category : #'widget API' }
OPErdNavigatorAdapter >> hasMappingFor: anObject in: aModel [

	^ { 
		  OPErd.
		  OPErdTransition.
		  OPErdIncomingTransition.
		  OPErdNode } anySatisfy: [ :any | anObject isKindOf: any ]
]

{ #category : #'widget API' }
OPErdNavigatorAdapter >> iconMapping [ 
	^ {(OPErd -> OPCoreIcons opErdDiagramIcon).
	(OPErdIncomingTransition -> 
		[ :o |
		o isInheritance
			ifTrue: [ OPCoreIcons opErdInheritanceConnectionIcon ]
			ifFalse: [ o isTotal 
				ifTrue: [ OPCoreIcons opErdTotalConnectionIcon ]
				ifFalse: [ OPCoreIcons opErdConnectionIcon ] ] ]).
	(OPErdTransition -> 
		[ :o |
		o isInheritance
			ifTrue: [ OPCoreIcons opErdInheritanceConnectionIcon ]
			ifFalse: [ o isTotal 
				ifTrue: [ OPCoreIcons opErdTotalConnectionIcon ]
				ifFalse: [ OPCoreIcons opErdConnectionIcon ] ] ]).
	(OPErdEntity -> 
		[ :o |
		o isWeak
			ifTrue: [ OPCoreIcons opErdWeakEntityIcon ]
			ifFalse: [ OPCoreIcons opErdEntityIcon ] ]).
	(OPErdRelation -> 
		[ :o |
		o isIdentifying  
			ifTrue: [ OPCoreIcons opErdIdentifyingRelationIcon ]
			ifFalse: [ OPCoreIcons opErdRelationIcon ] ]).
	(OPErdAttribute -> 
		[ :o | 
		o isDerived
			ifTrue: [ OPCoreIcons opErdDerivedAttributeIcon  ]
			ifFalse: [ o isMultivalued
				ifTrue: [ OPCoreIcons opErdMultivaluedAttributeIcon ]
				ifFalse: [ o isKey
					ifTrue: [ OPCoreIcons opErdKeyAttributeIcon ]
					ifFalse: [ OPCoreIcons opErdAttributeIcon ] ] ] ]).
	(OPErdExtensions -> 
		[ :o |
		o isDisjoint 
			ifTrue: [ OPCoreIcons opErdDisjointExtensionIcon ]
			ifFalse: [ o isOverlapping
				ifTrue: [ OPCoreIcons opErdOverlappingExtensionIcon ]
				ifFalse: [ o isUnion
					ifTrue: [ OPCoreIcons opErdUnionExtensionIcon ]
					ifFalse: [ OPCoreIcons opFsmRegularStateIcon ] ] ] ])}
]

{ #category : #'widget API' }
OPErdNavigatorAdapter >> sort: modelObjects [
	^ modelObjects
		sorted:
			[ :a :b | a name isNotNil and: [ b name isNil or: [ a name < b name ] ] ]
]

{ #category : #'widget API' }
OPErdNavigatorAdapter >> typesByDependency [
	^ {OPErd.
	OPErdNode.
	OPErdTransition.
	OPErdIncomingTransition }
]
