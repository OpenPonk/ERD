"
I am the controller for ERD transitions (edges).
I handle the creation, display, and visibility toggling of transitions between ERD nodes, including managing dependent elements in the diagram.
"
Class {
	#name : 'OPErdTransitionController',
	#superclass : 'OPDirectionalRelationshipController',
	#category : 'OpenPonk-ERD-Controllers',
	#package : 'OpenPonk-ERD',
	#tag : 'Controllers'
}

{ #category : 'construction' }
OPErdTransitionController class >> diagramElementClass [

	^ OPErdTransitionShape
]

{ #category : 'accessing' }
OPErdTransitionController class >> viewModelClass [
	^ OPErdTransitionViewModel
]

{ #category : 'accessing' }
OPErdTransitionController >> ensureSourceAndTargetIn: aDiagramController [

	source ifNil: [
		self source:
			(aDiagramController showWithoutDependentInDiagramModel:
				 self model source) ].
	target ifNil: [
		self target:
			(aDiagramController showWithoutDependentInDiagramModel:
				 self model target) ]
]

{ #category : 'testing' }
OPErdTransitionController >> isHideable [
	^ true
]

{ #category : 'construction' }
OPErdTransitionController >> showInDiagram: aDiagramController [

	self ensureSourceAndTargetIn: aDiagramController.
	^ super showInDiagram: aDiagramController
]

{ #category : 'construction' }
OPErdTransitionController >> showWithoutDependentInDiagram: aDiagramController [

	self ensureSourceAndTargetIn: aDiagramController.
	^ super showWithoutDependentInDiagram: aDiagramController
]

{ #category : 'deprecation' }
OPErdTransitionController >> updateCheckboxOf: aForm named: aLabel [
	self deprecated: 'Use viewModel instead'.
	^ self viewModel updateCheckboxOf: aForm named: aLabel
]
