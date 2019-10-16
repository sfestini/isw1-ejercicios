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

!TerniLapilliTest methodsFor: 'testing' stamp: 'Santiago Festini 10/16/2019 13:45:42'!
test02XMakesTheFirstPut
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

!TerniLapilliTest methodsFor: 'testing' stamp: 'Santiago Festini 10/16/2019 13:45:25'!
test05PlayerOCannotPutWhenItsNotItsTurn
	| terniLapilli |
	
	terniLapilli := TerniLapilli new.

	self 
		should: [ terniLapilli putOAt: 1@1]
		raise: Error - MessageNotUnderstood
		withExceptionDo: [:error | self assert: error messageText = TerniLapilli errorItsNotYourTurn .
								     self deny: (terniLapilli whatIsAt: 1@1) = #O.]
	! !

!TerniLapilliTest methodsFor: 'testing' stamp: 'Santiago Festini 10/16/2019 13:45:11'!
test06PlayerXCannotPutWhenItsNotItsTurn
	| terniLapilli |
	
	terniLapilli := TerniLapilli new.
	
	terniLapilli putXAt: 1@1.
	
	self 
		should: [ terniLapilli putXAt: 2@1]
		raise: Error - MessageNotUnderstood
		withExceptionDo: [:error | self assert: error messageText = TerniLapilli errorItsNotYourTurn .
								     self deny: (terniLapilli whatIsAt: 2@1) = #X.]
	! !

!TerniLapilliTest methodsFor: 'testing' stamp: 'Santiago Festini 10/16/2019 16:13:42'!
test07PlayerOCannotPutInOccupiedPosition
	| terniLapilli |
	
	terniLapilli := TerniLapilli new.
	
	terniLapilli putXAt: 1@1.
	
	self 
		should: [ terniLapilli putOAt: 1@1]
		raise: Error - MessageNotUnderstood
		withExceptionDo: [:error | self assert: error messageText = TerniLapilli errorCantPutInAnOccupiedPosition .
								     self assert: (terniLapilli whatIsAt: 1@1) = #X.]
	! !

!TerniLapilliTest methodsFor: 'testing' stamp: 'Santiago Festini 10/16/2019 16:13:42'!
test08PlayerXCannotPutInOccupiedPosition
	| terniLapilli |
	
	terniLapilli := TerniLapilli new.
	
	terniLapilli putXAt: 1@1.
	terniLapilli putOAt: 2@2.
	
	self 
		should: [ terniLapilli putXAt: 1@1]
		raise: Error - MessageNotUnderstood
		withExceptionDo: [:error | self assert: error messageText = TerniLapilli errorCantPutInAnOccupiedPosition .
								     self assert: (terniLapilli whatIsAt: 1@1) = #X.]
	! !

!TerniLapilliTest methodsFor: 'testing' stamp: 'Santiago Festini 10/16/2019 14:10:51'!
test09PlayerXCanOnlyHold3PositionsAtATime
	| terniLapilli |
	
	terniLapilli := TerniLapilli new.
	
	terniLapilli putXAt: 1@1.
	terniLapilli putOAt: 2@2.
	terniLapilli putXAt: 3@3.
	terniLapilli putOAt: 1@2.
	terniLapilli putXAt: 3@2.
	terniLapilli putOAt: 3@1.	
	
	self 
		should: [ terniLapilli putXAt: 1@3]
		raise: Error - MessageNotUnderstood
		withExceptionDo: [:error | self assert: error messageText = TerniLapilli errorOnly3PositionsPerPlayer .
								     self assert: (terniLapilli whatIsAt: 1@3) = #empty.]
	! !

!TerniLapilliTest methodsFor: 'testing' stamp: 'Santiago Festini 10/16/2019 14:25:24'!
test10PlayerOCanOnlyHold3PositionsAtATime
	| terniLapilli |
	
	terniLapilli := TerniLapilli new.
	
	terniLapilli putXAt: 1@1.
	terniLapilli putOAt: 2@2.
	terniLapilli putXAt: 3@3.
	terniLapilli putOAt: 1@2.
	terniLapilli putXAt: 3@2.
	terniLapilli putOAt: 3@1.	
	terniLapilli moveXFrom: 1@1 to: 2@1 .	
	
	self 
		should: [ terniLapilli putOAt: 1@3]
		raise: Error - MessageNotUnderstood
		withExceptionDo: [:error | self assert: error messageText = TerniLapilli errorOnly3PositionsPerPlayer .
								     self assert: (terniLapilli whatIsAt: 1@3) = #empty.]
	! !

!TerniLapilliTest methodsFor: 'testing' stamp: 'Santiago Festini 10/16/2019 15:23:02'!
test11WhenPlayerXMovesItNoLongerHoldsPreviousPositionAndIsNowInNewPosition
	| terniLapilli |
	
	terniLapilli := TerniLapilli new.
	
	terniLapilli putXAt: 1@1.
	terniLapilli putOAt: 2@2.
	terniLapilli putXAt: 3@3.
	terniLapilli putOAt: 1@2.
	terniLapilli putXAt: 3@2.
	terniLapilli putOAt: 3@1.	
	terniLapilli moveXFrom: 1@1 to: 2@1 .	
	
	self assert: (terniLapilli whatIsAt: 1@1) equals: #empty.
	self assert: (terniLapilli whatIsAt: 2@1) equals: #X.! !

!TerniLapilliTest methodsFor: 'testing' stamp: 'Santiago Festini 10/16/2019 15:28:56'!
test12WhenPlayerOMovesItNoLongerHoldsPreviousPositionAndIsNowInNewPosition
	| terniLapilli |
	
	terniLapilli := TerniLapilli new.
	
	terniLapilli putXAt: 1@1.
	terniLapilli putOAt: 2@2.
	terniLapilli putXAt: 3@3.
	terniLapilli putOAt: 1@2.
	terniLapilli putXAt: 3@2.
	terniLapilli putOAt: 3@1.	
	terniLapilli moveXFrom: 1@1 to: 2@1 .
	terniLapilli moveOFrom: 2@2 to: 2@3 .
	
	self assert: (terniLapilli whatIsAt: 2@2) equals: #empty.
	self assert: (terniLapilli whatIsAt: 2@3) equals: #O.! !

!TerniLapilliTest methodsFor: 'testing' stamp: 'Santiago Festini 10/16/2019 15:49:43'!
test13PlayerXCantMoveAPositionItDoesntHold
	| terniLapilli |
	
	terniLapilli := TerniLapilli new.
	
	terniLapilli putXAt: 1@1.
	terniLapilli putOAt: 2@2.
	terniLapilli putXAt: 3@3.
	terniLapilli putOAt: 1@2.
	terniLapilli putXAt: 3@2.
	terniLapilli putOAt: 3@1.	
	
	self 
		should: [ terniLapilli moveXFrom: 2@2 to: 2@1 ]
		raise: Error - MessageNotUnderstood
		withExceptionDo: [:error | self assert: error messageText = TerniLapilli errorCantMoveAPositionOfAnotherPlayer .
								     self assert: (terniLapilli whatIsAt: 2@1) = #empty.
								     self assert: (terniLapilli whatIsAt: 2@2) = #O.]
	! !

!TerniLapilliTest methodsFor: 'testing' stamp: 'Santiago Festini 10/16/2019 15:49:05'!
test14PlayerOCantMoveAPositionItDoesntHold
	| terniLapilli |
	
	terniLapilli := TerniLapilli new.
	
	terniLapilli putXAt: 1@1.
	terniLapilli putOAt: 2@2.
	terniLapilli putXAt: 3@3.
	terniLapilli putOAt: 1@2.
	terniLapilli putXAt: 3@2.
	terniLapilli putOAt: 3@1.	
	terniLapilli moveXFrom: 1@1 to: 2@1. 
	
	self 
		should: [ terniLapilli moveOFrom: 2@1 to: 1@1 ]
		raise: Error - MessageNotUnderstood
		withExceptionDo: [:error | self assert: error messageText = TerniLapilli errorCantMoveAPositionOfAnotherPlayer .
								     self assert: (terniLapilli whatIsAt: 1@1) = #empty.
								     self assert: (terniLapilli whatIsAt: 2@1) = #X.]
	! !

!TerniLapilliTest methodsFor: 'testing' stamp: 'Santiago Festini 10/16/2019 15:53:26'!
test15PlayerXCanOnlyMoveWhenItOccupies3Positions
	| terniLapilli |
	
	terniLapilli := TerniLapilli new.
	
	terniLapilli putXAt: 1@1.
	terniLapilli putOAt: 2@2.
	terniLapilli putXAt: 3@3.
	terniLapilli putOAt: 1@2.
	
	self 
		should: [ terniLapilli moveXFrom: 1@1 to: 2@1 ]
		raise: Error - MessageNotUnderstood
		withExceptionDo: [:error | self assert: error messageText = TerniLapilli errorCantMoveBeforeOwning3Positions .
								     self assert: (terniLapilli whatIsAt: 1@1) = #X.
								     self assert: (terniLapilli whatIsAt: 2@1) = #empty.]
	! !

!TerniLapilliTest methodsFor: 'testing' stamp: 'Santiago Festini 10/16/2019 15:56:48'!
test16PlayerOCanOnlyMoveWhenItOccupies3Positions
	| terniLapilli |
	
	terniLapilli := TerniLapilli new.
	
	terniLapilli putXAt: 1@1.
	terniLapilli putOAt: 2@2.
	terniLapilli putXAt: 3@3.
	terniLapilli putOAt: 1@2.
	terniLapilli putXAt: 3@2.
	
	self 
		should: [ terniLapilli moveOFrom: 2@2 to: 2@1 ]
		raise: Error - MessageNotUnderstood
		withExceptionDo: [:error | self assert: error messageText = TerniLapilli errorCantMoveBeforeOwning3Positions .
								     self assert: (terniLapilli whatIsAt: 2@2) = #O.
								     self assert: (terniLapilli whatIsAt: 2@1) = #empty.]
	! !

!TerniLapilliTest methodsFor: 'testing' stamp: 'Santiago Festini 10/16/2019 16:03:07'!
test17PlayerXCanOnlyPutXInRange
	| terniLapilli |
	
	terniLapilli := TerniLapilli new.
	
	self 
		should: [ terniLapilli putXAt: 5@5.]
		raise: Error - MessageNotUnderstood
		withExceptionDo: [:error | self assert: error messageText = TerniLapilli errorPositionNotInRange .]
	! !

!TerniLapilliTest methodsFor: 'testing' stamp: 'Santiago Festini 10/16/2019 16:09:40'!
test18PlayerOCanOnlyPutXInRange
	| terniLapilli |
	
	terniLapilli := TerniLapilli new.
	
	terniLapilli putXAt: 1@1.
	
	self 
		should: [ terniLapilli putOAt: 5@5.]
		raise: Error - MessageNotUnderstood
		withExceptionDo: [:error | self assert: error messageText = TerniLapilli errorPositionNotInRange .]
	! !

!TerniLapilliTest methodsFor: 'testing' stamp: 'Santiago Festini 10/16/2019 16:12:38'!
test19PlayerXCantMoveToAnOccupiedPosition
	| terniLapilli |
	
	terniLapilli := TerniLapilli new.
	
	terniLapilli putXAt: 1@1.
	terniLapilli putOAt: 2@2.
	terniLapilli putXAt: 3@3.
	terniLapilli putOAt: 1@2.
	terniLapilli putXAt: 3@2.
	terniLapilli putOAt: 3@1.	
	
	self 
		should: [ terniLapilli moveXFrom: 1@1 to: 2@2 ]
		raise: Error - MessageNotUnderstood
		withExceptionDo: [:error | self assert: error messageText = TerniLapilli errorCantMoveToAnOccupiedPosition .
								     self assert: (terniLapilli whatIsAt: 1@1) = #X.
								     self assert: (terniLapilli whatIsAt: 2@2) = #O.]
	! !

!TerniLapilliTest methodsFor: 'testing' stamp: 'Santiago Festini 10/16/2019 16:18:41'!
test20PlayerOCantMoveToAnOccupiedPosition
	| terniLapilli |
	
	terniLapilli := TerniLapilli new.
	
	terniLapilli putXAt: 1@1.
	terniLapilli putOAt: 2@2.
	terniLapilli putXAt: 3@3.
	terniLapilli putOAt: 1@2.
	terniLapilli putXAt: 3@2.
	terniLapilli putOAt: 3@1.	
	terniLapilli moveXFrom: 1@1 to: 2@1.
	
	self 
		should: [ terniLapilli moveOFrom: 2@2 to: 2@1 ]
		raise: Error - MessageNotUnderstood
		withExceptionDo: [:error | self assert: error messageText = TerniLapilli errorCantMoveToAnOccupiedPosition .
								     self assert: (terniLapilli whatIsAt: 2@1) = #X.
								     self assert: (terniLapilli whatIsAt: 2@2) = #O.]
	! !

!TerniLapilliTest methodsFor: 'testing' stamp: 'Santiago Festini 10/16/2019 16:22:20'!
test21PlayerXCanOnlyMoveInRange
	| terniLapilli |
	
	terniLapilli := TerniLapilli new.
	
	terniLapilli putXAt: 1@1.
	terniLapilli putOAt: 2@2.
	terniLapilli putXAt: 3@3.
	terniLapilli putOAt: 1@2.
	terniLapilli putXAt: 3@2.
	terniLapilli putOAt: 3@1.	
	
	self 
		should: [ terniLapilli moveXFrom: 1@1 to: 4@2 ]
		raise: Error - MessageNotUnderstood
		withExceptionDo: [:error | self assert: error messageText = TerniLapilli errorCantMoveOutsideOfRange .
								     self assert: (terniLapilli whatIsAt: 1@1) = #X.]
	! !

!TerniLapilliTest methodsFor: 'testing' stamp: 'Santiago Festini 10/16/2019 16:25:50'!
test22PlayerOCanOnlyMoveInRange
	| terniLapilli |
	
	terniLapilli := TerniLapilli new.
	
	terniLapilli putXAt: 1@1.
	terniLapilli putOAt: 2@2.
	terniLapilli putXAt: 3@3.
	terniLapilli putOAt: 1@2.
	terniLapilli putXAt: 3@2.
	terniLapilli putOAt: 3@1.	
	terniLapilli moveXFrom: 1@1 to: 2@1.
	self 
		should: [ terniLapilli moveOFrom: 2@2 to: 4@2 ]
		raise: Error - MessageNotUnderstood
		withExceptionDo: [:error | self assert: error messageText = TerniLapilli errorCantMoveOutsideOfRange .
								     self assert: (terniLapilli whatIsAt: 2@2) = #O.]
	! !

!TerniLapilliTest methodsFor: 'testing' stamp: 'Santiago Festini 10/16/2019 16:30:51'!
test23PlayerXCantMoveToTheSamePosition
	| terniLapilli |
	
	terniLapilli := TerniLapilli new.
	
	terniLapilli putXAt: 1@1.
	terniLapilli putOAt: 2@2.
	terniLapilli putXAt: 3@3.
	terniLapilli putOAt: 1@2.
	terniLapilli putXAt: 3@2.
	terniLapilli putOAt: 3@1.	
	
	self 
		should: [ terniLapilli moveXFrom: 1@1 to: 1@1 ]
		raise: Error - MessageNotUnderstood
		withExceptionDo: [:error | self assert: error messageText = TerniLapilli errorCantMoveToTheSamePosition .
								     self assert: (terniLapilli whatIsAt: 1@1) = #X.]
	! !

!TerniLapilliTest methodsFor: 'testing' stamp: 'Santiago Festini 10/16/2019 16:34:36'!
test24PlayerOCantMoveToTheSamePosition
	| terniLapilli |
	
	terniLapilli := TerniLapilli new.
	
	terniLapilli putXAt: 1@1.
	terniLapilli putOAt: 2@2.
	terniLapilli putXAt: 3@3.
	terniLapilli putOAt: 1@2.
	terniLapilli putXAt: 3@2.
	terniLapilli putOAt: 3@1.	
	terniLapilli moveXFrom: 1@1 to: 2@1. 
	
	self 
		should: [ terniLapilli moveOFrom: 2@2 to: 2@2 ]
		raise: Error - MessageNotUnderstood
		withExceptionDo: [:error | self assert: error messageText = TerniLapilli errorCantMoveToTheSamePosition .
								     self assert: (terniLapilli whatIsAt: 2@2) = #O.]
	! !

!TerniLapilliTest methodsFor: 'testing' stamp: 'Santiago Festini 10/16/2019 16:52:02'!
test25PlayerXCantMoveToADistanceGreaterOrEqualThan2
	| terniLapilli |
	
	terniLapilli := TerniLapilli new.
	
	terniLapilli putXAt: 1@1.
	terniLapilli putOAt: 2@2.
	terniLapilli putXAt: 3@3.
	terniLapilli putOAt: 1@2.
	terniLapilli putXAt: 3@2.
	terniLapilli putOAt: 3@1.	 
	
	self 
		should: [ terniLapilli moveXFrom: 1@1 to: 2@3. ]
		raise: Error - MessageNotUnderstood
		withExceptionDo: [:error | self assert: error messageText = TerniLapilli errorInvalidMove .
								     self assert: (terniLapilli whatIsAt: 1@1) = #X.
								     self assert: (terniLapilli whatIsAt: 2@3) = #empty.]
	! !

!TerniLapilliTest methodsFor: 'testing' stamp: 'Santiago Festini 10/16/2019 17:03:18'!
test26PlayerOCantMoveToADistanceGreaterOrEqualThan2
	| terniLapilli |
	
	terniLapilli := TerniLapilli new.
	
	terniLapilli putXAt: 1@1.
	terniLapilli putOAt: 2@2.
	terniLapilli putXAt: 3@3.
	terniLapilli putOAt: 1@2.
	terniLapilli putXAt: 3@2.
	terniLapilli putOAt: 3@1.
	terniLapilli moveXFrom: 1@1 to: 2@1. 	 
	
	self 
		should: [ terniLapilli moveOFrom: 3@1 to: 1@3. ]
		raise: Error - MessageNotUnderstood
		withExceptionDo: [:error | self assert: error messageText = TerniLapilli errorInvalidMove .
								     self assert: (terniLapilli whatIsAt: 3@1) = #O.
								     self assert: (terniLapilli whatIsAt: 1@3) = #empty.]
	! !

!TerniLapilliTest methodsFor: 'testing' stamp: 'Santiago Festini 10/16/2019 17:17:58'!
test27PlayerXCantMoveFrom1And2To2And1
	| terniLapilli |
	
	terniLapilli := TerniLapilli new.
	
	terniLapilli putXAt: 1@1.
	terniLapilli putOAt: 2@2.
	terniLapilli putXAt: 1@2.
	terniLapilli putOAt: 3@3.
	terniLapilli putXAt: 3@2.
	terniLapilli putOAt: 3@1. 	 
	
	self 
		should: [ terniLapilli moveXFrom: 1@2 to: 2@1. ]
		raise: Error - MessageNotUnderstood
		withExceptionDo: [:error | self assert: error messageText = TerniLapilli errorInvalidMove .
								     self assert: (terniLapilli whatIsAt: 1@2) = #X.
								     self assert: (terniLapilli whatIsAt: 2@1) = #empty.]
	! !

!TerniLapilliTest methodsFor: 'testing' stamp: 'Santiago Festini 10/16/2019 17:18:44'!
test28PlayerXCantMoveFrom2And1To1And2
	| terniLapilli |
	
	terniLapilli := TerniLapilli new.
	
	terniLapilli putXAt: 1@1.
	terniLapilli putOAt: 2@2.
	terniLapilli putXAt: 2@1.
	terniLapilli putOAt: 3@3.
	terniLapilli putXAt: 3@2.
	terniLapilli putOAt: 3@1. 	 
	
	self 
		should: [ terniLapilli moveXFrom: 2@1 to: 1@2. ]
		raise: Error - MessageNotUnderstood
		withExceptionDo: [:error | self assert: error messageText = TerniLapilli errorInvalidMove .
								     self assert: (terniLapilli whatIsAt: 2@1) = #X.
								     self assert: (terniLapilli whatIsAt: 1@2) = #empty.]
	! !

!TerniLapilliTest methodsFor: 'testing' stamp: 'Santiago Festini 10/16/2019 17:21:35'!
test29PlayerXCantMoveFrom1And2To2And3
	| terniLapilli |
	
	terniLapilli := TerniLapilli new.
	
	terniLapilli putXAt: 1@1.
	terniLapilli putOAt: 2@2.
	terniLapilli putXAt: 1@2.
	terniLapilli putOAt: 3@3.
	terniLapilli putXAt: 3@2.
	terniLapilli putOAt: 3@1. 	 
	
	self 
		should: [ terniLapilli moveXFrom: 1@2 to: 2@3. ]
		raise: Error - MessageNotUnderstood
		withExceptionDo: [:error | self assert: error messageText = TerniLapilli errorInvalidMove .
								     self assert: (terniLapilli whatIsAt: 1@2) = #X.
								     self assert: (terniLapilli whatIsAt: 2@3) = #empty.]
	! !

!TerniLapilliTest methodsFor: 'testing' stamp: 'Santiago Festini 10/16/2019 17:25:30'!
test30PlayerXCantMoveFrom2And3To1And2
	| terniLapilli |
	
	terniLapilli := TerniLapilli new.
	
	terniLapilli putXAt: 1@1.
	terniLapilli putOAt: 2@2.
	terniLapilli putXAt: 2@3.
	terniLapilli putOAt: 3@3.
	terniLapilli putXAt: 3@2.
	terniLapilli putOAt: 3@1. 	 
	
	self 
		should: [ terniLapilli moveXFrom: 2@3 to: 1@2. ]
		raise: Error - MessageNotUnderstood
		withExceptionDo: [:error | self assert: error messageText = TerniLapilli errorInvalidMove .
								     self assert: (terniLapilli whatIsAt: 2@3) = #X.
								     self assert: (terniLapilli whatIsAt: 1@2) = #empty.]
	! !

!TerniLapilliTest methodsFor: 'testing' stamp: 'Santiago Festini 10/16/2019 17:27:06'!
test31PlayerXCantMoveFrom3And2To2And1
	| terniLapilli |
	
	terniLapilli := TerniLapilli new.
	
	terniLapilli putXAt: 1@1.
	terniLapilli putOAt: 2@2.
	terniLapilli putXAt: 1@2.
	terniLapilli putOAt: 3@3.
	terniLapilli putXAt: 3@2.
	terniLapilli putOAt: 3@1. 	 
	
	self 
		should: [ terniLapilli moveXFrom: 3@2 to: 2@1. ]
		raise: Error - MessageNotUnderstood
		withExceptionDo: [:error | self assert: error messageText = TerniLapilli errorInvalidMove .
								     self assert: (terniLapilli whatIsAt: 3@2) = #X.
								     self assert: (terniLapilli whatIsAt: 2@1) = #empty.]
	! !

!TerniLapilliTest methodsFor: 'testing' stamp: 'Santiago Festini 10/16/2019 17:27:57'!
test32PlayerXCantMoveFrom3And2To2And3
	| terniLapilli |
	
	terniLapilli := TerniLapilli new.
	
	terniLapilli putXAt: 1@1.
	terniLapilli putOAt: 2@2.
	terniLapilli putXAt: 1@2.
	terniLapilli putOAt: 3@3.
	terniLapilli putXAt: 3@2.
	terniLapilli putOAt: 3@1. 	 
	
	self 
		should: [ terniLapilli moveXFrom: 3@2 to: 2@3. ]
		raise: Error - MessageNotUnderstood
		withExceptionDo: [:error | self assert: error messageText = TerniLapilli errorInvalidMove .
								     self assert: (terniLapilli whatIsAt: 3@2) = #X.
								     self assert: (terniLapilli whatIsAt: 2@3) = #empty.]
	! !

!TerniLapilliTest methodsFor: 'testing' stamp: 'Santiago Festini 10/16/2019 17:29:11'!
test33PlayerXCantMoveFrom2And1To3And2
	| terniLapilli |
	
	terniLapilli := TerniLapilli new.
	
	terniLapilli putXAt: 1@1.
	terniLapilli putOAt: 2@2.
	terniLapilli putXAt: 1@2.
	terniLapilli putOAt: 3@3.
	terniLapilli putXAt: 2@1.
	terniLapilli putOAt: 3@1. 	 
	
	self 
		should: [ terniLapilli moveXFrom: 2@1 to: 3@2. ]
		raise: Error - MessageNotUnderstood
		withExceptionDo: [:error | self assert: error messageText = TerniLapilli errorInvalidMove .
								     self assert: (terniLapilli whatIsAt: 2@1) = #X.
								     self assert: (terniLapilli whatIsAt: 3@2) = #empty.]
	! !

!TerniLapilliTest methodsFor: 'testing' stamp: 'Santiago Festini 10/16/2019 17:29:56'!
test34PlayerXCantMoveFrom2And3To3And2
	| terniLapilli |
	
	terniLapilli := TerniLapilli new.
	
	terniLapilli putXAt: 1@1.
	terniLapilli putOAt: 2@2.
	terniLapilli putXAt: 1@2.
	terniLapilli putOAt: 3@3.
	terniLapilli putXAt: 2@3.
	terniLapilli putOAt: 3@1. 	 
	
	self 
		should: [ terniLapilli moveXFrom: 2@3 to: 3@2. ]
		raise: Error - MessageNotUnderstood
		withExceptionDo: [:error | self assert: error messageText = TerniLapilli errorInvalidMove .
								     self assert: (terniLapilli whatIsAt: 2@3) = #X.
								     self assert: (terniLapilli whatIsAt: 3@2) = #empty.]
	! !

!TerniLapilliTest methodsFor: 'testing' stamp: 'Santiago Festini 10/16/2019 17:35:25'!
test35PlayerOCantMoveFrom1And2To2And1
	| terniLapilli |
	
	terniLapilli := TerniLapilli new.
	
	terniLapilli putXAt: 1@1.
	terniLapilli putOAt: 2@2.
	terniLapilli putXAt: 3@1.
	terniLapilli putOAt: 1@3.
	terniLapilli putXAt: 3@2.
	terniLapilli putOAt: 1@2. 	 
	terniLapilli moveXFrom: 3@2 to: 3@3. 
	
	self 
		should: [ terniLapilli moveOFrom: 1@2 to: 2@1. ]
		raise: Error - MessageNotUnderstood
		withExceptionDo: [:error | self assert: error messageText = TerniLapilli errorInvalidMove .
								     self assert: (terniLapilli whatIsAt: 1@2) = #O.
								     self assert: (terniLapilli whatIsAt: 2@1) = #empty.]
	! !

!TerniLapilliTest methodsFor: 'testing' stamp: 'Santiago Festini 10/16/2019 17:36:16'!
test36PlayerOCantMoveFrom1And2To2And3
	| terniLapilli |
	
	terniLapilli := TerniLapilli new.
	
	terniLapilli putXAt: 1@1.
	terniLapilli putOAt: 2@2.
	terniLapilli putXAt: 3@1.
	terniLapilli putOAt: 1@3.
	terniLapilli putXAt: 3@2.
	terniLapilli putOAt: 1@2. 	 
	terniLapilli moveXFrom: 3@2 to: 3@3. 
	
	self 
		should: [ terniLapilli moveOFrom: 1@2 to: 2@3. ]
		raise: Error - MessageNotUnderstood
		withExceptionDo: [:error | self assert: error messageText = TerniLapilli errorInvalidMove .
								     self assert: (terniLapilli whatIsAt: 1@2) = #O.
								     self assert: (terniLapilli whatIsAt: 2@3) = #empty.]
	! !

!TerniLapilliTest methodsFor: 'testing' stamp: 'Santiago Festini 10/16/2019 17:37:44'!
test37PlayerOCantMoveFrom2And1To1And2
	| terniLapilli |
	
	terniLapilli := TerniLapilli new.
	
	terniLapilli putXAt: 1@1.
	terniLapilli putOAt: 2@2.
	terniLapilli putXAt: 3@1.
	terniLapilli putOAt: 1@3.
	terniLapilli putXAt: 3@2.
	terniLapilli putOAt: 2@1. 	 
	terniLapilli moveXFrom: 3@2 to: 3@3. 
	
	self 
		should: [ terniLapilli moveOFrom: 2@1 to: 1@2. ]
		raise: Error - MessageNotUnderstood
		withExceptionDo: [:error | self assert: error messageText = TerniLapilli errorInvalidMove .
								     self assert: (terniLapilli whatIsAt: 2@1) = #O.
								     self assert: (terniLapilli whatIsAt: 1@2) = #empty.]
	! !

!TerniLapilliTest methodsFor: 'testing' stamp: 'Santiago Festini 10/16/2019 17:37:53'!
test38PlayerOCantMoveFrom2And3To1And2
	| terniLapilli |
	
	terniLapilli := TerniLapilli new.
	
	terniLapilli putXAt: 1@1.
	terniLapilli putOAt: 2@2.
	terniLapilli putXAt: 3@1.
	terniLapilli putOAt: 1@3.
	terniLapilli putXAt: 3@2.
	terniLapilli putOAt: 2@3.
	terniLapilli moveXFrom: 3@2 to: 3@3. 
	
	self 
		should: [ terniLapilli moveOFrom: 2@3 to: 1@2. ]
		raise: Error - MessageNotUnderstood
		withExceptionDo: [:error | self assert: error messageText = TerniLapilli errorInvalidMove .
								     self assert: (terniLapilli whatIsAt: 2@3) = #O.
								     self assert: (terniLapilli whatIsAt: 1@2) = #empty.]
	! !

!TerniLapilliTest methodsFor: 'testing' stamp: 'Santiago Festini 10/16/2019 17:39:22'!
test39PlayerOCantMoveFrom3And2To2And1
	| terniLapilli |
	
	terniLapilli := TerniLapilli new.
	
	terniLapilli putXAt: 1@1.
	terniLapilli putOAt: 2@2.
	terniLapilli putXAt: 3@1.
	terniLapilli putOAt: 1@3.
	terniLapilli putXAt: 3@3.
	terniLapilli putOAt: 3@2.
	terniLapilli moveXFrom: 1@1 to: 1@2. 
	
	self 
		should: [ terniLapilli moveOFrom: 3@2 to: 2@1. ]
		raise: Error - MessageNotUnderstood
		withExceptionDo: [:error | self assert: error messageText = TerniLapilli errorInvalidMove .
								     self assert: (terniLapilli whatIsAt: 3@2) = #O.
								     self assert: (terniLapilli whatIsAt: 2@1) = #empty.]
	! !

!TerniLapilliTest methodsFor: 'testing' stamp: 'Santiago Festini 10/16/2019 17:39:50'!
test40PlayerOCantMoveFrom3And2To2And3
	| terniLapilli |
	
	terniLapilli := TerniLapilli new.
	
	terniLapilli putXAt: 1@1.
	terniLapilli putOAt: 2@2.
	terniLapilli putXAt: 3@1.
	terniLapilli putOAt: 1@3.
	terniLapilli putXAt: 3@3.
	terniLapilli putOAt: 3@2.
	terniLapilli moveXFrom: 1@1 to: 1@2. 
	
	self 
		should: [ terniLapilli moveOFrom: 3@2 to: 2@3. ]
		raise: Error - MessageNotUnderstood
		withExceptionDo: [:error | self assert: error messageText = TerniLapilli errorInvalidMove .
								     self assert: (terniLapilli whatIsAt: 3@2) = #O.
								     self assert: (terniLapilli whatIsAt: 2@3) = #empty.]
	! !

!TerniLapilliTest methodsFor: 'testing' stamp: 'Santiago Festini 10/16/2019 17:40:38'!
test41PlayerOCantMoveFrom2And1To3And2
	| terniLapilli |
	
	terniLapilli := TerniLapilli new.
	
	terniLapilli putXAt: 1@1.
	terniLapilli putOAt: 2@2.
	terniLapilli putXAt: 3@1.
	terniLapilli putOAt: 1@3.
	terniLapilli putXAt: 3@3.
	terniLapilli putOAt: 2@1.
	terniLapilli moveXFrom: 1@1 to: 1@2. 
	
	self 
		should: [ terniLapilli moveOFrom: 2@1 to: 3@2. ]
		raise: Error - MessageNotUnderstood
		withExceptionDo: [:error | self assert: error messageText = TerniLapilli errorInvalidMove .
								     self assert: (terniLapilli whatIsAt: 2@1) = #O.
								     self assert: (terniLapilli whatIsAt: 3@2) = #empty.]
	! !

!TerniLapilliTest methodsFor: 'testing' stamp: 'Santiago Festini 10/16/2019 17:40:53'!
test42PlayerOCantMoveFrom2And3To3And2
	| terniLapilli |
	
	terniLapilli := TerniLapilli new.
	
	terniLapilli putXAt: 1@1.
	terniLapilli putOAt: 2@2.
	terniLapilli putXAt: 3@1.
	terniLapilli putOAt: 1@3.
	terniLapilli putXAt: 3@3.
	terniLapilli putOAt: 2@3.
	terniLapilli moveXFrom: 1@1 to: 1@2. 
	
	self 
		should: [ terniLapilli moveOFrom: 2@3 to: 3@2. ]
		raise: Error - MessageNotUnderstood
		withExceptionDo: [:error | self assert: error messageText = TerniLapilli errorInvalidMove .
								     self assert: (terniLapilli whatIsAt: 2@3) = #O.
								     self assert: (terniLapilli whatIsAt: 3@2) = #empty.]
	! !

!TerniLapilliTest methodsFor: 'testing' stamp: 'Santiago Festini 10/16/2019 17:51:59'!
test43WhenGameStartsNoOneWins
	| terniLapilli |
	
	terniLapilli := TerniLapilli new.
	
	self deny: (terniLapilli hasPlayerXWon).
	self deny: (terniLapilli hasPlayerOWon).	! !

!TerniLapilliTest methodsFor: 'testing' stamp: 'Santiago Festini 10/16/2019 17:50:46'!
test44WhenXHasThreeInLineWins
	| terniLapilli |
	
	terniLapilli := TerniLapilli new.
	terniLapilli putXAt: 1@1.
	terniLapilli putOAt: 2@2.
	terniLapilli putXAt: 1@2.
	terniLapilli putOAt: 2@1.
	terniLapilli putXAt: 1@3.

	self assert: (terniLapilli hasPlayerXWon).
	self deny: (terniLapilli hasPlayerOWon).	! !

!TerniLapilliTest methodsFor: 'testing' stamp: 'Santiago Festini 10/16/2019 18:04:18'!
test45WhenOHasThreeInLineWins
	| terniLapilli |
	
	terniLapilli := TerniLapilli new.
	terniLapilli putXAt: 3@3.
	terniLapilli putOAt: 1@1.
	terniLapilli putXAt: 2@2.
	terniLapilli putOAt: 1@2.
	terniLapilli putXAt: 2@3.
	terniLapilli putOAt: 1@3.
	
	self deny: (terniLapilli hasPlayerXWon).
	self assert: (terniLapilli hasPlayerOWon).	! !

!TerniLapilliTest methodsFor: 'testing' stamp: 'Santiago Festini 10/16/2019 18:08:04'!
test46WhenGameStartsItsNotOver
	| terniLapilli |
	
	terniLapilli := TerniLapilli new.
	
	self deny: (terniLapilli isOver).	! !

!TerniLapilliTest methodsFor: 'testing' stamp: 'Santiago Festini 10/16/2019 18:10:08'!
test47WhenSomeoneWinsTheGameIsOver
	| terniLapilli |
	
	terniLapilli := TerniLapilli new.
	terniLapilli putXAt: 1@1.
	terniLapilli putOAt: 2@2.
	terniLapilli putXAt: 1@2.
	terniLapilli putOAt: 2@1.
	terniLapilli putXAt: 1@3.

	self assert: (terniLapilli hasPlayerXWon).
	self deny: (terniLapilli hasPlayerOWon).	
	self assert: (terniLapilli isOver ).! !

!TerniLapilliTest methodsFor: 'testing' stamp: 'Santiago Festini 10/16/2019 18:12:48'!
test48WhenGameIsOverPlayerOCantPut
	| terniLapilli |
	
	terniLapilli := TerniLapilli new.
	terniLapilli putXAt: 1@1.
	terniLapilli putOAt: 2@2.
	terniLapilli putXAt: 1@2.
	terniLapilli putOAt: 2@1.
	terniLapilli putXAt: 1@3.

	self 
		should: [ terniLapilli putOAt: 3@2. ]
		raise: Error - MessageNotUnderstood
		withExceptionDo: [:error | self assert: error messageText = TerniLapilli errorTheGameIsOver .
								     self assert: (terniLapilli whatIsAt: 3@2) = #empty.]! !

!TerniLapilliTest methodsFor: 'testing' stamp: 'Santiago Festini 10/16/2019 18:18:16'!
test49WhenGameIsOverPlayerXCantMove
	| terniLapilli |
	
	terniLapilli := TerniLapilli new.
	terniLapilli putXAt: 1@1.
	terniLapilli putOAt: 2@2.
	terniLapilli putXAt: 1@2.
	terniLapilli putOAt: 2@1.
	terniLapilli putXAt: 3@3.
	terniLapilli putOAt: 2@3.

	self 
		should: [ terniLapilli moveXFrom: 3@3 to: 3@2. ]
		raise: Error - MessageNotUnderstood
		withExceptionDo: [:error | self assert: error messageText = TerniLapilli errorTheGameIsOver .
								     self assert: (terniLapilli whatIsAt: 3@2) = #empty.]! !

!TerniLapilliTest methodsFor: 'testing' stamp: 'Santiago Festini 10/16/2019 18:20:47'!
test50WhenGameIsOverPlayerXCantMove
	| terniLapilli |
	
	terniLapilli := TerniLapilli new.
	terniLapilli putXAt: 1@1.
	terniLapilli putOAt: 1@2.
	terniLapilli putXAt: 2@1.
	terniLapilli putOAt: 2@2.
	terniLapilli putXAt: 3@2.
	terniLapilli putOAt: 3@3.
	terniLapilli moveXFrom: 3@2  to: 3@1. 

	self 
		should: [ terniLapilli moveOFrom: 3@3 to: 2@3. ]
		raise: Error - MessageNotUnderstood
		withExceptionDo: [:error | self assert: error messageText = TerniLapilli errorTheGameIsOver .
								     self assert: (terniLapilli whatIsAt: 2@3) = #empty.]! !


!classDefinition: #TerniLapilli category: #TerniLapilli!
Object subclass: #TerniLapilli
	instanceVariableNames: 'currentPlayer board numberOfXPositions numberOfOPositions'
	classVariableNames: ''
	poolDictionaries: ''
	category: 'TerniLapilli'!

!TerniLapilli methodsFor: 'testing' stamp: 'Santiago Festini 10/16/2019 18:02:51'!
hasPlayerOWon
	((((self whatIsAt: (1@1)) = #O) and: ((self whatIsAt: (1@2)) = #O)) and: ((self whatIsAt: (1@3)) = #O)) ifTrue: [^true].
	((((self whatIsAt: (2@1)) = #O) and: ((self whatIsAt: (2@2)) = #O)) and: ((self whatIsAt: (2@3)) = #O)) ifTrue: [^true].
	((((self whatIsAt: (3@1)) = #O) and: ((self whatIsAt: (3@2)) = #O)) and: ((self whatIsAt: (3@3)) = #O)) ifTrue: [^true].
	((((self whatIsAt: (1@1)) = #O) and: ((self whatIsAt: (2@1)) = #O)) and: ((self whatIsAt: (3@1)) = #O)) ifTrue: [^true].
	((((self whatIsAt: (1@2)) = #O) and: ((self whatIsAt: (2@2)) = #O)) and: ((self whatIsAt: (3@2)) = #O)) ifTrue: [^true].
	((((self whatIsAt: (1@3)) = #O) and: ((self whatIsAt: (2@3)) = #O)) and: ((self whatIsAt: (3@3)) = #O)) ifTrue: [^true].
	((((self whatIsAt: (1@1)) = #O) and: ((self whatIsAt: (2@2)) = #O)) and: ((self whatIsAt: (3@3)) = #O)) ifTrue: [^true].
	((((self whatIsAt: (1@3)) = #O) and: ((self whatIsAt: (2@2)) = #O)) and: ((self whatIsAt: (3@1)) = #O)) ifTrue: [^true].
	^false.! !

!TerniLapilli methodsFor: 'testing' stamp: 'Santiago Festini 10/16/2019 18:01:34'!
hasPlayerXWon
	((((self whatIsAt: (1@1)) = #X) and: ((self whatIsAt: (1@2)) = #X)) and: ((self whatIsAt: (1@3)) = #X)) ifTrue: [^true].
	((((self whatIsAt: (2@1)) = #X) and: ((self whatIsAt: (2@2)) = #X)) and: ((self whatIsAt: (2@3)) = #X)) ifTrue: [^true].
	((((self whatIsAt: (3@1)) = #X) and: ((self whatIsAt: (3@2)) = #X)) and: ((self whatIsAt: (3@3)) = #X)) ifTrue: [^true].
	((((self whatIsAt: (1@1)) = #X) and: ((self whatIsAt: (2@1)) = #X)) and: ((self whatIsAt: (3@1)) = #X)) ifTrue: [^true].
	((((self whatIsAt: (1@2)) = #X) and: ((self whatIsAt: (2@2)) = #X)) and: ((self whatIsAt: (3@2)) = #X)) ifTrue: [^true].
	((((self whatIsAt: (1@3)) = #X) and: ((self whatIsAt: (2@3)) = #X)) and: ((self whatIsAt: (3@3)) = #X)) ifTrue: [^true].
	((((self whatIsAt: (1@1)) = #X) and: ((self whatIsAt: (2@2)) = #X)) and: ((self whatIsAt: (3@3)) = #X)) ifTrue: [^true].
	((((self whatIsAt: (1@3)) = #X) and: ((self whatIsAt: (2@2)) = #X)) and: ((self whatIsAt: (3@1)) = #X)) ifTrue: [^true].	
	^false.! !

!TerniLapilli methodsFor: 'testing' stamp: 'Santiago Festini 10/16/2019 18:07:25'!
isOver
	^ (self hasPlayerOWon ) or: (self hasPlayerXWon).! !

!TerniLapilli methodsFor: 'testing' stamp: 'Santiago Festini 10/10/2019 18:24:07'!
isPlayingO
	^currentPlayer = #O.! !

!TerniLapilli methodsFor: 'testing' stamp: 'Santiago Festini 10/10/2019 18:23:55'!
isPlayingX
	^currentPlayer = #X. ! !

!TerniLapilli methodsFor: 'testing' stamp: 'Santiago Festini 10/16/2019 13:41:44'!
whatIsAt: aPosition

	^(board at: aPosition  x) at: aPosition y! !


!TerniLapilli methodsFor: 'initialization' stamp: 'Santiago Festini 10/16/2019 14:17:47'!
initialize
	board := OrderedCollection with: (OrderedCollection with: #empty with: #empty with: #empty)
									with: (OrderedCollection with: #empty with: #empty with: #empty)
									with: (OrderedCollection with: #empty with: #empty with: #empty).
	
	numberOfXPositions := 0.
	numberOfOPositions := 0.
		
	currentPlayer := #X.! !


!TerniLapilli methodsFor: 'operations' stamp: 'Santiago Festini 10/16/2019 18:19:15'!
moveOFrom: startingPosition to: finalPosition
	self isOver ifTrue: [self error: (self class) errorTheGameIsOver ].
	numberOfOPositions = 3 ifFalse: [self error: (self class) errorCantMoveBeforeOwning3Positions ].
	(((finalPosition x) between: 1 and: 3) and: ((finalPosition y) between: 1 and: 3) ) ifFalse:[self error: (self class) errorCantMoveOutsideOfRange ].
	(startingPosition = finalPosition ) ifTrue: [self error: (self class) errorCantMoveToTheSamePosition].
	((startingPosition dist: finalPosition) < 2) ifFalse: [self error: (self class) errorInvalidMove ].
	((board at: finalPosition x) at: finalPosition y) = #empty ifFalse:[self error: (self class) errorCantMoveToAnOccupiedPosition].
	((board at: startingPosition x) at: startingPosition y) = #O ifFalse:[self error: (self class) errorCantMoveAPositionOfAnotherPlayer].
	((startingPosition = (1@2)) and: (finalPosition = (2@1))) ifTrue: [self error: (self class) errorInvalidMove ].
	((startingPosition = (2@1)) and: (finalPosition = (1@2))) ifTrue: [self error: (self class) errorInvalidMove ].
	((startingPosition = (1@2)) and: (finalPosition = (2@3))) ifTrue: [self error: (self class) errorInvalidMove ].
	((startingPosition = (2@3)) and: (finalPosition = (1@2))) ifTrue: [self error: (self class) errorInvalidMove ].
	((startingPosition = (3@2)) and: (finalPosition = (2@1))) ifTrue: [self error: (self class) errorInvalidMove ].
	((startingPosition = (3@2)) and: (finalPosition = (2@3))) ifTrue: [self error: (self class) errorInvalidMove ].
	((startingPosition = (2@1)) and: (finalPosition = (3@2))) ifTrue: [self error: (self class) errorInvalidMove ].
	((startingPosition = (2@3)) and: (finalPosition = (3@2))) ifTrue: [self error: (self class) errorInvalidMove ].
	currentPlayer := #O.
	(board at: startingPosition x) at: startingPosition y put: #empty.
	(board at: finalPosition x) at: finalPosition y put: #O.
	! !

!TerniLapilli methodsFor: 'operations' stamp: 'Santiago Festini 10/16/2019 18:19:07'!
moveXFrom: startingPosition to: finalPosition
	self isOver ifTrue: [self error: (self class) errorTheGameIsOver ].
	numberOfXPositions = 3 ifFalse: [self error: (self class) errorCantMoveBeforeOwning3Positions ].
	(((finalPosition x) between: 1 and: 3) and: ((finalPosition y) between: 1 and: 3) ) ifFalse:[self error: (self class) errorCantMoveOutsideOfRange ].
	(startingPosition = finalPosition ) ifTrue: [self error: (self class) errorCantMoveToTheSamePosition].
	((startingPosition dist: finalPosition) < 2) ifFalse: [self error: (self class) errorInvalidMove ].
	((board at: finalPosition x) at: finalPosition y) = #empty ifFalse:[self error: (self class) errorCantMoveToAnOccupiedPosition].
	((board at: startingPosition x) at: startingPosition y) = #X ifFalse: [self error: (self class) errorCantMoveAPositionOfAnotherPlayer].
	((startingPosition = (1@2)) and: (finalPosition = (2@1))) ifTrue: [self error: (self class) errorInvalidMove ].
	((startingPosition = (2@1)) and: (finalPosition = (1@2))) ifTrue: [self error: (self class) errorInvalidMove ].
	((startingPosition = (1@2)) and: (finalPosition = (2@3))) ifTrue: [self error: (self class) errorInvalidMove ].
	((startingPosition = (2@3)) and: (finalPosition = (1@2))) ifTrue: [self error: (self class) errorInvalidMove ].
	((startingPosition = (3@2)) and: (finalPosition = (2@1))) ifTrue: [self error: (self class) errorInvalidMove ].
	((startingPosition = (3@2)) and: (finalPosition = (2@3))) ifTrue: [self error: (self class) errorInvalidMove ].
	((startingPosition = (2@1)) and: (finalPosition = (3@2))) ifTrue: [self error: (self class) errorInvalidMove ].
	((startingPosition = (2@3)) and: (finalPosition = (3@2))) ifTrue: [self error: (self class) errorInvalidMove ].
	currentPlayer := #O.
	(board at: startingPosition x) at: startingPosition y put: #empty.
	(board at: finalPosition x) at: finalPosition y put: #X.
	! !

!TerniLapilli methodsFor: 'operations' stamp: 'Santiago Festini 10/16/2019 18:15:02'!
putOAt: aPosition
	self isOver ifTrue: [self error: (self class) errorTheGameIsOver ].
	currentPlayer = #X ifTrue: [self error: (self class) errorItsNotYourTurn ] .
	numberOfOPositions = 3 ifTrue: [self error: (self class) errorOnly3PositionsPerPlayer ].
	(((aPosition x) between: 1 and: 3) and: ((aPosition y) between: 1 and: 3) ) ifFalse:[self error: (self class) errorPositionNotInRange ].
	((board at: aPosition  x) at: aPosition y) = #empty ifFalse: [self error: (self class) errorCantPutInAnOccupiedPosition ].
	currentPlayer := #X.
	(board at: aPosition  x) at: aPosition y put: #O.
	numberOfOPositions := numberOfOPositions + 1.! !

!TerniLapilli methodsFor: 'operations' stamp: 'Santiago Festini 10/16/2019 16:13:42'!
putXAt: aPosition
	currentPlayer = #O ifTrue:[self error: (self class) errorItsNotYourTurn ].
	numberOfXPositions = 3 ifTrue: [self error: (self class) errorOnly3PositionsPerPlayer ].
	(((aPosition x) between: 1 and: 3) and: ((aPosition y) between: 1 and: 3) ) ifFalse:[self error: (self class) errorPositionNotInRange ].
	((board at: aPosition  x) at: aPosition y) = #empty ifFalse: [self error: (self class) errorCantPutInAnOccupiedPosition ].
	currentPlayer := #O.
	(board at: aPosition  x) at: aPosition y put: #X.
	numberOfXPositions := numberOfXPositions + 1.! !

"-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- "!

!classDefinition: 'TerniLapilli class' category: #TerniLapilli!
TerniLapilli class
	instanceVariableNames: ''!

!TerniLapilli class methodsFor: 'as yet unclassified' stamp: 'Santiago Festini 10/16/2019 15:40:17'!
errorCantMoveAPositionOfAnotherPlayer
	^'The position you are trying to move isnt yours!!'! !

!TerniLapilli class methodsFor: 'as yet unclassified' stamp: 'Santiago Festini 10/16/2019 15:53:59'!
errorCantMoveBeforeOwning3Positions
	^'You have to occupy 3 positions first!!'! !

!TerniLapilli class methodsFor: 'as yet unclassified' stamp: 'Santiago Festini 10/16/2019 16:22:36'!
errorCantMoveOutsideOfRange
	^'Position is not in range!!'! !

!TerniLapilli class methodsFor: 'as yet unclassified' stamp: 'Santiago Festini 10/16/2019 16:13:02'!
errorCantMoveToAnOccupiedPosition
	^'Position is occupied!!'! !

!TerniLapilli class methodsFor: 'as yet unclassified' stamp: 'Santiago Festini 10/16/2019 16:31:27'!
errorCantMoveToTheSamePosition
	^'Cant move to the same position!!'! !

!TerniLapilli class methodsFor: 'as yet unclassified' stamp: 'Santiago Festini 10/16/2019 16:13:42'!
errorCantPutInAnOccupiedPosition
	^'Position is occupied!!'! !

!TerniLapilli class methodsFor: 'as yet unclassified' stamp: 'Santiago Festini 10/16/2019 16:43:21'!
errorInvalidMove
	^'Thats not a valid move, read the rules again!!'! !

!TerniLapilli class methodsFor: 'as yet unclassified' stamp: 'Santiago Festini 10/10/2019 18:36:21'!
errorItsNotYourTurn
	^'Its not your turn!!'! !

!TerniLapilli class methodsFor: 'as yet unclassified' stamp: 'Santiago Festini 10/16/2019 14:11:44'!
errorOnly3PositionsPerPlayer
	^'A player can only hold up to 3 positions at a time!!'! !

!TerniLapilli class methodsFor: 'as yet unclassified' stamp: 'Santiago Festini 10/16/2019 16:08:30'!
errorPositionNotInRange
	^'Position is not in range!!'! !

!TerniLapilli class methodsFor: 'as yet unclassified' stamp: 'Santiago Festini 10/16/2019 18:13:27'!
errorTheGameIsOver
	^'The game is over so you cant play anymore'.! !


!classDefinition: #TerniLapilliState category: #TerniLapilli!
Object subclass: #TerniLapilliState
	instanceVariableNames: ''
	classVariableNames: ''
	poolDictionaries: ''
	category: 'TerniLapilli'!


!classDefinition: #TerniLapilliBegins category: #TerniLapilli!
TerniLapilliState subclass: #TerniLapilliBegins
	instanceVariableNames: ''
	classVariableNames: ''
	poolDictionaries: ''
	category: 'TerniLapilli'!


!classDefinition: #TerniLapilliIsOver category: #TerniLapilli!
TerniLapilliState subclass: #TerniLapilliIsOver
	instanceVariableNames: ''
	classVariableNames: ''
	poolDictionaries: ''
	category: 'TerniLapilli'!


!classDefinition: #TerniLapilliMovementState category: #TerniLapilli!
TerniLapilliState subclass: #TerniLapilliMovementState
	instanceVariableNames: ''
	classVariableNames: ''
	poolDictionaries: ''
	category: 'TerniLapilli'!


!classDefinition: #TerniLapilliPuttingState category: #TerniLapilli!
TerniLapilliState subclass: #TerniLapilliPuttingState
	instanceVariableNames: ''
	classVariableNames: ''
	poolDictionaries: ''
	category: 'TerniLapilli'!
