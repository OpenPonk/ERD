Class {
	#name : 'OPErdController',
	#superclass : 'OPDiagramController',
	#category : 'OpenPonk-ERD-Controllers',
	#package : 'OpenPonk-ERD',
	#tag : 'Controllers'
}

{ #category : 'connecting' }
OPErdController >> canBeTargetFor: aController [
	^ (super canBeTargetFor: aController)
		or: [ aController isKindOf: OPErdNodeController ]
]

{ #category : 'accessing' }
OPErdController >> commonModelClassPrefix [
	^ 'OPErd'
]

{ #category : 'accessing' }
OPErdController >> controllerFactory [

	^ super controllerFactory
		  register: OPErdAttributeController forModel: OPErdAttribute;
		  register: OPErdTransitionController forModel: OPErdTransition;
		  register: OPErdEntityController forModel: OPErdEntity;
		  register: OPErdRelationController forModel: OPErdRelation;
		  register: OPErdExtensionsController forModel: OPErdExtensions
]

{ #category : 'accessing' }
OPErdController >> elementsToShowInside [
	^ self model elements
]

{ #category : 'ui interaction' }
OPErdController >> initializePalette: aPalette [
	aPalette
		newCreationTool: 'Regular Entity'
			factory: [ OPErdEntityController new ] 
			icon: OPCoreIcons opErdEntityIcon;
		newCreationTool: 'Weak Entity'
			factory: [ OPErdWeakEntityController new ] 
			icon: OPCoreIcons opErdWeakEntityIcon;
		newSeparator;
		newCreationTool: 'Regular Relation' 
			factory: [ OPErdRelationController new ] 
			icon: OPCoreIcons opErdRelationIcon;
		newCreationTool: 'Identifying Relation' 
			factory: [ OPErdIdentifyingRelationController new ] 
			icon: OPCoreIcons opErdIdentifyingRelationIcon;
		newSeparator;
		newCreationTool: 'Regular Attribute' 
			factory: [ OPErdAttributeController new ] 
			icon: OPCoreIcons opErdAttributeIcon;
		newCreationTool: 'Derived Attribute' 
			factory: [ OPErdDerivedAttributeController new ] 
			icon: OPCoreIcons opErdDerivedAttributeIcon; 
		newCreationTool: 'Multivalued Attribute' 
			factory: [ OPErdMultivaluedAttributeController new ] 
			icon: OPCoreIcons opErdMultivaluedAttributeIcon; 
		newCreationTool: 'Key Attribute' 
			factory: [ OPErdKeyAttributeController new ] 
			icon: OPCoreIcons opErdKeyAttributeIcon; 
		newSeparator;
		newConnectionCreationTool: 'Regular Connection'
			factory: [ OPErdTransitionController new ]
			icon: OPCoreIcons opErdConnectionIcon;
		newConnectionCreationTool: 'Total Connection'
			factory: [ OPErdTotalTransitionController new ]
			icon: OPCoreIcons opErdTotalConnectionIcon;
		newConnectionCreationTool: 'Inheritance Connection'
			factory: [ OPErdInheritanceTransitionController new ]
			icon: OPCoreIcons opErdInheritanceConnectionIcon;
		newSeparator;
		newCreationTool: 'Custom State' 
			factory: [ OPErdExtensionsController new ] 
			icon: OPCoreIcons opFsmRegularStateIcon;
		newCreationTool: 'Union' 
			factory: [ OPErdUnionExtensionController new ] 
			icon: OPCoreIcons opErdUnionExtensionIcon;
		newCreationTool: 'Disjoint' 
			factory: [ OPErdDisjointExtensionController new ] 
			icon: OPCoreIcons opErdDisjointExtensionIcon;
		newCreationTool: 'Overlapping' 
			factory: [ OPErdOverlappingExtensionController new ] 
			icon: OPCoreIcons opErdOverlappingExtensionIcon
]

{ #category : 'accessing' }
OPErdController >> modelClass [
	^ OPErd
]
