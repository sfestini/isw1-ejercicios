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

!CartTest methodsFor: 'tests' stamp: 'sf 11/18/2019 16:50:00'!
test03AfterAddingAnItemTheCartIsNotEmptyAnymore

	| cart |
	
	cart := testObjectsFactory createCart.
	
	cart add: testObjectsFactory itemOneSellByTheStore.
	self deny: cart isEmpty ! !

!CartTest methodsFor: 'tests' stamp: 'sf 11/18/2019 16:50:00'!
test04CanNotAddNonPositiveNumberOfItems

	| cart |
	
	cart := testObjectsFactory createCart.
	
	self 
		should: [cart add: 0 of: testObjectsFactory itemOneSellByTheStore ]
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

!CartTest methodsFor: 'tests' stamp: 'sf 11/18/2019 16:50:00'!
test06CartRemembersAddedItems

	| cart |
	
	cart := testObjectsFactory createCart.
	
	cart add: testObjectsFactory itemOneSellByTheStore.
	self assert: (cart containsBook: testObjectsFactory itemOneSellByTheStore)! !

!CartTest methodsFor: 'tests' stamp: 'sf 11/18/2019 16:50:00'!
test07CartDoesNotHoldNotAddedItems

	| cart |
	
	cart := testObjectsFactory createCart.
	
	self deny: (cart containsBook: testObjectsFactory itemOneSellByTheStore)! !

!CartTest methodsFor: 'tests' stamp: 'sf 11/18/2019 16:50:00'!
test08CartRemembersTheNumberOfAddedItems

	| cart |
	
	cart := testObjectsFactory createCart.
	
	cart add: 2 of: testObjectsFactory itemOneSellByTheStore.
	self assert: (cart occurrencesOf: testObjectsFactory itemOneSellByTheStore) = 2! !

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

!CashierTest methodsFor: 'tests' stamp: 'sf 11/18/2019 17:30:41'!
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
			for: testObjectsFactory validClientOne ]
		raise: Error - MessageNotUnderstood
		withExceptionDo: [ :anError |
			self assert: anError messageText = Cashier cartCanNotBeEmptyErrorMessage.
			self assert: salesBook isEmpty ]! !

!CashierTest methodsFor: 'tests' stamp: 'sf 11/18/2019 17:30:41'!
test02CalculatedTotalIsCorrect

	| cart cashier |
	
	cart := testObjectsFactory createCart.
	cart add: 2 of: testObjectsFactory itemOneSellByTheStore.
	
	cashier :=  Cashier
		toCheckout: cart 
		charging: testObjectsFactory notExpiredCreditCard 
		through: self
		on: testObjectsFactory today 
		registeringOn: OrderedCollection new
		for: testObjectsFactory validClientOne.
		
	self assert: cashier checkOut = (testObjectsFactory itemOneSellByTheStorePrice * 2)! !

!CashierTest methodsFor: 'tests' stamp: 'sf 11/18/2019 17:30:41'!
test03CanNotCheckoutWithAnExpiredCreditCart

	| cart salesBook |

	cart := testObjectsFactory createCart.
	cart add: testObjectsFactory itemOneSellByTheStore.
	salesBook := OrderedCollection new.
	
	self
		should: [ Cashier 
				toCheckout: cart 
				charging: testObjectsFactory expiredCreditCard 
				through: self
				on: testObjectsFactory today
				registeringOn: salesBook
				for: testObjectsFactory validClientOne ]
		raise: Error - MessageNotUnderstood
		withExceptionDo: [ :anError | 
			self assert: anError messageText = Cashier canNotChargeAnExpiredCreditCardErrorMessage.
			self assert: salesBook isEmpty ]! !

!CashierTest methodsFor: 'tests' stamp: 'sf 11/18/2019 17:30:41'!
test04CheckoutRegistersASale

	| cart cashier salesBook total |

	cart := testObjectsFactory createCart.
	cart add: testObjectsFactory itemOneSellByTheStore.
	salesBook := OrderedCollection new.
 
	cashier:= Cashier 
		toCheckout: cart 
		charging: testObjectsFactory notExpiredCreditCard
		through: self
		on: testObjectsFactory today
		registeringOn: salesBook
		for: testObjectsFactory validClientOne.
		
	total := cashier checkOut.
					
	self assert: salesBook size = 1.
	self assert: salesBook first total = total.! !

!CashierTest methodsFor: 'tests' stamp: 'sf 11/18/2019 17:30:41'!
test05CashierChargesCreditCardUsingMerchantProcessor

	| cart cashier salesBook total creditCard debitedAmout debitedCreditCard  |

	cart := testObjectsFactory createCart.
	cart add: testObjectsFactory itemOneSellByTheStore.
	creditCard := testObjectsFactory notExpiredCreditCard.
	salesBook := OrderedCollection new.
 
	cashier:= Cashier 
		toCheckout: cart 
		charging: creditCard
		through: self
		on: testObjectsFactory today
		registeringOn: salesBook
		for: testObjectsFactory validClientOne.
		
	debitBehavior := [ :anAmount :aCreditCard | 
		debitedAmout := anAmount.
		debitedCreditCard := aCreditCard ].
	total := cashier checkOut.
					
	self assert: debitedCreditCard = creditCard.
	self assert: debitedAmout = total.! !

!CashierTest methodsFor: 'tests' stamp: 'sf 11/18/2019 17:30:41'!
test06CashierDoesNotSaleWhenTheCreditCardHasNoCredit

	| cart cashier salesBook creditCard |

	cart := testObjectsFactory createCart.
	cart add: testObjectsFactory itemOneSellByTheStore.
	creditCard := testObjectsFactory notExpiredCreditCard.
	salesBook := OrderedCollection new.
 	debitBehavior := [ :anAmount :aCreditCard | self error: Cashier creditCardHasNoCreditErrorMessage].
	
	cashier:= Cashier 
		toCheckout: cart 
		charging: creditCard
		through: self
		on: testObjectsFactory today
		registeringOn: salesBook
		for: testObjectsFactory validClientOne.
		
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


!classDefinition: #TusLibrosInterfaceTest category: #'TusLibros - Test'!
TestCase subclass: #TusLibrosInterfaceTest
	instanceVariableNames: 'testObjectsFactory merchantProcessor debitBehavior clock'
	classVariableNames: ''
	poolDictionaries: ''
	category: 'TusLibros - Test'!

!TusLibrosInterfaceTest methodsFor: 'setUp' stamp: 'sf 11/18/2019 18:25:45'!
setUp 

	testObjectsFactory := StoreTestObjectsFactory new.
	debitBehavior := [ :anAmount :aCreditCard | ].
	merchantProcessor := self.
	clock := GregorianDateTime now.! !


!TusLibrosInterfaceTest methodsFor: 'testing' stamp: 'sf 11/18/2019 19:07:54'!
test01ClientCanCreateACart
	
	| tusLibrosInterface aCartID salesBook |
	
	salesBook := OrderedCollection new.
	
	tusLibrosInterface := self createTusLibrosAPIWith: salesBook.
	aCartID := tusLibrosInterface createCartFor: testObjectsFactory validClientOne
									   withPassword: testObjectsFactory validPasswordOne. 
	
	self assert: (tusLibrosInterface listCart: aCartID) isEmpty.
	
	
	! !

!TusLibrosInterfaceTest methodsFor: 'testing' stamp: 'sf 11/18/2019 19:07:46'!
test02UnregisteredClientCantCreateACart
	
	| tusLibrosInterface salesBook |
	
	salesBook  := OrderedCollection new.
	
	tusLibrosInterface := self createTusLibrosAPIWith: salesBook.
	
	self 
		should: [ tusLibrosInterface createCartFor: testObjectsFactory invalidClient 
										withPassword: testObjectsFactory validPasswordOne ]
		raise: Error - MessageNotUnderstood
		withExceptionDo: [ :anError |
			self assert: anError messageText = tusLibrosInterface invalidClientOrPasswordErrorMessage. ].
	
	
	! !

!TusLibrosInterfaceTest methodsFor: 'testing' stamp: 'sf 11/18/2019 19:07:39'!
test03RegisteredClientWithWrongPasswordCantCreateACart
	
	| tusLibrosInterface salesBook |
	
	salesBook := OrderedCollection new.
	
	tusLibrosInterface := self createTusLibrosAPIWith: salesBook .
	
	self 
		should: [ tusLibrosInterface createCartFor: testObjectsFactory validClientOne 
										withPassword: testObjectsFactory invalidPassword ]
		raise: Error - MessageNotUnderstood
		withExceptionDo: [ :anError |
			self assert: anError messageText = tusLibrosInterface invalidClientOrPasswordErrorMessage. ].
	
	
	! !

!TusLibrosInterfaceTest methodsFor: 'testing' stamp: 'sf 11/18/2019 19:07:29'!
test04AClientCanAddBooksOfTheStoreToHisCart
	|shoppings tusLibrosInterface aCartID aBookISBN aQuantity salesBook |
	
	salesBook := OrderedCollection new.
	
	aBookISBN := testObjectsFactory itemOneSellByTheStore.
	aQuantity := 3.
	
	shoppings:= Bag new.
	shoppings add:  testObjectsFactory itemOneSellByTheStore withOccurrences: 3.
	
	tusLibrosInterface := self createTusLibrosAPIWith: salesBook.
	aCartID := tusLibrosInterface createCartFor: testObjectsFactory validClientOne
									   withPassword: testObjectsFactory validPasswordOne. 
	
	tusLibrosInterface add: aQuantity of: aBookISBN to: aCartID.
	
	self assert: shoppings equals: (tusLibrosInterface listCart: aCartID).
	
	
	! !

!TusLibrosInterfaceTest methodsFor: 'testing' stamp: 'sf 11/18/2019 19:07:08'!
test05AClientWhoAlreadyHasACartCanCreateAnotherCart
	| tusLibrosInterface aCartID anotherCartID shoppingsACartID shoppingsAnotherCartID salesBook |
	
	salesBook := OrderedCollection new.
	
	tusLibrosInterface := self createTusLibrosAPIWith: salesBook.
	aCartID := tusLibrosInterface createCartFor: testObjectsFactory validClientOne
									   withPassword: testObjectsFactory validPasswordOne. 
	tusLibrosInterface add: 1 of: testObjectsFactory itemOneSellByTheStore to: aCartID .
	anotherCartID := tusLibrosInterface createCartFor: testObjectsFactory validClientOne
											  withPassword: testObjectsFactory validPasswordOne.
	
	shoppingsACartID := Bag new.
	shoppingsACartID add: testObjectsFactory itemOneSellByTheStore .
	shoppingsAnotherCartID := Bag new.
	
	self assert: aCartID ~= anotherCartID .
	self assert: shoppingsACartID equals: (tusLibrosInterface listCart: aCartID ).
	self assert: shoppingsAnotherCartID equals: (tusLibrosInterface listCart: anotherCartID ).	
	
	! !

!TusLibrosInterfaceTest methodsFor: 'testing' stamp: 'sf 11/18/2019 15:52:37'!
test06CantListCartOfAnUnregisteredCart
	| anUnexistentCartID tusLibrosInterface salesBook |
	
	salesBook := OrderedCollection new.
	
	tusLibrosInterface := self createTusLibrosAPIWith: salesBook.
	anUnexistentCartID := 4567.
	
	self 
		should: [ tusLibrosInterface listCart: anUnexistentCartID.  ]
		raise: Error - MessageNotUnderstood
		withExceptionDo: [ :anError |
			self assert: anError messageText = tusLibrosInterface cartDoesntExistErrorMessage ].
	
	
	
	! !

!TusLibrosInterfaceTest methodsFor: 'testing' stamp: 'sf 11/18/2019 16:50:01'!
test07CantAddBooksToAnUnregisteredCart
	| anUnexistentCartID tusLibrosInterface aBookISBN aQuantity salesBook |
	
	salesBook := OrderedCollection new.
	
	aBookISBN := testObjectsFactory itemOneSellByTheStore.
	aQuantity := 3.
	
	tusLibrosInterface := self createTusLibrosAPIWith: salesBook.
	
	anUnexistentCartID := 4567.
	
	self 
		should: [ tusLibrosInterface add: aQuantity of: aBookISBN to: anUnexistentCartID ]
		raise: Error - MessageNotUnderstood
		withExceptionDo: [ :anError |
			self assert: anError messageText = tusLibrosInterface cartDoesntExistErrorMessage. ].
	
	
	
	! !

!TusLibrosInterfaceTest methodsFor: 'testing' stamp: 'sf 11/18/2019 17:40:09'!
test08AfterACartCheckoutTheCartDoesntExist
	| tusLibrosInterface aCartID aBookISBN aQuantity salesBook sales shoppings |
	
	salesBook := OrderedCollection new.
	
	aBookISBN := testObjectsFactory itemOneSellByTheStore.
	aQuantity := 3.
	
	tusLibrosInterface := self createTusLibrosAPIWith: salesBook.
	aCartID := tusLibrosInterface createCartFor: testObjectsFactory validClientOne
									   withPassword: testObjectsFactory validPasswordOne. 
	
	tusLibrosInterface add: aQuantity of: aBookISBN to: aCartID.
	tusLibrosInterface checkoutCart: aCartID with: testObjectsFactory validCardNumber 
													expiringOn: testObjectsFactory validExpirationDate 
													of: testObjectsFactory validCardOwner .	
	
	shoppings := Bag new.
	shoppings add: testObjectsFactory itemOneSellByTheStore withOccurrences: 3.
	sales := OrderedCollection new.
	sales add: (Sale of: shoppings valued: (3 * testObjectsFactory itemOneSellByTheStorePrice) for: testObjectsFactory validClientOne).
	
	self 
		should: [ tusLibrosInterface listCart: aCartID ]
		raise: Error - MessageNotUnderstood
		withExceptionDo: [ :anError |
			self assert: anError messageText = tusLibrosInterface cartDoesntExistErrorMessage.
			self assert: sales equals: salesBook ].
	
	! !

!TusLibrosInterfaceTest methodsFor: 'testing' stamp: 'sf 11/18/2019 17:40:33'!
test09CantCheckoutAnUnregisteredCart
	| anUnexistentCartID tusLibrosInterface salesBook |
	
	salesBook := OrderedCollection new.
	
	tusLibrosInterface := self createTusLibrosAPIWith: salesBook.
	anUnexistentCartID := 4567.
	
	self 
		should: [ tusLibrosInterface checkoutCart: anUnexistentCartID with: testObjectsFactory validCardNumber 
																				expiringOn: testObjectsFactory validExpirationDate 
																				of: testObjectsFactory validCardOwner .  ]
		raise: Error - MessageNotUnderstood
		withExceptionDo: [ :anError |
			self assert: anError messageText = tusLibrosInterface cartDoesntExistErrorMessage. ].! !

!TusLibrosInterfaceTest methodsFor: 'testing' stamp: 'sf 11/18/2019 17:44:13'!
test10ListPurchasesOfAClientWithNoShoppingsIsEmpty
	| tusLibrosInterface aCartID aBookISBN aQuantity salesBook purchases |
	
	salesBook := OrderedCollection new.
	
	aBookISBN := testObjectsFactory itemOneSellByTheStore.
	aQuantity := 3.
	
	tusLibrosInterface := self createTusLibrosAPIWith: salesBook.
	aCartID := tusLibrosInterface createCartFor: testObjectsFactory validClientOne
									   withPassword: testObjectsFactory validPasswordOne. 
	
	tusLibrosInterface add: aQuantity of: aBookISBN to: aCartID.
	tusLibrosInterface checkoutCart: aCartID with: testObjectsFactory validCardNumber 
													expiringOn: testObjectsFactory validExpirationDate 
													of: testObjectsFactory validCardOwner .
	
	purchases := OrderedCollection new.
	purchases add: Bag new.
	purchases add: 0.
	
	self assert: purchases equals: (tusLibrosInterface listPurchasesOf: testObjectsFactory validClientTwo with: testObjectsFactory validPasswordTwo).! !

!TusLibrosInterfaceTest methodsFor: 'testing' stamp: 'sf 11/18/2019 17:40:44'!
test11ListPurchasesOfAClientWhoBoughtOneBookShowsThatBookAndItsTotal
	| tusLibrosInterface purchases salesBook aBookISBN aCartID aQuantity shoppings |
	
	salesBook := OrderedCollection new.
	
	aBookISBN := testObjectsFactory itemOneSellByTheStore.
	aQuantity := 1.
	
	tusLibrosInterface := self createTusLibrosAPIWith: salesBook.
	aCartID := tusLibrosInterface createCartFor: testObjectsFactory validClientOne
									   withPassword: testObjectsFactory validPasswordOne. 
	
	tusLibrosInterface add: aQuantity of: aBookISBN to: aCartID.
	tusLibrosInterface checkoutCart: aCartID with: testObjectsFactory validCardNumber 
													expiringOn: testObjectsFactory validExpirationDate 
													of: testObjectsFactory validCardOwner .
	
	shoppings := Bag new .
	shoppings add: aBookISBN.
	
	purchases := OrderedCollection with: shoppings with: testObjectsFactory itemOneSellByTheStorePrice.
		
	self assert: purchases equals: (tusLibrosInterface listPurchasesOf: testObjectsFactory validClientOne with: testObjectsFactory validPasswordOne).! !

!TusLibrosInterfaceTest methodsFor: 'testing' stamp: 'sf 11/18/2019 17:40:55'!
test12ListPurchasesOfAClientWhoBoughtMoreThanOneBookShowsAllTheBooksAndTheirTotal
	| tusLibrosInterface purchases salesBook aBookISBN aCartID aQuantity shoppings |
	
	salesBook := OrderedCollection new.
	
	aBookISBN := testObjectsFactory itemOneSellByTheStore.
	aQuantity := 3.
	
	tusLibrosInterface := self createTusLibrosAPIWith: salesBook.
	aCartID := tusLibrosInterface createCartFor: testObjectsFactory validClientOne
									   withPassword: testObjectsFactory validPasswordOne. 
	
	tusLibrosInterface add: aQuantity of: aBookISBN to: aCartID.
	tusLibrosInterface checkoutCart: aCartID with: testObjectsFactory validCardNumber 
													expiringOn: testObjectsFactory validExpirationDate 
													of: testObjectsFactory validCardOwner .
	
	shoppings := Bag new .
	shoppings add: aBookISBN withOccurrences: aQuantity.
	
	purchases := OrderedCollection with: shoppings with: (testObjectsFactory itemOneSellByTheStorePrice * aQuantity).
		
	self assert: purchases equals: (tusLibrosInterface listPurchasesOf: testObjectsFactory validClientOne with: testObjectsFactory validPasswordOne).! !

!TusLibrosInterfaceTest methodsFor: 'testing' stamp: 'sf 11/18/2019 17:41:05'!
test13ListPurchasesOfAClientWhoBoughtDifferentBooksShowsAllTheBooksAndTheirTotal
	| tusLibrosInterface purchases salesBook aCartID shoppings bookOneISBN bookOneQuantity bookTwoISBN bookTwoQuantity |
	
	salesBook := OrderedCollection new.
	
	bookOneISBN := testObjectsFactory itemOneSellByTheStore.
	bookOneQuantity := 1.

	bookTwoISBN := testObjectsFactory itemTwoSellByTheStore.
	bookTwoQuantity := 2.
	
	tusLibrosInterface := self createTusLibrosAPIWith: salesBook.
	aCartID := tusLibrosInterface createCartFor: testObjectsFactory validClientOne
									   withPassword: testObjectsFactory validPasswordOne. 
	
	tusLibrosInterface add: bookOneQuantity of: bookOneISBN to: aCartID.
	tusLibrosInterface add: bookTwoQuantity of: bookTwoISBN to: aCartID.
	tusLibrosInterface checkoutCart: aCartID with: testObjectsFactory validCardNumber 
													expiringOn: testObjectsFactory validExpirationDate 
													of: testObjectsFactory validCardOwner .
	
	shoppings := Bag new .
	shoppings add: bookOneISBN withOccurrences: bookOneQuantity .
	shoppings add: bookTwoISBN withOccurrences: bookTwoQuantity .
	
	purchases := OrderedCollection with: shoppings with: (testObjectsFactory itemOneSellByTheStorePrice * bookOneQuantity +
																	(testObjectsFactory itemTwoSellByTheStorePrice * bookTwoQuantity )).
		
	self assert: purchases equals: (tusLibrosInterface listPurchasesOf: testObjectsFactory validClientOne with: testObjectsFactory validPasswordOne).! !

!TusLibrosInterfaceTest methodsFor: 'testing' stamp: 'sf 11/18/2019 17:41:25'!
test14ListPurchasesOfAClientWhoBoughtBooksInDifferentSalesShowsAllItsPurchases
	| tusLibrosInterface purchases salesBook aCartID shoppings bookOneISBN bookOneQuantity bookTwoISBN bookTwoQuantity |
	
	salesBook := OrderedCollection new.
	tusLibrosInterface := self createTusLibrosAPIWith: salesBook.
	
	bookOneISBN := testObjectsFactory itemOneSellByTheStore.
	bookOneQuantity := 3.

	aCartID := tusLibrosInterface createCartFor: testObjectsFactory validClientOne
									   withPassword: testObjectsFactory validPasswordOne. 	
	tusLibrosInterface add: bookOneQuantity of: bookOneISBN to: aCartID.
	tusLibrosInterface checkoutCart: aCartID with: testObjectsFactory validCardNumber 
													expiringOn: testObjectsFactory validExpirationDate 
													of: testObjectsFactory validCardOwner .

	bookTwoISBN := testObjectsFactory itemTwoSellByTheStore.
	bookTwoQuantity := 2.
	
	aCartID := tusLibrosInterface createCartFor: testObjectsFactory validClientOne
									   withPassword: testObjectsFactory validPasswordOne. 	
	tusLibrosInterface add: bookTwoQuantity of: bookTwoISBN to: aCartID.		
	tusLibrosInterface checkoutCart: aCartID with: testObjectsFactory validCardNumber 
													expiringOn: testObjectsFactory validExpirationDate 
													of: testObjectsFactory validCardOwner .
	
	shoppings := Bag new .
	shoppings add: bookOneISBN withOccurrences: bookOneQuantity .
	shoppings add: bookTwoISBN withOccurrences: bookTwoQuantity .
	
	purchases := OrderedCollection with: shoppings with: (testObjectsFactory itemOneSellByTheStorePrice * bookOneQuantity +
																	(testObjectsFactory itemTwoSellByTheStorePrice * bookTwoQuantity )).
		
	self assert: purchases equals: (tusLibrosInterface listPurchasesOf: testObjectsFactory validClientOne with: testObjectsFactory validPasswordOne).! !

!TusLibrosInterfaceTest methodsFor: 'testing' stamp: 'sf 11/18/2019 17:51:26'!
test15CantListPurchasesOfANonRegisteredClient

	| tusLibrosInterface salesBook |
	
	salesBook := OrderedCollection new.
	
	tusLibrosInterface := self createTusLibrosAPIWith: salesBook.
	
	self 
		should: [ tusLibrosInterface listPurchasesOf: testObjectsFactory invalidClient with: testObjectsFactory validPasswordOne ]
		raise: Error - MessageNotUnderstood
		withExceptionDo: [ :anError |
			self assert: anError messageText = tusLibrosInterface invalidClientOrPasswordErrorMessage .
			].
	! !

!TusLibrosInterfaceTest methodsFor: 'testing' stamp: 'sf 11/18/2019 19:08:32'!
test16CantListPurchasesOfARegisteredClientWithWrongPassword

	| tusLibrosInterface salesBook |
	
	salesBook := OrderedCollection new.
	
	tusLibrosInterface := self createTusLibrosAPIWith: salesBook.
	
	self 
		should: [ tusLibrosInterface listPurchasesOf: testObjectsFactory validClientOne with: testObjectsFactory validPasswordTwo ]
		raise: Error - MessageNotUnderstood
		withExceptionDo: [ :anError |
			self assert: anError messageText = tusLibrosInterface invalidClientOrPasswordErrorMessage .
			].
	! !

!TusLibrosInterfaceTest methodsFor: 'testing' stamp: 'sf 11/18/2019 19:11:13'!
test17CantAddToCartAfter30MinutesHavePassedSinceLastUsed
	
	| tusLibrosInterface aCartID aBookISBN aQuantity salesBook |
	
	salesBook := OrderedCollection new.
	aBookISBN := testObjectsFactory itemOneSellByTheStore.
	aQuantity := 1.
	
	tusLibrosInterface := self createTusLibrosAPIWith: salesBook.
	aCartID := tusLibrosInterface createCartFor: testObjectsFactory validClientOne
									   withPassword: testObjectsFactory validPasswordOne.
	
	self advanceMinutesAmount: 30.
	
	self 
		should: [ tusLibrosInterface add: aQuantity of: aBookISBN to: aCartID.  ]
		raise: Error - MessageNotUnderstood
		withExceptionDo: [ :anError | 
							self assert: anError messageText = tusLibrosInterface cartIsExpiredErrorMessage. ].
			
	! !

!TusLibrosInterfaceTest methodsFor: 'testing' stamp: 'sf 11/18/2019 19:13:10'!
test18CantCheckoutCartAfter30MinutesHavePassedSinceLastUsed
	
	| tusLibrosInterface aCartID salesBook |
	
	salesBook := OrderedCollection new.
	
	tusLibrosInterface := self createTusLibrosAPIWith: salesBook.
	aCartID := tusLibrosInterface createCartFor: testObjectsFactory validClientOne
									   withPassword: testObjectsFactory validPasswordOne.
	
	self advanceMinutesAmount: 30.
	
	self 
		should: [ tusLibrosInterface checkoutCart: aCartID
									     with: testObjectsFactory validCardNumber
										expiringOn: testObjectsFactory validExpirationDate 
										of: testObjectsFactory validCardOwner ]
		raise: Error - MessageNotUnderstood
		withExceptionDo: [ :anError | 
							self assert: anError messageText = tusLibrosInterface cartIsExpiredErrorMessage. ].
! !

!TusLibrosInterfaceTest methodsFor: 'testing' stamp: 'sf 11/18/2019 19:15:05'!
test19CantListCartAfter30MinutesHavePassedSinceLastUsed

	| tusLibrosInterface aCartID salesBook |
	
	salesBook := OrderedCollection new.
	
	tusLibrosInterface := self createTusLibrosAPIWith: salesBook.
	aCartID := tusLibrosInterface createCartFor: testObjectsFactory validClientOne
									   withPassword: testObjectsFactory validPasswordOne.
	
	self advanceMinutesAmount: 30.
	
	self 
		should: [ tusLibrosInterface listCart: aCartID ]
		raise: Error - MessageNotUnderstood
		withExceptionDo: [ :anError | 
							self assert: anError messageText = tusLibrosInterface cartIsExpiredErrorMessage. ].
! !

!TusLibrosInterfaceTest methodsFor: 'testing' stamp: 'sf 11/18/2019 19:24:32'!
test20AddingToCartResets30MinuteExpirationTimer

	| tusLibrosInterface aCartID salesBook shoppings |
	
	salesBook := OrderedCollection new.
	
	tusLibrosInterface := self createTusLibrosAPIWith: salesBook.
	aCartID := tusLibrosInterface createCartFor: testObjectsFactory validClientOne
									   withPassword: testObjectsFactory validPasswordOne.
	
	self advanceMinutesAmount: 20.
	
	tusLibrosInterface add: 1 of: testObjectsFactory itemOneSellByTheStore to: aCartID .
	
	self advanceMinutesAmount: 15.
	
	tusLibrosInterface add: 1 of: testObjectsFactory itemOneSellByTheStore to: aCartID .
	
	shoppings := Bag new.
	shoppings add: testObjectsFactory itemOneSellByTheStore withOccurrences: 2.	
	
	self assert:  shoppings equals: (tusLibrosInterface listCart: aCartID) .! !

!TusLibrosInterfaceTest methodsFor: 'testing' stamp: 'sf 11/18/2019 19:25:33'!
test21ListingCartResets30MinuteExpirationTimer

	| tusLibrosInterface aCartID salesBook shoppings |
	
	salesBook := OrderedCollection new.
	
	tusLibrosInterface := self createTusLibrosAPIWith: salesBook.
	aCartID := tusLibrosInterface createCartFor: testObjectsFactory validClientOne
									   withPassword: testObjectsFactory validPasswordOne.
	
	self advanceMinutesAmount: 20.
	
	tusLibrosInterface listCart: aCartID.
	
	self advanceMinutesAmount: 15.
	
	tusLibrosInterface add: 1 of: testObjectsFactory itemOneSellByTheStore to: aCartID .
	
	shoppings := Bag new.
	shoppings add: testObjectsFactory itemOneSellByTheStore.
	
	self assert:  shoppings equals: (tusLibrosInterface listCart: aCartID) .! !


!TusLibrosInterfaceTest methodsFor: 'merchant processor protocol' stamp: 'SF 11/11/2019 19:51:28'!
debit: anAmount from: aCreditCard 

	^debitBehavior value: anAmount value: aCreditCard ! !


!TusLibrosInterfaceTest methodsFor: 'clock protocol' stamp: 'sf 11/18/2019 18:56:08'!
advanceMinutesAmount: anAmountOfMinutes
	clock _ clock next: (anAmountOfMinutes * minute)! !

!TusLibrosInterfaceTest methodsFor: 'clock protocol' stamp: 'sf 11/18/2019 18:42:30'!
now

	^ clock! !


!TusLibrosInterfaceTest methodsFor: 'instance creation' stamp: 'sf 11/18/2019 19:08:15'!
createTusLibrosAPIWith: aSalesBook 

	^ TusLibrosInterface validatingAt: testObjectsFactory defaultAuthenticationSystem 
							    registeringOn: aSalesBook 
							    offering: testObjectsFactory defaultCatalog 
							    with: merchantProcessor
							    andClock: self! !


!classDefinition: #StoreTestObjectsFactory category: #'TusLibros - Test'!
Object subclass: #StoreTestObjectsFactory
	instanceVariableNames: 'today'
	classVariableNames: ''
	poolDictionaries: ''
	category: 'TusLibros - Test'!

!StoreTestObjectsFactory methodsFor: 'items' stamp: 'HernanWilkinson 6/17/2013 18:08'!
itemNotSellByTheStore
	
	^'invalidBook'! !

!StoreTestObjectsFactory methodsFor: 'items' stamp: 'sf 11/18/2019 16:50:00'!
itemOneSellByTheStore
	
	^ 'validBook'! !

!StoreTestObjectsFactory methodsFor: 'items' stamp: 'sf 11/18/2019 16:50:15'!
itemOneSellByTheStorePrice
	
	^10! !

!StoreTestObjectsFactory methodsFor: 'items' stamp: 'sf 11/18/2019 16:50:57'!
itemTwoSellByTheStore
	
	^ 'anotherValidBook'! !

!StoreTestObjectsFactory methodsFor: 'items' stamp: 'sf 11/18/2019 16:51:14'!
itemTwoSellByTheStorePrice
	
	^7! !


!StoreTestObjectsFactory methodsFor: 'authentication system' stamp: 'sf 11/18/2019 17:29:50'!
defaultAuthenticationSystem	
	
	^ Dictionary new
		at: self validClientOne put: self validPasswordOne;
		at: self validClientTwo put: self validPasswordTwo;
		yourself ! !


!StoreTestObjectsFactory methodsFor: 'cart' stamp: 'HernanWilkinson 6/17/2013 18:08'!
createCart
	
	^Cart acceptingItemsOf: self defaultCatalog! !

!StoreTestObjectsFactory methodsFor: 'cart' stamp: 'sf 11/18/2019 16:49:13'!
defaultCatalog
	
	^ Dictionary new
		at: self itemOneSellByTheStore put: self itemOneSellByTheStorePrice;
		at: self itemTwoSellByTheStore put: self itemTwoSellByTheStorePrice;
		yourself ! !


!StoreTestObjectsFactory methodsFor: 'credit card' stamp: 'sf 11/18/2019 15:36:00'!
expiredCreditCard
	
	^ CreditCard number: 1234123412341234 of: 'Pepe' expiringOn: (GregorianMonthOfYear yearNumber: 1 month: January).! !

!StoreTestObjectsFactory methodsFor: 'credit card' stamp: 'sf 11/18/2019 15:36:38'!
notExpiredCreditCard
	
	^CreditCard number: 1234123412341234 of: 'Pepe' expiringOn: (GregorianMonthOfYear yearNumber: SmallInteger maxVal month: December).! !

!StoreTestObjectsFactory methodsFor: 'credit card' stamp: 'sf 11/18/2019 17:37:25'!
validCardNumber 

	^ 1234123412341234.! !

!StoreTestObjectsFactory methodsFor: 'credit card' stamp: 'sf 11/18/2019 17:38:22'!
validCardOwner 

	^ 'Pepe'.! !

!StoreTestObjectsFactory methodsFor: 'credit card' stamp: 'sf 11/18/2019 17:37:57'!
validExpirationDate 

	^ GregorianMonthOfYear yearNumber: (SmallInteger maxVal) month: December.! !


!StoreTestObjectsFactory methodsFor: 'initialization' stamp: 'sf 11/18/2019 15:39:46'!
initialize

	today := FixedGregorianDate today! !


!StoreTestObjectsFactory methodsFor: 'client' stamp: 'sf 11/18/2019 17:34:05'!
invalidClient

	^ 0.! !

!StoreTestObjectsFactory methodsFor: 'client' stamp: 'sf 11/18/2019 17:34:48'!
invalidPassword

	^ 0.! !

!StoreTestObjectsFactory methodsFor: 'client' stamp: 'sf 11/18/2019 17:30:41'!
validClientOne

	^ 5.! !

!StoreTestObjectsFactory methodsFor: 'client' stamp: 'sf 11/18/2019 17:31:19'!
validClientTwo

	^ 21.! !

!StoreTestObjectsFactory methodsFor: 'client' stamp: 'sf 11/18/2019 17:30:51'!
validPasswordOne 

	^ 5678.! !

!StoreTestObjectsFactory methodsFor: 'client' stamp: 'sf 11/18/2019 17:31:08'!
validPasswordTwo 

	^ 8765.! !


!StoreTestObjectsFactory methodsFor: 'date' stamp: 'HernanWilkinson 6/17/2013 18:37'!
today
	
	^ today! !
