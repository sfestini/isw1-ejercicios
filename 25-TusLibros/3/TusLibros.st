!classDefinition: #CartTest category: #TusLibros stamp: 'SF 11/11/2019 21:11:49'!
TestCase subclass: #CartTest
	instanceVariableNames: 'testObjectsFactory'
	classVariableNames: ''
	poolDictionaries: ''
	category: 'TusLibros'!

!CartTest methodsFor: 'tests' stamp: 'HernanWilkinson 6/17/2013 18:10'!
test01NewCartsAreCreatedEmpty

	self assert: testObjectsFactory createCart isEmpty! !

!CartTest methodsFor: 'tests' stamp: 'HernanWilkinson 6/17/2013 18:10'!
test02CanNotAddItemsThatDoNotBelongToStore

	| cart |
	
	cart := testObjectsFactory createCart.
	
	self 
		should: [ cart add: testObjectsFactory itemNotSellByTheStore ]
		raise: Error - MessageNotUnderstood
		withExceptionDo: [ :anError |
			self assert: anError messageText = cart invalidItemErrorMessage.
			self assert: cart isEmpty ]! !

!CartTest methodsFor: 'tests' stamp: 'HernanWilkinson 6/17/2013 18:10'!
test03AfterAddingAnItemTheCartIsNotEmptyAnymore

	| cart |
	
	cart := testObjectsFactory createCart.
	
	cart add: testObjectsFactory itemSellByTheStore.
	self deny: cart isEmpty ! !

!CartTest methodsFor: 'tests' stamp: 'HernanWilkinson 6/17/2013 18:10'!
test04CanNotAddNonPositiveNumberOfItems

	| cart |
	
	cart := testObjectsFactory createCart.
	
	self 
		should: [cart add: 0 of: testObjectsFactory itemSellByTheStore ]
		raise: Error - MessageNotUnderstood
		withExceptionDo: [ :anError |
			self assert: anError messageText = cart invalidQuantityErrorMessage.
			self assert: cart isEmpty ]! !

!CartTest methodsFor: 'tests' stamp: 'HernanWilkinson 6/17/2013 18:10'!
test05CanNotAddMoreThanOneItemNotSellByTheStore

	| cart |
	
	cart := testObjectsFactory createCart.
	
	self 
		should: [cart add: 2 of: testObjectsFactory itemNotSellByTheStore  ]
		raise: Error - MessageNotUnderstood
		withExceptionDo: [ :anError |
			self assert: anError messageText = cart invalidItemErrorMessage.
			self assert: cart isEmpty ]! !

!CartTest methodsFor: 'tests' stamp: 'HernanWilkinson 6/17/2013 18:11'!
test06CartRemembersAddedItems

	| cart |
	
	cart := testObjectsFactory createCart.
	
	cart add: testObjectsFactory itemSellByTheStore.
	self assert: (cart includes: testObjectsFactory itemSellByTheStore)! !

!CartTest methodsFor: 'tests' stamp: 'HernanWilkinson 6/17/2013 18:11'!
test07CartDoesNotHoldNotAddedItems

	| cart |
	
	cart := testObjectsFactory createCart.
	
	self deny: (cart includes: testObjectsFactory itemSellByTheStore)! !

!CartTest methodsFor: 'tests' stamp: 'HernanWilkinson 6/17/2013 18:11'!
test08CartRemembersTheNumberOfAddedItems

	| cart |
	
	cart := testObjectsFactory createCart.
	
	cart add: 2 of: testObjectsFactory itemSellByTheStore.
	self assert: (cart occurrencesOf: testObjectsFactory itemSellByTheStore) = 2! !


!CartTest methodsFor: 'setup' stamp: 'HernanWilkinson 6/17/2013 18:09'!
setUp 

	testObjectsFactory := StoreTestObjectsFactory new.! !


!classDefinition: #CashierTest category: #TusLibros stamp: 'SF 11/11/2019 21:11:49'!
TestCase subclass: #CashierTest
	instanceVariableNames: 'testObjectsFactory debitBehavior'
	classVariableNames: ''
	poolDictionaries: ''
	category: 'TusLibros'!

!CashierTest methodsFor: 'tests' stamp: 'SF 11/11/2019 21:01:34'!
test01CanNotCheckoutAnEmptyCart

	| salesBook |
	
	salesBook := OrderedCollection new.
	self 
		should: [ Cashier 
			toCheckout: testObjectsFactory createCart 
			charging: testObjectsFactory notExpiredCreditCard 
			through: self
			on: testObjectsFactory today
			registeringOn:  salesBook
			for: testObjectsFactory validClient ]
		raise: Error - MessageNotUnderstood
		withExceptionDo: [ :anError |
			self assert: anError messageText = Cashier cartCanNotBeEmptyErrorMessage.
			self assert: salesBook isEmpty ]! !

!CashierTest methodsFor: 'tests' stamp: 'SF 11/11/2019 21:01:46'!
test02CalculatedTotalIsCorrect

	| cart cashier |
	
	cart := testObjectsFactory createCart.
	cart add: 2 of: testObjectsFactory itemSellByTheStore.
	
	cashier :=  Cashier
		toCheckout: cart 
		charging: testObjectsFactory notExpiredCreditCard 
		through: self
		on: testObjectsFactory today 
		registeringOn: OrderedCollection new
		for: testObjectsFactory validClient.
		
	self assert: cashier checkOut = (testObjectsFactory itemSellByTheStorePrice * 2)! !

!CashierTest methodsFor: 'tests' stamp: 'SF 11/11/2019 21:01:53'!
test03CanNotCheckoutWithAnExpiredCreditCart

	| cart salesBook |

	cart := testObjectsFactory createCart.
	cart add: testObjectsFactory itemSellByTheStore.
	salesBook := OrderedCollection new.
	
	self
		should: [ Cashier 
				toCheckout: cart 
				charging: testObjectsFactory expiredCreditCard 
				through: self
				on: testObjectsFactory today
				registeringOn: salesBook
				for: testObjectsFactory validClient ]
		raise: Error - MessageNotUnderstood
		withExceptionDo: [ :anError | 
			self assert: anError messageText = Cashier canNotChargeAnExpiredCreditCardErrorMessage.
			self assert: salesBook isEmpty ]! !

!CashierTest methodsFor: 'tests' stamp: 'SF 11/11/2019 21:01:58'!
test04CheckoutRegistersASale

	| cart cashier salesBook total |

	cart := testObjectsFactory createCart.
	cart add: testObjectsFactory itemSellByTheStore.
	salesBook := OrderedCollection new.
 
	cashier:= Cashier 
		toCheckout: cart 
		charging: testObjectsFactory notExpiredCreditCard
		through: self
		on: testObjectsFactory today
		registeringOn: salesBook
		for: testObjectsFactory validClient.
		
	total := cashier checkOut.
					
	self assert: salesBook size = 1.
	self assert: salesBook first total = total.! !

!CashierTest methodsFor: 'tests' stamp: 'SF 11/11/2019 21:02:03'!
test05CashierChargesCreditCardUsingMerchantProcessor

	| cart cashier salesBook total creditCard debitedAmout debitedCreditCard  |

	cart := testObjectsFactory createCart.
	cart add: testObjectsFactory itemSellByTheStore.
	creditCard := testObjectsFactory notExpiredCreditCard.
	salesBook := OrderedCollection new.
 
	cashier:= Cashier 
		toCheckout: cart 
		charging: creditCard
		through: self
		on: testObjectsFactory today
		registeringOn: salesBook
		for: testObjectsFactory validClient.
		
	debitBehavior := [ :anAmount :aCreditCard | 
		debitedAmout := anAmount.
		debitedCreditCard := aCreditCard ].
	total := cashier checkOut.
					
	self assert: debitedCreditCard = creditCard.
	self assert: debitedAmout = total.! !

!CashierTest methodsFor: 'tests' stamp: 'SF 11/11/2019 21:02:10'!
test06CashierDoesNotSaleWhenTheCreditCardHasNoCredit

	| cart cashier salesBook creditCard |

	cart := testObjectsFactory createCart.
	cart add: testObjectsFactory itemSellByTheStore.
	creditCard := testObjectsFactory notExpiredCreditCard.
	salesBook := OrderedCollection new.
 	debitBehavior := [ :anAmount :aCreditCard | self error: Cashier creditCardHasNoCreditErrorMessage].
	
	cashier:= Cashier 
		toCheckout: cart 
		charging: creditCard
		through: self
		on: testObjectsFactory today
		registeringOn: salesBook
		for: testObjectsFactory validClient.
		
	self 
		should: [cashier checkOut ]
		raise: Error - MessageNotUnderstood
		withExceptionDo: [ :anError |
			self assert: anError messageText = Cashier creditCardHasNoCreditErrorMessage.
			self assert: salesBook isEmpty ]! !


!CashierTest methodsFor: 'setup' stamp: 'HernanWilkinson 6/17/2013 19:03'!
setUp 

	testObjectsFactory := StoreTestObjectsFactory new.
	debitBehavior := [ :anAmount :aCreditCard | ]! !


!CashierTest methodsFor: 'merchant processor protocol' stamp: 'HernanWilkinson 6/17/2013 19:02'!
debit: anAmount from: aCreditCard 

	^debitBehavior value: anAmount value: aCreditCard ! !


!classDefinition: #TusLibrosInterfaceTest category: #TusLibros stamp: 'SF 11/11/2019 21:11:49'!
TestCase subclass: #TusLibrosInterfaceTest
	instanceVariableNames: 'aPassword testObjectsFactory aClientID validCardNumber validExpirationDate validCardOwner authenticationSystem anInvalidClientID aClientInvalidPassword catalog merchantProcessor debitBehavior'
	classVariableNames: ''
	poolDictionaries: ''
	category: 'TusLibros'!

!TusLibrosInterfaceTest methodsFor: 'setUp/tearDown' stamp: 'SF 11/11/2019 19:54:41'!
setUp 

	testObjectsFactory := StoreTestObjectsFactory new.
	aClientID := 1234.
	anInvalidClientID := 0000.
	aPassword := 5678.
	aClientInvalidPassword := 1111.
	validCardNumber := 1234123412341234.
	validExpirationDate := Month month: 12 year: (SmallInteger maxVal) .
	validCardOwner := 'Pepe'.
	authenticationSystem := Dictionary new.
	authenticationSystem at: aClientID put: aPassword .
	catalog := testObjectsFactory defaultCatalog .
	debitBehavior := [ :anAmount :aCreditCard | ].
	merchantProcessor := self.! !


!TusLibrosInterfaceTest methodsFor: 'testing' stamp: 'SF 11/11/2019 18:56:59'!
test01ClientCanCreateACart
	
	| tusLibrosInterface aCartID salesBook |
	
	salesBook := OrderedCollection new.
	
	tusLibrosInterface := TusLibrosInterface validatingAt: authenticationSystem registeringOn: salesBook offering: catalog with: merchantProcessor.
	aCartID := tusLibrosInterface createCartFor: aClientID withPassword: aPassword. 
	
	self assert: (tusLibrosInterface listCart: aCartID) isEmpty.
	
	
	! !

!TusLibrosInterfaceTest methodsFor: 'testing' stamp: 'SF 11/11/2019 18:57:10'!
test02UnregisteredClientCantCreateACart
	
	| tusLibrosInterface salesBook |
	
	salesBook  := OrderedCollection new.
	
	tusLibrosInterface := TusLibrosInterface validatingAt: authenticationSystem registeringOn: salesBook offering: catalog with: merchantProcessor.
	
	self 
		should: [ tusLibrosInterface createCartFor: anInvalidClientID withPassword: aPassword ]
		raise: Error - MessageNotUnderstood
		withExceptionDo: [ :anError |
			self assert: anError messageText = tusLibrosInterface invalidClientOrPasswordErrorMessage. ].
	
	
	! !

!TusLibrosInterfaceTest methodsFor: 'testing' stamp: 'SF 11/11/2019 18:57:18'!
test03RegisteredClientWithWrongPasswordCantCreateACart
	
	| tusLibrosInterface salesBook |
	
	salesBook := OrderedCollection new.
	
	tusLibrosInterface := TusLibrosInterface validatingAt: authenticationSystem registeringOn: salesBook offering: catalog with: merchantProcessor.
	
	self 
		should: [ tusLibrosInterface createCartFor: aClientID withPassword: aClientInvalidPassword ]
		raise: Error - MessageNotUnderstood
		withExceptionDo: [ :anError |
			self assert: anError messageText = tusLibrosInterface invalidClientOrPasswordErrorMessage. ].
	
	
	! !

!TusLibrosInterfaceTest methodsFor: 'testing' stamp: 'SF 11/11/2019 18:57:25'!
test04AClientCanAddBooksOfTheStoreToHisCart
	|shoppings tusLibrosInterface aCartID aBookISBN aQuantity salesBook |
	
	salesBook := OrderedCollection new.
	
	aBookISBN := testObjectsFactory itemSellByTheStore.
	aQuantity := 3.
	
	shoppings:= Bag new.
	shoppings add:  testObjectsFactory itemSellByTheStore withOccurrences: 3.
	
	tusLibrosInterface := TusLibrosInterface validatingAt: authenticationSystem registeringOn: salesBook offering: catalog with: merchantProcessor.
	aCartID := tusLibrosInterface createCartFor: aClientID withPassword: aPassword. 
	
	tusLibrosInterface add: aQuantity of: aBookISBN to: aCartID.
	
	self assert: shoppings equals: (tusLibrosInterface listCart: aCartID).
	
	
	! !

!TusLibrosInterfaceTest methodsFor: 'testing' stamp: 'SF 11/11/2019 19:01:24'!
test05AClientWhoAlreadyHasACartCanCreateAnotherCart
	| tusLibrosInterface aCartID anotherCartID shoppingsACartID shoppingsAnotherCartID salesBook |
	
	salesBook := OrderedCollection new.
	
	tusLibrosInterface := TusLibrosInterface validatingAt: authenticationSystem registeringOn: salesBook offering: catalog with: merchantProcessor.
	aCartID := tusLibrosInterface createCartFor: aClientID withPassword: aPassword. 
	tusLibrosInterface add: 1 of: testObjectsFactory itemSellByTheStore to: aCartID .
	anotherCartID := tusLibrosInterface createCartFor: aClientID withPassword: aPassword.
	
	shoppingsACartID := Bag new.
	shoppingsACartID add: testObjectsFactory itemSellByTheStore .
	shoppingsAnotherCartID := Bag new.
	
	self assert: aCartID ~= anotherCartID .
	self assert: shoppingsACartID equals: (tusLibrosInterface listCart: aCartID ).
	self assert: shoppingsAnotherCartID equals: (tusLibrosInterface listCart: anotherCartID ).	
	
	! !

!TusLibrosInterfaceTest methodsFor: 'testing' stamp: 'SF 11/11/2019 19:03:13'!
test06CantListCartOfAnUnregisteredCart
	| anUnexistentCartID tusLibrosInterface salesBook |
	
	salesBook := OrderedCollection new.
	
	tusLibrosInterface := TusLibrosInterface validatingAt: authenticationSystem registeringOn: salesBook offering: catalog with: merchantProcessor.
	anUnexistentCartID := 4567.
	
	self 
		should: [ tusLibrosInterface listCart: anUnexistentCartID.  ]
		raise: Error - MessageNotUnderstood
		withExceptionDo: [ :anError |
			self assert: anError messageText = tusLibrosInterface cartDoesntExistErrorMessage ].
	
	
	
	! !

!TusLibrosInterfaceTest methodsFor: 'testing' stamp: 'SF 11/11/2019 19:03:37'!
test07CantAddBooksToAnUnregisteredCart
	| anUnexistentCartID tusLibrosInterface aBookISBN aQuantity salesBook |
	
	salesBook := OrderedCollection new.
	
	aBookISBN := testObjectsFactory itemSellByTheStore.
	aQuantity := 3.
	
	tusLibrosInterface := TusLibrosInterface validatingAt: authenticationSystem registeringOn: salesBook offering: catalog with: merchantProcessor.
	
	anUnexistentCartID := 4567.
	
	self 
		should: [ tusLibrosInterface add: aQuantity of: aBookISBN to: anUnexistentCartID ]
		raise: Error - MessageNotUnderstood
		withExceptionDo: [ :anError |
			self assert: anError messageText = tusLibrosInterface cartDoesntExistErrorMessage. ].
	
	
	
	! !

!TusLibrosInterfaceTest methodsFor: 'testing' stamp: 'SF 11/11/2019 19:55:19'!
test08AfterACartCheckoutTheCartDoesntExist
	| tusLibrosInterface aCartID aBookISBN aQuantity salesBook sales |
	
	salesBook := OrderedCollection new.
	
	aBookISBN := testObjectsFactory itemSellByTheStore.
	aQuantity := 3.
	
	tusLibrosInterface := TusLibrosInterface validatingAt: authenticationSystem registeringOn: salesBook offering: catalog with: merchantProcessor.
	aCartID := tusLibrosInterface createCartFor: aClientID withPassword: aPassword. 
	
	tusLibrosInterface add: aQuantity of: aBookISBN to: aCartID.
	tusLibrosInterface checkoutCart: aCartID with: validCardNumber expiringOn: validExpirationDate of: validCardOwner .	
	
	sales := OrderedCollection new.
	sales add: (Sale of: (3 * testObjectsFactory itemSellByTheStorePrice )).
	
	self 
		should: [ tusLibrosInterface listCart: aCartID ]
		raise: Error - MessageNotUnderstood
		withExceptionDo: [ :anError |
			self assert: anError messageText = tusLibrosInterface cartDoesntExistErrorMessage.
			self assert: sales equals: salesBook ].
	
	! !

!TusLibrosInterfaceTest methodsFor: 'testing' stamp: 'SF 11/11/2019 19:09:52'!
test09CantCheckoutAnUnregisteredCart
	| anUnexistentCartID tusLibrosInterface salesBook |
	
	salesBook := OrderedCollection new.
	
	tusLibrosInterface := TusLibrosInterface validatingAt: authenticationSystem registeringOn: salesBook offering: catalog with: merchantProcessor.
	anUnexistentCartID := 4567.
	
	self 
		should: [ tusLibrosInterface checkoutCart: anUnexistentCartID with: validCardNumber  expiringOn: validExpirationDate of: validCardOwner.  ]
		raise: Error - MessageNotUnderstood
		withExceptionDo: [ :anError |
			self assert: anError messageText = tusLibrosInterface cartDoesntExistErrorMessage. ].! !

!TusLibrosInterfaceTest methodsFor: 'testing' stamp: 'SF 11/11/2019 20:45:43'!
test10ListPurchasesOfAClientWithNoShoppingsIsEmpty
	| tusLibrosInterface salesBook purchases |
	
	salesBook := OrderedCollection new.
	
	tusLibrosInterface := TusLibrosInterface validatingAt: authenticationSystem registeringOn: salesBook offering: catalog with: merchantProcessor.
	
	purchases := OrderedCollection new.
	purchases add: 0.
	
	self assert: purchases equals: (tusLibrosInterface listPurchasesOf: aClientID with: aPassword).! !

!TusLibrosInterfaceTest methodsFor: 'testing' stamp: 'SF 11/11/2019 20:48:22'!
test11ListPurchasesOfAClientWithShoppingsListTheShoppings
	| tusLibrosInterface salesBook purchases |
	
	salesBook := OrderedCollection new.
	
	tusLibrosInterface := TusLibrosInterface validatingAt: authenticationSystem registeringOn: salesBook offering: catalog with: merchantProcessor.
	
	purchases := OrderedCollection new.
	purchases add: 0.
	
	self assert: purchases equals: (tusLibrosInterface listPurchasesOf: aClientID with: aPassword).! !


!TusLibrosInterfaceTest methodsFor: 'merchant processor protocol' stamp: 'SF 11/11/2019 19:51:28'!
debit: anAmount from: aCreditCard 

	^debitBehavior value: anAmount value: aCreditCard ! !


!classDefinition: #Cart category: #TusLibros stamp: 'SF 11/11/2019 21:11:49'!
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


!Cart methodsFor: 'assertions' stamp: 'HernanWilkinson 6/17/2013 18:06'!
assertIsValidItem: anItem

	(catalog includesKey: anItem) ifFalse: [ self error: self invalidItemErrorMessage ]! !

!Cart methodsFor: 'assertions' stamp: 'HernanWilkinson 6/17/2013 17:51'!
assertIsValidQuantity: aQuantity

	aQuantity strictlyPositive ifFalse: [ self error: self invalidQuantityErrorMessage ]! !


!Cart methodsFor: 'initialization' stamp: 'HernanWilkinson 6/17/2013 17:48'!
initializeAcceptingItemsOf: aCatalog

	catalog := aCatalog.
	items := OrderedCollection new.! !


!Cart methodsFor: 'queries' stamp: 'HernanWilkinson 6/17/2013 17:45'!
occurrencesOf: anItem

	^items occurrencesOf: anItem  ! !


!Cart methodsFor: 'testing' stamp: 'HernanWilkinson 6/17/2013 17:44'!
includes: anItem

	^items includes: anItem ! !

!Cart methodsFor: 'testing' stamp: 'HernanWilkinson 6/17/2013 17:44'!
isEmpty
	
	^items isEmpty ! !


!Cart methodsFor: 'total' stamp: 'HernanWilkinson 6/17/2013 19:09'!
total

	^ items sum: [ :anItem | catalog at: anItem ]! !


!Cart methodsFor: 'adding' stamp: 'HernanWilkinson 6/17/2013 17:44'!
add: anItem

	^ self add: 1 of: anItem ! !

!Cart methodsFor: 'adding' stamp: 'HernanWilkinson 6/17/2013 17:51'!
add: aQuantity of: anItem

	self assertIsValidQuantity: aQuantity.
	self assertIsValidItem: anItem.

	1 to: aQuantity do: [ :aNumber | items add: anItem ]! !

!Cart methodsFor: 'adding' stamp: 'SF 11/11/2019 18:21:20'!
listBooks
	|shoppings|
	
	shoppings := items copyFrom: 1 to: items size.
	
	
	^shoppings asBag.! !

"-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- "!

!classDefinition: 'Cart class' category: #TusLibros stamp: 'SF 11/11/2019 21:11:49'!
Cart class
	instanceVariableNames: ''!

!Cart class methodsFor: 'instance creation' stamp: 'HernanWilkinson 6/17/2013 17:48'!
acceptingItemsOf: aCatalog

	^self new initializeAcceptingItemsOf: aCatalog ! !


!classDefinition: #Cashier category: #TusLibros stamp: 'SF 11/11/2019 21:11:49'!
Object subclass: #Cashier
	instanceVariableNames: 'client cart salesBook merchantProcessor creditCard total'
	classVariableNames: ''
	poolDictionaries: ''
	category: 'TusLibros'!

!Cashier methodsFor: 'checkout - private' stamp: 'HernanWilkinson 6/17/2013 19:08'!
calculateTotal

	total := cart total.
	! !

!Cashier methodsFor: 'checkout - private' stamp: 'SF 11/11/2019 21:03:40'!
createSale

	^ Sale of: total for: client.
! !

!Cashier methodsFor: 'checkout - private' stamp: 'HernanWilkinson 6/17/2013 19:06'!
debitTotal

	merchantProcessor debit: total from: creditCard.
	! !

!Cashier methodsFor: 'checkout - private' stamp: 'SF 11/11/2019 20:58:28'!
registerSale

	salesBook add: self createSale! !


!Cashier methodsFor: 'checkout' stamp: 'SF 11/11/2019 20:58:42'!
checkOut

	self calculateTotal.
	self debitTotal.
	self registerSale.

	^ total! !


!Cashier methodsFor: 'initialization' stamp: 'SF 11/11/2019 21:03:59'!
initializeToCheckout: aCart charging: aCreditCard through: aMerchantProcessor registeringOn: aSalesBook for: aClient
	
	cart := aCart.
	creditCard := aCreditCard.
	merchantProcessor := aMerchantProcessor.
	salesBook := aSalesBook.
	client := aClient .! !

"-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- "!

!classDefinition: 'Cashier class' category: #TusLibros stamp: 'SF 11/11/2019 21:11:49'!
Cashier class
	instanceVariableNames: ''!

!Cashier class methodsFor: 'assertions' stamp: 'HernanWilkinson 6/17/2013 18:22'!
assertIsNotEmpty: aCart 
	
	aCart isEmpty ifTrue: [self error: self cartCanNotBeEmptyErrorMessage ]! !

!Cashier class methodsFor: 'assertions' stamp: 'HernanWilkinson 6/17/2013 18:23'!
assertIsNotExpired: aCreditCard on: aDate
	
	(aCreditCard isExpiredOn: aDate) ifTrue: [ self error: self canNotChargeAnExpiredCreditCardErrorMessage ]! !


!Cashier class methodsFor: 'instance creation' stamp: 'SF 11/11/2019 21:00:23'!
toCheckout: aCart charging: aCreditCard through: aMerchantProcessor on: aDate registeringOn: aSalesBook for: aClient
	
	self assertIsNotEmpty: aCart.
	self assertIsNotExpired: aCreditCard on: aDate.
	
	^self new initializeToCheckout: aCart charging: aCreditCard through: aMerchantProcessor registeringOn: aSalesBook for: aClient .! !


!Cashier class methodsFor: 'error messages' stamp: 'HernanWilkinson 6/17/2013 18:21'!
canNotChargeAnExpiredCreditCardErrorMessage
	
	^'Can not charge an expired credit card'! !

!Cashier class methodsFor: 'error messages' stamp: 'HernanWilkinson 6/17/2013 17:56'!
cartCanNotBeEmptyErrorMessage
	
	^'Can not check out an empty cart'! !

!Cashier class methodsFor: 'error messages' stamp: 'HernanWilkinson 6/17/2013 19:02'!
creditCardHasNoCreditErrorMessage
	
	^'Credit card has no credit'! !


!classDefinition: #CreditCard category: #TusLibros stamp: 'SF 11/11/2019 21:11:49'!
Object subclass: #CreditCard
	instanceVariableNames: 'expiration cardNumber cardOwner'
	classVariableNames: ''
	poolDictionaries: ''
	category: 'TusLibros'!

!CreditCard methodsFor: 'testing' stamp: 'HernanWilkinson 6/17/2013 18:39'!
isExpiredOn: aDate 
	
	^expiration start < (Month month: aDate monthIndex year: aDate yearNumber) start ! !


!CreditCard methodsFor: 'initialization' stamp: 'SF 11/11/2019 19:36:51'!
initializeNumber: aNumber of: anOwner expiringOn: aMonth

	cardNumber := aNumber.
	cardOwner := anOwner .
	expiration := aMonth.! !

"-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- "!

!classDefinition: 'CreditCard class' category: #TusLibros stamp: 'SF 11/11/2019 21:11:49'!
CreditCard class
	instanceVariableNames: ''!

!CreditCard class methodsFor: 'instance creation' stamp: 'SF 11/11/2019 19:41:38'!
number: aNumber of: anOwner expiringOn: aMonth
	
	^self new initializeNumber: aNumber of: anOwner expiringOn: aMonth! !


!classDefinition: #Sale category: #TusLibros stamp: 'SF 11/11/2019 21:11:49'!
Object subclass: #Sale
	instanceVariableNames: 'total client'
	classVariableNames: ''
	poolDictionaries: ''
	category: 'TusLibros'!

!Sale methodsFor: 'total' stamp: 'SF 11/11/2019 19:56:16'!
= aSale

	^ total = aSale total! !

!Sale methodsFor: 'total' stamp: 'HernanWilkinson 6/17/2013 18:48'!
total
	
	^ total! !


!Sale methodsFor: 'initialization' stamp: 'SF 11/11/2019 21:10:58'!
initializeTotal: aTotal for: aClient

	client:= aClient.
	total := aTotal ! !

"-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- "!

!classDefinition: 'Sale class' category: #TusLibros stamp: 'SF 11/11/2019 21:11:49'!
Sale class
	instanceVariableNames: ''!

!Sale class methodsFor: 'instance creation' stamp: 'SF 11/11/2019 21:10:05'!
of: aTotal for: aClient

	"should assert total is not negative or 0!!"
	^self new initializeTotal: aTotal for: aClient. ! !


!classDefinition: #StoreTestObjectsFactory category: #TusLibros stamp: 'SF 11/11/2019 21:11:49'!
Object subclass: #StoreTestObjectsFactory
	instanceVariableNames: 'today'
	classVariableNames: ''
	poolDictionaries: ''
	category: 'TusLibros'!

!StoreTestObjectsFactory methodsFor: 'items' stamp: 'HernanWilkinson 6/17/2013 18:08'!
itemNotSellByTheStore
	
	^'invalidBook'! !

!StoreTestObjectsFactory methodsFor: 'items' stamp: 'HernanWilkinson 6/17/2013 18:08'!
itemSellByTheStore
	
	^ 'validBook'! !

!StoreTestObjectsFactory methodsFor: 'items' stamp: 'HernanWilkinson 6/17/2013 18:08'!
itemSellByTheStorePrice
	
	^10! !


!StoreTestObjectsFactory methodsFor: 'cart' stamp: 'HernanWilkinson 6/17/2013 18:08'!
createCart
	
	^Cart acceptingItemsOf: self defaultCatalog! !

!StoreTestObjectsFactory methodsFor: 'cart' stamp: 'HernanWilkinson 6/17/2013 18:08'!
defaultCatalog
	
	^ Dictionary new
		at: self itemSellByTheStore put: self itemSellByTheStorePrice;
		yourself ! !


!StoreTestObjectsFactory methodsFor: 'credit card' stamp: 'SF 11/11/2019 19:34:24'!
expiredCreditCard
	
	^CreditCard initializeNumber: 1234123412341234 of: 'Pepe' expiringOn: (Month month: today monthIndex year: today yearNumber - 1)! !

!StoreTestObjectsFactory methodsFor: 'credit card' stamp: 'SF 11/11/2019 19:34:52'!
notExpiredCreditCard
	
	^CreditCard initializeNumber: 1234123412341234 of: 'Pepe' expiringOn: (Month month: today monthIndex year: today yearNumber + 1)! !


!StoreTestObjectsFactory methodsFor: 'initialization' stamp: 'HernanWilkinson 6/17/2013 18:37'!
initialize

	today := DateAndTime now! !


!StoreTestObjectsFactory methodsFor: 'client' stamp: 'SF 11/11/2019 21:08:22'!
validClient

	^ 5.! !


!StoreTestObjectsFactory methodsFor: 'date' stamp: 'HernanWilkinson 6/17/2013 18:37'!
today
	
	^ today! !


!classDefinition: #TusLibrosInterface category: #TusLibros stamp: 'SF 11/11/2019 21:11:50'!
Object subclass: #TusLibrosInterface
	instanceVariableNames: 'carts authenticationSystem lastCartID catalog salesBook merchantProcessor cartsOwners'
	classVariableNames: ''
	poolDictionaries: ''
	category: 'TusLibros'!

!TusLibrosInterface methodsFor: 'as yet unclassified' stamp: 'SF 11/11/2019 16:02:45'!
add: aQuantity of: aBookISBN to: aCartID.
	
	self assertCartExists: aCartID .
	
	(carts at: aCartID) add: aQuantity of: aBookISBN. ! !

!TusLibrosInterface methodsFor: 'as yet unclassified' stamp: 'SF 11/11/2019 16:02:22'!
assertCartExists: aCartID
	
	^(self hasRegisteredCart: aCartID) ifFalse: [self error: self cartDoesntExistErrorMessage].
	
	! !

!TusLibrosInterface methodsFor: 'as yet unclassified' stamp: 'SF 11/11/2019 18:02:24'!
assertClientExists: aClientID 

	(authenticationSystem includesKey: aClientID) ifFalse: [self error: self invalidClientOrPasswordErrorMessage].
	
	! !

!TusLibrosInterface methodsFor: 'as yet unclassified' stamp: 'SF 11/11/2019 18:07:58'!
assertPassword: aPassword matchesWith: aClientID

	((authenticationSystem at: aClientID) = aPassword ) ifFalse: [self error: self invalidClientOrPasswordErrorMessage].


	
	! !

!TusLibrosInterface methodsFor: 'as yet unclassified' stamp: 'SF 11/11/2019 18:06:51'!
assertValidUser: aClientID with: aPassword
	
	self assertClientExists: aClientID .
	self assertPassword: aPassword matchesWith: aClientID. 
	
	! !

!TusLibrosInterface methodsFor: 'as yet unclassified' stamp: 'SF 11/11/2019 15:57:23'!
cartDoesntExistErrorMessage

	^ 'Cart doesnt exist!!'! !

!TusLibrosInterface methodsFor: 'as yet unclassified' stamp: 'SF 11/11/2019 21:06:23'!
checkoutCart: aCartID with: aCreditCardNumber expiringOn: anExpirationDate of: aCreditCardOwner

	| cashier aCreditCard |

	self assertCartExists: aCartID .
	
	aCreditCard := CreditCard number: aCreditCardNumber of: aCreditCardOwner expiringOn: anExpirationDate .
	
	cashier := Cashier toCheckout: (carts at: aCartID) charging: aCreditCard through: merchantProcessor on: DateAndTime now registeringOn: salesBook for: (cartsOwners at: aCartID).
	
	cashier checkOut .
	
	self removeCart: aCartID.! !

!TusLibrosInterface methodsFor: 'as yet unclassified' stamp: 'SF 11/7/2019 20:12:02'!
clientAlreadyHasACartErrorMessage

	^ 'Client already has a cart!!'! !

!TusLibrosInterface methodsFor: 'as yet unclassified' stamp: 'SF 11/11/2019 21:07:44'!
createCartFor: aClientID withPassword: aPassword
	
	self assertValidUser: aClientID with: aPassword .
	lastCartID := lastCartID + 1.
	
	carts at: lastCartID put: (Cart acceptingItemsOf: catalog).
	cartsOwners at: lastCartID put: aClientID .
	^ lastCartID .! !

!TusLibrosInterface methodsFor: 'as yet unclassified' stamp: 'SF 11/7/2019 21:17:56'!
hasRegisteredCart: aCartID

	^carts includesKey: aCartID.! !

!TusLibrosInterface methodsFor: 'as yet unclassified' stamp: 'SF 11/11/2019 17:58:09'!
invalidClientOrPasswordErrorMessage.

	^ 'User and/or password are incorrect!!'.! !

!TusLibrosInterface methodsFor: 'as yet unclassified' stamp: 'SF 11/11/2019 16:02:35'!
listCart: aCartID
	
	self assertCartExists: aCartID .
		
	^ (carts at: aCartID) listBooks.	! !

!TusLibrosInterface methodsFor: 'as yet unclassified' stamp: 'SF 11/11/2019 20:46:58'!
listPurchasesOf: aClientID with: aPassword

	^ OrderedCollection with: 0.! !

!TusLibrosInterface methodsFor: 'as yet unclassified' stamp: 'SF 11/11/2019 19:09:13'!
removeCart: aCartID

	carts removeKey: aCartID .! !

!TusLibrosInterface methodsFor: 'as yet unclassified' stamp: 'SF 11/11/2019 21:07:01'!
validatingAt: anAuthenticationSystem registeringOn: aSalesBook offering: aCatalog with: aMerchantProcessor
	
	lastCartID := 0.
	carts := Dictionary new.
	cartsOwners := Dictionary new.
	authenticationSystem := anAuthenticationSystem.
	salesBook := aSalesBook .
	catalog := aCatalog .
	merchantProcessor := aMerchantProcessor.
	! !

"-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- "!

!classDefinition: 'TusLibrosInterface class' category: #TusLibros stamp: 'SF 11/11/2019 21:11:50'!
TusLibrosInterface class
	instanceVariableNames: ''!

!TusLibrosInterface class methodsFor: 'as yet unclassified' stamp: 'SF 11/11/2019 18:45:50'!
validatingAt: anAuthenticationSystem registeringOn: aSalesBook offering: aCatalog with: aMerchantProcessor

	"CAMBIAR EL NOMBRE!!!!!!!!!!!!"

	^ self new validatingAt: anAuthenticationSystem registeringOn: aSalesBook offering: aCatalog with: aMerchantProcessor! !
