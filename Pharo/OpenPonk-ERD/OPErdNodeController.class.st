Class {
	#name : #OPErdNodeController,
	#superclass : #OPElementController,
	#category : #'OpenPonk-ERD-Controllers'
}

{ #category : #connecting }
OPErdNodeController >> canBeSourceFor: aController [
	^ (aController respondsTo: #modelClass) and: 
	[ aController modelClass = OPErdTransition ]
]

{ #category : #connecting }
OPErdNodeController >> canBeTargetFor: aController [
	^ self canBeSourceFor: aController
]

{ #category : #connecting }
OPErdNodeController >> createAttributeAdornmentBy: builder [

	builder
		addIconShape: (RSEllipse new
				 color: Color transparent;
				 borderColor: Color black;
				 size: 14;
				 yourself)
		action: [ 
			| tool |
			(tool := OPCreationTool new)
				palette: self diagramController editor palette;
				factory: [ OPErdAttributeController new ];
				whenCreated: [ :ctrl | 
					| t2 |
					t2 := OPConnectionCreationTool new
						      palette: self diagramController editor palette;
						      factory: [ OPErdTransitionController new ].
					self diagramController editor palette selectTool: t2.
					t2
						selectedControllers: { self };
						selectedControllers: { ctrl }.
					self diagramController editor palette selectedTool 
						selectedControllers: { ctrl } ].
			self diagramController editor palette selectTool: tool ]
]

{ #category : #connecting }
OPErdNodeController >> createRelationAdornmentBy: builder [

	builder
		addIconShape: (RSPolygon new
				 color: Color transparent;
				 borderColor: Color black;
				 points: { 0@2. 3@0. 0@(-2). -3@0. };
				 size: 14;
				 yourself)
		action: [ 
			| tool |
			(tool := OPCreationTool new)
				palette: self diagramController editor palette;
				factory: [ OPErdRelationController new ];
				whenCreated: [ :ctrl | 
					| t2 |
					t2 := OPConnectionCreationTool new
						      palette: self diagramController editor palette;
						      factory: [ OPErdTransitionController new ].
					self diagramController editor palette selectTool: t2.
					t2
						selectedControllers: { self };
						selectedControllers: { ctrl }.
					self diagramController editor palette selectedTool 
						selectedControllers: { ctrl } ].
			self diagramController editor palette selectTool: tool ]
]

{ #category : #connecting }
OPErdNodeController >> createTransitionAdornmentBy: builder [

	builder
		addIconShape: (RSSVGPath new
				 color: Color black;
				 svgPath: 'M-6.3,7 L4,-3.3 L4,2 L7,-7 L-2,-4 L3.3,-4 L-7,6.3 z';
				 size: 14;
				 yourself)
		action: [ 
			| tool |
			(tool := OPConnectionCreationTool new)
				palette: self diagramController editor palette;
				factory: [ OPErdTransitionController new ].
			self diagramController editor palette selectTool: tool.
			tool selectedControllers: { self } ]
]

{ #category : #connecting }
OPErdNodeController >> dependentElements [
	^ (model incoming , model outgoing) asSet
]

{ #category : #connecting }
OPErdNodeController >> hookDiagramElement [

	super hookDiagramElement.
	
	self diagramElement adornmentCreationBlock: [ :builder | 
		self
			createAttributeAdornmentBy: builder;
			createRelationAdornmentBy: builder;
			createTransitionAdornmentBy: builder ]
]

{ #category : #connecting }
OPErdNodeController >> internalSubscribeTo: aModel [
	super internalSubscribeTo: aModel.
	aModel when: OPElementRemoved do: [ :e | self removeController ]
]

{ #category : #connecting }
OPErdNodeController >> isHideable [
	^ true
]

{ #category : #connecting }
OPErdNodeController >> modelAsParent [
	^ self model owner
]

{ #category : #connecting }
OPErdNodeController >> removeModel [
	self model announcer unsubscribe: self.
	self diagramController model remove: self model
]

{ #category : #'as yet unclassified' }
OPErdNodeController >> updateCheckboxOf: aForm named: aLabel [
	aForm focusOrder do: [ :comp |
		(comp class == SpCheckBoxPresenter)
			ifTrue: [ (comp label asString = aLabel asString)
							ifTrue: [ comp state: false ] ] ]
]
