!classDefinition: #MarsRoverTest category: #MarsRover!
TestCase subclass: #MarsRoverTest
	instanceVariableNames: ''
	classVariableNames: ''
	poolDictionaries: ''
	category: 'MarsRover'!

!MarsRoverTest methodsFor: 'as yet unclassified' stamp: 'Santiago Festini 10/3/2019 21:03:13'!
test01DoNothingAndNothingChange
	|marsRover|	

	marsRover := MarsRover at: 0@0 withDirection: #North.
	
	marsRover do: ''.
	
	self assert: marsRover position equals: 0@0.
	self assert: marsRover direction equals: #North.! !

!MarsRoverTest methodsFor: 'as yet unclassified' stamp: 'Santiago Festini 10/3/2019 21:05:59'!
test02MoveFowardOnceAdvanceOnce
	|marsRover|	

	marsRover := MarsRover at: 0@0 withDirection: #North.
	
	marsRover do: 'f'.
	
	self assert: marsRover position equals: 0@1.  
	self assert: marsRover direction equals: #North.! !

!MarsRoverTest methodsFor: 'as yet unclassified' stamp: 'Santiago Festini 10/3/2019 21:25:22'!
test03MoveFowardManyTimesAdvanceManyTimes
	|marsRover|	

	marsRover := MarsRover at: 0@0 withDirection: #North.
	
	marsRover do: 'fff'.
	
	self assert: marsRover position equals: 0@3.
	self assert: marsRover direction equals: #North.  ! !


!classDefinition: #MarsRover category: #MarsRover!
Object subclass: #MarsRover
	instanceVariableNames: 'position direction'
	classVariableNames: ''
	poolDictionaries: ''
	category: 'MarsRover'!

!MarsRover methodsFor: 'as yet unclassified' stamp: 'Santiago Festini 10/3/2019 21:13:38'!
direction
	^direction .! !

!MarsRover methodsFor: 'as yet unclassified' stamp: 'Santiago Festini 10/3/2019 21:37:12'!
do: aSetOfInstructions
	
	aSetOfInstructions do: [:instruction | (instruction = $f) ifTrue: [position := position + (0@1)]].! !

!MarsRover methodsFor: 'as yet unclassified' stamp: 'Santiago Festini 10/3/2019 21:11:02'!
initializeWith: aPosition and: aDirection
	position := aPosition.
	direction := aDirection.! !

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
