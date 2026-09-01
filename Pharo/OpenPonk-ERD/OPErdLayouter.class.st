"
Applies automated layout algorithms to Entity-Relationship Diagrams, positioning nodes and routing edges for optimal visual structure.
"
Class {
	#name : 'OPErdLayouter',
	#superclass : 'OPNodesAndEdgesLayouter',
	#category : 'OpenPonk-ERD-Plugin',
	#package : 'OpenPonk-ERD',
	#tag : 'Plugin'
}

{ #category : 'accessing' }
OPErdLayouter >> allEdges [
	^ diagramController controllers
		select: [ :ctrl | ctrl isKindOf: OPMcTransitionController ]
		thenCollect: #roassalShape 
]

{ #category : 'accessing' }
OPErdLayouter >> allNodes [
	^ diagramController controllers
		select: [ :ctrl | ctrl isKindOf: OPErdNodeController ]
		thenCollect: #roassalShape
]

{ #category : 'layouts' }
OPErdLayouter >> defaultLayout [
	self gridLayout
]
