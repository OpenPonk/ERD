"
Provides example models and diagram setups for Entity-Relationship Diagrams (ERD).
"
Class {
	#name : 'OPErdExamples',
	#superclass : 'Object',
	#category : 'OpenPonk-ERD-Examples',
	#package : 'OpenPonk-ERD',
	#tag : 'Examples'
}

{ #category : 'examples' }
OPErdExamples class >> exampleERDModel [
	| erdModel customerEntity orderEntity itemEntity customerIdAttr customerNameAttr orderIdAttr orderDateAttr itemIdAttr itemNameAttr placesRelation containsRelation |
	erdModel := OPErd new name: 'Order Management ERD'.

	customerEntity := OPErdEntity new name: 'Customer'.
	orderEntity := OPErdEntity new name: 'Order'.
	itemEntity := OPErdEntity new name: 'Item'.

	customerIdAttr := OPErdAttribute new name: 'customer_id'; beKey.
	customerNameAttr := OPErdAttribute new name: 'name'.
	orderIdAttr := OPErdAttribute new name: 'order_id'; beKey.
	orderDateAttr := OPErdAttribute new name: 'created_at'.
	itemIdAttr := OPErdAttribute new name: 'item_id'; beKey.
	itemNameAttr := OPErdAttribute new name: 'name'.

	placesRelation := OPErdRelation new name: 'places'.
	containsRelation := OPErdRelation new name: 'contains'.

	erdModel addAll: {
		customerEntity . orderEntity . itemEntity .
		customerIdAttr . customerNameAttr .
		orderIdAttr . orderDateAttr .
		itemIdAttr . itemNameAttr .
		placesRelation . containsRelation .
		(OPErdTransition new source: customerEntity; target: customerIdAttr) .
		(OPErdTransition new source: customerEntity; target: customerNameAttr) .
		(OPErdTransition new source: orderEntity; target: orderIdAttr) .
		(OPErdTransition new source: orderEntity; target: orderDateAttr) .
		(OPErdTransition new source: itemEntity; target: itemIdAttr) .
		(OPErdTransition new source: itemEntity; target: itemNameAttr) .
		(OPErdTransition new source: customerEntity; target: placesRelation) .
		(OPErdTransition new source: placesRelation; target: orderEntity) .
		(OPErdTransition new source: orderEntity; target: containsRelation) .
		(OPErdTransition new source: containsRelation; target: itemEntity)
	}.

	^ erdModel
]

{ #category : 'examples' }
OPErdExamples class >> exampleERDsample [
	| project |
	project := OPProject new name: 'Entity Relationship Diagram'.
	project addModel: self exampleERDModel.
	^ (OPWorkbench openProject: project) showAllElementsInAllDiagrams
]

{ #category : 'world menu' }
OPErdExamples class >> exampleEmpty [
	| project erd |
	project := OPProject new name: 'Entity Relationship Diagram'.
	erd := OPErd new name: 'New ER Diagram'.
	project addModel: erd.
	(OPWorkbench openProject: project) showAllElementsInAllDiagrams
]

{ #category : 'examples' }
OPErdExamples class >> exampleUniversityERD [
	| erdModel personEntity studentEntity teacherEntity personIdAttribute personNameAttribute studentGpaAttribute teacherSalaryAttribute isaExtension |
	erdModel := OPErd new name: 'University Specialization ERD'.

	personEntity := OPErdEntity new name: 'Person'.
	studentEntity := OPErdEntity new name: 'Student'.
	teacherEntity := OPErdEntity new name: 'Teacher'.

	personIdAttribute := OPErdAttribute new name: 'person_id'; beKey.
	personNameAttribute := OPErdAttribute new name: 'name'.
	studentGpaAttribute := OPErdAttribute new name: 'gpa'.
	teacherSalaryAttribute := OPErdAttribute new name: 'salary'.

	isaExtension := OPErdExtensions new name: 'ISA'; beDisjoint.

	erdModel addAll: {
		personEntity . studentEntity . teacherEntity .
		personIdAttribute . personNameAttribute . studentGpaAttribute . teacherSalaryAttribute .
		isaExtension .
		(OPErdTransition new source: personEntity; target: personIdAttribute) .
		(OPErdTransition new source: personEntity; target: personNameAttribute) .
		(OPErdTransition new source: studentEntity; target: studentGpaAttribute) .
		(OPErdTransition new source: teacherEntity; target: teacherSalaryAttribute) .
		(OPErdTransition new source: personEntity; target: isaExtension) .
		(OPErdTransition new source: isaExtension; target: studentEntity) .
		(OPErdTransition new source: isaExtension; target: teacherEntity)
	}.

	^ erdModel
]
