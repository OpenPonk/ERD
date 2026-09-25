Class {
	#name : 'OPERDIcons',
	#superclass : 'Object',
	#category : 'OpenPonk-ERD-Icons',
	#package : 'OpenPonk-ERD',
	#tag : 'Icons'
}

{ #category : 'icons' }
OPERDIcons class >> opErdAttributeContents [
	"Private - Method generated with the content of the file File @ /home/peter/prog/dynacase/icons/dcFsmTransition.png"

	^ 'iVBORw0KGgoAAAANSUhEUgAAACAAAAAPCAYAAACFgM0XAAAAsElEQVQ4T2NkIANERET8B2lbsWIFWDeQD6aBfEZSjSNaA8hSkIXl5eUMnZ2dWPXB1IAcRKxjiHHAf1IMhIVAXV39/7NnzzBs3boVrx2EHAAKakJqCIU6XjPwGU4Ny2GOw2kWvrik1OcoIQNNHxhm4rKEmr7HGwqjDhi0aQAUb9RMB6TlAqTkSw1HkF0OwFMvOSVhamrq/9mzZ4PMoKgkhAcGMeU8MWrQi02yChtq1oYA7yFbELAAUOYAAAAASUVORK5CYII='
]

{ #category : 'icons' }
OPERDIcons class >> opErdAttributeIcon [

	^ Form fromBinaryStream: self opErdAttributeContents base64Decoded asByteArray readStream
]

{ #category : 'icons' }
OPERDIcons class >> opErdConnectionContents [
	"Private - Method generated with the content of the file File @ /home/peter/prog/dynacase/icons/dcFsmTransition.png"

	^ 'iVBORw0KGgoAAAANSUhEUgAAABAAAAAQCAYAAAAf8/9hAAAAkElEQVQ4T9WTYQ7AEAyFS+xY7uGI7uFYE10tIWXFMr/mD6H9vPeCgs2hNvthCXDOofceaAaaH/VTQGkuKiXISgEKFpueGQDPGOEwJtdkUKnlazkDJl1qQm5lpKC5pVOQXdXzaQYpJdRa9xaaWFYhluJeUYX8ABBCQGttliyq5ZvSo7m9EgQIsgR8+ldvQxzCL11EMRHXXN1rAAAAAElFTkSuQmCC'
]

{ #category : 'icons' }
OPERDIcons class >> opErdConnectionIcon [

	^ Form fromBinaryStream: self opErdConnectionContents base64Decoded asByteArray readStream
]

{ #category : 'icons' }
OPERDIcons class >> opErdCustomStateIcon [
	"Answers the icon for custom extension state."

	^ Form fromBinaryStream: self opErdCustomStateIconContents base64Decoded asByteArray readStream
]

{ #category : 'icons' }
OPERDIcons class >> opErdCustomStateIconContents [
	"Answers base64 encoded PNG data for custom extension state."

	^ 'iVBORw0KGgoAAAANSUhEUgAAABAAAAAQCAYAAAAf8/9hAAAABmJLR0QA/wD/AP+gvaeTAAAA
CXBIWXMAAAsTAAALEwEAmpwYAAAAB3RJTUUH3gwREQMGFh81tQAAABl0RVh0Q29tbWVudABD
cmVhdGVkIHdpdGggR0lNUFeBDhcAAACSSURBVDjLrdO9DcJADIbhR4QG6QbJEvQZAIpscHuk
YpX02SEFy6SlCY1pgBDy80purE/32WebTxJqdBgiusglM9QY0SOjjMiRG0PzlSYE+YdBDk0z
5VyZp3qvJP3hPFVJern3ltOjLnBDi/vCB464ijGVKyooMRxspMAZjxUtXHDa/Im7jHHzIu2y
yrsc06pzfgKTTTJXZ7zJ7gAAAABJRU5ErkJggg=='
]

{ #category : 'icons' }
OPERDIcons class >> opErdDerivedAttributeContents [
	"Private - Method generated with the content of the file File @ /home/peter/prog/dynacase/icons/dcFsmTransition.png"

	^ 'iVBORw0KGgoAAAANSUhEUgAAACAAAAAPCAYAAACFgM0XAAAAeElEQVQ4T2NkIA/8B2pjRNOKTYyg6eiGENQAVIDPIpIdQY4DiHEk0WoIOYBkH2GxGa8Z+BxADcth7sFpFlYHRERE/F+xYgWh0CE6mEEKcZlJVUtIchFU8agDBnUaGLhcgJSYqOEIsssBchI1yXrIyQWDoi6gWm0IAANOIBCnwFUxAAAAAElFTkSuQmCC'
]

{ #category : 'icons' }
OPERDIcons class >> opErdDerivedAttributeIcon [

	^ Form fromBinaryStream: self opErdDerivedAttributeContents base64Decoded asByteArray readStream
]

{ #category : 'icons' }
OPERDIcons class >> opErdDiagramIcon [

	^ Form fromBinaryStream: self opErdDiagramIconContents base64Decoded asByteArray readStream
]

{ #category : 'icons' }
OPERDIcons class >> opErdDiagramIconContents [
	"Private - Method generated with the content of the file File @ /home/peter/prog/dynacase/icons/dcFsmTransition.png"

	^ 'iVBORw0KGgoAAAANSUhEUgAAAA0AAAAPCAYAAAA/I0V3AAAAZElEQVQoU2NkAILDhw//t7W1BTHxAqA6BqA6Rkaoqv8REREMK1asgPExNAPl/wPlQeIITSAOEP/HYxVMHkMTIReCDEXVBPUbI4hG1w3yC9Qlo34aavEES4y4kgRSooZELqmpHAChnlsQd9dJfgAAAABJRU5ErkJggg=='
]

{ #category : 'icons' }
OPERDIcons class >> opErdDisjointExtensionContents [
	"Private - Method generated with the content of the file File @ /home/peter/prog/dynacase/icons/dcFsmTransition.png"

	^ 'iVBORw0KGgoAAAANSUhEUgAAABAAAAAQCAYAAAAf8/9hAAAA2ElEQVQ4T2NkQAOHDx/+b2trGwUUjgFiG6j0ESC9BCi3DCjHiKwFhQPVDJI/CcQLgHgGVHEGkE4AYnOgGgZkQ+AGIGnORNKI7kCQQdORDQEbgKTZE8jdga4Lje8B5G+HGcJIpM3/gZqQvQt3CUgwEojzgdgCj83oBoCUngDiiSADtgLxZjz+BinGZgDIFb4gAz4CMT+67Uheg0mhxBhU8CNOA0C2IoU2NheAzAAbgMsLhAyAewFrIBLhBUggEhmNOBMU5QkJZjSRLsGelLEYQnpmQjOE6OwMAF52f59jtcBbAAAAAElFTkSuQmCC'
]

{ #category : 'icons' }
OPERDIcons class >> opErdDisjointExtensionIcon [

	^ Form fromBinaryStream: self opErdDisjointExtensionContents base64Decoded asByteArray readStream
]

{ #category : 'icons' }
OPERDIcons class >> opErdEntityContents [
	"Private - Method generated with the content of the file File @ /home/peter/prog/dynacase/icons/dcFsmTransition.png"

	^ 'iVBORw0KGgoAAAANSUhEUgAAACAAAAAPCAYAAACFgM0XAAAAO0lEQVQ4T2NkwAT/sYhRW4gRZiCcgWQDyAHYxKnlCBTzRx0wGgKjITAaAqMhMBoCuEKAWhUPLnPg9gIAGQ0cENSO07kAAAAASUVORK5CYII='
]

{ #category : 'icons' }
OPERDIcons class >> opErdEntityIcon [

	^ Form fromBinaryStream: self opErdEntityContents base64Decoded asByteArray readStream
]

{ #category : 'icons' }
OPERDIcons class >> opErdIdentifyingRelationContents [
	"Private - Method generated with the content of the file File @ /home/peter/prog/dynacase/icons/dcFsmTransition.png"

	^ 'iVBORw0KGgoAAAANSUhEUgAAAB8AAAAPCAYAAAAceBSiAAAAmElEQVQ4T8VVQQ7AIAib8f9PNm4aTTZXKOBBjxPaUmCma+/UkZ4iMKGkh2glDYnwkjMSdv8xyEqOQOe3CfjGMolg5BrpmuuJ7YJ/5KWUmnMOVwPmoWFBJ7bVK1NOnUC2tyQkirVo1UFxJECqeqdi1FOE5xHhicUDJ1R0ZNVQH+GWjEDTflttl1p75PfqdUJ9b7zrE3m8xJwbwnkrEEJ0QxwAAAAASUVORK5CYII='
]

{ #category : 'icons' }
OPERDIcons class >> opErdIdentifyingRelationIcon [

	^ Form fromBinaryStream: self opErdIdentifyingRelationContents base64Decoded asByteArray readStream
]

{ #category : 'icons' }
OPERDIcons class >> opErdInheritanceConnectionContents [
	"Private - Method generated with the content of the file File @ /home/peter/prog/dynacase/icons/dcFsmTransition.png"

	^ 'iVBORw0KGgoAAAANSUhEUgAAABAAAAAQCAYAAAAf8/9hAAAAmElEQVQ4T6WT0Q3AIAhEMbFjuYcjuodj1YRKEwxalCb0x8bCuzuxAZxPcPaDCcg5YykF+gp9/dQfAdzMLjWI5QCViFPPCYB3a3DFSDUE4lr5rp+BsK41oYyyczCpLA4o1fj+5wxkhBW8H2OtFVNKpDYB+j70/SG8deAGkLSAvNNc1dne8TYrE5nqZQTt0shiNa41BfNfcwMeWE9CEfoVJdAAAAAASUVORK5CYII='
]

{ #category : 'icons' }
OPERDIcons class >> opErdInheritanceConnectionIcon [

	^ Form fromBinaryStream: self opErdInheritanceConnectionContents base64Decoded asByteArray readStream
]

{ #category : 'icons' }
OPERDIcons class >> opErdKeyAttributeContents [
	"Private - Method generated with the content of the file File @ /home/peter/prog/dynacase/icons/dcFsmTransition.png"

	^ 'iVBORw0KGgoAAAANSUhEUgAAACAAAAAPCAYAAACFgM0XAAAAwElEQVQ4T2NkIANERET8B2lbsWIFWDeQD6aBfEZSjSNaA8hSkIXl5eUMnZ2dWPXB1IAcRKxjiHHAf1IMhIVAXV39/7NnzzBs3boVrx2EHAAKakJqCIU6XjNwGi4vL///4cOHlFoOcxxOR+CLS2pZDkuooDSEYSYuS6gR9OhRg9XMUQcM2jQAij/kOAOXfGQAmAdJywVIFlEjMZJXDiA7gpySMDU19f/s2bNBxlBUEsLdQUw5T4wa9Ggkq7ChZm0IAJV6XxBD0g9oAAAAAElFTkSuQmCC'
]

{ #category : 'icons' }
OPERDIcons class >> opErdKeyAttributeIcon [

	^ Form fromBinaryStream: self opErdKeyAttributeContents base64Decoded asByteArray readStream
]

{ #category : 'icons' }
OPERDIcons class >> opErdMultivaluedAttributeContents [
	"Private - Method generated with the content of the file File @ /home/peter/prog/dynacase/icons/dcFsmTransition.png"

	^ 'iVBORw0KGgoAAAANSUhEUgAAACAAAAAPCAYAAACFgM0XAAAA4UlEQVQ4T81VwQ3DIAxMxJJZgEf+jZghSv88WIAlkYtRQDTBYFDVlk9EsM/nszHzNLCWZQF0s9YGb78PX7+fe+HYDhgUAyqlpn3fi37RBglxyXAIQAUwKOHXDSeSKZ3lKrUIYIBkk4EG2WOW1P8z0BvGtUQ1ArkjmSlR86s9SaJIYF1X0FqHMyEEOOdaSlG9lwKfKt1wKODk+Ng2eB7HEIFL0KIKLQLV+jGvXMQYIoDNhtfvuwpwpOvMnkzkP29Blt1P50DkMTQJpZRgjClOyZ5JmGw5c55j0zMJyT775Gv4AoAxkxDFp3QrAAAAAElFTkSuQmCC'
]

{ #category : 'icons' }
OPERDIcons class >> opErdMultivaluedAttributeIcon [

	^ Form fromBinaryStream: self opErdMultivaluedAttributeContents base64Decoded asByteArray readStream
]

{ #category : 'icons' }
OPERDIcons class >> opErdOverlappingExtensionContents [
	"Private - Method generated with the content of the file File @ /home/peter/prog/dynacase/icons/dcFsmTransition.png"

	^ 'iVBORw0KGgoAAAANSUhEUgAAABAAAAAQCAYAAAAf8/9hAAAA1klEQVQ4T2NkQAOHDx/+b2trGwUUjgFiG6j0ESC9BCi3DCjHiKwFhQPVDJI/CcQLgHgGVHEGkE4AYnOgGgZkQ+AGIGnORNKI7kCQQdORDQEbgKTZE8jdga4Lje8B5G+HGcKIy2YkcZAFKM4GGgB3CcgFkUCcD8QWMJtgmiMiIsBCK1aswGbICaDURJABW4F4M8zfMM3ItmITg7rCF2TARyDmR/Lnf5DNQFtRYggo9h/kEiBAFv9IFQMo9gJlgUiNaKQsIaHHPZBPelLGYgjpmQnNEKKzMwCmtLifzTv4KwAAAABJRU5ErkJggg=='
]

{ #category : 'icons' }
OPERDIcons class >> opErdOverlappingExtensionIcon [

	^ Form fromBinaryStream: self opErdOverlappingExtensionContents base64Decoded asByteArray readStream
]

{ #category : 'icons' }
OPERDIcons class >> opErdRelationContents [
	"Private - Method generated with the content of the file File @ /home/peter/prog/dynacase/icons/dcFsmTransition.png"

	^ 'iVBORw0KGgoAAAANSUhEUgAAAB8AAAAPCAYAAAAceBSiAAAAf0lEQVQ4T82USw6AIAxE5f6HVkh0QVOZTzWBbdN50x/tqL3zTm+OjJXUQRFqmVDhCILiU4NYuCSadCadCoKr0AhZ5r/Bq1DKRIR/DV2ayCofBtA4nMsaOZP2Vm2nZiWUbS1c1QS1O+pskSiKW58M6oQEfcTUypEJYR3+OynKxAWsDhoQGgBB5QAAAABJRU5ErkJggg=='
]

{ #category : 'icons' }
OPERDIcons class >> opErdRelationIcon [

	^ Form fromBinaryStream: self opErdRelationContents base64Decoded asByteArray readStream
]

{ #category : 'icons' }
OPERDIcons class >> opErdTotalConnectionContents [
	"Private - Method generated with the content of the file File @ /home/peter/prog/dynacase/icons/dcFsmTransition.png"

	^ 'iVBORw0KGgoAAAANSUhEUgAAABAAAAAQCAYAAAAf8/9hAAAAlklEQVQ4T7WT2w3AIAhF0dix3MMR3cOxaqTSRIMVH01Tf/gQDvdCUPDxqY/1sAQ459B7DzlCjl3+FFCKi0oJslKAgsWmZgbAM0Y4jCEG5RGMx5stAph0qRC5lZGC0o2aSJ3r/3QGKSXUWj8tNGNZDXGkoEL+BYQQ0Fq7bUHaeZHarY9/7J4D34w4g5kCyHYg23l3CzvSLjyaOBHbix1rAAAAAElFTkSuQmCC'
]

{ #category : 'icons' }
OPERDIcons class >> opErdTotalConnectionIcon [

	^ Form fromBinaryStream: self opErdTotalConnectionContents base64Decoded asByteArray readStream
]

{ #category : 'icons' }
OPERDIcons class >> opErdUnionExtensionContents [
	"Private - Method generated with the content of the file File @ /home/peter/prog/dynacase/icons/dcFsmTransition.png"

	^ 'iVBORw0KGgoAAAANSUhEUgAAABAAAAAQCAYAAAAf8/9hAAAA4UlEQVQ4T6WTMQ4CIRBFlxN4HC2k18IDaCws3cqzWGlpYbyAMdpjocfZE6x/Nix+RogYSX7IwPy3zMCaSg3nXGutXWB5CY399h3zEXsn7Bm2RIE3y/4TOkB7n7zGvIKGyKkYEgBkrsmoDyigHUM6AJmnCG/apeIJ4msPMZkvt0iKykPMa+EkkjSHNtCIvvQNIKkPaCuAC3RWdZcA5BQzATTQQNVZAhBLkwVwp6lPui8d4KOE3iAQGbh3uano/rEcSkg1ka82ZX43sfABZR/U/w+pRxeeJP2UE5DffyYFKf6dXxo8i5/mcinpAAAAAElFTkSuQmCC'
]

{ #category : 'icons' }
OPERDIcons class >> opErdUnionExtensionIcon [

	^ Form fromBinaryStream: self opErdUnionExtensionContents base64Decoded asByteArray readStream
]

{ #category : 'icons' }
OPERDIcons class >> opErdWeakEntityContents [
	"Private - Method generated with the content of the file File @ /home/peter/prog/dynacase/icons/dcFsmTransition.png"

	^ 'iVBORw0KGgoAAAANSUhEUgAAACAAAAAPCAYAAACFgM0XAAAAUklEQVQ4T2NkwAT/sYhRW4gRZiCcgWQDyAHYxKnlCBTz8TmAFiEBso8kB1AzJGAWjzpgNARGQ2A0BEgKAWoVv8hFP9EOoLblMPOIcgCtLMeoBAG8gjAQEIzL/wAAAABJRU5ErkJggg=='
]

{ #category : 'icons' }
OPERDIcons class >> opErdWeakEntityIcon [

	^ Form fromBinaryStream: self opErdWeakEntityContents base64Decoded asByteArray readStream
]
