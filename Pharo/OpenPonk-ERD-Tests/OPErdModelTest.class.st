"
Unit tests verifying domain predicates, state transitions, topological helpers, and matching semantics across entity-relationship diagram models.
"
Class {
	#name : 'OPErdModelTest',
	#superclass : 'TestCase',
	#instVars : [
		'erdModel',
		'entityModel',
		'attributeModel',
		'relationModel',
		'extensionModel',
		'transitionModel'
	],
	#category : 'OpenPonk-ERD-Tests-Models',
	#package : 'OpenPonk-ERD-Tests',
	#tag : 'Models'
}

{ #category : 'running' }
OPErdModelTest >> setUp [

	super setUp.
	erdModel := OPErd named: 'Test ERD'.
	entityModel := OPErdEntity named: 'Customer'.
	attributeModel := OPErdAttribute named: 'name'.
	relationModel := OPErdRelation named: 'places'.
	extensionModel := OPErdExtensions named: 'ISA'.
	transitionModel := OPErdTransition from: entityModel to: attributeModel named: 'has'.
	erdModel
		add: entityModel;
		add: attributeModel;
		add: relationModel;
		add: extensionModel;
		add: transitionModel
]

{ #category : 'running' }
OPErdModelTest >> tearDown [

	erdModel := nil.
	entityModel := nil.
	attributeModel := nil.
	relationModel := nil.
	extensionModel := nil.
	transitionModel := nil.
	super tearDown
]

{ #category : 'tests' }
OPErdModelTest >> testDiagramAndNodePredicatesAndArrowOperator [

	| baseNode arrowTransition twoArgTransition threeArgTransition |
	self deny: erdModel isState description: 'ERD root model must not report as a state'.
	self deny: erdModel isTransition description: 'ERD root model must not report as a transition'.

	baseNode := OPErdNode new.
	self assert: baseNode isState description: 'Base ERD node must report as a state'.
	self deny: baseNode isTransition description: 'Base ERD node must not report as a transition'.
	self deny: baseNode isDerived description: 'Base ERD node must not report as derived'.
	self deny: baseNode isNormal description: 'Abstract base ERD node must not report as normal'.

	arrowTransition := entityModel -> relationModel.
	self assert: arrowTransition class identicalTo: OPErdTransition.
	self assert: arrowTransition source identicalTo: entityModel.
	self assert: arrowTransition target identicalTo: relationModel.
	self assert: arrowTransition name equals: ''.

	twoArgTransition := OPErdTransition from: entityModel to: relationModel.
	self assert: twoArgTransition class identicalTo: OPErdTransition.
	self assert: twoArgTransition source identicalTo: entityModel.
	self assert: twoArgTransition target identicalTo: relationModel.
	self assert: twoArgTransition name equals: ''.

	threeArgTransition := OPErdTransition from: entityModel to: relationModel named: '1..N'.
	self assert: threeArgTransition source identicalTo: entityModel.
	self assert: threeArgTransition target identicalTo: relationModel.
	self assert: threeArgTransition name equals: '1..N'
]

{ #category : 'tests' }
OPErdModelTest >> testIsNormalFlagsAcrossAllModelElements [

	self assert: entityModel isNormal description: 'Fresh entity must report as normal'.
	entityModel beWeak.
	self deny: entityModel isNormal description: 'Weak entity must not report as normal'.
	entityModel beNormal.
	self assert: entityModel isNormal description: 'Entity restored via beNormal must report as normal'.

	self assert: relationModel isNormal description: 'Fresh relation must report as normal'.
	relationModel beIdentifying.
	self deny: relationModel isNormal description: 'Identifying relation must not report as normal'.
	relationModel beNormal.
	self assert: relationModel isNormal description: 'Relation restored via beNormal must report as normal'.

	self assert: attributeModel isNormal description: 'Fresh attribute must report as normal'.
	attributeModel beDerived.
	self deny: attributeModel isNormal description: 'Derived attribute must not report as normal'.
	attributeModel beNormal.
	attributeModel beMultivalued.
	self deny: attributeModel isNormal description: 'Multivalued attribute must not report as normal'.
	attributeModel beNormal.
	attributeModel beKey.
	self deny: attributeModel isNormal description: 'Key attribute must not report as normal'.
	attributeModel beNormal.
	self assert: attributeModel isNormal description: 'Attribute restored via beNormal must report as normal'.

	self assert: extensionModel isNormal description: 'Fresh extension must report as normal'.
	extensionModel beDisjoint.
	self deny: extensionModel isNormal description: 'Disjoint extension must not report as normal'.
	extensionModel beNormal.
	extensionModel beUnion.
	self deny: extensionModel isNormal description: 'Union extension must not report as normal'.
	extensionModel beNormal.
	extensionModel beOverlapping.
	self deny: extensionModel isNormal description: 'Overlapping extension must not report as normal'.
	extensionModel beNormal.
	self assert: extensionModel isNormal description: 'Extension restored via beNormal must report as normal'.

	self assert: transitionModel isNormal description: 'Fresh transition must report as normal'.
	transitionModel beTotal.
	self deny: transitionModel isNormal description: 'Total transition must not report as normal'.
	transitionModel beNormal.
	transitionModel beInheritance.
	self deny: transitionModel isNormal description: 'Inheritance transition must not report as normal'.
	transitionModel beNormal.
	self assert: transitionModel isNormal description: 'Transition restored via beNormal must report as normal'
]

{ #category : 'tests' }
OPErdModelTest >> testNodeRemovalAndRemovedFromTopology [

	| outgoingTransition incomingEntity incomingTransition targetEntity directRemovedTransition unownedNode |
	unownedNode := OPErdEntity named: 'Unowned'.
	self assertEmpty: unownedNode incoming.
	self assertEmpty: unownedNode outgoing.

	outgoingTransition := (entityModel -> relationModel)
		                      name: '1';
		                      yourself.
	erdModel add: outgoingTransition.

	self should: [ entityModel removedFrom: relationModel ] raise: AssertionFailure.

	erdModel remove: entityModel.
	self assert: entityModel owner identicalTo: nil.
	self assert: transitionModel owner identicalTo: nil.
	self assert: outgoingTransition owner identicalTo: nil.
	self assertEmpty: attributeModel incoming.
	self assertEmpty: relationModel incoming.

	incomingEntity := OPErdEntity named: 'Supplier'.
	incomingTransition := (incomingEntity -> relationModel)
		                      name: '1';
		                      yourself.
	targetEntity := OPErdEntity named: 'Order'.
	directRemovedTransition := (relationModel -> targetEntity)
		                           name: 'N';
		                           yourself.
	erdModel
		add: incomingEntity;
		add: incomingTransition;
		add: targetEntity;
		add: directRemovedTransition.
	relationModel removedFrom: erdModel.
	self assert: relationModel owner identicalTo: nil.
	self assert: incomingTransition owner identicalTo: nil.
	self assert: directRemovedTransition owner identicalTo: nil.
	self assert: directRemovedTransition source identicalTo: nil.
	self assert: directRemovedTransition target identicalTo: nil.
	self assertEmpty: incomingEntity outgoing.
	self assertEmpty: targetEntity incoming
]

{ #category : 'tests' }
OPErdModelTest >> testTransitionComparisonMatchingAndDetach [

	| identicalTransition differentTransition multiLabelTransition changedCount |
	self assert: transitionModel asTransition identicalTo: transitionModel.
	identicalTransition := transitionModel.
	differentTransition := OPErdTransition from: entityModel to: attributeModel named: 'has'.
	self assert: transitionModel equals: identicalTransition.
	self deny: transitionModel equals: differentTransition.
	self deny: transitionModel equals: entityModel.
	self assert: (transitionModel represents: identicalTransition) description: 'Transition must represent itself'.

	multiLabelTransition := OPErdTransition from: entityModel to: relationModel named: '0..1,1..N'.
	self assert: (multiLabelTransition matches: '0..1') description: 'Default matchBlock should match first comma-separated token'.
	self assert: (multiLabelTransition matches: #'1..N') description: 'Default matchBlock should match symbol converted via asString'.
	self deny: (multiLabelTransition matches: '0..N') description: 'Default matchBlock should reject unlisted token'.

	changedCount := 0.
	multiLabelTransition when: OPModelChanged do: [ changedCount := changedCount + 1 ] for: self.
	multiLabelTransition matchBlock: [ :value | value = 42 ].
	self
		assert: (multiLabelTransition matchBlock value: 42)
		description: 'Assigned matchBlock should be returned and evaluate custom predicate'.
	self assert: (multiLabelTransition matches: 42) description: 'Custom matchBlock should evaluate to true for matching input'.
	self deny: (multiLabelTransition matches: '0..1') description: 'Custom matchBlock should replace default name-based matcher'.
	self assert: changedCount equals: 1.

	transitionModel detach.
	self assert: transitionModel source identicalTo: nil.
	self assert: transitionModel target identicalTo: nil.
	self assert: transitionModel owner identicalTo: nil
]
