!classDefinition: #TusLibrosTest category: #'TusLibros-Ejercicio' stamp: 'SF 10/30/2019 18:41:34'!
TestCase subclass: #TusLibrosTest
	instanceVariableNames: ''
	classVariableNames: ''
	poolDictionaries: ''
	category: 'TusLibros-Ejercicio'!

!TusLibrosTest methodsFor: 'testing' stamp: 'SF 10/30/2019 17:21:52'!
test01ShoppingCartStartsEmpty

	| cart |
	
	cart := ShoppingCart new.
	
	self assert: cart isEmpty.! !

!TusLibrosTest methodsFor: 'testing' stamp: 'SF 10/30/2019 17:34:57'!
test02ShoppingCartIsNotEmptyWhenABookIsAdded

	| cart aBookID aQuantity |
	
	aBookID := 1234.
	aQuantity:= 1.
	cart := ShoppingCart new. 
	
	
	cart add: aQuantity of: aBookID.
	
	self deny: cart isEmpty.
	self assert: 1 equals: cart amountOfBooks.
	self assert: (cart has: aQuantity of: aBookID) .! !

!TusLibrosTest methodsFor: 'testing' stamp: 'SF 10/30/2019 17:42:03'!
test03ShoppingCartCanAddManyBooksOfTheSameID

	| cart aBookID aQuantity |
	
	aBookID := 1234.
	aQuantity:= 3.
	cart := ShoppingCart new. 
	
	
	cart add: aQuantity of: aBookID.
	
	self deny: cart isEmpty.
	self assert: 3 equals: cart amountOfBooks.
	self assert: (cart has: aQuantity of: aBookID) .! !

!TusLibrosTest methodsFor: 'testing' stamp: 'SF 10/30/2019 17:53:34'!
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


!classDefinition: #ShoppingCart category: #'TusLibros-Ejercicio' stamp: 'SF 10/30/2019 18:41:34'!
Object subclass: #ShoppingCart
	instanceVariableNames: 'books quantity'
	classVariableNames: ''
	poolDictionaries: ''
	category: 'TusLibros-Ejercicio'!

!ShoppingCart methodsFor: 'as yet unclassified' stamp: 'SF 10/30/2019 17:58:47'!
add: aQuantity of: aBookID
	
	books at: aBookID put: aQuantity .! !

!ShoppingCart methodsFor: 'as yet unclassified' stamp: 'SF 10/30/2019 18:41:00'!
amountOfBooks
	|totalOfBooks|
	
	totalOfBooks := 0.
	books keysDo:[:aBookID  | totalOfBooks := totalOfBooks + (books at: aBookID). ].
	^totalOfBooks.! !

!ShoppingCart methodsFor: 'as yet unclassified' stamp: 'SF 10/30/2019 18:30:25'!
has: aQuantity of: aBookID

	^true.! !

!ShoppingCart methodsFor: 'as yet unclassified' stamp: 'SF 10/30/2019 17:54:40'!
initialize

	books := Dictionary new.
	! !

!ShoppingCart methodsFor: 'as yet unclassified' stamp: 'SF 10/30/2019 17:40:00'!
isEmpty

	^self amountOfBooks = 0! !


!classDefinition: #TusLibros category: #'TusLibros-Ejercicio' stamp: 'SF 10/30/2019 18:41:34'!
Object subclass: #TusLibros
	instanceVariableNames: ''
	classVariableNames: ''
	poolDictionaries: ''
	category: 'TusLibros-Ejercicio'!
