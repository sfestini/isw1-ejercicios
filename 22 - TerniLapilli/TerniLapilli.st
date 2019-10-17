!classDefinition: #TerniLapilliTest category: #TerniLapilli!
TestCase subclass: #TerniLapilliTest
	instanceVariableNames: ''
	classVariableNames: ''
	poolDictionaries: ''
	category: 'TerniLapilli'!

!TerniLapilliTest methodsFor: 'testing' stamp: 'Santiago Festini 10/17/2019 16:31:32'!
test01XGoesFirst
	| terniLapilli |
	
	terniLapilli := TerniLapilli new.
	
	self isXTurnAt: terniLapilli .
	! !

!TerniLapilliTest methodsFor: 'testing' stamp: 'Santiago Festini 10/17/2019 16:44:34'!
test02XMakesTheFirstPut
	| terniLapilli |
	
	terniLapilli := TerniLapilli new.
	
	terniLapilli putXAt: 1@1.

	self at: 1@1  is: #X  at: terniLapilli .! !

!TerniLapilliTest methodsFor: 'testing' stamp: 'Santiago Festini 10/17/2019 16:31:56'!
test03AfterXMovesOPlays
	| terniLapilli |
	
	terniLapilli := TerniLapilli new.
	
	terniLapilli putXAt: 1@1.

	self isOTurnAt: terniLapilli .! !

!TerniLapilliTest methodsFor: 'testing' stamp: 'Santiago Festini 10/17/2019 16:32:09'!
test04AfterOMovesXPlays
	| terniLapilli |
	
	terniLapilli := TerniLapilli new.
	
	terniLapilli putXAt: 1@1.
	terniLapilli putOAt: 2@2.

	self isXTurnAt: terniLapilli .! !

!TerniLapilliTest methodsFor: 'testing' stamp: 'Santiago Festini 10/17/2019 16:46:01'!
test05PlayerOCannotPutWhenItsNotItsTurn
	| terniLapilli |
	
	terniLapilli := TerniLapilli new.

	self 
		should: [ terniLapilli putOAt: 1@1]
		raise: Error - MessageNotUnderstood
		withExceptionDo: [:error | self assert: error messageText = TerniLapilli errorItsNotYourTurn .
								     self at: 1@1 is: #empty at: terniLapilli .]
	! !

!TerniLapilliTest methodsFor: 'testing' stamp: 'Santiago Festini 10/17/2019 16:47:37'!
test06PlayerXCannotPutWhenItsNotItsTurn
	| terniLapilli |
	
	terniLapilli := TerniLapilli new.
	
	terniLapilli putXAt: 1@1.
	
	self 
		should: [ terniLapilli putXAt: 2@1]
		raise: Error - MessageNotUnderstood
		withExceptionDo: [:error | self assert: error messageText = TerniLapilli errorItsNotYourTurn .
									self at: 2@1 is: #empty  at: terniLapilli .]
	! !

!TerniLapilliTest methodsFor: 'testing' stamp: 'Santiago Festini 10/17/2019 15:20:48'!
test07PlayerOCannotPutInOccupiedPosition
	| terniLapilli |
	
	terniLapilli := TerniLapilli new.
	
	terniLapilli putXAt: 1@1.
	
	self 
		should: [ terniLapilli putOAt: 1@1]
		raise: Error - MessageNotUnderstood
		withExceptionDo: [:error | self assert: error messageText = TerniLapilli errorOccupiedPosition .
								     self assert: (terniLapilli whatIsAt: 1@1) = #X.]
	! !

!TerniLapilliTest methodsFor: 'testing' stamp: 'Santiago Festini 10/17/2019 16:49:20'!
test08PlayerXCannotPutInOccupiedPosition
	| terniLapilli |
	
	terniLapilli := TerniLapilli new.
	
	terniLapilli putXAt: 1@1.
	terniLapilli putOAt: 2@2.
	
	self 
		should: [ terniLapilli putXAt: 1@1]
		raise: Error - MessageNotUnderstood
		withExceptionDo: [:error | self assert: error messageText = TerniLapilli errorOccupiedPosition .
								     self at: 1@1 is: #X at: terniLapilli .]
	! !

!TerniLapilliTest methodsFor: 'testing' stamp: 'Santiago Festini 10/17/2019 16:49:47'!
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
								     self at: 1@3 is: #empty at: terniLapilli .]
	! !

!TerniLapilliTest methodsFor: 'testing' stamp: 'Santiago Festini 10/17/2019 16:50:10'!
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
								     self at: 1@3 is: #empty  at: terniLapilli .]
	! !

!TerniLapilliTest methodsFor: 'testing' stamp: 'Santiago Festini 10/17/2019 16:50:53'!
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
	
	self at: 1@1 is: #empty  at: terniLapilli .
	self at: 2@1 is: #X  at: terniLapilli .! !

!TerniLapilliTest methodsFor: 'testing' stamp: 'Santiago Festini 10/17/2019 16:51:33'!
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
	
	self at: 2@2 is: #empty  at: terniLapilli .
	self at: 2@3 is: #O  at: terniLapilli .
	! !

!TerniLapilliTest methodsFor: 'testing' stamp: 'Santiago Festini 10/17/2019 16:52:13'!
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
									self at: 2@1 is: #empty  at: terniLapilli .
									self at: 2@2 is: #O  at: terniLapilli .]
	! !

!TerniLapilliTest methodsFor: 'testing' stamp: 'Santiago Festini 10/17/2019 16:52:55'!
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
									self at: 1@1 is: #empty  at: terniLapilli .
									self at: 2@1 is: #X  at: terniLapilli .]
	! !

!TerniLapilliTest methodsFor: 'testing' stamp: 'Santiago Festini 10/17/2019 16:53:37'!
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
									self at:1@1  is:#X  at: terniLapilli .
									self at: 2@1 is: #empty  at: terniLapilli .]
	! !

!TerniLapilliTest methodsFor: 'testing' stamp: 'Santiago Festini 10/17/2019 16:54:18'!
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
									self at: 2@2 is: #O  at: terniLapilli .
									self at: 2@1 is: #empty  at: terniLapilli .]
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

!TerniLapilliTest methodsFor: 'testing' stamp: 'Santiago Festini 10/17/2019 16:55:11'!
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
		withExceptionDo: [:error | self assert: error messageText = TerniLapilli errorOccupiedPosition .
									self at: 1@1 is: #X  at: terniLapilli .
									self at: 2@2 is: #O  at: terniLapilli .]
	! !

!TerniLapilliTest methodsFor: 'testing' stamp: 'Santiago Festini 10/17/2019 15:21:36'!
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
		withExceptionDo: [:error | self assert: error messageText = TerniLapilli errorOccupiedPosition .
								     self assert: (terniLapilli whatIsAt: 2@1) = #X.
								     self assert: (terniLapilli whatIsAt: 2@2) = #O.]
	! !

!TerniLapilliTest methodsFor: 'testing' stamp: 'Santiago Festini 10/17/2019 15:19:50'!
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
		withExceptionDo: [:error | self assert: error messageText = TerniLapilli errorPositionNotInRange .
								     self assert: (terniLapilli whatIsAt: 1@1) = #X.]
	! !

!TerniLapilliTest methodsFor: 'testing' stamp: 'Santiago Festini 10/17/2019 15:20:02'!
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
		withExceptionDo: [:error | self assert: error messageText = TerniLapilli errorPositionNotInRange .
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

!TerniLapilliTest methodsFor: 'testing' stamp: 'Santiago Festini 10/17/2019 16:35:59'!
test44WhenXHasThreeInLineWins
	| terniLapilli |
	
	terniLapilli := TerniLapilli new.
	terniLapilli putXAt: 1@1.
	terniLapilli putOAt: 2@2.
	terniLapilli putXAt: 1@2.
	terniLapilli putOAt: 2@1.
	terniLapilli putXAt: 1@3.

	self hasXWonAt: terniLapilli.! !

!TerniLapilliTest methodsFor: 'testing' stamp: 'Santiago Festini 10/17/2019 16:36:38'!
test45WhenOHasThreeInLineWins
	| terniLapilli |
	
	terniLapilli := TerniLapilli new.
	terniLapilli putXAt: 3@3.
	terniLapilli putOAt: 1@1.
	terniLapilli putXAt: 2@2.
	terniLapilli putOAt: 1@2.
	terniLapilli putXAt: 2@3.
	terniLapilli putOAt: 1@3.
	
	self hasOWonAt: terniLapilli.
	! !

!TerniLapilliTest methodsFor: 'testing' stamp: 'Santiago Festini 10/16/2019 18:08:04'!
test46WhenGameStartsItsNotOver
	| terniLapilli |
	
	terniLapilli := TerniLapilli new.
	
	self deny: (terniLapilli isOver).	! !

!TerniLapilliTest methodsFor: 'testing' stamp: 'Santiago Festini 10/17/2019 16:37:20'!
test47WhenSomeoneWinsTheGameIsOver
	| terniLapilli |
	
	terniLapilli := TerniLapilli new.
	terniLapilli putXAt: 1@1.
	terniLapilli putOAt: 2@2.
	terniLapilli putXAt: 1@2.
	terniLapilli putOAt: 2@1.
	terniLapilli putXAt: 1@3.

	self hasXWonAt: terniLapilli.
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


!TerniLapilliTest methodsFor: 'assertions' stamp: 'Santiago Festini 10/17/2019 16:43:21'!
at: aPosition is: aPlayer at: aTerniLapilli
	self assert: (aTerniLapilli whatIsAt: aPosition) = aPlayer.
	! !

!TerniLapilliTest methodsFor: 'assertions' stamp: 'Santiago Festini 10/17/2019 16:33:51'!
hasOWonAt: aTerniLapilli

	self deny: (aTerniLapilli hasPlayerXWon).
	self assert: (aTerniLapilli hasPlayerOWon).	
	! !

!TerniLapilliTest methodsFor: 'assertions' stamp: 'Santiago Festini 10/17/2019 16:33:32'!
hasXWonAt: aTerniLapilli

	self assert: (aTerniLapilli hasPlayerXWon).
	self deny: (aTerniLapilli hasPlayerOWon).	
	! !

!TerniLapilliTest methodsFor: 'assertions' stamp: 'Santiago Festini 10/17/2019 16:30:48'!
isOTurnAt: aTerniLapilli

	self deny: (aTerniLapilli isPlayingX).
	self assert: (aTerniLapilli isPlayingO).! !

!TerniLapilliTest methodsFor: 'assertions' stamp: 'Santiago Festini 10/17/2019 16:30:30'!
isXTurnAt: aTerniLapilli

	self assert: (aTerniLapilli isPlayingX).
	self deny: (aTerniLapilli isPlayingO).! !


!classDefinition: #TerniLapilli category: #TerniLapilli!
Object subclass: #TerniLapilli
	instanceVariableNames: 'board numberOfXPositions numberOfOPositions gameState currentPlayer'
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

!TerniLapilli methodsFor: 'testing' stamp: 'mm 10/17/2019 09:43:05'!
isPlayingO
	^ currentPlayer isPlayingO.! !

!TerniLapilli methodsFor: 'testing' stamp: 'mm 10/17/2019 09:43:10'!
isPlayingX
	^currentPlayer isPlayingX .
	! !


!TerniLapilli methodsFor: 'initialization' stamp: 'mm 10/17/2019 09:42:47'!
initialize
	board := OrderedCollection with: (OrderedCollection with: #empty with: #empty with: #empty)
									with: (OrderedCollection with: #empty with: #empty with: #empty)
									with: (OrderedCollection with: #empty with: #empty with: #empty).
	
	numberOfXPositions := 0.
	numberOfOPositions := 0.
	
	gameState := TerniLapilliPuttingState new.
	currentPlayer := PlayerXTurn new.
	! !


!TerniLapilli methodsFor: 'operations' stamp: 'Santiago Festini 10/17/2019 16:16:49'!
moveOFrom: startingPosition to: finalPosition

	currentPlayer CanOMove .
	
	self assertValidMovePositionOf: startingPosition to: finalPosition .
	
	gameState := gameState moveOFrom: startingPosition to: finalPosition at: self.	
	currentPlayer := PlayerXTurn new.
		! !

!TerniLapilli methodsFor: 'operations' stamp: 'Santiago Festini 10/17/2019 16:17:05'!
moveXFrom: startingPosition to: finalPosition

	currentPlayer CanXMove .

	self assertValidMovePositionOf: startingPosition to: finalPosition .
	
	gameState := gameState moveXFrom: startingPosition to: finalPosition at: self.
	currentPlayer := PlayerOTurn new.	! !

!TerniLapilli methodsFor: 'operations' stamp: 'Santiago Festini 10/17/2019 16:17:20'!
putOAt: aPosition

	currentPlayer CanOMove.

	self assertValidPutPosition: aPosition.

	gameState := gameState putOAt: aPosition at: self.	
	currentPlayer := PlayerXTurn new.! !

!TerniLapilli methodsFor: 'operations' stamp: 'Santiago Festini 10/17/2019 16:17:38'!
putXAt: aPosition
	
	currentPlayer CanXMove .
	
	self assertValidPutPosition: aPosition.
	
	gameState := gameState putXAt: aPosition at: self.
	currentPlayer := PlayerOTurn new.
	! !


!TerniLapilli methodsFor: 'private operations' stamp: 'Santiago Festini 10/17/2019 15:47:33'!
safeMoveOFrom: aStartingPosition to: aFinalPosition 

	(board at: aStartingPosition x) at: aStartingPosition y put: #empty.
	(board at: aFinalPosition x) at: aFinalPosition y put: #O.! !

!TerniLapilli methodsFor: 'private operations' stamp: 'Santiago Festini 10/17/2019 15:47:16'!
safeMoveXFrom: aStartingPosition to: aFinalPosition 

	(board at: aStartingPosition x) at: aStartingPosition y put: #empty.
	(board at: aFinalPosition x) at: aFinalPosition y put: #X.! !

!TerniLapilli methodsFor: 'private operations' stamp: 'Santiago Festini 10/17/2019 14:01:54'!
safePutOAt: aPosition

(board at: aPosition  x) at: aPosition y put: #O.
numberOfOPositions := numberOfOPositions + 1.! !

!TerniLapilli methodsFor: 'private operations' stamp: 'Santiago Festini 10/17/2019 13:57:37'!
safePutXAt: aPosition

(board at: aPosition  x) at: aPosition y put: #X.
numberOfXPositions := numberOfXPositions + 1.! !


!TerniLapilli methodsFor: 'assertions' stamp: 'Santiago Festini 10/17/2019 15:38:53'!
assertDistanceIsWithinBoundariesOf: aStartingPosition and: aFinalPosition

	self assertPositionsArentTheSame: aStartingPosition and: aFinalPosition .
	self assertPositionsAreNeighboursOf: aStartingPosition and: aFinalPosition .
	

	! !

!TerniLapilli methodsFor: 'assertions' stamp: 'Santiago Festini 10/17/2019 15:36:23'!
assertMoveIsLegalOf: aStartingPosition and: aFinalPosition 

	self assertDistanceIsWithinBoundariesOf: aStartingPosition and: aFinalPosition .
	self assertMoveIsntProhibitedOf: aStartingPosition and: aFinalPosition .

	! !

!TerniLapilli methodsFor: 'assertions' stamp: 'Santiago Festini 10/17/2019 15:42:00'!
assertMoveIsntProhibitedOf: aStartingPosition and: aFinalPosition 

	((aStartingPosition = (1@2)) and: (aFinalPosition = (2@1))) ifTrue: [self error: (self class) errorInvalidMove ].
	((aStartingPosition = (2@1)) and: (aFinalPosition = (1@2))) ifTrue: [self error: (self class) errorInvalidMove ].
	((aStartingPosition = (1@2)) and: (aFinalPosition = (2@3))) ifTrue: [self error: (self class) errorInvalidMove ].
	((aStartingPosition = (2@3)) and: (aFinalPosition = (1@2))) ifTrue: [self error: (self class) errorInvalidMove ].
	((aStartingPosition = (3@2)) and: (aFinalPosition = (2@1))) ifTrue: [self error: (self class) errorInvalidMove ].
	((aStartingPosition = (3@2)) and: (aFinalPosition = (2@3))) ifTrue: [self error: (self class) errorInvalidMove ].
	((aStartingPosition = (2@1)) and: (aFinalPosition = (3@2))) ifTrue: [self error: (self class) errorInvalidMove ].
	((aStartingPosition = (2@3)) and: (aFinalPosition = (3@2))) ifTrue: [self error: (self class) errorInvalidMove ].! !

!TerniLapilli methodsFor: 'assertions' stamp: 'Santiago Festini 10/17/2019 13:40:31'!
assertPositionInRange: aPosition

	(((aPosition x) between: 1 and: 3) and: ((aPosition y) between: 1 and: 3) ) ifFalse:[self error: (self class) errorPositionNotInRange ].! !

!TerniLapilli methodsFor: 'assertions' stamp: 'Santiago Festini 10/17/2019 15:20:48'!
assertPositionIsEmpty: aPosition.
	((board at: aPosition  x) at: aPosition y) = #empty ifFalse: [self error: (self class) errorOccupiedPosition ].! !

!TerniLapilli methodsFor: 'assertions' stamp: 'Santiago Festini 10/17/2019 15:39:03'!
assertPositionsAreNeighboursOf: aStartingPosition and: aFinalPosition 

	((aStartingPosition dist: aFinalPosition) < 2) ifFalse: [self error: (self class) errorInvalidMove ].
	

	! !

!TerniLapilli methodsFor: 'assertions' stamp: 'Santiago Festini 10/17/2019 15:33:41'!
assertPositionsArentTheSame: startingPosition and: finalPosition

	(startingPosition = finalPosition ) ifTrue: [self error: (self class) errorCantMoveToTheSamePosition].	! !

!TerniLapilli methodsFor: 'assertions' stamp: 'Santiago Festini 10/17/2019 16:20:40'!
assertStartingPositionIsHeldByThePlayer: aStartingPosition

	((board at: aStartingPosition x) at: aStartingPosition y) = (currentPlayer whoIs) ifFalse: [self error: (self class) errorCantMoveAPositionOfAnotherPlayer].! !

!TerniLapilli methodsFor: 'assertions' stamp: 'Santiago Festini 10/17/2019 16:20:41'!
assertValidMovePositionOf: startingPosition to: finalPosition

	self assertPositionInRange: startingPosition.
	self assertPositionInRange: finalPosition.
	self assertMoveIsLegalOf: startingPosition and: finalPosition .
	self assertPositionIsEmpty: finalPosition.
	self assertStartingPositionIsHeldByThePlayer: startingPosition.! !

!TerniLapilli methodsFor: 'assertions' stamp: 'Santiago Festini 10/17/2019 16:16:20'!
assertValidPutPosition: aPosition.

	self assertPositionInRange: aPosition.
	self assertPositionIsEmpty: aPosition.! !


!TerniLapilli methodsFor: 'accessing' stamp: 'mm 10/17/2019 10:02:08'!
numberOfOPositions
	^numberOfOPositions.! !

!TerniLapilli methodsFor: 'accessing' stamp: 'mm 10/17/2019 10:02:00'!
numberOfXPositions
	^numberOfXPositions.! !

!TerniLapilli methodsFor: 'accessing' stamp: 'Santiago Festini 10/16/2019 13:41:44'!
whatIsAt: aPosition

	^(board at: aPosition  x) at: aPosition y! !

"-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- "!

!classDefinition: 'TerniLapilli class' category: #TerniLapilli!
TerniLapilli class
	instanceVariableNames: ''!

!TerniLapilli class methodsFor: 'error messages' stamp: 'Santiago Festini 10/16/2019 15:40:17'!
errorCantMoveAPositionOfAnotherPlayer
	^'The position you are trying to move isnt yours!!'! !

!TerniLapilli class methodsFor: 'error messages' stamp: 'Santiago Festini 10/16/2019 15:53:59'!
errorCantMoveBeforeOwning3Positions
	^'You have to occupy 3 positions first!!'! !

!TerniLapilli class methodsFor: 'error messages' stamp: 'Santiago Festini 10/16/2019 16:31:27'!
errorCantMoveToTheSamePosition
	^'Cant move to the same position!!'! !

!TerniLapilli class methodsFor: 'error messages' stamp: 'Santiago Festini 10/16/2019 16:43:21'!
errorInvalidMove
	^'Thats not a valid move, read the rules again!!'! !

!TerniLapilli class methodsFor: 'error messages' stamp: 'Santiago Festini 10/10/2019 18:36:21'!
errorItsNotYourTurn
	^'Its not your turn!!'! !

!TerniLapilli class methodsFor: 'error messages' stamp: 'Santiago Festini 10/17/2019 15:20:48'!
errorOccupiedPosition
	^'Position is occupied!!'! !

!TerniLapilli class methodsFor: 'error messages' stamp: 'Santiago Festini 10/16/2019 14:11:44'!
errorOnly3PositionsPerPlayer
	^'A player can only hold up to 3 positions at a time!!'! !

!TerniLapilli class methodsFor: 'error messages' stamp: 'Santiago Festini 10/16/2019 16:08:30'!
errorPositionNotInRange
	^'Position is not in range!!'! !

!TerniLapilli class methodsFor: 'error messages' stamp: 'Santiago Festini 10/16/2019 18:13:27'!
errorTheGameIsOver
	^'The game is over so you cant play anymore'.! !


!classDefinition: #TerniLapilliState category: #TerniLapilli!
Object subclass: #TerniLapilliState
	instanceVariableNames: ''
	classVariableNames: ''
	poolDictionaries: ''
	category: 'TerniLapilli'!

!TerniLapilliState methodsFor: 'operations' stamp: 'mm 10/17/2019 09:51:35'!
moveOFrom: startingPosition to: finalPosition at: aTerniLapilli

	self subclassResponsibility.! !

!TerniLapilliState methodsFor: 'operations' stamp: 'mm 10/17/2019 09:51:43'!
moveXFrom: startingPosition to: finalPosition at: aTerniLapilli

	self subclassResponsibility.! !

!TerniLapilliState methodsFor: 'operations' stamp: 'mm 10/17/2019 09:50:53'!
putOAt: aPosition at: aTerniLapilli

	self subclassResponsibility.! !

!TerniLapilliState methodsFor: 'operations' stamp: 'mm 10/17/2019 09:51:17'!
putXAt: aPosition at: aTerniLapilli

	self subclassResponsibility.! !


!classDefinition: #TerniLapilliIsOver category: #TerniLapilli!
TerniLapilliState subclass: #TerniLapilliIsOver
	instanceVariableNames: ''
	classVariableNames: ''
	poolDictionaries: ''
	category: 'TerniLapilli'!

!TerniLapilliIsOver methodsFor: 'operations' stamp: 'mm 10/17/2019 09:52:04'!
moveOFrom: startingPosition to: finalPosition at: aTerniLapilli

	self error: TerniLapilli errorTheGameIsOver.
! !

!TerniLapilliIsOver methodsFor: 'operations' stamp: 'mm 10/17/2019 09:52:17'!
moveXFrom: startingPosition to: finalPosition at: aTerniLapilli
	
	self error: TerniLapilli errorTheGameIsOver.
! !

!TerniLapilliIsOver methodsFor: 'operations' stamp: 'mm 10/17/2019 09:52:26'!
putOAt: aPosition at: aTerniLapilli

	self error: TerniLapilli errorTheGameIsOver.! !

!TerniLapilliIsOver methodsFor: 'operations' stamp: 'mm 10/17/2019 09:52:35'!
putXAt: aPosition at: aTerniLapilli

	self error: TerniLapilli errorTheGameIsOver.! !


!classDefinition: #TerniLapilliMovementState category: #TerniLapilli!
TerniLapilliState subclass: #TerniLapilliMovementState
	instanceVariableNames: ''
	classVariableNames: ''
	poolDictionaries: ''
	category: 'TerniLapilli'!

!TerniLapilliMovementState methodsFor: 'operations' stamp: 'Santiago Festini 10/17/2019 15:48:33'!
moveOFrom: startingPosition to: finalPosition at: aTerniLapilli

	aTerniLapilli safeMoveOFrom: startingPosition to: finalPosition .
	aTerniLapilli isOver ifTrue: [ ^ TerniLapilliIsOver new. ].
! !

!TerniLapilliMovementState methodsFor: 'operations' stamp: 'Santiago Festini 10/17/2019 15:48:22'!
moveXFrom: startingPosition to: finalPosition at: aTerniLapilli

	aTerniLapilli safeMoveXFrom: startingPosition to: finalPosition .
	aTerniLapilli isOver ifTrue: [ ^ TerniLapilliIsOver new. ].
! !

!TerniLapilliMovementState methodsFor: 'operations' stamp: 'mm 10/17/2019 09:59:54'!
putOAt: aPosition at: aTerniLapilli

		self error: TerniLapilli errorOnly3PositionsPerPlayer.
	

! !

!TerniLapilliMovementState methodsFor: 'operations' stamp: 'mm 10/17/2019 10:00:00'!
putXAt: aPosition at: aTerniLapilli

		self error: TerniLapilli errorOnly3PositionsPerPlayer.! !


!classDefinition: #TerniLapilliPuttingState category: #TerniLapilli!
TerniLapilliState subclass: #TerniLapilliPuttingState
	instanceVariableNames: ''
	classVariableNames: ''
	poolDictionaries: ''
	category: 'TerniLapilli'!

!TerniLapilliPuttingState methodsFor: 'operations' stamp: 'mm 10/17/2019 09:53:16'!
moveOFrom: startingPosition to: finalPosition at: aTerniLapilli

	self error: TerniLapilli errorCantMoveBeforeOwning3Positions.! !

!TerniLapilliPuttingState methodsFor: 'operations' stamp: 'Santiago Festini 10/17/2019 15:48:11'!
moveXFrom: startingPosition to: finalPosition at: aTerniLapilli
	
	self error: TerniLapilli errorCantMoveBeforeOwning3Positions.
! !

!TerniLapilliPuttingState methodsFor: 'operations' stamp: 'Santiago Festini 10/17/2019 14:06:57'!
putOAt: aPosition at: aTerniLapilli

	aTerniLapilli safePutOAt: aPosition.
	aTerniLapilli isOver ifTrue: [ ^ TerniLapilliIsOver new. ].
	aTerniLapilli numberOfXPositions = 3 ifTrue: [ ^ TerniLapilliMovementState new ].	
	! !

!TerniLapilliPuttingState methodsFor: 'operations' stamp: 'Santiago Festini 10/17/2019 13:56:56'!
putXAt: aPosition at: aTerniLapilli
	
	aTerniLapilli safePutXAt: aPosition.
	aTerniLapilli isOver ifTrue: [ ^ TerniLapilliIsOver new. ].! !


!classDefinition: #TerniLapilliTurn category: #TerniLapilli!
Object subclass: #TerniLapilliTurn
	instanceVariableNames: ''
	classVariableNames: ''
	poolDictionaries: ''
	category: 'TerniLapilli'!

!TerniLapilliTurn methodsFor: 'testing' stamp: 'Santiago Festini 10/17/2019 16:23:58'!
CanOMove
	self subclassResponsibility ! !

!TerniLapilliTurn methodsFor: 'testing' stamp: 'Santiago Festini 10/17/2019 16:23:55'!
CanXMove
	self subclassResponsibility ! !

!TerniLapilliTurn methodsFor: 'testing' stamp: 'mm 10/17/2019 09:36:05'!
isPlayingO
	self subclassResponsibility ! !

!TerniLapilliTurn methodsFor: 'testing' stamp: 'mm 10/17/2019 09:19:55'!
isPlayingX
	self subclassResponsibility ! !

!TerniLapilliTurn methodsFor: 'testing' stamp: 'Santiago Festini 10/17/2019 16:07:07'!
whoIs
	self subclassResponsibility ! !


!classDefinition: #PlayerOTurn category: #TerniLapilli!
TerniLapilliTurn subclass: #PlayerOTurn
	instanceVariableNames: ''
	classVariableNames: ''
	poolDictionaries: ''
	category: 'TerniLapilli'!

!PlayerOTurn methodsFor: 'testing' stamp: 'mm 10/17/2019 09:39:34'!
CanOMove

	^true.! !

!PlayerOTurn methodsFor: 'testing' stamp: 'mm 10/17/2019 09:24:46'!
CanXMove

	self error: TerniLapilli errorItsNotYourTurn.! !

!PlayerOTurn methodsFor: 'testing' stamp: 'mm 10/17/2019 09:20:38'!
isPlayingO

	^true.! !

!PlayerOTurn methodsFor: 'testing' stamp: 'mm 10/17/2019 09:36:19'!
isPlayingX

	^false.! !

!PlayerOTurn methodsFor: 'testing' stamp: 'Santiago Festini 10/17/2019 16:07:21'!
whoIs

	^#O.! !


!classDefinition: #PlayerXTurn category: #TerniLapilli!
TerniLapilliTurn subclass: #PlayerXTurn
	instanceVariableNames: ''
	classVariableNames: ''
	poolDictionaries: ''
	category: 'TerniLapilli'!

!PlayerXTurn methodsFor: 'testing' stamp: 'mm 10/17/2019 09:24:33'!
CanOMove
	
	self error: TerniLapilli errorItsNotYourTurn.! !

!PlayerXTurn methodsFor: 'testing' stamp: 'mm 10/17/2019 09:39:48'!
CanXMove
	
	^true.! !

!PlayerXTurn methodsFor: 'testing' stamp: 'mm 10/17/2019 09:36:28'!
isPlayingO
	
	^false.! !

!PlayerXTurn methodsFor: 'testing' stamp: 'mm 10/17/2019 09:20:21'!
isPlayingX
	
	^true.! !

!PlayerXTurn methodsFor: 'testing' stamp: 'Santiago Festini 10/17/2019 16:07:34'!
whoIs
	
	^#X.! !
