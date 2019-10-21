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

!PortfolioTest methodsFor: 'testing' stamp: 'mm 10/21/2019 00:32:59'!
test04PortfolioDoesntAddTheSameAccount
	| portfolio account  |
	"Rehacer"
	 
	account := ReceptiveAccount new.
	
	Deposit register: 100 on: account .
	
	portfolio := Portfolio new.
	portfolio add: account.	
	
	self 
		should: [ portfolio add: account ]
		raise: Error - MessageNotUnderstood 
		withExceptionDo: [ :anError |
			self assert: Portfolio canNotAddTheSameAccount equals: anError messageText.
			self assert: 1 equals: portfolio numberOfAccounts .
			self assert: ((portfolio accounts) includes: account ) ]! !

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

!PortfolioTest methodsFor: 'testing' stamp: 'mm 10/20/2019 20:38:37'!
test08EmptyPortfolioHasNoRegisters
	| portfolio  deposit|
	 	
	portfolio := Portfolio new.
	deposit := Deposit for: 100.		self deny: (portfolio hasRegistered: deposit)	
	! !

!PortfolioTest methodsFor: 'testing' stamp: 'mm 10/20/2019 20:58:24'!
test09PortfolioWithAnAccountHasTheSameRegistersAsAccount
	| portfolio  account deposit |
	
	account := ReceptiveAccount new.
	deposit := Deposit register: 100 on: account .	
	portfolio := Portfolio new.	
	portfolio add: account .
	
	self assert: (portfolio hasRegistered: deposit).
	
	! !

!PortfolioTest methodsFor: 'testing' stamp: 'mm 10/20/2019 20:58:39'!
test10PortfolioWithManyAccountsHasTheSameRegistersAsAccounts
	| portfolio  account1 account2 account3 deposit1 deposit2 deposit3|
	
	account1 := ReceptiveAccount new.
	account2 := ReceptiveAccount new.
	account3 := ReceptiveAccount new.
	
	deposit1 := Deposit register: 100 on: account1 .
	deposit2 := Deposit register: 100 on: account2 .
	deposit3 := Deposit register: 100 on: account3 .	
	portfolio := Portfolio new.	
	portfolio add: account1.
	portfolio add: account2.
	portfolio add: account3.
	
	self assert: (portfolio hasRegistered: deposit1).
	self assert: (portfolio hasRegistered: deposit2).
	self assert: (portfolio hasRegistered: deposit3).	
	! !

!PortfolioTest methodsFor: 'testing' stamp: 'mm 10/21/2019 00:30:44'!
test11PortfolioWithAccountsAndPortfoliosHasTheSameBalanceAsAccountsAndPortfolios
	| portfolio1 portfolio2  account1 account2 |
	
	account1 := ReceptiveAccount new.
	account2 := ReceptiveAccount new.
	
	Deposit register: 100 on: account1 .
	Deposit register: 50 on: account2 .
		
	portfolio1 := Portfolio new.	
	portfolio1 add: account1.
	
	portfolio2 := Portfolio new.	
	portfolio2 add: account2.
	portfolio2 add: portfolio1.
	
	self assert: (account2 balance + portfolio1 balance) equals: portfolio2 balance.
		
	! !

!PortfolioTest methodsFor: 'testing' stamp: 'mm 10/20/2019 23:38:56'!
test12PortfolioWithAccountsAndPortfoliosHasTheSameTransactionsAsAccountsAndPortfolios
	| portfolio1 portfolio2  account1 account2 allTransactions |
	
	account1 := ReceptiveAccount new.
	account2 := ReceptiveAccount new.
	
	Deposit register: 100 on: account1 .
	Deposit register: 50 on: account2 .
		
	portfolio1 := Portfolio new.	
	portfolio1 add: account1.
	
	portfolio2 := Portfolio new.	
	portfolio2 add: account2.
	portfolio2 add: portfolio1.
	
	allTransactions := OrderedCollection new.
	allTransactions addAll: (account1 transactions ).
	allTransactions addAll: (account2 transactions ).
	
	self assert: ((portfolio2 transactions ) asSet) equals: (allTransactions asSet).
	
		
	! !

!PortfolioTest methodsFor: 'testing' stamp: 'mm 10/20/2019 20:59:27'!
test13PortfolioWithAccountsAndPortfoliosHasTheSameRegistersAsAccountsAndPortfolios
	| portfolio1 portfolio2  account1 account2 deposit1 deposit2|
	
	account1 := ReceptiveAccount new.
	account2 := ReceptiveAccount new.
	
	deposit1 := Deposit register: 100 on: account1 .
	deposit2 := Deposit register: 50 on: account2 .
		
	portfolio1 := Portfolio new.	
	portfolio1 add: account1.
	
	portfolio2 := Portfolio new.	
	portfolio2 add: account2.
	portfolio2 add: portfolio1.
	
	self assert: (portfolio2 hasRegistered: deposit1).
	self assert: (portfolio2 hasRegistered: deposit2).
		
	! !

!PortfolioTest methodsFor: 'testing' stamp: 'mm 10/21/2019 15:22:23'!
test14PortfolioDoesNotAddAccountsOfPorfolios
	| account portfolio1  portfolio2 |
	
	account := ReceptiveAccount new.
		
	portfolio1 := Portfolio new.	
	portfolio1 add: account.
	
	portfolio2 := Portfolio new.
	portfolio2 add: portfolio1.
	
	self 
		should: [ portfolio2 add: account ]
		raise: Error - MessageNotUnderstood 
		withExceptionDo: [ :anError |
			self assert: Portfolio canNotAddTheSameAccount equals: anError messageText.
			self assert: ((portfolio2 accounts) includes: portfolio1 ) .
			self assert: 1 equals: portfolio2 numberOfAccounts .]
		
	! !

!PortfolioTest methodsFor: 'testing' stamp: 'mm 10/21/2019 15:58:12'!
test15PortfolioDoesNotHaveParentPortfolio
	| account1 account2 portfolio1 portfolio2  |
	
	account1 := ReceptiveAccount new.
	account2 := ReceptiveAccount new.
	
	Deposit  register: 100 on: account1 .
	Deposit register: 50 on: account2 .
	
	portfolio1 := Portfolio new.
	portfolio2 := Portfolio new.
	
	portfolio2 add: portfolio1 .
	portfolio2 add: account1.
	portfolio2 add: account2 .
	
	self 
		should: [ portfolio1 add: account1 ]
		raise: Error - MessageNotUnderstood 
		withExceptionDo: [ :anError |
			self assert: ((portfolio1 accounts) isEmpty ).
			self assert: Portfolio canNotAddTheSameAccount equals: anError messageText.. ]
		
	! !

!PortfolioTest methodsFor: 'testing' stamp: 'mm 10/21/2019 15:28:50'!
test16PortfolioWithPortfoliosDoesNotHaveParentPortfolio
	| account portfolio1 portfolio2 portfolio3 portfolio4 portfolio5 |
	
	account := ReceptiveAccount new.
	Deposit register: 100 on: account .
	
	portfolio1 := Portfolio new.
	
	portfolio2 := Portfolio new.
	portfolio1 add: portfolio2 .
	
	portfolio3 := Portfolio new.
	portfolio3 add: portfolio1 .
	portfolio3 add: account.
	
	portfolio4 := Portfolio new.
	portfolio4 add: portfolio2 .
	
	portfolio5 := Portfolio new.
	portfolio5 add: portfolio4 .
	portfolio5 add: account.

	self 
		should: [ portfolio2 add: account ]
		raise: Error - MessageNotUnderstood 
		withExceptionDo: [ :anError |
			self assert: (portfolio2 accounts) isEmpty.
			self assert: Portfolio canNotAddTheSameAccount equals: anError messageText. ]
		
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


!classDefinition: #Account category: #Portfolio!
Object subclass: #Account
	instanceVariableNames: ''
	classVariableNames: ''
	poolDictionaries: ''
	category: 'Portfolio'!

!Account methodsFor: 'testing' stamp: 'mm 10/21/2019 00:35:39'!
belongTo: aPortfolio
	
	self subclassResponsibility .! !

!Account methodsFor: 'testing' stamp: 'mm 10/21/2019 00:36:06'!
has: anAccount
	
	self subclassResponsibility .! !

!Account methodsFor: 'testing' stamp: 'mm 10/20/2019 23:47:28'!
hasRegistered: aTransaction

	self subclassResponsibility ! !


!Account methodsFor: 'operations' stamp: 'mm 10/21/2019 00:35:17'!
collectTransactions: bunchOfTransactions
	
	self subclassResponsibility .! !


!Account methodsFor: 'as yet unclassified' stamp: 'mm 10/20/2019 23:47:08'!
balance
	self subclassResponsibility ! !

!Account methodsFor: 'as yet unclassified' stamp: 'mm 10/20/2019 23:47:40'!
transactions

	self subclassResponsibility ! !


!classDefinition: #Portfolio category: #Portfolio!
Account subclass: #Portfolio
	instanceVariableNames: 'accounts parents'
	classVariableNames: ''
	poolDictionaries: ''
	category: 'Portfolio'!

!Portfolio methodsFor: 'initialization' stamp: 'mm 10/20/2019 23:48:14'!
initialize
	accounts := OrderedCollection new.
	parents := OrderedCollection new.! !


!Portfolio methodsFor: 'operations' stamp: 'mm 10/21/2019 00:48:01'!
add: anAccount	
	self canAdd: anAccount .
	
	anAccount belongTo: self.
	
	accounts add: anAccount .! !

!Portfolio methodsFor: 'operations' stamp: 'mm 10/21/2019 00:15:34'!
parentHas: anAcount
	^self rootParents anySatisfy: [ :aParent | aParent has: anAcount ]! !


!Portfolio methodsFor: 'as yet unclassified' stamp: 'mm 10/21/2019 00:23:20'!
accounts
	^accounts .! !

!Portfolio methodsFor: 'as yet unclassified' stamp: 'mm 10/19/2019 15:09:59'!
balance
	^accounts sum: [:account| account balance] ifEmpty: [0].! !

!Portfolio methodsFor: 'as yet unclassified' stamp: 'mm 10/21/2019 00:02:05'!
belongTo: aPortfolio
	parents add: aPortfolio .! !

!Portfolio methodsFor: 'as yet unclassified' stamp: 'mm 10/21/2019 00:22:18'!
canAdd: anAccount 
	
	(self parentHas: anAccount ) ifTrue: [ self error: self class canNotAddTheSameAccount ].! !

!Portfolio methodsFor: 'as yet unclassified' stamp: 'mm 10/21/2019 15:42:59'!
collectParents: rootParents
	"implementacion recursiva"
	parents ifEmpty: [ rootParents add: self ] ifNotEmpty: [ parents do: [ :aParent | aParent collectParents: rootParents ]]! !

!Portfolio methodsFor: 'as yet unclassified' stamp: 'mm 10/20/2019 23:58:29'!
collectTransactions: bunchOfTransactions
	
	accounts do: [ :anAccount | anAccount collectTransactions: bunchOfTransactions ]! !

!Portfolio methodsFor: 'as yet unclassified' stamp: 'mm 10/21/2019 00:19:46'!
has: anAccount
	
	^self = anAccount or: [ accounts anySatisfy: [ :bunchOfAccounts | bunchOfAccounts has: anAccount ]]! !

!Portfolio methodsFor: 'as yet unclassified' stamp: 'mm 10/21/2019 00:02:56'!
hasRegistered: aTransaction

	^accounts anySatisfy: [ :anAccount | anAccount hasRegistered: aTransaction ]! !

!Portfolio methodsFor: 'as yet unclassified' stamp: 'mm 10/19/2019 15:10:08'!
numberOfAccounts
	^ accounts size.! !

!Portfolio methodsFor: 'as yet unclassified' stamp: 'mm 10/21/2019 00:53:38'!
parents
	^parents .! !

!Portfolio methodsFor: 'as yet unclassified' stamp: 'mm 10/21/2019 00:54:51'!
rootParents
	| Parents |
	
	Parents := Set new.
	
	self collectParents: Parents.
	^ Parents! !

!Portfolio methodsFor: 'as yet unclassified' stamp: 'mm 10/20/2019 23:59:15'!
transactions
	|allTransactions|
	allTransactions := OrderedCollection new. 
	accounts do:[:anAccount| anAccount collectTransactions: allTransactions ].
	^allTransactions .! !

"-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- "!

!classDefinition: 'Portfolio class' category: #Portfolio!
Portfolio class
	instanceVariableNames: ''!

!Portfolio class methodsFor: 'error messages' stamp: 'mm 10/21/2019 00:21:44'!
canNotAddTheSameAccount

	^'You can not add the same account to a portfolio that already has it'.! !


!classDefinition: #ReceptiveAccount category: #Portfolio!
Account subclass: #ReceptiveAccount
	instanceVariableNames: 'transactions'
	classVariableNames: ''
	poolDictionaries: ''
	category: 'Portfolio'!

!ReceptiveAccount methodsFor: 'initialization' stamp: 'NR 10/17/2019 15:06:56'!
initialize

	transactions := OrderedCollection new.! !


!ReceptiveAccount methodsFor: 'transactions' stamp: 'mm 10/21/2019 00:09:00'!
has: anAccount
	^ self = anAccount .
! !

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


!ReceptiveAccount methodsFor: 'as yet unclassified' stamp: 'mm 10/21/2019 00:05:32'!
belongTo: aPortfolio! !

!ReceptiveAccount methodsFor: 'as yet unclassified' stamp: 'mm 10/21/2019 00:04:58'!
collectTransactions: bunchOfTransactions
	bunchOfTransactions addAll: transactions .! !


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
