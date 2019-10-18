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

!PortfolioTest methodsFor: 'testing' stamp: 'Santiago Festini 10/17/2019 19:54:30'!
test04PortfolioDoesntAddTheSameAccount
	| portfolio account1  |
	 
	account1 := ReceptiveAccount new.
	
	Deposit register: 100 on: account1 .
	
	portfolio := Portfolio new.
	portfolio add: account1.
	portfolio add: account1.
	portfolio add: account1.	
	
	
	self assert: (portfolio numberOfAccounts) equals: 1.
	self assert: (portfolio balance) equals: (account1 balance).! !

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

!PortfolioTest methodsFor: 'testing' stamp: 'Santiago Festini 10/17/2019 20:44:06'!
test09PortfolioWithAnAccountHasTheSameTransactionsAsAccount
	| portfolio  account|
	
	account := ReceptiveAccount new.
	Deposit register: 100 on: account .	
	portfolio := Portfolio new.	
	portfolio add: account .
	
	self assert: (portfolio transactions) equals: (account transactions).! !


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


!classDefinition: #Transactions category: #Portfolio!
Object subclass: #Transactions
	instanceVariableNames: 'transactions'
	classVariableNames: ''
	poolDictionaries: ''
	category: 'Portfolio'!


!classDefinition: #Portfolio category: #Portfolio!
Transactions subclass: #Portfolio
	instanceVariableNames: ''
	classVariableNames: ''
	poolDictionaries: ''
	category: 'Portfolio'!

!Portfolio methodsFor: 'as yet unclassified' stamp: 'Santiago Festini 10/17/2019 20:53:43'!
add: anAccount
	transactions add: anAccount .! !

!Portfolio methodsFor: 'as yet unclassified' stamp: 'Santiago Festini 10/17/2019 20:53:50'!
balance
	^transactions sum: [:account| account balance] ifEmpty: [0].! !

!Portfolio methodsFor: 'as yet unclassified' stamp: 'Santiago Festini 10/17/2019 20:54:02'!
initialize
	transactions := Set new.! !

!Portfolio methodsFor: 'as yet unclassified' stamp: 'Santiago Festini 10/17/2019 20:54:09'!
numberOfAccounts
	^ transactions size.! !

!Portfolio methodsFor: 'as yet unclassified' stamp: 'Santiago Festini 10/17/2019 20:54:16'!
transactions
	|allTransactions|
	allTransactions := OrderedCollection new. 
	transactions do:[:anAccount| allTransactions addAll: (anAccount transactions) ].
	^allTransactions .! !


!classDefinition: #ReceptiveAccount category: #Portfolio!
Transactions subclass: #ReceptiveAccount
	instanceVariableNames: ''
	classVariableNames: ''
	poolDictionaries: ''
	category: 'Portfolio'!

!ReceptiveAccount methodsFor: 'initialization' stamp: 'NR 10/17/2019 15:06:56'!
initialize

	transactions := OrderedCollection new.! !


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
