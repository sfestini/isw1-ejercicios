!classDefinition: #MarsRoverTest category: #MarsRover!
TestCase subclass: #MarsRoverTest
	instanceVariableNames: 'east south west north'
	classVariableNames: ''
	poolDictionaries: ''
	category: 'MarsRover'!

!MarsRoverTest methodsFor: 'as yet unclassified' stamp: 'Santiago Festini 10/7/2019 15:42:52'!
setUp

	east := Direction newWith: #East.
	west := Direction newWith: #West .
	north := Direction newWith: #North.
	south := South newWith: #South.! !

!MarsRoverTest methodsFor: 'as yet unclassified' stamp: 'Santiago Festini 10/7/2019 15:44:14'!
test01DoNothingAndNothingChange
	|marsRover|	

	marsRover := MarsRover at: 0@0 withDirection: #North.
	
	marsRover do: ''.
	
	self assert: marsRover position equals: 0@0.
	self assert: ((marsRover direction) isKindOf: (north class)).! !

!MarsRoverTest methodsFor: 'as yet unclassified' stamp: 'Santiago Festini 10/7/2019 15:44:42'!
test02MoveFowardOnceAdvanceOnce
	|marsRover|	

	marsRover := MarsRover at: 0@0 withDirection: #North.
	
	marsRover do: 'f'.
	
	self assert: marsRover position equals: 0@1.  
	self assert: ((marsRover direction) isKindOf: (north class)).! !

!MarsRoverTest methodsFor: 'as yet unclassified' stamp: 'Santiago Festini 10/7/2019 15:44:48'!
test03MoveFowardManyTimesAdvanceManyTimes
	|marsRover|	

	marsRover := MarsRover at: 0@0 withDirection: #North.
	
	marsRover do: 'fff'.
	
	self assert: marsRover position equals: 0@3.
	self assert: ((marsRover direction) isKindOf: (north class)).! !

!MarsRoverTest methodsFor: 'as yet unclassified' stamp: 'Santiago Festini 10/7/2019 15:44:53'!
test04MoveBackwardsOnceGoBackOnce
	|marsRover|	

	marsRover := MarsRover at: 0@0 withDirection: #North.
	
	marsRover do: 'b'.
	
	self assert: marsRover position equals: 0@-1.  
	self assert: ((marsRover direction) isKindOf: (north class)).! !

!MarsRoverTest methodsFor: 'as yet unclassified' stamp: 'Santiago Festini 10/7/2019 15:45:02'!
test05MoveBackwardsManyTimesGoBackManyTimes
"Preguntar si hay que borrar test, porque lo hicimos y paso de una"
	|marsRover|	

	marsRover := MarsRover at: 0@0 withDirection: #North.
	
	marsRover do: 'bbb'.
	
	self assert: marsRover position equals: 0@-3.
	self assert: ((marsRover direction) isKindOf: (north class)).! !

!MarsRoverTest methodsFor: 'as yet unclassified' stamp: 'Santiago Festini 10/7/2019 15:55:13'!
test06TurnRightOnceChangesDirection

	|marsRover|	

	marsRover := MarsRover at: 0@0 withDirection: #North.
	
	marsRover do: 'r'.
	
	self assert: marsRover position equals: 0@0.
	self assert: ((marsRover direction) isKindOf: (east class)).! !

!MarsRoverTest methodsFor: 'as yet unclassified' stamp: 'Santiago Festini 10/7/2019 15:55:25'!
test07TurnRightManyTimesChangesDirectionManyTimes

	|marsRover|	

	marsRover := MarsRover at: 0@0 withDirection: #North.
	
	marsRover do: 'rrr'.
	
	self assert: marsRover position equals: 0@0.
	self assert: ((marsRover direction) isKindOf: (west class)).! !

!MarsRoverTest methodsFor: 'as yet unclassified' stamp: 'Santiago Festini 10/7/2019 15:54:23'!
test08TurnLeftOnceChangesDirection

	|marsRover|	

	marsRover := MarsRover at: 0@0 withDirection: #North.
	
	marsRover do: 'l'.
	
	self assert: marsRover position equals: 0@0.
	self assert: ((marsRover direction) isKindOf: (west class)).! !

!MarsRoverTest methodsFor: 'as yet unclassified' stamp: 'Santiago Festini 10/7/2019 16:24:21'!
test09TurnLeftManyTimesChangesDirection

	|marsRover|	

	marsRover := MarsRover at: 0@0 withDirection: #North.
	
	marsRover do: 'lll'.
	
	self assert: marsRover position equals: 0@0.
	self assert: ((marsRover direction) isKindOf: (east class)).! !

!MarsRoverTest methodsFor: 'as yet unclassified' stamp: 'Santiago Festini 10/7/2019 16:26:23'!
test10TurnCompleteLeft

	|marsRover|	

	marsRover := MarsRover at: 0@0 withDirection: #North.
	
	marsRover do: 'llll'.
	
	self assert: marsRover position equals: 0@0.
	self assert: ((marsRover direction) isKindOf: (north class)).! !

!MarsRoverTest methodsFor: 'as yet unclassified' stamp: 'Santiago Festini 10/7/2019 16:29:21'!
test11TurnCompleteRight
	|marsRover|	

	marsRover := MarsRover at: 0@0 withDirection: #North.
	
	marsRover do: 'rrrr'.
	
	self assert: marsRover position equals: 0@0.
	self assert: ((marsRover direction) isKindOf: (north class)).! !

!MarsRoverTest methodsFor: 'as yet unclassified' stamp: 'Santiago Festini 10/7/2019 16:30:14'!
test12ManyDifferentInstructions
	"No hacemos mas TDD, testeamos la funcionalidad"

	|marsRover|	

	marsRover := MarsRover at: 0@0 withDirection: #North.
	
	marsRover do: 'frbflblr'.
	
	self assert: marsRover position equals: 0@0.
	self assert: ((marsRover direction) isKindOf: (north class)).! !


!classDefinition: #Direction category: #MarsRover!
Object subclass: #Direction
	instanceVariableNames: ''
	classVariableNames: ''
	poolDictionaries: ''
	category: 'MarsRover'!

!Direction methodsFor: 'as yet unclassified' stamp: 'Santiago Festini 10/7/2019 15:17:09'!
turnLeft
	self subclassResponsibility ! !

!Direction methodsFor: 'as yet unclassified' stamp: 'Santiago Festini 10/7/2019 15:17:16'!
turnRight
	self subclassResponsibility ! !

"-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- "!

!classDefinition: 'Direction class' category: #MarsRover!
Direction class
	instanceVariableNames: ''!

!Direction class methodsFor: 'as yet unclassified' stamp: 'Santiago Festini 10/7/2019 15:26:55'!
newWith: aDirection
	(aDirection = #North) ifTrue: [^ North new.].
	(aDirection = #East) ifTrue: [^ East new.].
	(aDirection = #West) ifTrue: [^ West new.].
	(aDirection = #South) ifTrue: [^ South new.].! !


!classDefinition: #East category: #MarsRover!
Direction subclass: #East
	instanceVariableNames: ''
	classVariableNames: ''
	poolDictionaries: ''
	category: 'MarsRover'!

!East methodsFor: 'as yet unclassified' stamp: 'Santiago Festini 10/7/2019 15:18:40'!
turnLeft
	^North new.! !

!East methodsFor: 'as yet unclassified' stamp: 'Santiago Festini 10/7/2019 15:18:50'!
turnRight
	^South new.! !


!classDefinition: #North category: #MarsRover!
Direction subclass: #North
	instanceVariableNames: ''
	classVariableNames: ''
	poolDictionaries: ''
	category: 'MarsRover'!

!North methodsFor: 'as yet unclassified' stamp: 'Santiago Festini 10/7/2019 15:19:13'!
turnLeft
	^West new.! !

!North methodsFor: 'as yet unclassified' stamp: 'Santiago Festini 10/7/2019 15:19:22'!
turnRight
	^East new.! !


!classDefinition: #South category: #MarsRover!
Direction subclass: #South
	instanceVariableNames: ''
	classVariableNames: ''
	poolDictionaries: ''
	category: 'MarsRover'!

!South methodsFor: 'as yet unclassified' stamp: 'Santiago Festini 10/7/2019 15:19:41'!
turnLeft
	^East new.! !

!South methodsFor: 'as yet unclassified' stamp: 'Santiago Festini 10/7/2019 15:19:52'!
turnRight
	^West new.! !


!classDefinition: #West category: #MarsRover!
Direction subclass: #West
	instanceVariableNames: ''
	classVariableNames: ''
	poolDictionaries: ''
	category: 'MarsRover'!

!West methodsFor: 'as yet unclassified' stamp: 'Santiago Festini 10/7/2019 15:20:02'!
turnLeft
	^South new.! !

!West methodsFor: 'as yet unclassified' stamp: 'Santiago Festini 10/7/2019 15:20:19'!
turnRight
	^North new.! !


!classDefinition: #MarsRover category: #MarsRover!
Object subclass: #MarsRover
	instanceVariableNames: 'position direction'
	classVariableNames: ''
	poolDictionaries: ''
	category: 'MarsRover'!

!MarsRover methodsFor: 'as yet unclassified' stamp: 'Santiago Festini 10/3/2019 21:13:38'!
direction
	^direction .! !

!MarsRover methodsFor: 'as yet unclassified' stamp: 'Santiago Festini 10/7/2019 15:50:11'!
do: aSetOfInstructions
	
	aSetOfInstructions do: [:instruction | (instruction = $f) ifTrue: [position := position + (0@1)] .
										  (instruction = $b) ifTrue: [position := position + (0@-1)] .
										  (instruction = $r) ifTrue: [direction := direction turnRight].
										  (instruction = $l) ifTrue: [direction := direction turnLeft].
										].! !

!MarsRover methodsFor: 'as yet unclassified' stamp: 'Santiago Festini 10/7/2019 15:23:46'!
initializeWith: aPosition and: aDirection
	position := aPosition.
	direction := Direction newWith: aDirection .! !

!MarsRover methodsFor: 'as yet unclassified' stamp: 'Santiago Festini 10/3/2019 21:13:53'!
position
	^position.! !

"-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- "!

!classDefinition: 'MarsRover class' category: #MarsRover!
MarsRover class
	instanceVariableNames: ''!

!MarsRover class methodsFor: 'as yet unclassified' stamp: 'Santiago Festini 10/3/2019 21:11:10'!
at: aPoint withDirection: aDirection
	^ self new initializeWith: aPoint and: aDirection.! !
