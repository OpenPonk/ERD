"
An abstract base class for Commander 1 model commands executed within an ERD diagram editor.
"
Class {
	#name : 'OPErdCommand',
	#superclass : 'OPModelCommand',
	#category : 'OpenPonk-ERD-Commands',
	#package : 'OpenPonk-ERD',
	#tag : 'Commands'
}

{ #category : 'testing' }
OPErdCommand class >> canBeExecutedInEditor: anEditor [
	"Answers true if the active editor plugin is ERD."
	^ anEditor plugin isKindOf: OPErdPlugin
]

{ #category : 'testing' }
OPErdCommand class >> isAbstract [
	"Answers true if this class is the abstract root of ERD model commands."
	^ self = OPErdCommand
]
