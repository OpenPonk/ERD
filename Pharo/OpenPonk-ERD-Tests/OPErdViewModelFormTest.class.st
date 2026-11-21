"
Tests dynamic property form generation, field bindings, and validation for ERD view models.
"
Class {
	#name : 'OPErdViewModelFormTest',
	#superclass : 'TestCase',
	#instVars : [
		'undoManager',
		'form'
	],
	#category : 'OpenPonk-ERD-Tests-ViewModels',
	#package : 'OpenPonk-ERD-Tests',
	#tag : 'ViewModels'
}

{ #category : 'running' }
OPErdViewModelFormTest >> setUp [
	"Prepare isolated test fixture with dedicated undo manager and dynamic form."
	super setUp.
	undoManager := OPUndoManager new.
	form := OPPropertiesForm new.
	form undoManager: undoManager
]

{ #category : 'running' }
OPErdViewModelFormTest >> tearDown [
	"Clean up isolated test fixture."
	form := nil.
	undoManager := nil.
	super tearDown
]

{ #category : 'tests' }
OPErdViewModelFormTest >> testAttributeViewModelFormBindingsAndUndo [

	| model viewModel keyBinding derivedBinding multivaluedBinding attributeFromEntity erd |
	erd := OPErd new.
	model := OPErdAttribute new
		         name: 'attr';
		         isKey: false;
		         isDerived: false;
		         isMultivalued: false.
	attributeFromEntity := OPErdEntity new name: 'Entity1'.
	erd
		add: attributeFromEntity;
		add: model;
		add: (OPErdTransition from: attributeFromEntity to: model).
	viewModel := OPErdAttributeViewModel new model: model.
	form viewModel: viewModel.

	self assertCollection: (form bindings collect: #selector) includesAll: #( #name #isKey #isDerived #isMultivalued ).

	keyBinding := form bindings detect: [ :each | each selector = #isKey ].
	derivedBinding := form bindings detect: [ :each | each selector = #isDerived ].
	multivaluedBinding := form bindings detect: [ :each | each selector = #isMultivalued ].
	self assert: derivedBinding presenter isEnabled description: 'Derived checkbox must be enabled when incoming source is an entity'.

	keyBinding writeModelValue: true.
	self assert: model isKey description: 'Key binding must enable isKey'.
	self deny: model isDerived description: 'Enabling isKey must keep isDerived false'.
	self deny: model isMultivalued description: 'Enabling isKey must keep isMultivalued false'.

	derivedBinding writeModelValue: true.
	self assert: model isDerived description: 'Derived binding must enable isDerived'.
	self deny: model isKey description: 'Enabling isDerived must reset isKey to false'.
	self deny: model isMultivalued description: 'Enabling isDerived must keep isMultivalued false'.

	multivaluedBinding writeModelValue: true.
	self assert: model isMultivalued description: 'Multivalued binding must enable isMultivalued'.
	self deny: model isDerived description: 'Enabling isMultivalued must reset isDerived to false'.
	self deny: model isKey description: 'Enabling isMultivalued must keep isKey false'.

	multivaluedBinding writeModelValue: false.
	self deny: model isMultivalued description: 'Setting isMultivalued to false must clear the flag'.

	undoManager undo.
	self assert: model isMultivalued description: 'Undoing false assignment must restore isMultivalued'.

	undoManager undo.
	self assert: model isDerived description: 'Undoing multivalued must restore isDerived'.
	self deny: model isMultivalued description: 'Undoing multivalued must clear isMultivalued'.

	undoManager undo.
	self assert: model isKey description: 'Undoing derived must restore isKey'.
	self deny: model isDerived description: 'Undoing derived must clear isDerived'.

	undoManager redo.
	self assert: model isDerived description: 'Redoing derived must re-enable isDerived'.
	self deny: model isKey description: 'Redoing derived must clear isKey'
]

{ #category : 'tests' }
OPErdViewModelFormTest >> testAttributeViewModelValidationAndValidSources [

	| erdModel entityModel relationModel otherAttributeModel derivedAttributeModel keyAttributeModel normalAttributeModel extensionModel normalViewModel keyViewModel derivedViewModel derivedBinding |
	erdModel := OPErd new.
	entityModel := OPErdEntity named: 'Customer'.
	relationModel := OPErdRelation named: 'places'.
	extensionModel := OPErdExtensions named: 'ISA'.
	normalAttributeModel := OPErdAttribute named: 'street'.
	otherAttributeModel := OPErdAttribute named: 'city'.
	derivedAttributeModel := (OPErdAttribute named: 'age')
		                         beDerived;
		                         yourself.
	keyAttributeModel := (OPErdAttribute named: 'id')
		                     beKey;
		                     yourself.
	erdModel addAll: {
			entityModel.
			relationModel.
			extensionModel.
			normalAttributeModel.
			otherAttributeModel.
			derivedAttributeModel.
			keyAttributeModel }.

	normalViewModel := OPErdAttributeViewModel new model: normalAttributeModel.
	keyViewModel := OPErdAttributeViewModel new model: keyAttributeModel.
	derivedViewModel := OPErdAttributeViewModel new model: derivedAttributeModel.

	self assertCollection: normalViewModel validDerivedSources hasSameElements: {
			OPErdEntity.
			OPErdRelation }.
	self assertCollection: normalViewModel validDerivedTargets hasSameElements: { OPErdEntity }.
	self assertCollection: normalViewModel validSources hasSameElements: {
			OPErdEntity.
			OPErdRelation }.
	self assertCollection: keyViewModel validSources hasSameElements: { OPErdEntity }.
	self assertCollection: derivedViewModel validSources hasSameElements: { OPErdEntity }.

	self assert: (normalViewModel sourceIsValid: entityModel) description: 'Normal attribute should accept entity as source'.
	self assert: (normalViewModel sourceIsValid: relationModel) description: 'Normal attribute should accept relation as source'.
	self
		assert: (normalViewModel sourceIsValid: otherAttributeModel)
		description: 'Normal attribute should accept another normal attribute as source'.
	self deny: (normalViewModel sourceIsValid: normalAttributeModel) description: 'Attribute must reject self as source'.
	self
		deny: (normalViewModel sourceIsValid: derivedAttributeModel)
		description: 'Normal attribute must reject derived attribute as source'.
	self deny: (normalViewModel sourceIsValid: keyAttributeModel) description: 'Normal attribute must reject key attribute as source'.
	self deny: (normalViewModel sourceIsValid: extensionModel) description: 'Attribute must reject extension as source'.

	self assert: (derivedViewModel sourceIsValid: entityModel) description: 'Derived attribute should accept entity as source'.
	self
		deny: (derivedViewModel sourceIsValid: relationModel)
		description: 'Derived attribute should reject relation as source per validSources'.
	self deny: (derivedViewModel sourceIsValid: otherAttributeModel) description: 'Derived attribute must reject attribute as source'.
	self assert: (keyViewModel sourceIsValid: entityModel) description: 'Key attribute should accept entity as source'.
	self deny: (keyViewModel sourceIsValid: relationModel) description: 'Key attribute must reject relation as source'.

	self assert: normalViewModel derivedValidation description: 'Attribute with no connections should allow becoming derived'.

	erdModel add: (OPErdTransition from: entityModel to: normalAttributeModel).
	erdModel add: (OPErdTransition from: relationModel to: normalAttributeModel).
	self
		assert: normalViewModel derivedValidation
		description: 'Attribute with incoming from entity and relation should allow becoming derived'.

	erdModel add: (OPErdTransition from: normalAttributeModel to: entityModel).
	self assert: normalViewModel derivedValidation description: 'Attribute with outgoing to entity should allow becoming derived'.

	erdModel add: (OPErdTransition from: normalAttributeModel to: relationModel).
	self deny: normalViewModel derivedValidation description: 'Attribute with outgoing to relation must disallow becoming derived'.

	form viewModel: normalViewModel.
	derivedBinding := form bindings detect: [ :each | each selector = #isDerived ].
	self deny: derivedBinding presenter isEnabled description: 'Derived checkbox must be disabled when derivedValidation fails'.

	erdModel remove: (normalAttributeModel outgoing detect: [ :each | each target == relationModel ]).
	erdModel add: (OPErdTransition from: otherAttributeModel to: normalAttributeModel).
	self
		deny: normalViewModel derivedValidation
		description: 'Attribute with incoming from another attribute must disallow becoming derived'
]

{ #category : 'tests' }
OPErdViewModelFormTest >> testEntityViewModelFormBindingsAndUndo [

	| model viewModel weakBinding |
	model := OPErdEntity new
		         name: 'Entity1';
		         isWeak: false.
	viewModel := OPErdEntityViewModel new model: model.
	form viewModel: viewModel.

	self assertCollection: (form bindings collect: #selector) includesAll: #( #name #isWeak ).

	weakBinding := form bindings detect: [ :each | each selector = #isWeak ].
	weakBinding writeModelValue: true.
	self assert: model isWeak description: 'Weak binding must enable isWeak'.

	undoManager undo.
	self deny: model isWeak description: 'Undoing weak must clear isWeak'.

	undoManager redo.
	self assert: model isWeak description: 'Redoing weak must restore isWeak'
]

{ #category : 'tests' }
OPErdViewModelFormTest >> testEntityViewModelValidationAndValidSources [

	| regularEntity weakEntity otherEntity relationModel attributeModel extensionModel regularViewModel weakViewModel |
	regularEntity := OPErdEntity named: 'Customer'.
	weakEntity := (OPErdEntity named: 'OrderItem')
		              beWeak;
		              yourself.
	otherEntity := OPErdEntity named: 'Order'.
	relationModel := OPErdRelation named: 'places'.
	attributeModel := OPErdAttribute named: 'name'.
	extensionModel := OPErdExtensions named: 'ISA'.

	regularViewModel := OPErdEntityViewModel new model: regularEntity.
	weakViewModel := OPErdEntityViewModel new model: weakEntity.

	self assertCollection: regularViewModel validSources hasSameElements: {
			OPErdRelation.
			OPErdAttribute.
			OPErdExtensions }.
	self assertCollection: weakViewModel validSources hasSameElements: {
			OPErdAttribute.
			OPErdExtensions }.

	self
		assert: (regularViewModel sourceIsValid: otherEntity)
		description: 'Regular entity should accept another entity as inheritance source'.
	self deny: (regularViewModel sourceIsValid: regularEntity) description: 'Regular entity must reject itself as source'.
	self deny: (regularViewModel sourceIsValid: relationModel) description: 'Regular entity sourceIsValid: must reject relation'.
	self deny: (regularViewModel sourceIsValid: attributeModel) description: 'Regular entity sourceIsValid: must reject attribute'.

	self
		assert: (weakViewModel sourceIsValid: attributeModel)
		description: 'Weak entity should accept attribute as regular transition source'.
	self
		assert: (weakViewModel sourceIsValid: extensionModel)
		description: 'Weak entity should accept extension as regular transition source'.
	self
		deny: (weakViewModel sourceIsValid: relationModel)
		description: 'Weak entity must reject relation as regular transition source'.
	self deny: (weakViewModel sourceIsValid: otherEntity) description: 'Weak entity sourceIsValid: must reject entity'
]

{ #category : 'tests' }
OPErdViewModelFormTest >> testExtensionsViewModelFormBindingsAndUndo [

	| model viewModel disjointBinding unionBinding overlappingBinding |
	model := OPErdExtensions new
		         name: 'Ext1';
		         isDisjoint: false;
		         isUnion: false;
		         isOverlapping: false.
	viewModel := OPErdExtensionsViewModel new model: model.
	form viewModel: viewModel.

	self assertCollection: (form bindings collect: #selector) includesAll: #( #name #isDisjoint #isUnion #isOverlapping ).

	disjointBinding := form bindings detect: [ :each | each selector = #isDisjoint ].
	unionBinding := form bindings detect: [ :each | each selector = #isUnion ].
	overlappingBinding := form bindings detect: [ :each | each selector = #isOverlapping ].

	disjointBinding writeModelValue: true.
	self assert: model isDisjoint description: 'Disjoint binding must enable isDisjoint'.
	self deny: model isUnion description: 'Enabling isDisjoint must keep isUnion false'.
	self deny: model isOverlapping description: 'Enabling isDisjoint must keep isOverlapping false'.

	unionBinding writeModelValue: true.
	self assert: model isUnion description: 'Union binding must enable isUnion'.
	self deny: model isDisjoint description: 'Enabling isUnion must reset isDisjoint to false'.
	self deny: model isOverlapping description: 'Enabling isUnion must keep isOverlapping false'.

	overlappingBinding writeModelValue: true.
	self assert: model isOverlapping description: 'Overlapping binding must enable isOverlapping'.
	self deny: model isUnion description: 'Enabling isOverlapping must reset isUnion to false'.

	overlappingBinding writeModelValue: false.
	self deny: model isOverlapping description: 'Setting isOverlapping to false must clear the flag'.

	undoManager undo.
	undoManager undo.
	self assert: model isUnion description: 'Undoing overlapping must restore isUnion'.
	self deny: model isOverlapping description: 'Undoing overlapping must clear isOverlapping'.

	undoManager undo.
	self assert: model isDisjoint description: 'Undoing union must restore isDisjoint'.
	self deny: model isUnion description: 'Undoing union must clear isUnion'.

	undoManager redo.
	self assert: model isUnion description: 'Redoing union must restore isUnion'.
	self deny: model isDisjoint description: 'Redoing union must clear isDisjoint'
]

{ #category : 'tests' }
OPErdViewModelFormTest >> testRelationViewModelFormBindingsAndUndo [

	| model viewModel identifyingBinding |
	model := OPErdRelation new
		         name: 'Relation1';
		         isIdentifying: false.
	viewModel := OPErdRelationViewModel new model: model.
	form viewModel: viewModel.

	self assertCollection: (form bindings collect: #selector) includesAll: #( #name #isIdentifying ).

	identifyingBinding := form bindings detect: [ :each | each selector = #isIdentifying ].
	identifyingBinding writeModelValue: true.
	self assert: model isIdentifying description: 'Identifying binding must enable isIdentifying'.

	undoManager undo.
	self deny: model isIdentifying description: 'Undoing identifying must clear isIdentifying'.

	undoManager redo.
	self assert: model isIdentifying description: 'Redoing identifying must restore isIdentifying'
]

{ #category : 'tests' }
OPErdViewModelFormTest >> testTransitionViewModelFormBindingsAndUndo [

	| model viewModel totalBinding inheritanceBinding |
	model := OPErdTransition new
		         isTotal: false;
		         isInheritance: false.
	viewModel := OPErdTransitionViewModel new model: model.
	form viewModel: viewModel.

	self assertCollection: (form bindings collect: #selector) includesAll: #( #isTotal #isInheritance ).

	totalBinding := form bindings detect: [ :each | each selector = #isTotal ].
	inheritanceBinding := form bindings detect: [ :each | each selector = #isInheritance ].

	totalBinding writeModelValue: true.
	self assert: model isTotal description: 'Total binding must enable isTotal'.
	self deny: model isInheritance description: 'Enabling isTotal must keep isInheritance false'.

	inheritanceBinding writeModelValue: true.
	self assert: model isInheritance description: 'Inheritance binding must enable isInheritance'.
	self deny: model isTotal description: 'Enabling isInheritance must reset isTotal to false'.

	inheritanceBinding writeModelValue: false.
	self deny: model isInheritance description: 'Setting isInheritance to false must clear the flag'.

	undoManager undo.
	undoManager undo.
	self assert: model isTotal description: 'Undoing inheritance must restore isTotal'.
	self deny: model isInheritance description: 'Undoing inheritance must clear isInheritance'.

	undoManager redo.
	self assert: model isInheritance description: 'Redoing inheritance must restore isInheritance'.
	self deny: model isTotal description: 'Redoing inheritance must clear isTotal'
]

{ #category : 'tests' }
OPErdViewModelFormTest >> testViewModelChildrenAndIcons [

	| project projectController erdModel entityModel relationModel attributeModel extensionModel transitionModel erdViewModel entityViewModel relationViewModel attributeViewModel extensionViewModel transitionViewModel |
	self assert: OPErdNodeViewModel isAbstract description: 'Abstract base node view model must report as abstract'.
	self deny: OPErdEntityViewModel isAbstract description: 'Concrete entity view model must not report as abstract'.
	self assert: OPErdNodeViewModel modelClass identicalTo: OPErdNode.

	erdModel := OPErd named: 'Diagram'.
	project := OPProject named: 'ErdViewModelTest'.
	project addModel: erdModel.
	projectController := OPProjectController forProject: project.
	erdViewModel := projectController viewModelRegistry viewModelFor: erdModel.
	self assertEmpty: erdViewModel childrenModels.

	entityModel := OPErdEntity named: 'Customer'.
	relationModel := OPErdRelation named: 'places'.
	attributeModel := OPErdAttribute named: 'name'.
	extensionModel := OPErdExtensions named: 'ISA'.
	transitionModel := OPErdTransition from: entityModel to: relationModel.
	erdModel addAll: {
			entityModel.
			relationModel.
			attributeModel.
			extensionModel.
			transitionModel }.

	self assertCollection: erdViewModel childrenModels hasSameElements: {
			entityModel.
			relationModel.
			attributeModel.
			extensionModel }.
	self assertCollection: erdViewModel allChildrenModels hasSameElements: {
			entityModel.
			relationModel.
			attributeModel.
			extensionModel.
			transitionModel }.

	entityViewModel := OPErdEntityViewModel new model: entityModel.
	self assert: entityViewModel icon bits equals: OPERDIcons opErdEntityIcon bits.
	entityModel beWeak.
	self assert: entityViewModel icon bits equals: OPERDIcons opErdWeakEntityIcon bits.

	relationViewModel := OPErdRelationViewModel new model: relationModel.
	self assert: relationViewModel icon bits equals: OPERDIcons opErdRelationIcon bits.
	relationModel beIdentifying.
	self assert: relationViewModel icon bits equals: OPERDIcons opErdIdentifyingRelationIcon bits.

	attributeViewModel := OPErdAttributeViewModel new model: attributeModel.
	self assert: attributeViewModel icon bits equals: OPERDIcons opErdAttributeIcon bits.
	attributeModel beMultivalued.
	self assert: attributeViewModel icon bits equals: OPERDIcons opErdMultivaluedAttributeIcon bits.
	attributeModel
		beNormal;
		beKey.
	self assert: attributeViewModel icon bits equals: OPERDIcons opErdKeyAttributeIcon bits.
	attributeModel
		beNormal;
		beDerived.
	self assert: attributeViewModel icon bits equals: OPERDIcons opErdDerivedAttributeIcon bits.

	extensionViewModel := OPErdExtensionsViewModel new model: extensionModel.
	self assert: extensionViewModel icon bits equals: OPERDIcons opErdCustomStateIcon bits.
	extensionModel beDisjoint.
	self assert: extensionViewModel icon bits equals: OPERDIcons opErdDisjointExtensionIcon bits.
	extensionModel
		beNormal;
		beOverlapping.
	self assert: extensionViewModel icon bits equals: OPERDIcons opErdOverlappingExtensionIcon bits.
	extensionModel
		beNormal;
		beUnion.
	self assert: extensionViewModel icon bits equals: OPERDIcons opErdUnionExtensionIcon bits.

	transitionViewModel := OPErdTransitionViewModel new model: transitionModel.
	self assert: transitionViewModel icon bits equals: OPERDIcons opErdConnectionIcon bits.
	transitionModel beTotal.
	self assert: transitionViewModel icon bits equals: OPERDIcons opErdTotalConnectionIcon bits.
	transitionModel
		beNormal;
		beInheritance.
	self assert: transitionViewModel icon bits equals: OPERDIcons opErdInheritanceConnectionIcon bits
]
