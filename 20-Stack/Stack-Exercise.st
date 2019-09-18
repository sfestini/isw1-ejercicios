!classDefinition: #OOStackTest category: #'Stack-Exercise'!
TestCase subclass: #OOStackTest
	instanceVariableNames: ''
	classVariableNames: ''
	poolDictionaries: ''
	category: 'Stack-Exercise'!

!OOStackTest methodsFor: 'test' stamp: 'HernanWilkinson 5/7/2012 11:30'!
test01StackShouldBeEmptyWhenCreated

	| stack |
	
	stack := OOStack new.
	
	self assert: stack isEmpty! !

!OOStackTest methodsFor: 'test' stamp: 'HernanWilkinson 5/7/2012 11:30'!
test02PushAddElementsToTheStack

	| stack |
	
	stack := OOStack new.
	stack push: 'Something'.
	
	self deny: stack isEmpty! !

!OOStackTest methodsFor: 'test' stamp: 'HernanWilkinson 5/7/2012 11:31'!
test03PopRemovesElementsFromTheStack

	| stack |
	
	stack := OOStack new.
	stack push: 'Something'.
	stack pop.
	
	self assert: stack isEmpty! !

!OOStackTest methodsFor: 'test' stamp: 'HernanWilkinson 5/8/2012 08:20'!
test04PopReturnsLastPushedObject

	| stack pushedObject |
	
	stack := OOStack new.
	pushedObject := 'Something'.
	stack push: pushedObject.
	
	self assert: stack pop = pushedObject! !

!OOStackTest methodsFor: 'test' stamp: 'HernanWilkinson 5/7/2012 11:33'!
test05StackBehavesLIFO

	| stack firstPushedObject secondPushedObject |
	
	stack := OOStack new.
	firstPushedObject := 'First'.
	secondPushedObject := 'Second'.
	
	stack push: firstPushedObject.
	stack push: secondPushedObject.
	
	self assert: stack pop = secondPushedObject.
	self assert: stack pop = firstPushedObject.
	self assert: stack isEmpty 
	! !

!OOStackTest methodsFor: 'test' stamp: 'HernanWilkinson 5/7/2012 11:35'!
test06TopReturnsLastPushedObject

	| stack pushedObject |
	
	stack := OOStack new.
	pushedObject := 'Something'.
	
	stack push: pushedObject.
	
	self assert: stack top = pushedObject.
	! !

!OOStackTest methodsFor: 'test' stamp: 'HernanWilkinson 5/7/2012 11:36'!
test07TopDoesNotRemoveObjectFromStack

	| stack pushedObject |
	
	stack := OOStack new.
	pushedObject := 'Something'.
	
	stack push: pushedObject.
	
	self assert: stack size = 1.
	stack top.
	self assert: stack size = 1.
	! !

!OOStackTest methodsFor: 'test' stamp: 'HAW 4/14/2017 22:48:26'!
test08CanNotPopWhenThereAreNoObjectsInTheStack

	| stack  |
	
	stack := OOStack new.
	self
		should: [ stack pop ]
		raise: Error - MessageNotUnderstood 
		withExceptionDo: [ :anError |
			self assert: anError messageText = OOStack stackEmptyErrorDescription ]
		
! !

!OOStackTest methodsFor: 'test' stamp: 'HAW 4/14/2017 22:48:36'!
test09CanNotPopWhenThereAreNoObjectsInTheStackAndTheStackHadObjects

	| stack  |
	
	stack := OOStack new.
	stack push: 'Something'.
	stack pop.
	
	self
		should: [ stack pop ]
		raise: Error - MessageNotUnderstood 
		withExceptionDo: [ :anError |
			self assert: anError messageText = OOStack stackEmptyErrorDescription ]
		
! !

!OOStackTest methodsFor: 'test' stamp: 'HAW 4/14/2017 22:48:44'!
test10CanNotTopWhenThereAreNoObjectsInTheStack

	| stack  |
	
	stack := OOStack new.
	self
		should: [ stack top ]
		raise: Error - MessageNotUnderstood 
		withExceptionDo: [ :anError |
			self assert: anError messageText = OOStack stackEmptyErrorDescription ]
		
! !


!classDefinition: #SentenceFinderByPrefixTest category: #'Stack-Exercise'!
TestCase subclass: #SentenceFinderByPrefixTest
	instanceVariableNames: 'sentenceFinder1 sentenceFinder2'
	classVariableNames: ''
	poolDictionaries: ''
	category: 'Stack-Exercise'!

!SentenceFinderByPrefixTest methodsFor: 'setup' stamp: 'Santiago Festini 9/18/2019 16:50:41'!
setUp
	| stack stack2 |
	
	stack := OOStack new.
	stack2 := OOStack new.
	
	stack push: 'hola'.
	stack push: 'Hola'.
	stack push: 'h ola'.
	stack push: ' hola'.
	stack push: 'holA '.
	stack push: 'nose hola'.
	stack push: 'holaa'.
	stack push: 'hola CHAU'.
		
	sentenceFinder1 := SentenceFinderByPrefix new initializeWith: stack.
	
	stack2 push: 'hola'.
	stack2 push: 'Hola'.
	stack2 push: 'h ola'.
	stack2 push: ' hola'.
	
	sentenceFinder2 := SentenceFinderByPrefix new initializeWith: stack2.! !


!SentenceFinderByPrefixTest methodsFor: 'testing' stamp: 'Santiago Festini 9/18/2019 16:47:26'!
test01PrefixShouldNotBeEmpty
	
		self
		should: [ sentenceFinder1 find: '' ]
		raise: Error - MessageNotUnderstood 
		withExceptionDo: [ :anError |
			self assert: anError messageText = SentenceFinderByPrefix prefixEmptyErrorDescription ]! !

!SentenceFinderByPrefixTest methodsFor: 'testing' stamp: 'Santiago Festini 9/18/2019 16:47:31'!
test02PrefixShouldNotContainEmptySpaces
	
		self
		should: [ sentenceFinder1 find: 'ho ' ]
		raise: Error - MessageNotUnderstood 
		withExceptionDo: [ :anError |
			self assert: anError messageText = SentenceFinderByPrefix prefixWithEmptySpacesErrorDescription]! !

!SentenceFinderByPrefixTest methodsFor: 'testing' stamp: 'Santiago Festini 9/18/2019 16:47:38'!
test03FinderIsCaseSensitive

	| wordsFound |
	
	wordsFound := sentenceFinder1 find: 'HOLa'.

	self assert: (wordsFound = OrderedCollection new initialize ).	
	
		! !

!SentenceFinderByPrefixTest methodsFor: 'testing' stamp: 'Santiago Festini 9/18/2019 16:47:44'!
test04FindsTheRightPrefixes

	| wordsFound  rightAnwser|
	
	wordsFound := sentenceFinder1 find: 'hola'.
	rightAnwser := OrderedCollection new initialize.
	rightAnwser add: 'hola'.
	rightAnwser add: 'holaa'.
	rightAnwser add: 'hola CHAU'.
	
	self assert: (wordsFound = rightAnwser ).	
	
		! !

!SentenceFinderByPrefixTest methodsFor: 'testing' stamp: 'Santiago Festini 9/18/2019 16:47:11'!
test05FindsDoesNotChangeStackOrder

	|  element1 element2 element3 element4 |
	
	
	sentenceFinder2 find: 'hola'.
	
	element1  := (sentenceFinder2 stack) pop.
	element2  := (sentenceFinder2 stack) pop.
	element3  := (sentenceFinder2 stack) pop.
	element4  := (sentenceFinder2 stack) pop.	

	self assert: (element4 = 'hola').
	self assert: (element3 = 'Hola').
	self assert: (element2 = 'h ola').
	self assert: (element1 = ' hola').	
	
		! !


!classDefinition: #OOStack category: #'Stack-Exercise'!
Object subclass: #OOStack
	instanceVariableNames: 'topElement size'
	classVariableNames: ''
	poolDictionaries: ''
	category: 'Stack-Exercise'!

!OOStack methodsFor: 'testing' stamp: 'Santiago Festini 9/16/2019 20:35:14'!
isEmpty
	^size = 0 .! !


!OOStack methodsFor: 'stack operations' stamp: 'Santiago Festini 9/16/2019 20:50:12'!
pop
	
	| nextTop prevTop |
	
	nextTop := topElement nextElement .
	prevTop := topElement .
	size := size - 1.
	topElement := nextTop.
	^ prevTop value.! !

!OOStack methodsFor: 'stack operations' stamp: 'Santiago Festini 9/16/2019 21:00:39'!
push: anString
	
	topElement := ElementWithValue new initializeWith: anString andAfter: topElement.
	size := size + 1.! !


!OOStack methodsFor: 'getters' stamp: 'Santiago Festini 9/16/2019 20:36:02'!
size
	^size
					! !

!OOStack methodsFor: 'getters' stamp: 'Santiago Festini 9/16/2019 21:02:19'!
top
	^topElement value.! !


!OOStack methodsFor: 'initialization' stamp: 'Santiago Festini 9/16/2019 20:58:34'!
initialize
	size := 0.
	topElement := EmptyElement new.! !

"-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- "!

!classDefinition: 'OOStack class' category: #'Stack-Exercise'!
OOStack class
	instanceVariableNames: ''!

!OOStack class methodsFor: 'error descriptions' stamp: 'Santiago Festini 9/16/2019 19:31:25'!
create
	^self new initialize
	! !

!OOStack class methodsFor: 'error descriptions' stamp: 'HernanWilkinson 5/7/2012 11:51'!
stackEmptyErrorDescription
	
	^ 'Stack is empty'! !


!classDefinition: #SentenceFinderByPrefix category: #'Stack-Exercise'!
Object subclass: #SentenceFinderByPrefix
	instanceVariableNames: 'stack'
	classVariableNames: ''
	poolDictionaries: ''
	category: 'Stack-Exercise'!

!SentenceFinderByPrefix methodsFor: 'getters' stamp: 'Santiago Festini 9/18/2019 16:15:32'!
stack
	^stack! !


!SentenceFinderByPrefix methodsFor: 'operations' stamp: 'Santiago Festini 9/18/2019 16:37:40'!
find: aPrefix

	| topElement result |
	
	aPrefix isEmpty ifTrue: [self error: self class prefixEmptyErrorDescription].
	(aPrefix findString: ' ') = 0 ifFalse: [self error: self class prefixWithEmptySpacesErrorDescription ].
		
	stack isEmpty ifTrue: [^ OrderedCollection new initialize.].
	
	topElement := stack pop.
	result := self find: aPrefix.
	(topElement beginsWith: aPrefix) ifTrue:[result add: topElement].
	stack push: topElement.
	^result.
	
	! !


!SentenceFinderByPrefix methodsFor: 'initialization' stamp: 'Santiago Festini 9/18/2019 14:51:58'!
initializeWith: aStack

	stack := aStack.! !

"-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- "!

!classDefinition: 'SentenceFinderByPrefix class' category: #'Stack-Exercise'!
SentenceFinderByPrefix class
	instanceVariableNames: ''!

!SentenceFinderByPrefix class methodsFor: 'as yet unclassified' stamp: 'Santiago Festini 9/18/2019 15:21:44'!
prefixEmptyErrorDescription
	
	^ 'Prefix is empty'! !

!SentenceFinderByPrefix class methodsFor: 'as yet unclassified' stamp: 'Santiago Festini 9/18/2019 15:38:47'!
prefixWithEmptySpacesErrorDescription
	
	^ 'Prefix contains empty spaces'! !


!classDefinition: #StackElement category: #'Stack-Exercise'!
Object subclass: #StackElement
	instanceVariableNames: ''
	classVariableNames: ''
	poolDictionaries: ''
	category: 'Stack-Exercise'!


!classDefinition: #ElementWithValue category: #'Stack-Exercise'!
StackElement subclass: #ElementWithValue
	instanceVariableNames: 'nextElement value'
	classVariableNames: ''
	poolDictionaries: ''
	category: 'Stack-Exercise'!

!ElementWithValue methodsFor: 'getters' stamp: 'Santiago Festini 9/16/2019 20:45:49'!
nextElement

	^nextElement .! !

!ElementWithValue methodsFor: 'getters' stamp: 'Santiago Festini 9/16/2019 20:50:26'!
value

	^ value.! !


!ElementWithValue methodsFor: 'initialization' stamp: 'Santiago Festini 9/16/2019 20:44:47'!
initializeWith: myValue andAfter: nextelement

	value := myValue .
	nextElement := nextelement .! !


!classDefinition: #EmptyElement category: #'Stack-Exercise'!
StackElement subclass: #EmptyElement
	instanceVariableNames: ''
	classVariableNames: ''
	poolDictionaries: ''
	category: 'Stack-Exercise'!

!EmptyElement methodsFor: 'getters' stamp: 'Santiago Festini 9/16/2019 20:46:41'!
nextElement

	^self error: OOStack stackEmptyErrorDescription .! !

!EmptyElement methodsFor: 'getters' stamp: 'Santiago Festini 9/16/2019 21:02:32'!
value

	^self error: OOStack stackEmptyErrorDescription .! !
