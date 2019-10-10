!classDefinition: #TerniLapilliTest category: #TerniLapilli!
TestCase subclass: #TerniLapilliTest
	instanceVariableNames: ''
	classVariableNames: ''
	poolDictionaries: ''
	category: 'TerniLapilli'!

!TerniLapilliTest methodsFor: 'testing' stamp: 'Santiago Festini 10/10/2019 17:23:15'!
test01XGoesFirst
	| terniLapilli |
	
	terniLapilli := TerniLapilli new.
	
	self assert: (terniLapilli isPlayingX).
	self deny: (terniLapilli isPlayingO).! !

!TerniLapilliTest methodsFor: 'testing' stamp: 'Santiago Festini 10/10/2019 18:43:40'!
test02XMakesTheFirstMove
	| terniLapilli |
	
	terniLapilli := TerniLapilli new.
	
	terniLapilli putXAt: 1@1.

	self assert: (terniLapilli whatIsAt: 1@1) equals: #X.! !

!TerniLapilliTest methodsFor: 'testing' stamp: 'Santiago Festini 10/10/2019 18:26:52'!
test03AfterXMovesOPlays
	| terniLapilli |
	
	terniLapilli := TerniLapilli new.
	
	terniLapilli putXAt: 1@1.

	self assert: terniLapilli isPlayingO.
	self deny: terniLapilli isPlayingX.! !

!TerniLapilliTest methodsFor: 'testing' stamp: 'Santiago Festini 10/10/2019 18:26:38'!
test04AfterOMovesXPlays
	| terniLapilli |
	
	terniLapilli := TerniLapilli new.
	
	terniLapilli putXAt: 1@1.
	terniLapilli putOAt: 2@2.

	self deny: terniLapilli isPlayingO.
	self assert: terniLapilli isPlayingX.! !

!TerniLapilliTest methodsFor: 'testing' stamp: 'Santiago Festini 10/10/2019 19:12:21'!
test05PlayerCannotMoveWhenItsNotItsTurn
	| terniLapilli |
	
	terniLapilli := TerniLapilli new.

	self 
		should: [ terniLapilli putOAt: 1@1]
		raise: Error - MessageNotUnderstood
		withExceptionDo: [:error | self assert: error messageText = TerniLapilli errorItsNotYourTurn .
								     self deny: (terniLapilli whatIsAt: 1@1) = #O.]
	! !

!TerniLapilliTest methodsFor: 'testing' stamp: 'Santiago Festini 10/10/2019 18:50:27'!
test06
	| terniLapilli |
	
	terniLapilli := TerniLapilli new.
	
	terniLapilli putXAt: 1@1.
	terniLapilli putOAt: 2@2.

	self assert: (terniLapilli whatIsAt: 1@1) equals: #X.
	self assert: (terniLapilli whatIsAt: 2@2) equals: #O.
! !


!classDefinition: #TerniLapilli category: #TerniLapilli!
Object subclass: #TerniLapilli
	instanceVariableNames: 'currentPlayer board'
	classVariableNames: ''
	poolDictionaries: ''
	category: 'TerniLapilli'!

!TerniLapilli methodsFor: 'testing' stamp: 'Santiago Festini 10/10/2019 18:24:07'!
isPlayingO
	^currentPlayer = #O.! !

!TerniLapilli methodsFor: 'testing' stamp: 'Santiago Festini 10/10/2019 18:23:55'!
isPlayingX
	^currentPlayer = #X. ! !

!TerniLapilli methodsFor: 'testing' stamp: 'Santiago Festini 10/10/2019 18:22:50'!
whatIsAt: aPosition

	^#X! !


!TerniLapilli methodsFor: 'initialization' stamp: 'Santiago Festini 10/10/2019 18:54:44'!
initialize
	board := OrderedCollection with: (OrderedCollection with: #empty with: #empty with: #empty)
									with: (OrderedCollection with: #empty with: #empty with: #empty)
									with: (OrderedCollection with: #empty with: #empty with: #empty).
	currentPlayer := #X.! !


!TerniLapilli methodsFor: 'operations' stamp: 'Santiago Festini 10/10/2019 18:57:47'!
putOAt: aPoint
	currentPlayer = #X ifTrue:[self error: (self class) errorItsNotYourTurn ] .
	currentPlayer := #X.
	(board at: aPoint  x) at: aPoint y put: #Y.! !

!TerniLapilli methodsFor: 'operations' stamp: 'Santiago Festini 10/10/2019 18:57:29'!
putXAt: aPoint
	currentPlayer = #O ifTrue:[self error: (self class) errorItsNotYourTurn ] .
	currentPlayer := #O.
	(board at: aPoint  x) at: aPoint y put: #X.! !

"-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- "!

!classDefinition: 'TerniLapilli class' category: #TerniLapilli!
TerniLapilli class
	instanceVariableNames: ''!

!TerniLapilli class methodsFor: 'as yet unclassified' stamp: 'Santiago Festini 10/10/2019 18:36:21'!
errorItsNotYourTurn
	^'Its not your turn!!'! !
