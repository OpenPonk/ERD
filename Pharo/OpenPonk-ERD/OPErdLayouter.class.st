Class {
	#name : #OPErdLayouter,
	#superclass : #OPLayouter,
	#category : #'OpenPonk-ERD-Plugin'
}

{ #category : #accessing }
OPErdLayouter >> allEdges [
	^ diagramController controllers
		select: [ :ctrl | ctrl isKindOf: OPMcTransitionController ]
		thenCollect: #roassalShape 
]

{ #category : #accessing }
OPErdLayouter >> allNodes [
	^ diagramController controllers
		select: [ :ctrl | ctrl isKindOf: OPErdNodeController ]
		thenCollect: #roassalShape
]

{ #category : #accessing }
OPErdLayouter >> defaultLayout [
	self gridLayout
]
