!classDefinition: #CartTest category: #'TusLibros - Test'!
TestCase subclass: #CartTest
	instanceVariableNames: 'testObjectsFactory'
	classVariableNames: ''
	poolDictionaries: ''
	category: 'TusLibros - Test'!

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

!CartTest methodsFor: 'tests' stamp: 'mm 11/18/2019 12:42:47'!
test06CartRemembersAddedItems

	| cart |
	
	cart := testObjectsFactory createCart.
	
	cart add: testObjectsFactory itemSellByTheStore.
	self assert: (cart containsBook: testObjectsFactory itemSellByTheStore)! !

!CartTest methodsFor: 'tests' stamp: 'mm 11/18/2019 12:42:55'!
test07CartDoesNotHoldNotAddedItems

	| cart |
	
	cart := testObjectsFactory createCart.
	
	self deny: (cart containsBook: testObjectsFactory itemSellByTheStore)! !

!CartTest methodsFor: 'tests' stamp: 'HernanWilkinson 6/17/2013 18:11'!
test08CartRemembersTheNumberOfAddedItems

	| cart |
	
	cart := testObjectsFactory createCart.
	
	cart add: 2 of: testObjectsFactory itemSellByTheStore.
	self assert: (cart occurrencesOf: testObjectsFactory itemSellByTheStore) = 2! !

!CartTest methodsFor: 'tests' stamp: 'mm 11/18/2019 14:33:32'!
test09TotalPriceWithNoProductsShouldBeZero! !

!CartTest methodsFor: 'tests' stamp: 'mm 11/18/2019 14:33:42'!
test10TotalPriceWithProductsShouldBeTheSumOfThePrices! !


!CartTest methodsFor: 'setup' stamp: 'HernanWilkinson 6/17/2013 18:09'!
setUp 

	testObjectsFactory := StoreTestObjectsFactory new.! !


!classDefinition: #CashierTest category: #'TusLibros - Test'!
TestCase subclass: #CashierTest
	instanceVariableNames: 'testObjectsFactory debitBehavior'
	classVariableNames: ''
	poolDictionaries: ''
	category: 'TusLibros - Test'!

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


!classDefinition: #CreditCardTest category: #'TusLibros - Test'!
TestCase subclass: #CreditCardTest
	instanceVariableNames: ''
	classVariableNames: ''
	poolDictionaries: ''
	category: 'TusLibros - Test'!

!CreditCardTest methodsFor: 'as yet unclassified' stamp: 'mm 11/18/2019 14:37:28'!
test01NewCreditCardShouldHaveAllAttributesSet! !

!CreditCardTest methodsFor: 'as yet unclassified' stamp: 'mm 11/18/2019 14:37:40'!
test02ExpiredCreditCardShouldBeExpired! !

!CreditCardTest methodsFor: 'as yet unclassified' stamp: 'mm 11/18/2019 14:37:51'!
test03CreditCardShouldNotBeExpiredOnSameYearMonthAsExpiration! !

!CreditCardTest methodsFor: 'as yet unclassified' stamp: 'mm 11/18/2019 14:38:04'!
test04CreditCardShouldNotBeExpiredBeforeExpirationYearMonth! !

!CreditCardTest methodsFor: 'as yet unclassified' stamp: 'mm 11/18/2019 14:38:16'!
test05CantCreateCreditCardWithNumberLengthDifferentFrom16! !

!CreditCardTest methodsFor: 'as yet unclassified' stamp: 'mm 11/18/2019 14:38:29'!
test06NumberShouldHaveAllDigits! !

!CreditCardTest methodsFor: 'as yet unclassified' stamp: 'mm 11/18/2019 14:38:40'!
test07OwnerCantBeEmpty! !


!classDefinition: #ManualClock category: #'TusLibros - Test'!
TestCase subclass: #ManualClock
	instanceVariableNames: 'currentDateTime'
	classVariableNames: ''
	poolDictionaries: ''
	category: 'TusLibros - Test'!

!ManualClock methodsFor: 'accessing' stamp: 'mm 11/18/2019 14:40:43'!
now
	^currentDateTime! !


!ManualClock methodsFor: 'advancing time' stamp: 'mm 11/18/2019 14:40:21'!
advance: aTimeMeasure
	currentDateTime _ currentDateTime next: aTimeMeasure.! !


!ManualClock methodsFor: 'initialization' stamp: 'mm 11/18/2019 14:40:33'!
initializeOn: aTimePoint
	currentDateTime _ aTimePoint.! !

"-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- "!

!classDefinition: 'ManualClock class' category: #'TusLibros - Test'!
ManualClock class
	instanceVariableNames: ''!

!ManualClock class methodsFor: 'as yet unclassified' stamp: 'mm 11/18/2019 14:41:46'!
startingAt: aTimePoint
	^self new initializeOn: aTimePoint.! !

!ManualClock class methodsFor: 'as yet unclassified' stamp: 'mm 11/18/2019 14:41:57'!
startingNow
	^self startingAt: GregorianDateTime now.! !


!classDefinition: #TusLibrosInterfaceTest category: #'TusLibros - Test'!
TestCase subclass: #TusLibrosInterfaceTest
	instanceVariableNames: 'aPassword testObjectsFactory aClientID validCardNumber validExpirationDate validCardOwner authenticationSystem anInvalidClientID aClientInvalidPassword catalog merchantProcessor debitBehavior now'
	classVariableNames: ''
	poolDictionaries: ''
	category: 'TusLibros - Test'!

!TusLibrosInterfaceTest methodsFor: 'setUp' stamp: 'mm 11/18/2019 15:02:06'!
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
	merchantProcessor := self.
	now _ GregorianDateTime now.! !


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

!TusLibrosInterfaceTest methodsFor: 'testing' stamp: 'mm 11/18/2019 14:48:34'!
test12DifferentCreatedCartsShouldHaveDifferentId! !

!TusLibrosInterfaceTest methodsFor: 'testing' stamp: 'mm 11/18/2019 14:50:55'!
test13ProductAddedWithAmountGreaterThanOneShouldAppearInListWithRightAmount! !

!TusLibrosInterfaceTest methodsFor: 'testing' stamp: 'mm 11/18/2019 14:51:19'!
test14ManyProductsAddedToSameCartShouldBeListed! !

!TusLibrosInterfaceTest methodsFor: 'testing' stamp: 'mm 11/18/2019 14:51:49'!
test15CantAddLessThanOneBook! !

!TusLibrosInterfaceTest methodsFor: 'testing' stamp: 'mm 11/18/2019 14:52:38'!
test16CheckingOutAValidCartShouldDebitTheRightAmount
! !

!TusLibrosInterfaceTest methodsFor: 'testing' stamp: 'mm 11/18/2019 14:53:15'!
test17ListingPurchasesWithoutAnyPurchasesShouldReturnAnEmptyList! !

!TusLibrosInterfaceTest methodsFor: 'testing' stamp: 'mm 11/18/2019 14:53:28'!
test18ListingPurchasesWithOnePurchaseShouldReturnTheCorrectPurchaseAmount! !

!TusLibrosInterfaceTest methodsFor: 'testing' stamp: 'mm 11/18/2019 14:53:38'!
test19ListingPurchasesWithManyBooksShouldReturnTheCorrectPurchaseAmount! !

!TusLibrosInterfaceTest methodsFor: 'testing' stamp: 'mm 11/18/2019 14:53:52'!
test20ListingPurchasesWithManyCheckoutsShouldReturnTheCorrectPurchaseAmount! !

!TusLibrosInterfaceTest methodsFor: 'testing' stamp: 'mm 11/18/2019 14:54:07'!
test21ListingPurchasesOfDifferentClientsShouldListCorrespondingPurchases! !

!TusLibrosInterfaceTest methodsFor: 'testing' stamp: 'mm 11/18/2019 14:54:19'!
test22CantListPurchasesOfNonRegisteredClient! !

!TusLibrosInterfaceTest methodsFor: 'testing' stamp: 'mm 11/18/2019 14:54:41'!
test23CantCheckoutSameCartTwice! !

!TusLibrosInterfaceTest methodsFor: 'testing' stamp: 'mm 11/18/2019 15:04:57'!
test24CantAddToCartAfter30MinutesHavePassed
	
	| tusLibrosInterface aCartID aBookISBN aQuantity salesBook |
	
	salesBook := OrderedCollection new.
	aBookISBN := testObjectsFactory itemSellByTheStore.
	aQuantity := 1.
	
	tusLibrosInterface := TusLibrosInterface validatingAt: authenticationSystem registeringOn: salesBook offering: catalog with: merchantProcessor.
	aCartID := tusLibrosInterface createCartFor: aClientID withPassword: aPassword. 
	
	self advanceMinutesAmount: 30.
	
	self 
		should: [ tusLibrosInterface add: aQuantity of: aBookISBN to: aCartID.  ]
		raise: Error - MessageNotUnderstood
		withExceptionDo: [ :anError | ].
		
	! !

!TusLibrosInterfaceTest methodsFor: 'testing' stamp: 'mm 11/18/2019 14:55:12'!
test25CantCheckoutCartAfter30MinutesHavePassedSinceCreation! !

!TusLibrosInterfaceTest methodsFor: 'testing' stamp: 'mm 11/18/2019 14:55:28'!
test26AddingToCartResets30MinuteDeleteTimer
! !

!TusLibrosInterfaceTest methodsFor: 'testing' stamp: 'mm 11/18/2019 14:55:41'!
test27CantCheckoutCartAfter30MinutesHavePassedSinceAdding
! !

!TusLibrosInterfaceTest methodsFor: 'testing' stamp: 'mm 11/18/2019 14:55:55'!
test28CantListCartAfter30MinutesHavePassed! !

!TusLibrosInterfaceTest methodsFor: 'testing' stamp: 'mm 11/18/2019 14:56:35'!
test29ListingCartResets30MinuteDeleteTimer! !

!TusLibrosInterfaceTest methodsFor: 'testing' stamp: 'mm 11/18/2019 14:56:40'!
test30CantListCartAfterCheckout! !

!TusLibrosInterfaceTest methodsFor: 'testing' stamp: 'mm 11/18/2019 14:56:58'!
test31CantAddToCartAfterCheckout! !


!TusLibrosInterfaceTest methodsFor: 'merchant processor protocol' stamp: 'SF 11/11/2019 19:51:28'!
debit: anAmount from: aCreditCard 

	^debitBehavior value: anAmount value: aCreditCard ! !


!TusLibrosInterfaceTest methodsFor: 'as yet unclassified' stamp: 'mm 11/18/2019 15:02:37'!
advanceMinutesAmount: anAmountOfMinutes
	now _ now next: anAmountOfMinutes * TimeUnits minute.! !


!classDefinition: #StoreTestObjectsFactory category: #'TusLibros - Test'!
Object subclass: #StoreTestObjectsFactory
	instanceVariableNames: 'today'
	classVariableNames: ''
	poolDictionaries: ''
	category: 'TusLibros - Test'!

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
