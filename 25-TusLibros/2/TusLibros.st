!classDefinition: #CartTest category: #TusLibros stamp: 'SF 11/7/2019 16:16:16'!
TestCase subclass: #CartTest
	instanceVariableNames: ''
	classVariableNames: ''
	poolDictionaries: ''
	category: 'TusLibros'!

!CartTest methodsFor: 'tests' stamp: 'HernanWilkinson 6/17/2013 17:08'!
test01NewCartsAreCreatedEmpty

	self assert: self createCart isEmpty! !

!CartTest methodsFor: 'tests' stamp: 'SF 11/4/2019 19:02:52'!
test02CanNotAddItemsThatDoNotBelongToStore

	| cart |
	
	cart := self createCart.
	
	self 
		should: [ cart add: 1 of: self itemNotSoldByTheStore ]
		raise: Error - MessageNotUnderstood
		withExceptionDo: [ :anError |
			self assert: anError messageText = cart invalidItemErrorMessage.
			self assert: cart isEmpty ]! !

!CartTest methodsFor: 'tests' stamp: 'SF 11/4/2019 19:02:33'!
test03AfterAddingAnItemTheCartIsNotEmptyAnymore

	| cart |
	
	cart := self createCart.
	
	cart add:1 of: self itemSoldByTheStore.
	self deny: cart isEmpty ! !

!CartTest methodsFor: 'tests' stamp: 'SF 11/4/2019 19:02:33'!
test04CanNotAddNonPositiveNumberOfItems

	| cart |
	
	cart := self createCart.
	
	self 
		should: [cart add: 0 of: self itemSoldByTheStore ]
		raise: Error - MessageNotUnderstood
		withExceptionDo: [ :anError |
			self assert: anError messageText = cart invalidQuantityErrorMessage.
			self assert: cart isEmpty ]! !

!CartTest methodsFor: 'tests' stamp: 'SF 11/4/2019 19:02:52'!
test05CanNotAddMoreThanOneItemNotSellByTheStore

	| cart |
	
	cart := self createCart.
	
	self 
		should: [cart add: 2 of: self itemNotSoldByTheStore  ]
		raise: Error - MessageNotUnderstood
		withExceptionDo: [ :anError |
			self assert: anError messageText = cart invalidItemErrorMessage.
			self assert: cart isEmpty ]! !

!CartTest methodsFor: 'tests' stamp: 'SF 11/4/2019 19:02:33'!
test06CartRemembersAddedItems

	| cart |
	
	cart := self createCart.
	
	cart add: 1 of: self itemSoldByTheStore.
	self assert: (cart includes: self itemSoldByTheStore)! !

!CartTest methodsFor: 'tests' stamp: 'SF 11/4/2019 19:02:33'!
test07CartDoesNotHoldNotAddedItems

	| cart |
	
	cart := self createCart.
	
	self deny: (cart includes: self itemSoldByTheStore)! !

!CartTest methodsFor: 'tests' stamp: 'SF 11/4/2019 19:02:33'!
test08CartRemembersTheNumberOfAddedItems

	| cart |
	
	cart := self createCart.
	
	cart add: 2 of: self itemSoldByTheStore.
	self assert: (cart occurrencesOf: self itemSoldByTheStore) = 2! !


!CartTest methodsFor: 'support' stamp: 'HernanWilkinson 6/17/2013 17:48'!
createCart
	
	^Cart acceptingItemsOf: self defaultCatalog! !

!CartTest methodsFor: 'support' stamp: 'SF 11/4/2019 19:05:50'!
defaultCatalog
	
	^ Dictionary with: (self itemSoldByTheStore)->10.! !

!CartTest methodsFor: 'support' stamp: 'SF 11/4/2019 19:08:06'!
itemNotSoldByTheStore
	
	^ 'invalidBook'! !

!CartTest methodsFor: 'support' stamp: 'SF 11/4/2019 19:02:33'!
itemSoldByTheStore
	
	^ 'validBook'! !


!classDefinition: #CashierTest category: #TusLibros stamp: 'SF 11/7/2019 16:16:16'!
TestCase subclass: #CashierTest
	instanceVariableNames: ''
	classVariableNames: ''
	poolDictionaries: ''
	category: 'TusLibros'!

!CashierTest methodsFor: 'testing' stamp: 'SF 11/7/2019 15:34:22'!
test01CantCheckoutAnEmptyCart
	
	| shoppingCart cashier aSalesBook |
	
	aSalesBook := OrderedCollection new.
	shoppingCart := self createCart .
	
	cashier := Cashier for: shoppingCart toBePayedWith: self createValidCard registeredOn: aSalesBook andProcessedBy: self createSuccesfulMerchantProcessor .
	
	self 
		should: [ cashier checkout ]
		raise: Error - MessageNotUnderstood
		withExceptionDo: [ :anError |
			self assert: anError messageText = Cashier emptyCartCheckoutErrorMessage.
			self assert: aSalesBook isEmpty. ]! !

!CashierTest methodsFor: 'testing' stamp: 'SF 11/7/2019 15:34:39'!
test02CheckoutOfCartWithABookChecksOutTheBookPrice
	
	| shoppingCart cashier aSalesBook |
	
	aSalesBook := OrderedCollection new.
	shoppingCart := self createCart .
	shoppingCart add: self itemSoldByTheStore .
	cashier := Cashier for: shoppingCart toBePayedWith: self createValidCard registeredOn: aSalesBook andProcessedBy: self createSuccesfulMerchantProcessor .
	
	self assert: 10 equals: cashier checkout.
	self assert: 1 equals: aSalesBook size.
! !

!CashierTest methodsFor: 'testing' stamp: 'SF 11/7/2019 15:34:49'!
test03CheckoutOfCartWithManyBooksChecksOutTheSumOfTheBooksPrices
	
	| shoppingCart cashier aSalesBook |
	
	aSalesBook := OrderedCollection new.
	shoppingCart := self createCart .
	shoppingCart add: 5 of: self itemSoldByTheStore .
	cashier := Cashier for: shoppingCart toBePayedWith: self createValidCard registeredOn: aSalesBook andProcessedBy: self createSuccesfulMerchantProcessor  .
	
	self assert: 50 equals: cashier checkout.
	self assert: 1 equals: aSalesBook size.
! !

!CashierTest methodsFor: 'testing' stamp: 'SF 11/7/2019 15:34:56'!
test04CantCheckoutWithAnExpiredCreditCard
	
	| shoppingCart cashier aSalesBook  creditCard aDate |
	
	aDate := GregorianMonthOfYear yearNumber: 2010 month: November.
	creditCard := CreditCard withNumber: 1234123412341234 anOwner: 'Lopez Garcia' expirationDate: aDate.
	 
	aSalesBook := OrderedCollection new.
	shoppingCart := self createCart .
	shoppingCart add: 5 of: self itemSoldByTheStore .
	
	cashier := Cashier for: shoppingCart toBePayedWith: creditCard registeredOn: aSalesBook andProcessedBy: self createSuccesfulMerchantProcessor  .
	
	self 
		should: [ cashier checkout ]
		raise: Error - MessageNotUnderstood
		withExceptionDo: [ :anError |
			self assert: anError messageText = Cashier expiredCardErrorMessage.
			self assert: aSalesBook isEmpty. ]
	
	
	! !

!CashierTest methodsFor: 'testing' stamp: 'SF 11/7/2019 15:35:02'!
test05CantCheckoutWithACreditCardWhichOwnerNameExceedsThirtyCharacters
	
	| shoppingCart cashier aSalesBook  creditCard aDate |
	
	aDate := GregorianMonthOfYear yearNumber: SmallInteger maxVal month: December.
	creditCard := CreditCard withNumber: 1234123412341234 anOwner: 'Lopez Garciaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaa' expirationDate: aDate.
	 
	aSalesBook := OrderedCollection new.
	shoppingCart := self createCart .
	shoppingCart add: 5 of: self itemSoldByTheStore .
	
	cashier := Cashier for: shoppingCart toBePayedWith: creditCard registeredOn: aSalesBook andProcessedBy: self createSuccesfulMerchantProcessor  .
	
	self 
		should: [ cashier checkout ]
		raise: Error - MessageNotUnderstood
		withExceptionDo: [ :anError |
			self assert: anError messageText = Cashier ownerNameIsTooLongErrorMessage.
			self assert: aSalesBook isEmpty. ]
	
	
	! !

!CashierTest methodsFor: 'testing' stamp: 'SF 11/7/2019 15:42:09'!
test06CashierFailsAndDoesntRegisterTheSaleIfDebitFails
	
	| shoppingCart cashier aSalesBook  creditCard |
	
	creditCard := self createValidCard .
	 
	aSalesBook := OrderedCollection new.
	shoppingCart := self createCart .
	shoppingCart add: 5 of: self itemSoldByTheStore .
	
	cashier := Cashier for: shoppingCart toBePayedWith: creditCard registeredOn: aSalesBook andProcessedBy: self createDebitErrorMerchantProcessor .
	
	self 
		should: [ cashier checkout ]
		raise: Error - MessageNotUnderstood
		withExceptionDo: [ :anError |
			self assert: anError messageText = cashier debitFailErrorMessage.
			self assert: aSalesBook isEmpty. ]
	
	! !


!CashierTest methodsFor: 'support' stamp: 'SF 11/4/2019 16:23:54'!
createCart
	
	^Cart acceptingItemsOf: self defaultCatalog! !

!CashierTest methodsFor: 'support' stamp: 'SF 11/7/2019 15:33:57'!
createDebitErrorMerchantProcessor
	
	^ MPDebitError new.! !

!CashierTest methodsFor: 'support' stamp: 'SF 11/7/2019 15:33:42'!
createSuccesfulMerchantProcessor
	
	^ MPSuccesfulDebit new.! !

!CashierTest methodsFor: 'support' stamp: 'SF 11/6/2019 18:12:20'!
createValidCard

	| aDate |
	
	aDate := GregorianMonthOfYear yearNumber: (SmallInteger maxVal) month: December.
	^ CreditCard withNumber: 1234123412341234 anOwner: 'Lopez Garcia' expirationDate: aDate.! !

!CashierTest methodsFor: 'support' stamp: 'SF 11/4/2019 19:04:35'!
defaultCatalog
	
	^ Dictionary with: (self itemSoldByTheStore)->10.! !

!CashierTest methodsFor: 'support' stamp: 'SF 11/4/2019 19:05:11'!
itemNotSoldByTheStore
	
	^ 'invalidBook'! !

!CashierTest methodsFor: 'support' stamp: 'SF 11/4/2019 19:02:33'!
itemSoldByTheStore
	
	^ 'validBook'! !


!classDefinition: #CreditCardTest category: #TusLibros stamp: 'SF 11/7/2019 16:16:16'!
TestCase subclass: #CreditCardTest
	instanceVariableNames: ''
	classVariableNames: ''
	poolDictionaries: ''
	category: 'TusLibros'!

!CreditCardTest methodsFor: 'testing' stamp: 'SF 11/6/2019 18:23:48'!
test01CreditCardNumberCantHaveMoreThan16Digits

	self 
		should: [ CreditCard withNumber: 12341234123412345 anOwner: 'Pepe' expirationDate: (GregorianMonthOfYear yearNumber: SmallInteger maxVal month: December)]
		raise: Error - MessageNotUnderstood
		withExceptionDo: [ :anError |
			self assert: anError messageText = CreditCard invalidCardNumberRangeError . ]! !

!CreditCardTest methodsFor: 'testing' stamp: 'SF 11/6/2019 18:23:31'!
test02CreditCardNumberCantHaveLessThan16Digits

	self 
		should: [ CreditCard withNumber: 123412341234123 anOwner: 'Pepe' expirationDate: (GregorianMonthOfYear yearNumber: SmallInteger maxVal month: December)]
		raise: Error - MessageNotUnderstood
		withExceptionDo: [ :anError |
			self assert: anError messageText = CreditCard invalidCardNumberRangeError . ]! !

!CreditCardTest methodsFor: 'testing' stamp: 'SF 11/6/2019 18:37:26'!
test03CreditCardIsExpiredWhenItsExpirationDateIsEarlierInTime
	
	|creditCard|
	
	creditCard := CreditCard withNumber: 1234123412341234 anOwner: 'Pepe' expirationDate: (GregorianMonthOfYear yearNumber: 2010 month: December).
	
	self assert: (creditCard isExpiredOn: (FixedGregorianDate yearNumber: 2011 month: December  dayNumber: 22)).
	
	
	! !

!CreditCardTest methodsFor: 'testing' stamp: 'SF 11/6/2019 18:38:42'!
test04CreditCardIsNotExpiredWhenItsExpirationDateIsForwardInTime
	
	|creditCard|
	
	creditCard := CreditCard withNumber: 1234123412341234 anOwner: 'Pepe' expirationDate: (GregorianMonthOfYear yearNumber: 2010 month: December).
	
	self deny: (creditCard isExpiredOn: (FixedGregorianDate yearNumber: 2000 month: December  dayNumber: 22)).
	
	
	! !


!classDefinition: #Cart category: #TusLibros stamp: 'SF 11/7/2019 16:16:16'!
Object subclass: #Cart
	instanceVariableNames: 'catalog items'
	classVariableNames: ''
	poolDictionaries: ''
	category: 'TusLibros'!

!Cart methodsFor: 'error messages' stamp: 'HernanWilkinson 6/17/2013 17:45'!
invalidItemErrorMessage
	
	^'Item is not in catalog'! !

!Cart methodsFor: 'error messages' stamp: 'HernanWilkinson 6/17/2013 17:45'!
invalidQuantityErrorMessage
	
	^'Invalid number of items'! !


!Cart methodsFor: 'assertions' stamp: 'SF 11/4/2019 19:07:26'!
assertIsValidItem: anItem

	(catalog includesKey: anItem) ifFalse: [ self error: self invalidItemErrorMessage ]! !

!Cart methodsFor: 'assertions' stamp: 'HernanWilkinson 6/17/2013 17:51'!
assertIsValidQuantity: aQuantity

	aQuantity strictlyPositive ifFalse: [ self error: self invalidQuantityErrorMessage ]! !


!Cart methodsFor: 'initialization' stamp: 'SF 11/4/2019 19:55:14'!
initializeAcceptingItemsOf: aCatalog

	catalog := aCatalog.
	items := OrderedCollection new.! !


!Cart methodsFor: 'queries' stamp: 'HernanWilkinson 6/17/2013 17:45'!
occurrencesOf: anItem

	^items occurrencesOf: anItem  ! !

!Cart methodsFor: 'queries' stamp: 'SF 11/4/2019 19:53:56'!
totalCost

	^ items inject: 0 into: [:totalCost :aBook | totalCost + (catalog at: aBook)].! !


!Cart methodsFor: 'testing' stamp: 'HernanWilkinson 6/17/2013 17:44'!
includes: anItem

	^items includes: anItem ! !

!Cart methodsFor: 'testing' stamp: 'HernanWilkinson 6/17/2013 17:44'!
isEmpty
	
	^items isEmpty ! !


!Cart methodsFor: 'adding' stamp: 'SF 11/4/2019 18:55:34'!
add: anItem

	^ self add: 1 of: anItem! !

!Cart methodsFor: 'adding' stamp: 'HernanWilkinson 6/17/2013 17:51'!
add: aQuantity of: anItem

	self assertIsValidQuantity: aQuantity.
	self assertIsValidItem: anItem.

	1 to: aQuantity do: [ :aNumber | items add: anItem ]! !

"-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- "!

!classDefinition: 'Cart class' category: #TusLibros stamp: 'SF 11/7/2019 16:16:16'!
Cart class
	instanceVariableNames: ''!

!Cart class methodsFor: 'instance creation' stamp: 'HernanWilkinson 6/17/2013 17:48'!
acceptingItemsOf: aCatalog

	^self new initializeAcceptingItemsOf: aCatalog ! !


!classDefinition: #Cashier category: #TusLibros stamp: 'SF 11/7/2019 16:16:16'!
Object subclass: #Cashier
	instanceVariableNames: 'merchantProcessor cart salesBook creditCard'
	classVariableNames: ''
	poolDictionaries: ''
	category: 'TusLibros'!

!Cashier methodsFor: 'checkout' stamp: 'SF 11/7/2019 15:59:13'!
checkout

	self assertValidSale.  
	
	((merchantProcessor debit: cart totalCost to: creditCard) = 'debit error') ifTrue:[self error: self debitFailErrorMessage ].
	
	salesBook add: 'validBook'.
	^ cart totalCost .
! !


!Cashier methodsFor: 'instance error messages' stamp: 'SF 11/7/2019 15:42:40'!
debitFailErrorMessage

	^ 'debit error'.! !


!Cashier methodsFor: 'initialize' stamp: 'SF 11/7/2019 15:29:33'!
initializeFor: aShoppingCart toBePayedWith: aCreditCard registeredOn: aSalesBook andProcessedBy: aMerchantProcessor

	cart := aShoppingCart .
	salesBook := aSalesBook .	
	creditCard := aCreditCard.
	merchantProcessor := aMerchantProcessor! !


!Cashier methodsFor: 'assertions' stamp: 'SF 11/6/2019 17:52:50'!
assertValidSale

	cart isEmpty ifTrue: [self error: self class emptyCartCheckoutErrorMessage].
	(creditCard isExpiredOn: FixedGregorianDate today) ifTrue: [self error: self class expiredCardErrorMessage].
	(creditCard nameSizeIsGreaterThan: 30) ifTrue: [self error: self class ownerNameIsTooLongErrorMessage].
	

! !

"-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- "!

!classDefinition: 'Cashier class' category: #TusLibros stamp: 'SF 11/7/2019 16:16:16'!
Cashier class
	instanceVariableNames: ''!

!Cashier class methodsFor: 'as yet unclassified' stamp: 'SF 11/4/2019 19:19:12'!
emptyCartCheckoutErrorMessage

	^ 'Cant checkout an empty cart!!'! !

!Cashier class methodsFor: 'as yet unclassified' stamp: 'SF 11/4/2019 20:36:01'!
expiredCardErrorMessage

	^ 'Cant checkout with an expired card!!'! !

!Cashier class methodsFor: 'as yet unclassified' stamp: 'SF 11/7/2019 15:30:53'!
for: aShoppingCart toBePayedWith: aCreditCard registeredOn: aSalesBook andProcessedBy: aMerchantProcessor

	^ self new initializeFor: aShoppingCart toBePayedWith: aCreditCard registeredOn: aSalesBook andProcessedBy: aMerchantProcessor .! !

!Cashier class methodsFor: 'as yet unclassified' stamp: 'SF 11/6/2019 17:53:56'!
ownerNameIsTooLongErrorMessage

	^ 'Owner name is too long!!'! !


!classDefinition: #CreditCard category: #TusLibros stamp: 'SF 11/7/2019 16:16:16'!
Object subclass: #CreditCard
	instanceVariableNames: 'cardNumber owner expireDate'
	classVariableNames: ''
	poolDictionaries: ''
	category: 'TusLibros'!

!CreditCard methodsFor: 'testing' stamp: 'SF 11/4/2019 20:44:52'!
isExpiredOn: aDate

	^ expireDate < aDate .

	

	! !

!CreditCard methodsFor: 'testing' stamp: 'SF 11/6/2019 17:54:51'!
nameSizeIsGreaterThan: aNumber

	^ owner size > aNumber.! !


!CreditCard methodsFor: 'initialization' stamp: 'SF 11/6/2019 18:20:39'!
initializeWithNumber: aNumber anOwner: anOwner expirationDate: aDate

	cardNumber := aNumber .
	owner := anOwner .
	expireDate := aDate .! !


!CreditCard methodsFor: 'accessing' stamp: 'SF 11/7/2019 15:47:27'!
expirationDate

	^ expireDate .! !

!CreditCard methodsFor: 'accessing' stamp: 'SF 11/7/2019 15:47:17'!
number

	^ cardNumber .! !

!CreditCard methodsFor: 'accessing' stamp: 'SF 11/7/2019 15:47:41'!
ownerName

	^ owner .! !

"-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- "!

!classDefinition: 'CreditCard class' category: #TusLibros stamp: 'SF 11/7/2019 16:16:16'!
CreditCard class
	instanceVariableNames: ''!

!CreditCard class methodsFor: 'as yet unclassified' stamp: 'SF 11/6/2019 18:20:24'!
invalidCardNumberRangeError

	^ 'Invalid card number range!!'.! !

!CreditCard class methodsFor: 'as yet unclassified' stamp: 'SF 11/6/2019 18:20:56'!
withNumber: aNumber anOwner: anOwner expirationDate: aDate

	aNumber decimalDigitLength = 16 ifFalse: [^ self error: self invalidCardNumberRangeError].

	^ self new initializeWithNumber: aNumber anOwner: anOwner expirationDate: aDate! !


!classDefinition: #MerchantProcessorSimulator category: #TusLibros stamp: 'SF 11/7/2019 16:16:16'!
Object subclass: #MerchantProcessorSimulator
	instanceVariableNames: ''
	classVariableNames: ''
	poolDictionaries: ''
	category: 'TusLibros'!

!MerchantProcessorSimulator methodsFor: 'debit' stamp: 'SF 11/7/2019 15:58:45'!
debit: anAmount to: aCreditCard

	^ self subclassResponsibility .! !


!classDefinition: #MPDebitError category: #TusLibros stamp: 'SF 11/7/2019 16:16:16'!
MerchantProcessorSimulator subclass: #MPDebitError
	instanceVariableNames: ''
	classVariableNames: ''
	poolDictionaries: ''
	category: 'TusLibros'!

!MPDebitError methodsFor: 'debit' stamp: 'SF 11/7/2019 15:59:29'!
debit: anAmount to: aCreditCard
	
	^ 'debit error'! !


!classDefinition: #MPSuccesfulDebit category: #TusLibros stamp: 'SF 11/7/2019 16:16:16'!
MerchantProcessorSimulator subclass: #MPSuccesfulDebit
	instanceVariableNames: ''
	classVariableNames: ''
	poolDictionaries: ''
	category: 'TusLibros'!

!MPSuccesfulDebit methodsFor: 'debit' stamp: 'SF 11/7/2019 15:59:40'!
debit: anAmount to: aCreditCard

	^ 'succesful debit'.! !
