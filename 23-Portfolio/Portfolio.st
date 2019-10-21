!classDefinition: #PortfolioTest category: #Portfolio!
TestCase subclass: #PortfolioTest
	instanceVariableNames: ''
	classVariableNames: ''
	poolDictionaries: ''
	category: 'Portfolio'!

!PortfolioTest methodsFor: 'testing' stamp: 'Santiago Festini 10/17/2019 19:48:38'!
test01AnEmptyPortfolioHasZeroBalance
	| portfolio |
	
	portfolio := Portfolio new.
	
	self assert: (portfolio balance) equals: 0.! !

!PortfolioTest methodsFor: 'testing' stamp: 'Santiago Festini 10/17/2019 19:47:13'!
test02PortfolioWithOneAccountHasTheSameBalanceAsTheAccount
	| portfolio account|
	 
	account := ReceptiveAccount new.
	Deposit register: 100 on: account .
	
	portfolio := Portfolio new.
	portfolio add: account.
	
	self assert: (portfolio balance) equals: (account balance).! !

!PortfolioTest methodsFor: 'testing' stamp: 'Santiago Festini 10/17/2019 19:47:22'!
test03PortfolioWithManyAccountsHasTheSameBalanceAsTheAccounts
	| portfolio account1 account2 account3 totalAccountBalance |
	 
	account1 := ReceptiveAccount new.
	account2 := ReceptiveAccount new.
	account3 := ReceptiveAccount new.

	Deposit register: 100 on: account1 .
	Deposit register: 50 on: account2 .
	Deposit register: 250 on: account3 .

	
	portfolio := Portfolio new.
	portfolio add: account1.
	portfolio add: account2.
	portfolio add: account3.	
	
	totalAccountBalance:= account1 balance + account2 balance + account3 balance.
	
	self assert: (portfolio balance) equals: (totalAccountBalance).! !

!PortfolioTest methodsFor: 'testing' stamp: 'Santiago Festini 10/21/2019 11:20:40'!
test04PortfolioWithPortfoliosHasTheSameBalanceAsTheSumOfThePortfoliosBalances
	| portfolio portfolioA portfolioB portfolioC account1 account2 account3 totalBalance |
	 
	account1 := ReceptiveAccount new.
	account2 := ReceptiveAccount new.
	account3 := ReceptiveAccount new.

	Deposit register: 100 on: account1 .
	Deposit register: 50 on: account2 .
	Deposit register: 250 on: account3 .

	
	portfolio := Portfolio new.
	portfolioA := Portfolio new.
	portfolioB := Portfolio new.
	portfolioC := Portfolio new.	
	
	portfolioA add: account1.
	portfolioB add: account2.
	portfolioC add: account3.	
	
	portfolio add: portfolioA .
	portfolio add: portfolioB .
	portfolio add: portfolioC .
	
	totalBalance:= portfolioA balance + portfolioB balance + portfolioC balance.
	
	self assert: (portfolio balance) equals: (totalBalance).! !

!PortfolioTest methodsFor: 'testing' stamp: 'Santiago Festini 10/17/2019 20:01:24'!
test05EmptyPortfolioHasNoTransactions
	| portfolio  |
	 	
	portfolio := Portfolio new.	
	
	self assert: ((portfolio transactions) size) equals: 0.! !

!PortfolioTest methodsFor: 'testing' stamp: 'Santiago Festini 10/17/2019 20:03:30'!
test06PortfolioWithAnAccountHasTheSameTransactionsAsAccount
	| portfolio  account|
	
	account := ReceptiveAccount new.
	Deposit register: 100 on: account .	
	portfolio := Portfolio new.	
	portfolio add: account .
	
	self assert: (portfolio transactions) equals: (account transactions).! !

!PortfolioTest methodsFor: 'testing' stamp: 'Santiago Festini 10/17/2019 20:40:18'!
test07PortfolioWithManyAccountsHasTheSameTransactionsAsTheAccounts
	| portfolio  account1 account2 account3 allTransactions |
	
	account1 := ReceptiveAccount new.
	account2 := ReceptiveAccount new.
	account3 := ReceptiveAccount new.
	
	Deposit register: 100 on: account1 .	
	Deposit register: 50 on: account2 .	
	Deposit register: 25 on: account3 .	

	portfolio := Portfolio new.	

	portfolio add: account1.
	portfolio add: account2.
	portfolio add: account3.
	
	allTransactions := OrderedCollection new.
	allTransactions addAll: (account1 transactions ).
	allTransactions addAll: (account2 transactions ).
	allTransactions addAll: (account3 transactions ).
	
	self assert: ((portfolio transactions ) asSet) equals: (allTransactions asSet).! !

!PortfolioTest methodsFor: 'testing' stamp: 'Santiago Festini 10/17/2019 20:43:36'!
test08EmptyPortfolioHasNoRegisters
	| portfolio  |
	 	
	portfolio := Portfolio new.	
	
	self assert: ((portfolio transactions) size) equals: 0.! !

!PortfolioTest methodsFor: 'testing' stamp: 'Santiago Festini 10/21/2019 11:00:14'!
test09PortfolioWithAnAccountWithARegisteredTransactionHasTheSameTransactionRegistered
	|depositTransaction portfolio  account|
	
	account := ReceptiveAccount new.
	depositTransaction := Deposit for: 100.
	account register: depositTransaction .	
	portfolio := Portfolio new.	
	portfolio add: account .
	
	self assert: (portfolio hasRegistered: depositTransaction ) equals: (account hasRegistered: depositTransaction).! !

!PortfolioTest methodsFor: 'testing' stamp: 'Santiago Festini 10/21/2019 11:10:40'!
test10PortfolioOnlyRegistersTransactionIfTransactionIsRegisteredInOneOfItsAccounts
	|depositTransaction portfolio  account|
	
	account := ReceptiveAccount new.
	depositTransaction := Deposit for: 100.
	portfolio := Portfolio new.	
	portfolio add: account .
	
	self deny: (account hasRegistered: depositTransaction).
	self deny: (portfolio hasRegistered: depositTransaction).! !

!PortfolioTest methodsFor: 'testing' stamp: 'Santiago Festini 10/21/2019 11:52:13'!
test11PortfolioCantAddAnAccountItAlreadyHas
	| portfolio account1  |
	 
	account1 := ReceptiveAccount new.
	
	Deposit register: 100 on: account1 .
	
	portfolio := Portfolio new.
	portfolio add: account1.
	
	self 
		should: [ portfolio add: account1. ]
		raise: Error - MessageNotUnderstood
		withExceptionDo: [:error | self assert: error messageText = Portfolio errorSameTransactionAdd .
								     self assert: (portfolio balance) = 100.
								     self assert: (portfolio numberOfTransactions ) = 1.]
	! !

!PortfolioTest methodsFor: 'testing' stamp: 'Santiago Festini 10/21/2019 15:44:30'!
test12PortfolioCantAddAPortfolioItAlreadyHas
	| portfolio portfolioA  |
	 
	portfolioA := Portfolio new.
	
	portfolio := Portfolio new.
	portfolio add: portfolioA .
	
	self 
		should: [ portfolio add: portfolioA. ]
		raise: Error - MessageNotUnderstood
		withExceptionDo: [:error | self assert: error messageText = Portfolio errorSameTransactionAdd .
								     self assert: (portfolio balance) = 0.
								     self assert: (portfolio numberOfTransactions ) = 0.
								     self assert: (portfolio numberOfLinkedBankEntities) = 1.]
	! !

!PortfolioTest methodsFor: 'testing' stamp: 'Santiago Festini 10/21/2019 15:44:30'!
test13PortfolioCantAddItself
	| portfolio |
	
	portfolio := Portfolio new.
	
	self 
		should: [ portfolio add: portfolio. ]
		raise: Error - MessageNotUnderstood
		withExceptionDo: [:error | self assert: error messageText = Portfolio errorSameTransactionAdd .
								     self assert: (portfolio balance) = 0.
								     self assert: (portfolio numberOfTransactions ) = 0.
								     self assert: (portfolio numberOfLinkedBankEntities) = 0.]
	! !

!PortfolioTest methodsFor: 'testing' stamp: 'Santiago Festini 10/21/2019 15:44:30'!
test14PortfolioCantAddTransactionIfAParentAlreadyHasTransaction
	| portfolioChild portfolioRoot account1 |
	
	portfolioRoot := Portfolio new.
	portfolioChild := Portfolio new.
	account1 := ReceptiveAccount new.
	
	portfolioRoot add: account1 .
	portfolioRoot add: portfolioChild .
	
	self 
		should: [ portfolioChild add: account1. ]
		raise: Error - MessageNotUnderstood
		withExceptionDo: [:error | self assert: error messageText = Portfolio errorSameTransactionAdd .
								     self assert: (portfolioChild numberOfLinkedBankEntities) = 0.]
	! !

!PortfolioTest methodsFor: 'testing' stamp: 'Santiago Festini 10/21/2019 14:45:08'!
test15PortfolioCantAddAPortfolioThatHasATransactionThatAParentOfTheFirstPortfolioAlreadyHas
	| portfolio1 portfolio2 portfolio3 account1 |
	
	portfolio1 := Portfolio new.
	portfolio2 := Portfolio new.
	portfolio3 := Portfolio new.
	account1 := ReceptiveAccount new.
	
	portfolio2 add: account1 .
	portfolio3 add: portfolio1 .
	portfolio3 add: account1 .
	
	self 
		should: [ portfolio1 add: portfolio2 . ]
		raise: Error - MessageNotUnderstood
		withExceptionDo: [:error | self assert: error messageText = Portfolio errorSameTransactionAdd .]
	! !


!classDefinition: #ReceptiveAccountTest category: #Portfolio!
TestCase subclass: #ReceptiveAccountTest
	instanceVariableNames: ''
	classVariableNames: ''
	poolDictionaries: ''
	category: 'Portfolio'!

!ReceptiveAccountTest methodsFor: 'tests' stamp: 'HAW 5/23/2019 15:19:48'!
test01ReceptiveAccountHaveZeroAsBalanceWhenCreated 

	| account |
	
	account := ReceptiveAccount new.

	self assert: 0 equals: account balance .
! !

!ReceptiveAccountTest methodsFor: 'tests' stamp: 'HAW 5/23/2019 15:19:54'!
test02DepositIncreasesBalanceOnTransactionValue 

	| account |
	
	account := ReceptiveAccount  new.
	Deposit register: 100 on: account.
		
	self assert: 100 equals: account balance .
! !

!ReceptiveAccountTest methodsFor: 'tests' stamp: 'HAW 5/23/2019 15:20:02'!
test03WithdrawDecreasesBalanceOnTransactionValue 

	| account |
	
	account := ReceptiveAccount new.
	Deposit register: 100 on: account.
	Withdraw register: 50 on: account.
		
	self assert: 50 equals: account balance .
! !

!ReceptiveAccountTest methodsFor: 'tests' stamp: 'HAW 5/23/2019 15:20:32'!
test04WithdrawValueMustBePositive 

	| account withdrawValue |
	
	account := ReceptiveAccount new.
	withdrawValue := 50.
	
	self assert: withdrawValue equals: (Withdraw register: withdrawValue on: account) value
! !

!ReceptiveAccountTest methodsFor: 'tests' stamp: 'HAW 5/23/2019 15:20:46'!
test05ReceptiveAccountKnowsRegisteredTransactions 

	| account deposit withdraw |
	
	account := ReceptiveAccount new.
	deposit := Deposit register: 100 on: account.
	withdraw := Withdraw register: 50 on: account.
		
	self assert: (account hasRegistered: deposit).
	self assert: (account hasRegistered: withdraw).
! !

!ReceptiveAccountTest methodsFor: 'tests' stamp: 'HAW 5/23/2019 15:20:54'!
test06ReceptiveAccountDoNotKnowNotRegisteredTransactions

	| account deposit withdraw |
	
	account := ReceptiveAccount new.
	deposit :=  Deposit for: 100.
	withdraw := Withdraw for: 50.
		
	self deny: (account hasRegistered: deposit).
	self deny: (account hasRegistered:withdraw).
! !

!ReceptiveAccountTest methodsFor: 'tests' stamp: 'HAW 5/23/2019 15:21:24'!
test07AccountKnowsItsTransactions 

	| account1 deposit1 |
	
	account1 := ReceptiveAccount new.
	
	deposit1 := Deposit register: 100 on: account1.
		
	self assert: 1 equals: account1 transactions size .
	self assert: (account1 transactions includes: deposit1).
! !


!classDefinition: #AccountTransaction category: #Portfolio!
Object subclass: #AccountTransaction
	instanceVariableNames: ''
	classVariableNames: ''
	poolDictionaries: ''
	category: 'Portfolio'!

!AccountTransaction methodsFor: 'value' stamp: 'HernanWilkinson 9/12/2011 12:25'!
value 

	self subclassResponsibility ! !

"-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- "!

!classDefinition: 'AccountTransaction class' category: #Portfolio!
AccountTransaction class
	instanceVariableNames: ''!

!AccountTransaction class methodsFor: 'instance creation' stamp: 'NR 10/17/2019 03:22:00'!
register: aValue on: account

	| transaction |
	
	transaction := self for: aValue.
	account register: transaction.
		
	^ transaction! !


!classDefinition: #Deposit category: #Portfolio!
AccountTransaction subclass: #Deposit
	instanceVariableNames: 'value'
	classVariableNames: ''
	poolDictionaries: ''
	category: 'Portfolio'!

!Deposit methodsFor: 'initialization' stamp: 'HernanWilkinson 7/13/2011 18:45'!
initializeFor: aValue

	value := aValue ! !


!Deposit methodsFor: 'value' stamp: 'HernanWilkinson 7/13/2011 18:38'!
value

	^ value! !

!Deposit methodsFor: 'value' stamp: 'Santiago Festini 10/17/2019 19:32:29'!
valueForBalance

	^ value! !

"-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- "!

!classDefinition: 'Deposit class' category: #Portfolio!
Deposit class
	instanceVariableNames: ''!

!Deposit class methodsFor: 'instance creation' stamp: 'HernanWilkinson 7/13/2011 18:38'!
for: aValue

	^ self new initializeFor: aValue ! !


!classDefinition: #Withdraw category: #Portfolio!
AccountTransaction subclass: #Withdraw
	instanceVariableNames: 'value'
	classVariableNames: ''
	poolDictionaries: ''
	category: 'Portfolio'!

!Withdraw methodsFor: 'initialization' stamp: 'HernanWilkinson 7/13/2011 18:46'!
initializeFor: aValue

	value := aValue ! !


!Withdraw methodsFor: 'value' stamp: 'HernanWilkinson 7/13/2011 18:33'!
value

	^ value! !

!Withdraw methodsFor: 'value' stamp: 'Santiago Festini 10/17/2019 19:32:29'!
valueForBalance

	^ value negated.! !

"-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- "!

!classDefinition: 'Withdraw class' category: #Portfolio!
Withdraw class
	instanceVariableNames: ''!

!Withdraw class methodsFor: 'instance creation' stamp: 'HernanWilkinson 7/13/2011 18:33'!
for: aValue

	^ self new initializeFor: aValue ! !


!classDefinition: #BankEntity category: #Portfolio!
Object subclass: #BankEntity
	instanceVariableNames: 'parentEntities'
	classVariableNames: ''
	poolDictionaries: ''
	category: 'Portfolio'!

!BankEntity methodsFor: 'transactions' stamp: 'Santiago Festini 10/21/2019 15:21:39'!
hasRegistered: aTransaction

	^ self subclassResponsibility .! !

!BankEntity methodsFor: 'transactions' stamp: 'Santiago Festini 10/21/2019 15:17:04'!
transactions

	^ self subclassResponsibility .! !


!BankEntity methodsFor: 'balance' stamp: 'Santiago Festini 10/21/2019 15:21:44'!
balance

	^ self subclassResponsibility .! !


!BankEntity methodsFor: 'bank entities' stamp: 'Santiago Festini 10/21/2019 15:47:34'!
addAsParent: aBankEntity

	^ parentEntities add: aBankEntity .! !

!BankEntity methodsFor: 'bank entities' stamp: 'Santiago Festini 10/21/2019 15:39:08'!
linkedBankEntities

	^ self subclassResponsibility .! !



!classDefinition: #Portfolio category: #Portfolio!
BankEntity subclass: #Portfolio
	instanceVariableNames: 'bankEntities'
	classVariableNames: ''
	poolDictionaries: ''
	category: 'Portfolio'!

!Portfolio methodsFor: 'testing' stamp: 'Santiago Festini 10/21/2019 16:49:21'!
numberOfLinkedBankEntities
	^ bankEntities size.! !

!Portfolio methodsFor: 'testing' stamp: 'Santiago Festini 10/21/2019 11:30:59'!
numberOfTransactions
	^ (self transactions) size.! !


!Portfolio methodsFor: 'asserts - private' stamp: 'Santiago Festini 10/21/2019 16:49:21'!
assertValidEntity: aBankEntity 
	(((aBankEntity = self) or: 
	[bankEntities includes: aBankEntity] ) or: 
	[self rootEntityHasEntity: aBankEntity]) ifTrue: 
	[self error: Portfolio errorSameTransactionAdd].
	! !

!Portfolio methodsFor: 'asserts - private' stamp: 'Santiago Festini 10/21/2019 16:57:47'!
wouldRepeatAnEntity: aBankEntity

	| linkedBankEntities|
	
	linkedBankEntities := aBankEntity linkedBankEntities .
	
	^ linkedBankEntities anySatisfy: [:bankEntity | (self linkedBankEntities) includes: bankEntity.].
	
	
	
	! !


!Portfolio methodsFor: 'bank entities' stamp: 'Santiago Festini 10/21/2019 16:49:21'!
add: aBankEntity
	self assertValidEntity: aBankEntity .
	aBankEntity addAsParent: self.
	bankEntities add: aBankEntity .! !

!Portfolio methodsFor: 'bank entities' stamp: 'Santiago Festini 10/21/2019 16:49:21'!
linkedBankEntities
	|allTransactions|
	allTransactions := OrderedCollection new. 
	bankEntities do:[:bankEntity| allTransactions addAll: (bankEntity linkedBankEntities) ].
	^allTransactions .! !

!Portfolio methodsFor: 'bank entities' stamp: 'Santiago Festini 10/21/2019 15:51:11'!
rootEntityHasEntity: aBankEntity

	(parentEntities size = 0) ifTrue: [^ (self wouldRepeatAnEntity: aBankEntity) .].
	^parentEntities allSatisfy: [ :parentEntity | parentEntity rootEntityHasEntity: aBankEntity . ].
	! !


!Portfolio methodsFor: 'balance' stamp: 'Santiago Festini 10/21/2019 16:49:21'!
balance
	^bankEntities sum: [:bankEntity | bankEntity balance] ifEmpty: [0].! !


!Portfolio methodsFor: 'transactions' stamp: 'Santiago Festini 10/21/2019 11:13:11'!
hasRegistered: aTransaction

	^ (self transactions) includes: aTransaction ! !

!Portfolio methodsFor: 'transactions' stamp: 'Santiago Festini 10/21/2019 16:49:21'!
transactions
	|allTransactions|
	allTransactions := OrderedCollection new. 
	bankEntities do:[:anAccount| allTransactions addAll: (anAccount transactions) ].
	^allTransactions .! !


!Portfolio methodsFor: 'initialization' stamp: 'Santiago Festini 10/21/2019 16:50:06'!
initialize

	bankEntities := OrderedCollection new.
	parentEntities := Set new.! !

"-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- "!

!classDefinition: 'Portfolio class' category: #Portfolio!
Portfolio class
	instanceVariableNames: ''!

!Portfolio class methodsFor: 'as yet unclassified' stamp: 'Santiago Festini 10/21/2019 11:51:02'!
errorSameTransactionAdd

	^'Cant add the same account to a portfolio!!'! !


!classDefinition: #ReceptiveAccount category: #Portfolio!
BankEntity subclass: #ReceptiveAccount
	instanceVariableNames: 'transactions'
	classVariableNames: ''
	poolDictionaries: ''
	category: 'Portfolio'!

!ReceptiveAccount methodsFor: 'bank entities' stamp: 'Santiago Festini 10/21/2019 15:39:08'!
linkedBankEntities
	| set |
	
	set := Set new.
	set add: self.
	^set.! !


!ReceptiveAccount methodsFor: 'transactions' stamp: 'HernanWilkinson 7/13/2011 18:37'!
register: aTransaction

	transactions add: aTransaction 
! !

!ReceptiveAccount methodsFor: 'transactions' stamp: 'HernanWilkinson 7/13/2011 18:37'!
transactions 

	^ transactions copy! !


!ReceptiveAccount methodsFor: 'balance' stamp: 'Santiago Festini 10/17/2019 19:32:29'!
balance

	^transactions sum: [ :aTransaction | aTransaction valueForBalance ] ifEmpty: [ 0 ]! !


!ReceptiveAccount methodsFor: 'testing' stamp: 'NR 10/17/2019 03:28:43'!
hasRegistered: aTransaction

	^ transactions includes: aTransaction 
! !


!ReceptiveAccount methodsFor: 'initialization' stamp: 'Santiago Festini 10/21/2019 16:50:28'!
initialize

	transactions := OrderedCollection new.
	parentEntities := Set new.! !
