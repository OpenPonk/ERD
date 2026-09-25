"
Controller for the top-level Entity-Relationship Diagram. 
Manages the lifecycle, layout applications, and palette initialization.
"
Class {
	#name : 'OPErdController',
	#superclass : 'OPDiagramController',
	#category : 'OpenPonk-ERD-Controllers',
	#package : 'OpenPonk-ERD',
	#tag : 'Controllers'
}

{ #category : 'accessing' }
OPErdController class >> viewModelClass [
	^ OPErdViewModel
]

{ #category : 'connecting' }
OPErdController >> canBeTargetFor: aController [
	^ (super canBeTargetFor: aController)
		or: [ aController isKindOf: OPErdNodeController ]
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

{ #category : 'ui interaction' }
OPErdController >> initializePalette: aPalette [
	aPalette
		newCreationTool: 'Regular Entity'
			factory: [ OPErdEntityController new ]
			icon: OPERDIcons opErdEntityIcon;
		newCreationTool: 'Weak Entity'
			factory: [ OPErdWeakEntityController new ]
			icon: OPERDIcons opErdWeakEntityIcon;
		newSeparator;
		newCreationTool: 'Regular Relation'
			factory: [ OPErdRelationController new ]
			icon: OPERDIcons opErdRelationIcon;
		newCreationTool: 'Identifying Relation'
			factory: [ OPErdIdentifyingRelationController new ]
			icon: OPERDIcons opErdIdentifyingRelationIcon;
		newSeparator;
		newCreationTool: 'Regular Attribute'
			factory: [ OPErdAttributeController new ]
			icon: OPERDIcons opErdAttributeIcon;
		newCreationTool: 'Derived Attribute'
			factory: [ OPErdDerivedAttributeController new ]
			icon: OPERDIcons opErdDerivedAttributeIcon;
		newCreationTool: 'Multivalued Attribute'
			factory: [ OPErdMultivaluedAttributeController new ]
			icon: OPERDIcons opErdMultivaluedAttributeIcon;
		newCreationTool: 'Key Attribute'
			factory: [ OPErdKeyAttributeController new ]
			icon: OPERDIcons opErdKeyAttributeIcon;
		newSeparator;
		newConnectionCreationTool: 'Regular Connection'
			factory: [ OPErdTransitionController new ]
			icon: OPERDIcons opErdConnectionIcon;
		newConnectionCreationTool: 'Total Connection'
			factory: [ OPErdTotalTransitionController new ]
			icon: OPERDIcons opErdTotalConnectionIcon;
		newConnectionCreationTool: 'Inheritance Connection'
			factory: [ OPErdInheritanceTransitionController new ]
			icon: OPERDIcons opErdInheritanceConnectionIcon;
		newSeparator;
		newCreationTool: 'Custom State'
			factory: [ OPErdExtensionsController new ]
			icon: OPERDIcons opErdCustomStateIcon;
		newCreationTool: 'Union'
			factory: [ OPErdUnionExtensionController new ]
			icon: OPERDIcons opErdUnionExtensionIcon;
		newCreationTool: 'Disjoint'
			factory: [ OPErdDisjointExtensionController new ]
			icon: OPERDIcons opErdDisjointExtensionIcon;
		newCreationTool: 'Overlapping'
			factory: [ OPErdOverlappingExtensionController new ]
			icon: OPERDIcons opErdOverlappingExtensionIcon
]
