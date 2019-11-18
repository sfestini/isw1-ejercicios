!classDefinition: #Cart category: #TusLibros!
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


!Cart methodsFor: 'testing' stamp: 'mm 11/18/2019 12:43:29'!
containsBook: anItem

	^items includes: anItem ! !

!Cart methodsFor: 'testing' stamp: 'HernanWilkinson 6/17/2013 17:44'!
isEmpty
	
	^items isEmpty ! !


!Cart methodsFor: 'total' stamp: 'mm 11/18/2019 12:44:58'!
total

	^ items sum: [ :anItem | catalog at: anItem ] ifEmpty: [0].! !


!Cart methodsFor: 'adding' stamp: 'HernanWilkinson 6/17/2013 17:44'!
add: anItem

	^ self add: 1 of: anItem ! !

!Cart methodsFor: 'adding' stamp: 'sf 11/18/2019 15:26:02'!
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

!classDefinition: 'Cart class' category: #TusLibros!
Cart class
	instanceVariableNames: ''!

!Cart class methodsFor: 'instance creation' stamp: 'HernanWilkinson 6/17/2013 17:48'!
acceptingItemsOf: aCatalog

	^self new initializeAcceptingItemsOf: aCatalog ! !


!classDefinition: #Cashier category: #TusLibros!
Object subclass: #Cashier
	instanceVariableNames: 'client cart salesBook merchantProcessor creditCard total'
	classVariableNames: ''
	poolDictionaries: ''
	category: 'TusLibros'!

!Cashier methodsFor: 'checkout - private' stamp: 'HernanWilkinson 6/17/2013 19:08'!
calculateTotal

	total := cart total.
	! !

!Cashier methodsFor: 'checkout - private' stamp: 'SF 11/14/2019 17:36:11'!
createSale

	^ Sale of: cart listBooks valued: total for: client.
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

!classDefinition: 'Cashier class' category: #TusLibros!
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


!classDefinition: #CreditCard category: #TusLibros!
Object subclass: #CreditCard
	instanceVariableNames: 'expiration cardNumber cardOwner'
	classVariableNames: ''
	poolDictionaries: ''
	category: 'TusLibros'!

!CreditCard methodsFor: 'testing' stamp: 'sf 11/18/2019 15:33:25'!
isExpiredOn: aDate 
	
	^ aDate monthOfYear > expiration.! !


!CreditCard methodsFor: 'initialization' stamp: 'SF 11/11/2019 19:36:51'!
initializeNumber: aNumber of: anOwner expiringOn: aMonth

	cardNumber := aNumber.
	cardOwner := anOwner .
	expiration := aMonth.! !

"-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- "!

!classDefinition: 'CreditCard class' category: #TusLibros!
CreditCard class
	instanceVariableNames: ''!

!CreditCard class methodsFor: 'instance creation' stamp: 'SF 11/11/2019 19:41:38'!
number: aNumber of: anOwner expiringOn: aMonth
	
	^self new initializeNumber: aNumber of: anOwner expiringOn: aMonth! !


!classDefinition: #Sale category: #TusLibros!
Object subclass: #Sale
	instanceVariableNames: 'shoppingList total client'
	classVariableNames: ''
	poolDictionaries: ''
	category: 'TusLibros'!

!Sale methodsFor: 'accessing' stamp: 'SF 11/14/2019 17:41:24'!
client

	^ client! !

!Sale methodsFor: 'accessing' stamp: 'SF 11/14/2019 17:40:38'!
shoppingList

	^ shoppingList.! !

!Sale methodsFor: 'accessing' stamp: 'SF 11/14/2019 17:40:21'!
total
	
	^ total! !


!Sale methodsFor: 'comparing' stamp: 'sf 11/18/2019 15:29:41'!
= aSale

	^ (total = aSale total) and: [shoppingList = aSale shoppingList ] and: [client = aSale client].! !


!Sale methodsFor: 'initialization' stamp: 'SF 11/14/2019 17:40:52'!
initializeSaleFor: aShoppingList valued: aTotal for: aClient

	shoppingList := aShoppingList.
	client:= aClient.
	total := aTotal.! !

"-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- "!

!classDefinition: 'Sale class' category: #TusLibros!
Sale class
	instanceVariableNames: ''!

!Sale class methodsFor: 'instance creation' stamp: 'SF 11/14/2019 17:41:04'!
of: aShoppingList valued: aTotal for: aClient

	"should assert total is not negative or 0!!"
	^self new initializeSaleFor: aShoppingList valued: aTotal for: aClient. ! !


!classDefinition: #TusLibrosInterface category: #TusLibros!
Object subclass: #TusLibrosInterface
	instanceVariableNames: 'carts authenticationSystem lastCartID catalog salesBook merchantProcessor cartsOwners cartsTimers clock'
	classVariableNames: ''
	poolDictionaries: ''
	category: 'TusLibros'!

!TusLibrosInterface methodsFor: 'assertions' stamp: 'SF 11/11/2019 16:02:22'!
assertCartExists: aCartID
	
	^(self hasRegisteredCart: aCartID) ifFalse: [self error: self cartDoesntExistErrorMessage].
	
	! !

!TusLibrosInterface methodsFor: 'assertions' stamp: 'sf 11/18/2019 19:05:03'!
assertCartIsntExpired: aCartID

	((clock now) <  ((cartsTimers at: aCartID) next: (30 * minute))) ifFalse: [^ self error: self cartIsExpiredErrorMessage]! !

!TusLibrosInterface methodsFor: 'assertions' stamp: 'SF 11/11/2019 18:02:24'!
assertClientExists: aClientID 

	(authenticationSystem includesKey: aClientID) ifFalse: [self error: self invalidClientOrPasswordErrorMessage].
	
	! !

!TusLibrosInterface methodsFor: 'assertions' stamp: 'SF 11/11/2019 18:07:58'!
assertPassword: aPassword matchesWith: aClientID

	((authenticationSystem at: aClientID) = aPassword ) ifFalse: [self error: self invalidClientOrPasswordErrorMessage].


	
	! !

!TusLibrosInterface methodsFor: 'assertions' stamp: 'SF 11/11/2019 18:06:51'!
assertValidUser: aClientID with: aPassword
	
	self assertClientExists: aClientID .
	self assertPassword: aPassword matchesWith: aClientID. 
	
	! !


!TusLibrosInterface methodsFor: 'error messages' stamp: 'SF 11/11/2019 15:57:23'!
cartDoesntExistErrorMessage

	^ 'Cart doesnt exist!!'! !

!TusLibrosInterface methodsFor: 'error messages' stamp: 'sf 11/18/2019 18:44:28'!
cartIsExpiredErrorMessage

	^ 'cart is expired!!!!'! !

!TusLibrosInterface methodsFor: 'error messages' stamp: 'SF 11/7/2019 20:12:02'!
clientAlreadyHasACartErrorMessage

	^ 'Client already has a cart!!'! !

!TusLibrosInterface methodsFor: 'error messages' stamp: 'SF 11/11/2019 17:58:09'!
invalidClientOrPasswordErrorMessage.

	^ 'User and/or password are incorrect!!'.! !


!TusLibrosInterface methodsFor: 'cart operations - public' stamp: 'sf 11/18/2019 18:45:42'!
add: aQuantity of: aBookISBN to: aCartID.
	
	self assertCartExists: aCartID .
	self assertCartIsntExpired: aCartID.
	
	(carts at: aCartID) add: aQuantity of: aBookISBN. 
	
	self updateLastUseOf: aCartID.
	! !

!TusLibrosInterface methodsFor: 'cart operations - public' stamp: 'sf 11/18/2019 19:37:17'!
checkoutCart: aCartID with: aCreditCardNumber expiringOn: anExpirationDate of: aCreditCardOwner

	| cashier aCreditCard |

	self assertCartExists: aCartID .
	self assertCartIsntExpired: aCartID.
	
	aCreditCard := CreditCard number: aCreditCardNumber 
									 of: aCreditCardOwner 
									 expiringOn: anExpirationDate .
	
	cashier := Cashier toCheckout: (carts at: aCartID) 
						   charging: aCreditCard 
						   through: merchantProcessor 
						   on: FixedGregorianDate today 
						   registeringOn: salesBook 
						   for: (cartsOwners at: aCartID).
	
	cashier checkOut .
	
	self removeCart: aCartID.! !

!TusLibrosInterface methodsFor: 'cart operations - public' stamp: 'sf 11/18/2019 19:44:24'!
createCartFor: aClientID withPassword: aPassword
	
	self assertValidUser: aClientID with: aPassword .
	
	self updateLastID.
	
	self createNewCartFor: aClientID.
	self updateLastUseOf: lastCartID.
	
	^ lastCartID .! !

!TusLibrosInterface methodsFor: 'cart operations - public' stamp: 'sf 11/18/2019 19:15:55'!
listCart: aCartID
	
	self assertCartExists: aCartID .
	self assertCartIsntExpired: aCartID.
	
	self updateLastUseOf: aCartID.
		
	^ (carts at: aCartID) listBooks.	! !


!TusLibrosInterface methodsFor: 'list purchases - private' stamp: 'sf 11/18/2019 19:58:07'!
calculateTotalOfSales: clientSales
	
	| total |

	total := 0.
	clientSales do: [:aSale | total := total + aSale total].
	
	^ total.! !

!TusLibrosInterface methodsFor: 'list purchases - private' stamp: 'sf 11/18/2019 19:56:28'!
gatherListOfClientShoppings: clientSales 

	| items |

	items := Bag new.
	clientSales do: [:aSale | items addAll: aSale shoppingList] .
	
	^ items.
	
	! !

!TusLibrosInterface methodsFor: 'list purchases - private' stamp: 'sf 11/18/2019 19:48:16'!
getClientSales: aClientID

	^ salesBook select: [:aSale | aSale client = aClientID].! !


!TusLibrosInterface methodsFor: 'list purchases - public' stamp: 'sf 11/18/2019 19:51:28'!
listPurchasesOf: aClientID with: aPassword

	| clientSales itemsBoughtByClient totalPayedByClient |
	
	self assertValidUser: aClientID with: aPassword .
	
	clientSales := self getClientSales: aClientID.
	
	itemsBoughtByClient := self gatherListOfClientShoppings: clientSales .
	totalPayedByClient := self calculateTotalOfSales: clientSales.
	
	^ OrderedCollection with: itemsBoughtByClient with: totalPayedByClient.! !


!TusLibrosInterface methodsFor: 'initialization' stamp: 'sf 11/18/2019 18:37:44'!
validatingAt: anAuthenticationSystem registeringOn: aSalesBook offering: aCatalog with: aMerchantProcessor andClock: aClock
	
	lastCartID := 0.
	carts := Dictionary new.
	cartsOwners := Dictionary new.
	cartsTimers := Dictionary new.
	authenticationSystem := anAuthenticationSystem.
	salesBook := aSalesBook .
	catalog := aCatalog .
	merchantProcessor := aMerchantProcessor.
	clock := aClock.
	! !


!TusLibrosInterface methodsFor: 'cart operations - private' stamp: 'sf 11/18/2019 19:44:54'!
createNewCartFor: aClientID
	
	carts at: lastCartID put: (Cart acceptingItemsOf: catalog).
	cartsOwners at: lastCartID put: aClientID .! !

!TusLibrosInterface methodsFor: 'cart operations - private' stamp: 'SF 11/7/2019 21:17:56'!
hasRegisteredCart: aCartID

	^carts includesKey: aCartID.! !

!TusLibrosInterface methodsFor: 'cart operations - private' stamp: 'SF 11/11/2019 19:09:13'!
removeCart: aCartID

	carts removeKey: aCartID .! !

!TusLibrosInterface methodsFor: 'cart operations - private' stamp: 'sf 11/18/2019 19:39:51'!
updateLastID 

	^ lastCartID := lastCartID + 1.! !

!TusLibrosInterface methodsFor: 'cart operations - private' stamp: 'sf 11/18/2019 18:45:53'!
updateLastUseOf: aCartID

	cartsTimers at: aCartID put: clock now.
	! !

"-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- "!

!classDefinition: 'TusLibrosInterface class' category: #TusLibros!
TusLibrosInterface class
	instanceVariableNames: ''!

!TusLibrosInterface class methodsFor: 'as yet unclassified' stamp: 'sf 11/18/2019 18:35:37'!
validatingAt: anAuthenticationSystem registeringOn: aSalesBook offering: aCatalog with: aMerchantProcessor andClock: aClock

	"CAMBIAR EL NOMBRE!!!!!!!!!!!!"

	^ self new validatingAt: anAuthenticationSystem registeringOn: aSalesBook offering: aCatalog with: aMerchantProcessor andClock: aClock.! !
