!classDefinition: #ShoppingCartTest category: #'TusLibros-Ejercicio' stamp: 'SF 10/31/2019 17:00:52'!
TestCase subclass: #ShoppingCartTest
	instanceVariableNames: ''
	classVariableNames: ''
	poolDictionaries: ''
	category: 'TusLibros-Ejercicio'!

!ShoppingCartTest methodsFor: 'testing' stamp: 'SF 10/30/2019 17:21:52'!
test01ShoppingCartStartsEmpty

	| cart |
	
	cart := ShoppingCart new.
	
	self assert: cart isEmpty.! !

!ShoppingCartTest methodsFor: 'testing' stamp: 'SF 10/30/2019 17:34:57'!
test02ShoppingCartIsNotEmptyWhenABookIsAdded

	| cart aBookID aQuantity |
	
	aBookID := 1234.
	aQuantity:= 1.
	cart := ShoppingCart new. 
	
	
	cart add: aQuantity of: aBookID.
	
	self deny: cart isEmpty.
	self assert: 1 equals: cart amountOfBooks.
	self assert: (cart has: aQuantity of: aBookID) .! !

!ShoppingCartTest methodsFor: 'testing' stamp: 'SF 10/30/2019 17:42:03'!
test03ShoppingCartCanAddManyBooksOfTheSameID

	| cart aBookID aQuantity |
	
	aBookID := 1234.
	aQuantity:= 3.
	cart := ShoppingCart new. 
	
	
	cart add: aQuantity of: aBookID.
	
	self deny: cart isEmpty.
	self assert: 3 equals: cart amountOfBooks.
	self assert: (cart has: aQuantity of: aBookID) .! !

!ShoppingCartTest methodsFor: 'testing' stamp: 'SF 10/30/2019 17:53:34'!
test04ShoppingCartCanAddBooksOfDifferentIDs

	| cart aBookID anotherBookID aQuantity  anotherQuantity|
	
	aBookID := 1234 .
	anotherBookID := 1212.
	aQuantity:= 3.
	anotherQuantity := 2.
	cart := ShoppingCart new. 
	
	
	cart add: aQuantity of: aBookID.
	cart add: anotherQuantity of: anotherBookID.
	
	self deny: cart isEmpty.
	self assert: 5 equals: cart amountOfBooks.
	self assert: (cart has: aQuantity of: aBookID) .
	self assert: (cart has: anotherQuantity of: anotherBookID) .! !

!ShoppingCartTest methodsFor: 'testing' stamp: 'SF 10/31/2019 16:27:42'!
test05ShoppingCartFailsWhenTryingToAddABookWithInvalidID

	| cart aBookID aQuantity |
	
	aBookID := -5 .
	aQuantity:= 3.
	cart := ShoppingCart new. 
	
	self 
		should: [ cart add: aQuantity of: aBookID]
		raise: Error - MessageNotUnderstood
		withExceptionDo: [:error | self assert: error messageText = ShoppingCart errorInvalidBookID .
									self assert: cart isEmpty.	
							 ]
	
	! !

!ShoppingCartTest methodsFor: 'testing' stamp: 'SF 10/31/2019 16:33:27'!
test06ShoppingCartFailsWhenTryingToAddLessThan1Book

	| cart aBookID aQuantity |
	
	aBookID := 5 .
	aQuantity:= 0.
	cart := ShoppingCart new. 
	
	self 
		should: [ cart add: aQuantity of: aBookID]
		raise: Error - MessageNotUnderstood
		withExceptionDo: [:error | self assert: error messageText = ShoppingCart errorInvalidBookQuantity .
									self assert: cart isEmpty.	
							 ]
	
	! !

!ShoppingCartTest methodsFor: 'testing' stamp: 'SF 10/31/2019 16:46:52'!
test07ShoppingCartHasOfReturnsFalseIfTheresNothingRegisteredToThatID

	| cart |
	
	cart := ShoppingCart new. 
	
	self deny: (cart has: 5 of: 10).
	! !

!ShoppingCartTest methodsFor: 'testing' stamp: 'SF 10/31/2019 16:51:08'!
test08ShoppingCartRemoveDiscountsQuantityOfRegisteredBooksToTheID

	| cart aBookID aQuantity |
	
	aBookID := 5 .
	aQuantity:= 3.
	cart := ShoppingCart new. 
	cart add: aQuantity of: aBookID.
	cart remove: 2 of: aBookID.
	
	self assert: (cart has: 1 of: aBookID)! !

!ShoppingCartTest methodsFor: 'testing' stamp: 'SF 10/31/2019 16:55:19'!
test09ShoppingCartCantRemoveAnInvalidAmountOfBooks

	| cart aBookID aQuantity |
	
	aBookID := 5 .
	aQuantity:= 0.
	cart := ShoppingCart new. 
	
	self 
		should: [ cart remove: aQuantity of: aBookID]
		raise: Error - MessageNotUnderstood
		withExceptionDo: [:error | self assert: error messageText = ShoppingCart errorInvalidBookQuantity .
									self assert: cart isEmpty.	
							 ]
	
	! !

!ShoppingCartTest methodsFor: 'testing' stamp: 'SF 10/31/2019 16:57:49'!
test10ShoppingCartCantRemoveBooksFromAnInvalidID

	| cart aBookID aQuantity |
	
	aBookID := -2 .
	aQuantity:= 3.
	cart := ShoppingCart new.	
	
	self 
		should: [ cart remove: aQuantity of: aBookID]
		raise: Error - MessageNotUnderstood
		withExceptionDo: [:error | self assert: error messageText = ShoppingCart errorInvalidBookID .
									self assert: cart isEmpty.	
							 ]
	
	! !

!ShoppingCartTest methodsFor: 'testing' stamp: 'SF 10/31/2019 17:00:37'!
test11ShoppingCartCantRemoveMoreBooksThanThereAreRegisteredToThatID

	| cart aBookID aQuantity |
	
	aBookID := 1 .
	aQuantity:= 3.
	cart := ShoppingCart new.	
	cart add: 1 of: aBookID.
	
	self 
		should: [ cart remove: aQuantity of: aBookID]
		raise: Error - MessageNotUnderstood
		withExceptionDo: [:error | self assert: error messageText = ShoppingCart errorInvalidBookQuantity .
							 ]
	
	! !


!classDefinition: #ShoppingCart category: #'TusLibros-Ejercicio' stamp: 'SF 10/31/2019 17:00:52'!
Object subclass: #ShoppingCart
	instanceVariableNames: 'books'
	classVariableNames: ''
	poolDictionaries: ''
	category: 'TusLibros-Ejercicio'!

!ShoppingCart methodsFor: 'as yet unclassified' stamp: 'SF 10/31/2019 16:34:23'!
add: aQuantity of: aBookID
	
	aBookID <= 0 ifTrue:[self error: self class errorInvalidBookID .].
	aQuantity <= 0 ifTrue:[self error: self class errorInvalidBookQuantity .].
	
	books at: aBookID put: aQuantity .! !

!ShoppingCart methodsFor: 'as yet unclassified' stamp: 'SF 10/30/2019 18:41:00'!
amountOfBooks
	|totalOfBooks|
	
	totalOfBooks := 0.
	books keysDo:[:aBookID  | totalOfBooks := totalOfBooks + (books at: aBookID). ].
	^totalOfBooks.! !

!ShoppingCart methodsFor: 'as yet unclassified' stamp: 'SF 10/31/2019 16:48:17'!
has: aQuantity of: aBookID

	^ (books at: aBookID ifAbsent: [^aQuantity = 0]) = aQuantity .! !

!ShoppingCart methodsFor: 'as yet unclassified' stamp: 'SF 10/30/2019 17:54:40'!
initialize

	books := Dictionary new.
	! !

!ShoppingCart methodsFor: 'as yet unclassified' stamp: 'SF 10/30/2019 17:40:00'!
isEmpty

	^self amountOfBooks = 0! !

!ShoppingCart methodsFor: 'as yet unclassified' stamp: 'SF 10/31/2019 17:00:19'!
remove: aQuantity of: aBookID

	aBookID <= 0 ifTrue:[self error: self class errorInvalidBookID .].
	((aQuantity <= 0) or: [(books at: aBookID) < aQuantity ]) ifTrue:[self error: self class errorInvalidBookQuantity .].

	books at: aBookID put: ((books at: aBookID) - aQuantity ).! !

"-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- "!

!classDefinition: 'ShoppingCart class' category: #'TusLibros-Ejercicio' stamp: 'SF 10/31/2019 17:00:52'!
ShoppingCart class
	instanceVariableNames: ''!

!ShoppingCart class methodsFor: 'as yet unclassified' stamp: 'SF 10/31/2019 16:28:59'!
errorInvalidBookID

	^ 'Error - Invalid Book ID!!'.! !

!ShoppingCart class methodsFor: 'as yet unclassified' stamp: 'SF 10/31/2019 16:33:53'!
errorInvalidBookQuantity

	^ 'Error - Invalid Book Quantity!!'.! !
