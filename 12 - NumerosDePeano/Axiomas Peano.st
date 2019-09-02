!classDefinition: #I category: #'Axiomas Peano'!
DenotativeObject subclass: #I
	instanceVariableNames: ''
	classVariableNames: ''
	poolDictionaries: ''
	category: 'Axiomas Peano'!

"-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- "!

!classDefinition: 'I class' category: #'Axiomas Peano'!
I class
	instanceVariableNames: ''!

!I class methodsFor: 'as yet unclassified' stamp: 'Santiago Festini 8/26/2019 20:51:32'!
* unNumeroDePeano
	
	^unNumeroDePeano! !

!I class methodsFor: 'as yet unclassified' stamp: 'Santiago Festini 8/26/2019 18:51:02'!
+ unNumeroDePeano

	^unNumeroDePeano next! !

!I class methodsFor: 'as yet unclassified' stamp: 'Santiago Festini 9/2/2019 16:00:37'!
- unNumeroDePeano

	^self error: self descripcionDeErrorDeNumerosNegativosNoSoportados .! !

!I class methodsFor: 'as yet unclassified' stamp: 'Santiago Festini 9/2/2019 16:00:47'!
/ unNumeroDePeano

	unNumeroDePeano = I ifTrue: [^I]
							  ifFalse: [^self error: self descripcionDeErrorDeNoSePuedeDividirPorUnNumeroMayor]! !

!I class methodsFor: 'as yet unclassified' stamp: 'Santiago Festini 9/2/2019 15:30:39'!
< unNumeroDePeano

	self = unNumeroDePeano ifTrue: [^false]
								ifFalse:[^true]! !

!I class methodsFor: 'as yet unclassified' stamp: 'Santiago Festini 9/2/2019 15:52:43'!
descripcionDeErrorDeNoSePuedeDividirPorUnNumeroMayor

	^'descripcionDeErrorDeNoSePuedeDividirPorUnNumeroMayor'! !

!I class methodsFor: 'as yet unclassified' stamp: 'Santiago Festini 9/2/2019 15:40:59'!
descripcionDeErrorDeNumerosNegativosNoSoportados

	^'descripcionDeErrorDeNumerosNegativosNoSoportados'! !

!I class methodsFor: 'as yet unclassified' stamp: 'Santiago Festini 8/26/2019 18:30:02'!
next 

	^II! !

!I class methodsFor: 'as yet unclassified' stamp: 'Santiago Festini 9/2/2019 15:11:34'!
restaInversa: unNumeroDePeano

	^unNumeroDePeano previous.! !


!classDefinition: #II category: #'Axiomas Peano'!
DenotativeObject subclass: #II
	instanceVariableNames: ''
	classVariableNames: ''
	poolDictionaries: ''
	category: 'Axiomas Peano'!

"-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- "!

!classDefinition: 'II class' category: #'Axiomas Peano'!
II class
	instanceVariableNames: 'next previous'!

!II class methodsFor: 'as yet unclassified' stamp: 'Santiago Festini 8/26/2019 20:51:13'!
* unNumeroDePeano

	^ self previous * unNumeroDePeano + unNumeroDePeano! !

!II class methodsFor: 'as yet unclassified' stamp: 'Santiago Festini 8/26/2019 19:09:04'!
+ unNumeroDePeano

	^self previous + unNumeroDePeano next

	! !

!II class methodsFor: 'as yet unclassified' stamp: 'Santiago Festini 9/2/2019 15:27:39'!
- unNumeroDePeano

	^unNumeroDePeano restaInversa: self.
	
							! !

!II class methodsFor: 'as yet unclassified' stamp: 'Santiago Festini 9/2/2019 16:04:04'!
/ unNumeroDePeano

(unNumeroDePeano  < self)  	
									ifTrue: [^(self - unNumeroDePeano  / unNumeroDePeano ) + I]
									ifFalse: [ unNumeroDePeano = self ifTrue: [^I]
																		  ifFalse: [^self error: self descripcionDeErrorDeNoSePuedeDividirPorUnNumeroMayor ]
																		]
		

	! !

!II class methodsFor: 'as yet unclassified' stamp: 'Santiago Festini 9/2/2019 15:31:46'!
< unNumeroDePeano

	unNumeroDePeano = I ifTrue:[^false]
							 ifFalse:[^self previous < unNumeroDePeano previous]! !

!II class methodsFor: 'as yet unclassified' stamp: 'Santiago Festini 9/2/2019 16:03:33'!
descripcionDeErrorDeNoSePuedeDividirPorUnNumeroMayor

	^'descripcionDeErrorDeNoSePuedeDividirPorUnNumeroMayor'! !

!II class methodsFor: 'as yet unclassified' stamp: 'Santiago Festini 9/2/2019 16:03:42'!
descripcionDeErrorDeNumerosNegativosNoSoportados

	^'descripcionDeErrorDeNumerosNegativosNoSoportados'! !

!II class methodsFor: 'as yet unclassified' stamp: 'Santiago Festini 9/2/2019 16:06:29'!
initializeCollaboratorsFromFile
	"Auto generated method for loading purposes - Do not modify it"

	next := III.
	previous := I.! !

!II class methodsFor: 'as yet unclassified' stamp: 'Santiago Festini 8/26/2019 19:03:45'!
next

	next ifNil: [next := self cloneNamed: self name, 'I'.
			     next previous: self.].
	
	^next! !

!II class methodsFor: 'as yet unclassified' stamp: 'Santiago Festini 8/26/2019 18:55:17'!
previous

	^previous! !

!II class methodsFor: 'as yet unclassified' stamp: 'Santiago Festini 8/26/2019 19:04:38'!
previous: unNumeroDePeano

	previous := unNumeroDePeano.! !

!II class methodsFor: 'as yet unclassified' stamp: 'Santiago Festini 8/26/2019 18:39:17'!
removeAllNext

	next ifNotNil:
	[
		next removeAllNext.
		next removeFromSystem.
		next := nil.

	]! !

!II class methodsFor: 'as yet unclassified' stamp: 'Santiago Festini 9/2/2019 16:01:38'!
restaInversa: unNumeroDePeano

	^unNumeroDePeano previous - self previous .! !


!classDefinition: #III category: #'Axiomas Peano'!
DenotativeObject subclass: #III
	instanceVariableNames: ''
	classVariableNames: ''
	poolDictionaries: ''
	category: 'Axiomas Peano'!

"-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- "!

!classDefinition: 'III class' category: #'Axiomas Peano'!
III class
	instanceVariableNames: 'next previous'!

!III class methodsFor: 'as yet unclassified' stamp: 'Santiago Festini 9/2/2019 16:04:19'!
* unNumeroDePeano

	^ self previous * unNumeroDePeano + unNumeroDePeano! !

!III class methodsFor: 'as yet unclassified' stamp: 'Santiago Festini 9/2/2019 16:04:19'!
+ unNumeroDePeano

	^self previous + unNumeroDePeano next

	! !

!III class methodsFor: 'as yet unclassified' stamp: 'Santiago Festini 9/2/2019 16:04:19'!
- unNumeroDePeano

	^unNumeroDePeano restaInversa: self.
	
							! !

!III class methodsFor: 'as yet unclassified' stamp: 'Santiago Festini 9/2/2019 16:04:19'!
/ unNumeroDePeano

(unNumeroDePeano  < self)  	
									ifTrue: [^(self - unNumeroDePeano  / unNumeroDePeano ) + I]
									ifFalse: [ unNumeroDePeano = self ifTrue: [^I]
																		  ifFalse: [^self error: self descripcionDeErrorDeNoSePuedeDividirPorUnNumeroMayor ]
																		]
		

	! !

!III class methodsFor: 'as yet unclassified' stamp: 'Santiago Festini 9/2/2019 16:04:19'!
< unNumeroDePeano

	unNumeroDePeano = I ifTrue:[^false]
							 ifFalse:[^self previous < unNumeroDePeano previous]! !

!III class methodsFor: 'as yet unclassified' stamp: 'Santiago Festini 9/2/2019 16:04:19'!
descripcionDeErrorDeNoSePuedeDividirPorUnNumeroMayor

	^'descripcionDeErrorDeNoSePuedeDividirPorUnNumeroMayor'! !

!III class methodsFor: 'as yet unclassified' stamp: 'Santiago Festini 9/2/2019 16:04:19'!
descripcionDeErrorDeNumerosNegativosNoSoportados

	^'descripcionDeErrorDeNumerosNegativosNoSoportados'! !

!III class methodsFor: 'as yet unclassified' stamp: 'Santiago Festini 9/2/2019 16:06:29'!
initializeCollaboratorsFromFile
	"Auto generated method for loading purposes - Do not modify it"

	next := IIII.
	previous := II.! !

!III class methodsFor: 'as yet unclassified' stamp: 'Santiago Festini 9/2/2019 16:04:19'!
next

	next ifNil: [next := self cloneNamed: self name, 'I'.
			     next previous: self.].
	
	^next! !

!III class methodsFor: 'as yet unclassified' stamp: 'Santiago Festini 9/2/2019 16:04:19'!
previous

	^previous! !

!III class methodsFor: 'as yet unclassified' stamp: 'Santiago Festini 9/2/2019 16:04:19'!
previous: unNumeroDePeano

	previous := unNumeroDePeano.! !

!III class methodsFor: 'as yet unclassified' stamp: 'Santiago Festini 9/2/2019 16:04:19'!
removeAllNext

	next ifNotNil:
	[
		next removeAllNext.
		next removeFromSystem.
		next := nil.

	]! !

!III class methodsFor: 'as yet unclassified' stamp: 'Santiago Festini 9/2/2019 16:04:19'!
restaInversa: unNumeroDePeano

	^unNumeroDePeano previous - self previous .! !


!classDefinition: #IIII category: #'Axiomas Peano'!
DenotativeObject subclass: #IIII
	instanceVariableNames: ''
	classVariableNames: ''
	poolDictionaries: ''
	category: 'Axiomas Peano'!

"-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- "!

!classDefinition: 'IIII class' category: #'Axiomas Peano'!
IIII class
	instanceVariableNames: 'next previous'!

!IIII class methodsFor: 'as yet unclassified' stamp: 'Santiago Festini 9/2/2019 16:04:19'!
* unNumeroDePeano

	^ self previous * unNumeroDePeano + unNumeroDePeano! !

!IIII class methodsFor: 'as yet unclassified' stamp: 'Santiago Festini 9/2/2019 16:04:19'!
+ unNumeroDePeano

	^self previous + unNumeroDePeano next

	! !

!IIII class methodsFor: 'as yet unclassified' stamp: 'Santiago Festini 9/2/2019 16:04:19'!
- unNumeroDePeano

	^unNumeroDePeano restaInversa: self.
	
							! !

!IIII class methodsFor: 'as yet unclassified' stamp: 'Santiago Festini 9/2/2019 16:04:19'!
/ unNumeroDePeano

(unNumeroDePeano  < self)  	
									ifTrue: [^(self - unNumeroDePeano  / unNumeroDePeano ) + I]
									ifFalse: [ unNumeroDePeano = self ifTrue: [^I]
																		  ifFalse: [^self error: self descripcionDeErrorDeNoSePuedeDividirPorUnNumeroMayor ]
																		]
		

	! !

!IIII class methodsFor: 'as yet unclassified' stamp: 'Santiago Festini 9/2/2019 16:04:19'!
< unNumeroDePeano

	unNumeroDePeano = I ifTrue:[^false]
							 ifFalse:[^self previous < unNumeroDePeano previous]! !

!IIII class methodsFor: 'as yet unclassified' stamp: 'Santiago Festini 9/2/2019 16:04:19'!
descripcionDeErrorDeNoSePuedeDividirPorUnNumeroMayor

	^'descripcionDeErrorDeNoSePuedeDividirPorUnNumeroMayor'! !

!IIII class methodsFor: 'as yet unclassified' stamp: 'Santiago Festini 9/2/2019 16:04:19'!
descripcionDeErrorDeNumerosNegativosNoSoportados

	^'descripcionDeErrorDeNumerosNegativosNoSoportados'! !

!IIII class methodsFor: 'as yet unclassified' stamp: 'Santiago Festini 9/2/2019 16:06:29'!
initializeCollaboratorsFromFile
	"Auto generated method for loading purposes - Do not modify it"

	next := nil.
	previous := III.! !

!IIII class methodsFor: 'as yet unclassified' stamp: 'Santiago Festini 9/2/2019 16:04:19'!
next

	next ifNil: [next := self cloneNamed: self name, 'I'.
			     next previous: self.].
	
	^next! !

!IIII class methodsFor: 'as yet unclassified' stamp: 'Santiago Festini 9/2/2019 16:04:19'!
previous

	^previous! !

!IIII class methodsFor: 'as yet unclassified' stamp: 'Santiago Festini 9/2/2019 16:04:19'!
previous: unNumeroDePeano

	previous := unNumeroDePeano.! !

!IIII class methodsFor: 'as yet unclassified' stamp: 'Santiago Festini 9/2/2019 16:04:19'!
removeAllNext

	next ifNotNil:
	[
		next removeAllNext.
		next removeFromSystem.
		next := nil.

	]! !

!IIII class methodsFor: 'as yet unclassified' stamp: 'Santiago Festini 9/2/2019 16:04:19'!
restaInversa: unNumeroDePeano

	^unNumeroDePeano previous - self previous .! !


!classDefinition: #Peano category: #'Axiomas Peano'!
DenotativeObject subclass: #Peano
	instanceVariableNames: ''
	classVariableNames: ''
	poolDictionaries: ''
	category: 'Axiomas Peano'!

"-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- "!

!classDefinition: 'Peano class' category: #'Axiomas Peano'!
Peano class
	instanceVariableNames: 'uno'!

!Peano class methodsFor: 'as yet unclassified' stamp: 'Santiago Festini 9/2/2019 16:06:29'!
initializeCollaboratorsFromFile
	"Auto generated method for loading purposes - Do not modify it"

	uno := nil.! !

!Peano class methodsFor: 'as yet unclassified' stamp: 'Santiago Festini 8/26/2019 18:22:25'!
next: anInteger
	! !

II initializeAfterFileIn!
III initializeAfterFileIn!
IIII initializeAfterFileIn!
Peano initializeAfterFileIn!