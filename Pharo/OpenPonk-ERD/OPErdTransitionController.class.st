Class {
	#name : #OPErdTransitionController,
	#superclass : #OPDirectionalRelationshipController,
	#category : #'OpenPonk-ERD-Controllers'
}

{ #category : #forms }
OPErdTransitionController >> buildEditorForm: aForm [

	super buildEditorForm: aForm.
	(aForm addCheckbox: 'Total')
		state: self model isTotal;
		whenChangedDo: [ :newValue |
			self updateCheckboxOf: aForm named: 'Inheritance'. 
			self model isTotal: newValue.
			self model isInheritance: false.
			self diagramElement modelChanged.
			self diagramElement roassalShape update.
			self diagramElement total update].
	(aForm addCheckbox: 'Inheritance')
		state: self model isInheritance;
		whenChangedDo: [ :newValue |
			self updateCheckboxOf: aForm named: 'Total'. 
			self model isInheritance: newValue.
			self model isTotal: false.
			self diagramElement modelChanged ].
]

{ #category : #construction }
OPErdTransitionController >> diagramElementClass [

	^ OPErdTransitionShape
]

{ #category : #accessing }
OPErdTransitionController >> ensureSourceAndTargetIn: aDiagramController [

	source ifNil: [ 
		self source:
			(aDiagramController showWithoutDependentInDiagramModel:
				 model source) ].
	target ifNil: [ 
		self target:
			(aDiagramController showWithoutDependentInDiagramModel:
				 model target) ]
]

{ #category : #announcements }
OPErdTransitionController >> internalSubscribeTo: aModel [
	super internalSubscribeTo: aModel.
	aModel when: OPElementRemoved do: [ :e | self removeController ]
]

{ #category : #testing }
OPErdTransitionController >> isHideable [
	^ true
]

{ #category : #accessing }
OPErdTransitionController >> modelClass [
	^ OPErdTransition
]

{ #category : #private }
OPErdTransitionController >> removeModel [
	self model announcer unsubscribe: self.
	self diagramController model remove: self model
]

{ #category : #construction }
OPErdTransitionController >> showInDiagram: aDiagramController [

	self ensureSourceAndTargetIn: aDiagramController.
	^ super showInDiagram: aDiagramController
]

{ #category : #construction }
OPErdTransitionController >> showWithoutDependentInDiagram: aDiagramController [

	self ensureSourceAndTargetIn: aDiagramController.
	^ super showWithoutDependentInDiagram: aDiagramController
]

{ #category : #'as yet unclassified' }
OPErdTransitionController >> updateCheckboxOf: aForm named: aLabel [
	aForm focusOrder do: [ :comp |
		(comp className asString = 'SpCheckBoxPresenter')
			ifTrue: [ (comp label asString = aLabel asString)
							ifTrue: [ comp state: false ] ] ]
]
