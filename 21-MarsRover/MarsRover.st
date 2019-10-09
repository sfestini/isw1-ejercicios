!classDefinition: #MarsRoverTest category: #MarsRover!
TestCase subclass: #MarsRoverTest
	instanceVariableNames: 'east south west north'
	classVariableNames: ''
	poolDictionaries: ''
	category: 'MarsRover'!

!MarsRoverTest methodsFor: 'assertions' stamp: 'Santiago Festini 10/9/2019 17:38:31'!
rover: aRover isAt: aPosition withDirection: aDirection 
	
	self assert: aRover position equals: aPosition.
	self assert: ((aRover direction) = aDirection).! !


!MarsRoverTest methodsFor: 'testing' stamp: 'Santiago Festini 10/9/2019 17:39:25'!
test01DoNothingAndNothingChange
	|marsRover|	

	marsRover := MarsRover at: 0@0 withDirection: #North.
	
	marsRover do: ''.
	
	self rover: marsRover isAt: 0@0 withDirection: north. 
! !

!MarsRoverTest methodsFor: 'testing' stamp: 'Santiago Festini 10/9/2019 17:39:49'!
test02MoveFowardOnceAdvanceOnce
	|marsRover|	

	marsRover := MarsRover at: 0@0 withDirection: #North.
	
	marsRover do: 'f'.
	
	self rover: marsRover isAt: 0@1 withDirection: north.
! !

!MarsRoverTest methodsFor: 'testing' stamp: 'Santiago Festini 10/9/2019 17:40:07'!
test03MoveFowardManyTimesAdvanceManyTimes
	|marsRover|	

	marsRover := MarsRover at: 0@0 withDirection: #North.
	
	marsRover do: 'fff'.
	
	self rover: marsRover isAt: 0@3 withDirection: north.
! !

!MarsRoverTest methodsFor: 'testing' stamp: 'Santiago Festini 10/9/2019 17:40:28'!
test04MoveBackwardsOnceGoBackOnce
	|marsRover|	

	marsRover := MarsRover at: 0@0 withDirection: #North.
	
	marsRover do: 'b'.
	
	self rover: marsRover isAt: 0@-1 withDirection: north.
! !

!MarsRoverTest methodsFor: 'testing' stamp: 'Santiago Festini 10/9/2019 17:40:50'!
test05MoveBackwardsManyTimesGoBackManyTimes
"Preguntar si hay que borrar test, porque lo hicimos y paso de una"
	|marsRover|	

	marsRover := MarsRover at: 0@0 withDirection: #North.
	
	marsRover do: 'bbb'.
	
	self rover: marsRover isAt: 0@-3 withDirection: north.
! !

!MarsRoverTest methodsFor: 'testing' stamp: 'Santiago Festini 10/9/2019 17:41:08'!
test06TurnRightOnceChangesDirection

	|marsRover|	

	marsRover := MarsRover at: 0@0 withDirection: #North.
	
	marsRover do: 'r'.
	
	self rover: marsRover isAt: 0@0 withDirection: east.
! !

!MarsRoverTest methodsFor: 'testing' stamp: 'Santiago Festini 10/9/2019 17:41:30'!
test07TurnRightManyTimesChangesDirectionManyTimes

	|marsRover|	

	marsRover := MarsRover at: 0@0 withDirection: #North.
	
	marsRover do: 'rrr'.
	
	self rover: marsRover isAt: 0@0 withDirection: west.
! !

!MarsRoverTest methodsFor: 'testing' stamp: 'Santiago Festini 10/9/2019 17:41:49'!
test08TurnLeftOnceChangesDirection

	|marsRover|	

	marsRover := MarsRover at: 0@0 withDirection: #North.
	
	marsRover do: 'l'.
	
	self rover: marsRover isAt: 0@0 withDirection: west.
! !

!MarsRoverTest methodsFor: 'testing' stamp: 'Santiago Festini 10/9/2019 17:42:08'!
test09TurnLeftManyTimesChangesDirection

	|marsRover|	

	marsRover := MarsRover at: 0@0 withDirection: #North.
	
	marsRover do: 'lll'.
	
	self rover: marsRover isAt: 0@0 withDirection: east.
! !

!MarsRoverTest methodsFor: 'testing' stamp: 'Santiago Festini 10/9/2019 17:42:30'!
test10TurnCompleteLeft

	|marsRover|	

	marsRover := MarsRover at: 0@0 withDirection: #North.
	
	marsRover do: 'llll'.
	
	self rover: marsRover isAt: 0@0 withDirection: north.
! !

!MarsRoverTest methodsFor: 'testing' stamp: 'Santiago Festini 10/9/2019 17:43:01'!
test11TurnCompleteRight
	|marsRover|	

	marsRover := MarsRover at: 0@0 withDirection: #North.
	
	marsRover do: 'rrrr'.
	
	self rover: marsRover isAt: 0@0 withDirection: north.! !

!MarsRoverTest methodsFor: 'testing' stamp: 'Santiago Festini 10/9/2019 17:43:17'!
test12DirectionEastAndMoveForward

	|marsRover|	

	marsRover := MarsRover at: 0@0 withDirection: #East.
	
	marsRover do: 'f'.
	
	self rover: marsRover isAt: 1@0 withDirection: east.! !

!MarsRoverTest methodsFor: 'testing' stamp: 'Santiago Festini 10/9/2019 17:43:45'!
test13DirectionSouthAndMoveForward

	|marsRover|	

	marsRover := MarsRover at: 0@0 withDirection: #South.
	
	marsRover do: 'f'.
	
	self rover: marsRover isAt: 0@-1 withDirection: south.! !

!MarsRoverTest methodsFor: 'testing' stamp: 'Santiago Festini 10/9/2019 17:44:05'!
test14DirectionWestAndMoveForward

	|marsRover|	

	marsRover := MarsRover at: 0@0 withDirection: #West.
	
	marsRover do: 'f'.
	
	self rover: marsRover isAt: -1@0 withDirection: west.! !

!MarsRoverTest methodsFor: 'testing' stamp: 'Santiago Festini 10/9/2019 17:44:21'!
test15DirectionWestAndMoveBackward

	|marsRover|	

	marsRover := MarsRover at: 0@0 withDirection: #West.
	
	marsRover do: 'b'.
	
	self rover: marsRover isAt: 1@0 withDirection: west.! !

!MarsRoverTest methodsFor: 'testing' stamp: 'Santiago Festini 10/9/2019 17:44:37'!
test16DirectionSouthtAndMoveBackward

	|marsRover|	

	marsRover := MarsRover at: 0@0 withDirection: #South.
	
	marsRover do: 'b'.
	
	self rover: marsRover isAt: 0@1 withDirection: south.! !

!MarsRoverTest methodsFor: 'testing' stamp: 'Santiago Festini 10/9/2019 17:44:52'!
test17DirectionEasttAndMoveBackward

	|marsRover|	

	marsRover := MarsRover at: 0@0 withDirection: #East.
	
	marsRover do: 'b'.
	
	self rover: marsRover isAt: -1@0 withDirection: east.! !

!MarsRoverTest methodsFor: 'testing' stamp: 'Santiago Festini 10/9/2019 17:45:08'!
test18MultipleInstructions

	|marsRover|	

	marsRover := MarsRover at: 0@0 withDirection: #East.
	
	marsRover do: 'b'.
	
	self rover: marsRover isAt: -1@0 withDirection: east.! !


!MarsRoverTest methodsFor: 'setUp' stamp: 'Santiago Festini 10/9/2019 16:32:50'!
setUp

	east := CardinalPoint newWith: #East.
	west := CardinalPoint newWith: #West .
	north := CardinalPoint newWith: #North.
	south := South newWith: #South.! !


!classDefinition: #CardinalPoint category: #MarsRover!
Object subclass: #CardinalPoint
	instanceVariableNames: ''
	classVariableNames: ''
	poolDictionaries: ''
	category: 'MarsRover'!

!CardinalPoint methodsFor: 'accessing' stamp: 'Santiago Festini 10/9/2019 16:38:57'!
absolutePosition
	self subclassResponsibility ! !

!CardinalPoint methodsFor: 'accessing' stamp: 'Santiago Festini 10/9/2019 16:36:55'!
leftCardinalPoint
	self subclassResponsibility ! !

!CardinalPoint methodsFor: 'accessing' stamp: 'Santiago Festini 10/9/2019 16:37:15'!
rightCardinalPoint
	self subclassResponsibility ! !

"-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- "!

!classDefinition: 'CardinalPoint class' category: #MarsRover!
CardinalPoint class
	instanceVariableNames: ''!

!CardinalPoint class methodsFor: 'initialization' stamp: 'Santiago Festini 10/7/2019 15:26:55'!
newWith: aDirection
	(aDirection = #North) ifTrue: [^ North new.].
	(aDirection = #East) ifTrue: [^ East new.].
	(aDirection = #West) ifTrue: [^ West new.].
	(aDirection = #South) ifTrue: [^ South new.].! !


!classDefinition: #East category: #MarsRover!
CardinalPoint subclass: #East
	instanceVariableNames: ''
	classVariableNames: ''
	poolDictionaries: ''
	category: 'MarsRover'!

!East methodsFor: 'accessing' stamp: 'Santiago Festini 10/9/2019 16:36:14'!
absolutePosition
	^1@0! !

!East methodsFor: 'accessing' stamp: 'Santiago Festini 10/9/2019 16:36:55'!
leftCardinalPoint
	^North new.! !

!East methodsFor: 'accessing' stamp: 'Santiago Festini 10/9/2019 16:37:15'!
rightCardinalPoint
	^South new.! !

"-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- "!

!classDefinition: 'East class' category: #MarsRover!
East class
	instanceVariableNames: 'uniqueInstance'!

!East class methodsFor: 'class initialization' stamp: 'Santiago Festini 10/9/2019 16:55:56'!
initialize

	uniqueInstance := self basicNew .! !


!East class methodsFor: 'initialization' stamp: 'Santiago Festini 10/9/2019 16:56:36'!
new

	^ uniqueInstance .! !


!classDefinition: #North category: #MarsRover!
CardinalPoint subclass: #North
	instanceVariableNames: ''
	classVariableNames: ''
	poolDictionaries: ''
	category: 'MarsRover'!

!North methodsFor: 'accessing' stamp: 'Santiago Festini 10/9/2019 16:37:47'!
absolutePosition

	^0@1.! !

!North methodsFor: 'accessing' stamp: 'Santiago Festini 10/9/2019 16:36:55'!
leftCardinalPoint
	^West new.! !

!North methodsFor: 'accessing' stamp: 'Santiago Festini 10/9/2019 16:37:15'!
rightCardinalPoint
	^East new.! !

"-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- "!

!classDefinition: 'North class' category: #MarsRover!
North class
	instanceVariableNames: 'uniqueInstance'!

!North class methodsFor: 'class initialization' stamp: 'Santiago Festini 10/9/2019 16:56:06'!
initialize

	uniqueInstance := self basicNew .! !


!North class methodsFor: 'initialization' stamp: 'Santiago Festini 10/9/2019 16:56:42'!
new

	^ uniqueInstance .! !


!classDefinition: #South category: #MarsRover!
CardinalPoint subclass: #South
	instanceVariableNames: ''
	classVariableNames: ''
	poolDictionaries: ''
	category: 'MarsRover'!

!South methodsFor: 'accessing' stamp: 'Santiago Festini 10/9/2019 16:38:17'!
absolutePosition

	^0@-1.! !

!South methodsFor: 'accessing' stamp: 'Santiago Festini 10/9/2019 16:36:55'!
leftCardinalPoint
	^East new.! !

!South methodsFor: 'accessing' stamp: 'Santiago Festini 10/9/2019 16:37:15'!
rightCardinalPoint
	^West new.! !

"-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- "!

!classDefinition: 'South class' category: #MarsRover!
South class
	instanceVariableNames: 'uniqueInstance'!

!South class methodsFor: 'initialization' stamp: 'Santiago Festini 10/9/2019 16:56:46'!
new

	^ uniqueInstance .! !


!South class methodsFor: 'class initialization' stamp: 'Santiago Festini 10/9/2019 16:56:10'!
initialize

	uniqueInstance := self basicNew .! !


!classDefinition: #West category: #MarsRover!
CardinalPoint subclass: #West
	instanceVariableNames: ''
	classVariableNames: ''
	poolDictionaries: ''
	category: 'MarsRover'!

!West methodsFor: 'accessing' stamp: 'Santiago Festini 10/9/2019 16:38:39'!
absolutePosition

	^-1@0.! !

!West methodsFor: 'accessing' stamp: 'Santiago Festini 10/9/2019 16:36:55'!
leftCardinalPoint
	^South new.! !

!West methodsFor: 'accessing' stamp: 'Santiago Festini 10/9/2019 16:37:15'!
rightCardinalPoint
	^North new.! !

"-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- "!

!classDefinition: 'West class' category: #MarsRover!
West class
	instanceVariableNames: 'uniqueInstance'!

!West class methodsFor: 'class initialization' stamp: 'Santiago Festini 10/9/2019 16:56:14'!
initialize

	uniqueInstance := self basicNew .! !


!West class methodsFor: 'initialization' stamp: 'Santiago Festini 10/9/2019 16:56:50'!
new

	^ uniqueInstance .! !


!classDefinition: #MarsRover category: #MarsRover!
Object subclass: #MarsRover
	instanceVariableNames: 'position direction'
	classVariableNames: ''
	poolDictionaries: ''
	category: 'MarsRover'!

!MarsRover methodsFor: 'accessing' stamp: 'Santiago Festini 10/3/2019 21:13:38'!
direction
	^direction .! !

!MarsRover methodsFor: 'accessing' stamp: 'Santiago Festini 10/3/2019 21:13:53'!
position
	^position.! !


!MarsRover methodsFor: 'initialization' stamp: 'Santiago Festini 10/9/2019 16:32:50'!
initializeWith: aPosition and: aDirection
	position := aPosition.
	direction := CardinalPoint newWith: aDirection .! !


!MarsRover methodsFor: 'operations' stamp: 'Santiago Festini 10/9/2019 16:40:24'!
do: aSetOfInstructions
	
	aSetOfInstructions do: [:instruction | (instruction = $f) ifTrue: [ position := position + direction absolutePosition ].															
										  (instruction = $b) ifTrue: [ position := position - direction absolutePosition ].																
										  (instruction = $r) ifTrue: [direction := direction rightCardinalPoint].
										  (instruction = $l) ifTrue: [direction := direction leftCardinalPoint].
										].! !

"-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- "!

!classDefinition: 'MarsRover class' category: #MarsRover!
MarsRover class
	instanceVariableNames: ''!

!MarsRover class methodsFor: 'initialization' stamp: 'Santiago Festini 10/3/2019 21:11:10'!
at: aPoint withDirection: aDirection
	^ self new initializeWith: aPoint and: aDirection.! !

East initialize!
North initialize!
South initialize!
West initialize!