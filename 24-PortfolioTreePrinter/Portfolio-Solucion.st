!classDefinition: #AccountSummaryTest category: #'Portfolio-Solucion'!
TestCase subclass: #AccountSummaryTest
	instanceVariableNames: ''
	classVariableNames: ''
	poolDictionaries: ''
	category: 'Portfolio-Solucion'!

!AccountSummaryTest methodsFor: 'as yet unclassified' stamp: 'sf 10/26/2019 17:18:38'!
test01SummaryReportOfEmptyAccountPrintsOnlyBalanceAsZero

	| account report accountOperations |
	
	account := ReceptiveAccount new.
	report := SummaryReport for: account .
	
	accountOperations := OrderedCollection new.
	
	accountOperations add: 'Balance = 0'.
	
	self assert: report accountOperations equals: accountOperations.
	
	
	! !

!AccountSummaryTest methodsFor: 'as yet unclassified' stamp: 'sf 10/26/2019 17:48:41'!
test02SummaryReportOfAccountWithDepositPrintsDeposit

	| account report accountOperations |
	
	account := ReceptiveAccount new.
	report := SummaryReport for: account .
	Deposit register: 100 on: account .
	
	accountOperations := OrderedCollection new.
	accountOperations add: 'Deposito por 100'.
	accountOperations add: 'Balance = 100'.
	
	self assert: report accountOperations equals: accountOperations.
	
	
	! !

!AccountSummaryTest methodsFor: 'as yet unclassified' stamp: 'sf 10/26/2019 17:48:47'!
test03SummaryReportOfAccountWithWithdrawPrintsWithdraw

	| account report accountOperations |
	
	account := ReceptiveAccount new.
	report := SummaryReport for: account .
	Withdraw register: 100 on: account .
	
	accountOperations := OrderedCollection new.
	accountOperations add: 'Extraccion por 100'.
	accountOperations add: 'Balance = -100'.
	
	self assert: report accountOperations equals: accountOperations.
	
	
	! !

!AccountSummaryTest methodsFor: 'as yet unclassified' stamp: 'sf 10/26/2019 17:48:54'!
test04SummaryReportOfAccountWithTransferenceInPrintsTransferenceIn

	| report accountOperations accountReceiver accountSender |
	
	accountSender := ReceptiveAccount new.
	accountReceiver := ReceptiveAccount new.
	report := SummaryReport for: accountReceiver .
	Transference transfer: 50 from: accountSender to: accountReceiver.
	
	accountOperations := OrderedCollection new.
	accountOperations add: 'Entrada por transferencia de 50'.
	accountOperations add: 'Balance = 50'.
	
	self assert: report accountOperations equals: accountOperations.
	
	
	! !

!AccountSummaryTest methodsFor: 'as yet unclassified' stamp: 'sf 10/26/2019 17:49:01'!
test05SummaryReportOfAccountWithTransferenceOutPrintsTransferenceOut

	| report accountOperations accountReceiver accountSender |
	
	accountSender := ReceptiveAccount new.
	accountReceiver := ReceptiveAccount new.
	report := SummaryReport for: accountSender .
	Transference transfer: 50 from: accountSender to: accountReceiver.
	
	accountOperations := OrderedCollection new.
	accountOperations add: 'Salida por transferencia de 50'.
	accountOperations add: 'Balance = -50'.
	
	self assert: report accountOperations equals: accountOperations.
	
	
	! !

!AccountSummaryTest methodsFor: 'as yet unclassified' stamp: 'sf 10/26/2019 17:51:19'!
test06SummaryReportOfAccountWithMoreThanOneTransactionPrintsAllTheTransactions

	| report accountOperations accountReceiver accountSender |
	
	accountSender := ReceptiveAccount new.
	accountReceiver := ReceptiveAccount new.
	report := SummaryReport for: accountSender .
	Transference transfer: 50 from: accountSender to: accountReceiver.
	Deposit register: 100 on: accountSender .
	Withdraw register: 25 on: accountSender .
	
	accountOperations := OrderedCollection new.
	accountOperations add: 'Salida por transferencia de 50'.
	accountOperations add: 'Deposito por 100'.
	accountOperations add: 'Extraccion por 25'.
	accountOperations add: 'Balance = 25'.
	
	self assert: report accountOperations equals: accountOperations.
	
	
	! !


!classDefinition: #PortfolioTest category: #'Portfolio-Solucion'!
TestCase subclass: #PortfolioTest
	instanceVariableNames: ''
	classVariableNames: ''
	poolDictionaries: ''
	category: 'Portfolio-Solucion'!

!PortfolioTest methodsFor: 'tests' stamp: 'HAW 5/25/2019 11:16:26'!
test01BalanceOfPortfolioWithoutAccountsIsZero

	self assert: 0 equals: Portfolio new balance! !

!PortfolioTest methodsFor: 'tests' stamp: 'sf 10/26/2019 16:31:34'!
test02BalanceOfPortfolioWithOneAccountIsAccountBalance

	| account portfolio |
	
	account := ReceptiveAccount new.
	Deposit register: 100 on: account.
	portfolio := Portfolio for: account.
	
	self assert: account balance equals: portfolio balance! !

!PortfolioTest methodsFor: 'tests' stamp: 'sf 10/26/2019 16:31:34'!
test03BalanceOfPortfolioIsCalculatedRecursivelyOnPortfolios

	| simplePortfolioAccount simplePortfolio composedPortfolioAccount composedPortofolio |
	
	simplePortfolioAccount := ReceptiveAccount new.
	Deposit register: 100 on: simplePortfolioAccount.
	simplePortfolio := Portfolio for: simplePortfolioAccount.
	
	composedPortfolioAccount := ReceptiveAccount new.
	Withdraw register: 50 on: composedPortfolioAccount.
	composedPortofolio := Portfolio with: simplePortfolio with: composedPortfolioAccount.
	
	self assert: (composedPortfolioAccount balance + simplePortfolio balance) equals: composedPortofolio balance! !

!PortfolioTest methodsFor: 'tests' stamp: 'HAW 5/25/2019 11:43:15'!
test04PortfolioWithoutAccountsHasNoRegisteredTransaction

	self deny: (Portfolio new hasRegistered: (Deposit for: 100))! !

!PortfolioTest methodsFor: 'tests' stamp: 'sf 10/26/2019 16:31:34'!
test05PortfolioHasRegisteredItsAccountsTransactions

	| account portfolio deposit |
	
	account := ReceptiveAccount new.
	deposit := Deposit register: 100 on: account.
	portfolio := Portfolio for: account.
	
	self assert: (portfolio hasRegistered: deposit)! !

!PortfolioTest methodsFor: 'tests' stamp: 'sf 10/26/2019 16:31:34'!
test06PortfolioLooksForRegisteredTransactionsRecursively

	| simplePortfolioAccount simplePortfolio composedPortfolioAccount composedPortfolio composedPortfolioAccountWithdraw simplePortfolioAccountDeposit |
	
	simplePortfolioAccount := ReceptiveAccount new.
	simplePortfolioAccountDeposit := Deposit register: 100 on: simplePortfolioAccount.
	simplePortfolio := Portfolio for: simplePortfolioAccount.
	
	composedPortfolioAccount := ReceptiveAccount new.
	composedPortfolioAccountWithdraw := Withdraw register: 50 on: composedPortfolioAccount.
	composedPortfolio := Portfolio with: simplePortfolio with: composedPortfolioAccount.
	
	self assert: (composedPortfolio hasRegistered: simplePortfolioAccountDeposit).
	self assert: (composedPortfolio hasRegistered: composedPortfolioAccountWithdraw)! !

!PortfolioTest methodsFor: 'tests' stamp: 'HAW 5/25/2019 11:58:10'!
test07PortfolioHasNoTransactionWhenHasNoAccounts

	self assert: Portfolio new transactions isEmpty! !

!PortfolioTest methodsFor: 'tests' stamp: 'sf 10/26/2019 16:31:34'!
test08PortfolioTransasctionsIncludesAllItsAccountsTransactions

	| account portfolio accountDeposit anotherAccount portfolioTransactions anotherAccountWithdraw |
	
	account := ReceptiveAccount new.
	accountDeposit := Deposit register: 100 on: account.
	anotherAccount := ReceptiveAccount new.
	anotherAccountWithdraw := Withdraw register: 100 on: account.
	portfolio := Portfolio for: account.
	
	portfolioTransactions := portfolio transactions.
	
	self assert: 2 equals: portfolioTransactions size.
	self assert: (portfolioTransactions includes: accountDeposit).
	self assert: (portfolioTransactions includes: anotherAccountWithdraw)! !

!PortfolioTest methodsFor: 'tests' stamp: 'sf 10/26/2019 16:31:34'!
test09PortfolioTransactionsAreCalculatedRecursively

	| simplePortfolioAccount simplePortfolio composedPortfolioAccount composedPortfolio composedPortfolioAccountWithdraw simplePortfolioAccountDeposit composedPortfolioTransactions |
	
	simplePortfolioAccount := ReceptiveAccount new.
	simplePortfolioAccountDeposit := Deposit register: 100 on: simplePortfolioAccount.
	simplePortfolio := Portfolio for: simplePortfolioAccount.
	
	composedPortfolioAccount := ReceptiveAccount new.
	composedPortfolioAccountWithdraw := Withdraw register: 50 on: composedPortfolioAccount.
	composedPortfolio := Portfolio with: simplePortfolio with: composedPortfolioAccount.
	
	composedPortfolioTransactions := composedPortfolio transactions.
	self assert: 2 equals: composedPortfolioTransactions size.
	self assert: (composedPortfolioTransactions includes: simplePortfolioAccountDeposit).
	self assert: (composedPortfolioTransactions includes: composedPortfolioAccountWithdraw)! !

!PortfolioTest methodsFor: 'tests' stamp: 'sf 10/26/2019 16:31:34'!
test10PortfolioCanNotIncludeTheSameAccountMoreThanOnce

	| account portfolio |
	
	account := ReceptiveAccount new.
	portfolio := Portfolio for: account.
	
	self 
		should: [ portfolio add: account ]
		raise: Error - MessageNotUnderstood 
		withExceptionDo: [ :anError |
			self assert: Portfolio canNotAddAccountErrorMessage equals: anError messageText.
			self assert: 1 equals: portfolio accountsSize.
			self assert: (portfolio accountsIncludes: account) ]! !

!PortfolioTest methodsFor: 'tests' stamp: 'sf 10/26/2019 16:31:34'!
test11PortfolioCanNotIncludeAccountOfItsPortfolios

	| account simplePortfolio composedPortfolio |
	
	account := ReceptiveAccount new.
	simplePortfolio := Portfolio for: account.
	composedPortfolio := Portfolio for: simplePortfolio.
	
	self 
		should: [ composedPortfolio add: account ]
		raise: Error - MessageNotUnderstood 
		withExceptionDo: [ :anError |
			self assert: Portfolio canNotAddAccountErrorMessage equals: anError messageText.
			self assert: 1 equals: composedPortfolio accountsSize.
			self assert: (composedPortfolio accountsIncludes: simplePortfolio) ]! !

!PortfolioTest methodsFor: 'tests' stamp: 'sf 10/26/2019 16:31:34'!
test12PortfolioCanNotIncludeItself

	| account simplePortfolio |
	
	account := ReceptiveAccount new.
	simplePortfolio := Portfolio for: account.
	
	self 
		should: [ simplePortfolio add: simplePortfolio ]
		raise: Error - MessageNotUnderstood 
		withExceptionDo: [ :anError |
			self assert: Portfolio canNotAddAccountErrorMessage equals: anError messageText.
			self assert: 1 equals: simplePortfolio accountsSize.
			self assert: (simplePortfolio accountsIncludes: account) ]! !

!PortfolioTest methodsFor: 'tests' stamp: 'sf 10/26/2019 16:31:34'!
test13ComposedPortfolioCanNotHaveParentPortfolioAccount

	| account simplePortfolio composedPortfolio |
	
	account := ReceptiveAccount new.
	simplePortfolio := Portfolio new.
	composedPortfolio := Portfolio for: simplePortfolio.
	composedPortfolio add: account.
	
	self 
		should: [ simplePortfolio add: account ]
		raise: Error - MessageNotUnderstood 
		withExceptionDo: [ :anError |
			self assert: Portfolio canNotAddAccountErrorMessage equals: anError messageText.
			self assert: simplePortfolio accountsIsEmpty ]! !

!PortfolioTest methodsFor: 'tests' stamp: 'sf 10/26/2019 16:31:34'!
test14ComposedPortfolioCanNotHaveAccountOfAnyRootParentRecursively

	| account leftParentPortfolio leftRootParentPortfolio portfolio rightParentPortfolio rightRootParentPortfolio |
	
	account := ReceptiveAccount new.
	portfolio := Portfolio new.
	leftParentPortfolio := Portfolio for: portfolio .
	leftRootParentPortfolio := Portfolio for: leftParentPortfolio.
	leftRootParentPortfolio add: account.
	
	rightParentPortfolio := Portfolio for: portfolio .
	rightRootParentPortfolio := Portfolio for: rightParentPortfolio.
	rightRootParentPortfolio add: account.

	self 
		should: [ portfolio add: account ]
		raise: Error - MessageNotUnderstood 
		withExceptionDo: [ :anError |
			self assert: Portfolio canNotAddAccountErrorMessage equals: anError messageText.
			self assert: portfolio accountsIsEmpty ]! !

!PortfolioTest methodsFor: 'tests' stamp: 'sf 10/26/2019 16:31:34'!
test15PortfolioCanNotIncludeAnyOfTheComposedAccountOfPortfolioToAdd

	| portfolioToAdd portfolioToModify rootPortfolio sharedAccount |
	
	sharedAccount := ReceptiveAccount new.
	portfolioToModify := Portfolio new.
	rootPortfolio := Portfolio with: sharedAccount with: portfolioToModify.
	portfolioToAdd := Portfolio for: sharedAccount.
	
	self 
		should: [ portfolioToModify add: portfolioToAdd ]
		raise: Error - MessageNotUnderstood 
		withExceptionDo: [ :anError | 
			self assert: Portfolio canNotAddAccountErrorMessage equals: anError messageText.
			self assert: portfolioToModify accountsIsEmpty ]! !


!classDefinition: #ReceptiveAccountTest category: #'Portfolio-Solucion'!
TestCase subclass: #ReceptiveAccountTest
	instanceVariableNames: ''
	classVariableNames: ''
	poolDictionaries: ''
	category: 'Portfolio-Solucion'!

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


!classDefinition: #TransferNetTest category: #'Portfolio-Solucion'!
TestCase subclass: #TransferNetTest
	instanceVariableNames: ''
	classVariableNames: ''
	poolDictionaries: ''
	category: 'Portfolio-Solucion'!

!TransferNetTest methodsFor: 'as yet unclassified' stamp: 'sf 10/26/2019 18:02:31'!
test01TransferNetForAnAccountWithoutTransactionsIsZero

	| account transferNet |
	
	account := ReceptiveAccount new.
	transferNet := TransferNet for: account.
	
	self assert: 0 equals: (transferNet value).! !

!TransferNetTest methodsFor: 'as yet unclassified' stamp: 'sf 10/26/2019 18:35:39'!
test02TransferNetForAnAccountWithOnlyATransferenceInIsTheTransferenceValue

	| receiverAccount senderAccount transferNet |
	
	receiverAccount := ReceptiveAccount new.
	senderAccount := ReceptiveAccount new.
	transferNet := TransferNet for: receiverAccount .

	Transference transfer: 50 from: senderAccount to: receiverAccount .
	
	self assert: 50 equals: (transferNet value).! !

!TransferNetTest methodsFor: 'as yet unclassified' stamp: 'sf 10/26/2019 18:11:42'!
test03TransferNetForAnAccountDoesNotTakeIntoAccountDeposits

	| account transferNet |
	
	account := ReceptiveAccount new.
	transferNet := TransferNet for: account.

	Deposit register: 100 on: account .
	
	self assert: 0 equals: (transferNet value).! !

!TransferNetTest methodsFor: 'as yet unclassified' stamp: 'sf 10/26/2019 18:33:29'!
test04TransferNetForAnAccountDoesNotTakeIntoAccountWithdraws

	| account transferNet |
	
	account := ReceptiveAccount new.
	transferNet := TransferNet for: account.

	Withdraw register: 100 on: account .
	
	self assert: 0 equals: (transferNet value).! !

!TransferNetTest methodsFor: 'as yet unclassified' stamp: 'sf 10/26/2019 18:35:54'!
test05TransferNetForAnAccountWithOnlyATransferenceOutIsTheTransferenceValue

	| receiverAccount senderAccount transferNet |
	
	receiverAccount := ReceptiveAccount new.
	senderAccount := ReceptiveAccount new.
	transferNet := TransferNet for: senderAccount.

	Transference transfer: 50 from: senderAccount to: receiverAccount .
	
	self assert: -50 equals: (transferNet value).! !

!TransferNetTest methodsFor: 'as yet unclassified' stamp: 'sf 10/26/2019 18:42:01'!
test06TransferNetForAnAccountWithManyTransactionsOnlyConsidersTheTransferences

	| transferNetAccount otherAccount transferNet |
	
	transferNetAccount := ReceptiveAccount new.
	otherAccount := ReceptiveAccount new.
	transferNet := TransferNet for: transferNetAccount .

	Transference transfer: 50 from: otherAccount to: transferNetAccount .
	Transference transfer: 5 from: transferNetAccount to: otherAccount .
	Deposit register: 17 on: transferNetAccount .
	Withdraw register: 541 on: transferNetAccount .
		
	self assert: 45 equals: (transferNet value).! !


!classDefinition: #TransferenceTest category: #'Portfolio-Solucion'!
TestCase subclass: #TransferenceTest
	instanceVariableNames: ''
	classVariableNames: ''
	poolDictionaries: ''
	category: 'Portfolio-Solucion'!

!TransferenceTest methodsFor: 'testing' stamp: 'Santiago Festini 10/21/2019 19:22:56'!
test01MakingATransferenceModifiesBothAccounts

	| account1 account2 |
	account1 := ReceptiveAccount new.
	account2 := ReceptiveAccount new.
	
	Transference transfer: 50 from: account1 to: account2.
	
	self assert: -50 equals: account1 balance.
	self assert: 50 equals: account2 balance.! !

!TransferenceTest methodsFor: 'testing' stamp: 'Santiago Festini 10/24/2019 17:01:59'!
test02TransferenceValueMustBePositive

	| account1 account2 |
	account1 := ReceptiveAccount new.
	account2 := ReceptiveAccount new.
	
	self 
		should: [ Transference transfer: -50 from: account1 to: account2. ]
		raise: Error - MessageNotUnderstood 
		withExceptionDo: [ :anError |
			self assert: Transference cantTransferThatAmount equals: anError messageText.
			self assert: 0 equals: account1 balance.
			self assert: 0 equals: account2 balance. ]
	
	
	! !

!TransferenceTest methodsFor: 'testing' stamp: 'Santiago Festini 10/24/2019 17:01:59'!
test03TransferenceValueCantBeZero

	| account1 account2 |
	account1 := ReceptiveAccount new.
	account2 := ReceptiveAccount new.
	
	self 
		should: [ Transference transfer: 0 from: account1 to: account2. ]
		raise: Error - MessageNotUnderstood 
		withExceptionDo: [ :anError |
			self assert: Transference cantTransferThatAmount equals: anError messageText.
			self assert: 0 equals: account1 balance.
			self assert: 0 equals: account2 balance. ]
	
	
	! !

!TransferenceTest methodsFor: 'testing' stamp: 'sf 10/26/2019 16:25:39'!
test04TransferenceAccountCantBeTheSame

	| account1 |
	account1 := ReceptiveAccount new.
	
	self 
		should: [ Transference transfer: 50 from: account1 to: account1. ]
		raise: Error - MessageNotUnderstood 
		withExceptionDo: [ :anError |
			self assert: Transference cantTransferToTheSameAccount equals: anError messageText.
			self assert: 0 equals: account1 balance. ]
	
	
	! !

!TransferenceTest methodsFor: 'testing' stamp: 'sf 10/26/2019 16:49:22'!
test05TransferenceIsRegisteredInBothAccounts

	| accountSender accountReceiver transfer |
	accountSender := ReceptiveAccount new.
	accountReceiver := ReceptiveAccount new.
	
	transfer := (Transference transfer: 50 from: accountSender to: accountReceiver ).
	
	self assert: (accountSender hasRegistered: transfer transferenceOut).
	self assert: (accountReceiver hasRegistered: transfer transferenceIn).	
	
	
	! !

!TransferenceTest methodsFor: 'testing' stamp: 'sf 10/26/2019 16:49:22'!
test06TransfereceInCanAccessTransferenceOut

	| accountSender accountReceiver transfer |
	accountSender := ReceptiveAccount new.
	accountReceiver := ReceptiveAccount new.
	
	transfer := (Transference transfer: 50 from: accountSender to: accountReceiver ).
	
	self assert: (transfer transferenceIn transferenceOut) equals: (transfer transferenceOut).
	
	
	! !

!TransferenceTest methodsFor: 'testing' stamp: 'sf 10/26/2019 16:49:22'!
test07TransfereceOutCanAccessTransferenceIn

	| accountSender accountReceiver transfer |
	accountSender := ReceptiveAccount new.
	accountReceiver := ReceptiveAccount new.
	
	transfer := (Transference transfer: 50 from: accountSender to: accountReceiver ).
	
	self assert: (transfer transferenceOut transferenceIn) equals: (transfer transferenceIn).
	
	
	! !


!classDefinition: #Account category: #'Portfolio-Solucion'!
Object subclass: #Account
	instanceVariableNames: ''
	classVariableNames: ''
	poolDictionaries: ''
	category: 'Portfolio-Solucion'!

!Account methodsFor: 'testing' stamp: 'HAW 5/25/2019 12:23:47'!
hasRegistered: aTransaction

	self subclassResponsibility ! !

!Account methodsFor: 'testing' stamp: 'HAW 5/25/2019 12:24:25'!
isComposedBy: anAccount

	self subclassResponsibility ! !


!Account methodsFor: 'balance' stamp: 'HAW 5/25/2019 12:23:40'!
balance

	self subclassResponsibility ! !


!Account methodsFor: 'transactions' stamp: 'HAW 5/25/2019 12:23:27'!
addTransactionsTo: aCollectionOfTransactions

	self subclassResponsibility ! !

!Account methodsFor: 'transactions' stamp: 'HAW 5/25/2019 12:23:15'!
transactions

	self subclassResponsibility ! !


!Account methodsFor: 'composition' stamp: 'HAW 5/25/2019 12:24:04'!
addedTo: aPortfolio

	self subclassResponsibility ! !


!classDefinition: #Portfolio category: #'Portfolio-Solucion'!
Account subclass: #Portfolio
	instanceVariableNames: 'accounts parents'
	classVariableNames: ''
	poolDictionaries: ''
	category: 'Portfolio-Solucion'!

!Portfolio methodsFor: 'accounts management' stamp: 'HAW 5/25/2019 11:49:20'!
accountsIncludes: anAccount

	^accounts includes: anAccount ! !

!Portfolio methodsFor: 'accounts management' stamp: 'HAW 5/25/2019 12:05:04'!
accountsIsEmpty
	
	^accounts isEmpty ! !

!Portfolio methodsFor: 'accounts management' stamp: 'HAW 5/25/2019 11:49:06'!
accountsSize
	
	^accounts size! !

!Portfolio methodsFor: 'accounts management' stamp: 'HAW 5/25/2019 12:19:20'!
add: accountToAdd

	self assertCanAdd: accountToAdd.
		
	accounts add: accountToAdd.
	accountToAdd addedTo: self 
	! !

!Portfolio methodsFor: 'accounts management' stamp: 'HAW 5/25/2019 12:17:31'!
rootParents
	
	| rootParents |
	
	rootParents := Set new.
	self addRootParentsTo: rootParents.
	
	^ rootParents! !


!Portfolio methodsFor: 'initialization' stamp: 'HAW 5/25/2019 12:03:18'!
initialize

	accounts := OrderedCollection new.
	parents := OrderedCollection new.! !


!Portfolio methodsFor: 'balance' stamp: 'HAW 5/25/2019 11:19:36'!
balance
	
	^accounts sum: [ :anAccount | anAccount balance ] ifEmpty: [ 0 ]! !


!Portfolio methodsFor: 'transactions' stamp: 'HAW 5/25/2019 11:42:55'!
addTransactionsTo: aCollectionOfTransactions

	accounts do: [ :anAccount | anAccount addTransactionsTo: aCollectionOfTransactions ]! !

!Portfolio methodsFor: 'transactions' stamp: 'HAW 5/25/2019 11:38:32'!
transactions
	
	| transactions |
	
	transactions := OrderedCollection new.
	accounts do: [ :anAccount | anAccount addTransactionsTo: transactions ].
	
	^transactions ! !


!Portfolio methodsFor: 'composition' stamp: 'HAW 5/25/2019 12:02:59'!
addedTo: aPortfolio 
	
	parents add: aPortfolio ! !


!Portfolio methodsFor: 'testing' stamp: 'HAW 5/25/2019 12:20:56'!
anyRootParentIsComposedBy: accountToAdd

	^self rootParents anySatisfy: [ :aParent | aParent isComposedBy: accountToAdd]! !

!Portfolio methodsFor: 'testing' stamp: 'HAW 5/25/2019 11:28:29'!
hasRegistered: aTransaction

	^accounts anySatisfy: [ :anAccount | anAccount hasRegistered: aTransaction ]! !

!Portfolio methodsFor: 'testing' stamp: 'HAW 5/29/2019 16:24:54'!
isComposedBy: anAccount

	^ self = anAccount or: [ accounts anySatisfy: [ :composedAccount | (composedAccount isComposedBy: anAccount) or: [ anAccount isComposedBy: composedAccount ]]]! !


!Portfolio methodsFor: 'account management - private' stamp: 'HAW 5/25/2019 12:17:31'!
addRootParentsTo: rootParents

	parents 
		ifEmpty: [ rootParents add: self ] 
		ifNotEmpty: [ parents do: [ :aParent | aParent addRootParentsTo: rootParents ]]! !

!Portfolio methodsFor: 'account management - private' stamp: 'HAW 5/25/2019 12:20:36'!
assertCanAdd: accountToAdd

	(self anyRootParentIsComposedBy: accountToAdd) ifTrue: [ self signalCanNotAddAccount ].
! !

!Portfolio methodsFor: 'account management - private' stamp: 'HAW 5/25/2019 11:48:34'!
signalCanNotAddAccount
	
	self error: self class canNotAddAccountErrorMessage! !

"-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- "!

!classDefinition: 'Portfolio class' category: #'Portfolio-Solucion'!
Portfolio class
	instanceVariableNames: ''!

!Portfolio class methodsFor: 'as yet unclassified' stamp: 'HAW 5/25/2019 11:48:55'!
canNotAddAccountErrorMessage
	
	^'Can not add repeated account to a portfolio'! !

!Portfolio class methodsFor: 'as yet unclassified' stamp: 'sf 10/26/2019 16:31:34'!
for: anAccount

	^self new 
		add: anAccount;
		yourself! !

!Portfolio class methodsFor: 'as yet unclassified' stamp: 'HAW 5/25/2019 11:23:59'!
with: anAccount with: anotherAccount

	^self new 
		add: anAccount;
		add: anotherAccount;
		yourself! !


!classDefinition: #ReceptiveAccount category: #'Portfolio-Solucion'!
Account subclass: #ReceptiveAccount
	instanceVariableNames: 'transactions'
	classVariableNames: ''
	poolDictionaries: ''
	category: 'Portfolio-Solucion'!

!ReceptiveAccount methodsFor: 'initialization' stamp: 'HernanWilkinson 7/13/2011 18:35'!
initialize

	super initialize.
	transactions := OrderedCollection new.! !


!ReceptiveAccount methodsFor: 'transactions' stamp: 'HAW 5/25/2019 11:38:52'!
addTransactionsTo: aCollectionOfTransactions

	aCollectionOfTransactions addAll: transactions ! !

!ReceptiveAccount methodsFor: 'transactions' stamp: 'HernanWilkinson 7/13/2011 18:37'!
register: aTransaction

	transactions add: aTransaction 
! !

!ReceptiveAccount methodsFor: 'transactions' stamp: 'HernanWilkinson 7/13/2011 18:37'!
transactions 

	^ transactions copy! !


!ReceptiveAccount methodsFor: 'balance' stamp: 'HAW 5/25/2019 11:24:46'!
balance

	^transactions 
		inject: 0
		into: [ :currentBalance :transaction | transaction affectBalance: currentBalance ]! !


!ReceptiveAccount methodsFor: 'testing' stamp: 'NR 10/21/2019 14:26:41'!
hasRegistered: aTransaction

	^ transactions includes: aTransaction
! !

!ReceptiveAccount methodsFor: 'testing' stamp: 'HAW 5/25/2019 11:54:51'!
isComposedBy: anAccount

	^self = anAccount ! !


!ReceptiveAccount methodsFor: 'composition' stamp: 'HAW 5/25/2019 12:03:32'!
addedTo: aPortfolio 
	
	! !


!classDefinition: #AccountTransaction category: #'Portfolio-Solucion'!
Object subclass: #AccountTransaction
	instanceVariableNames: ''
	classVariableNames: ''
	poolDictionaries: ''
	category: 'Portfolio-Solucion'!

!AccountTransaction methodsFor: 'value' stamp: 'Santiago Festini 10/24/2019 15:18:17'!
initializeFor: aValue

	^ self subclassResponsibility .! !

!AccountTransaction methodsFor: 'value' stamp: 'Santiago Festini 10/21/2019 21:03:00'!
value

	^ self subclassResponsibility .! !


!AccountTransaction methodsFor: 'balance' stamp: 'HAW 5/25/2019 11:25:39'!
affectBalance: aBalance

	self subclassResponsibility ! !

"-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- "!

!classDefinition: 'AccountTransaction class' category: #'Portfolio-Solucion'!
AccountTransaction class
	instanceVariableNames: ''!

!AccountTransaction class methodsFor: 'instance creation' stamp: 'NR 10/21/2019 14:27:17'!
for: aValue

	^ self new initializeFor: aValue! !

!AccountTransaction class methodsFor: 'instance creation' stamp: 'NR 10/21/2019 14:27:05'!
register: aValue on: account

	| transaction |
	
	transaction := self for: aValue.
	account register: transaction.
		
	^ transaction! !


!classDefinition: #Deposit category: #'Portfolio-Solucion'!
AccountTransaction subclass: #Deposit
	instanceVariableNames: 'value'
	classVariableNames: ''
	poolDictionaries: ''
	category: 'Portfolio-Solucion'!

!Deposit methodsFor: 'balance' stamp: 'HAW 5/25/2019 11:25:02'!
affectBalance: aBalance

	^aBalance + value ! !


!Deposit methodsFor: 'value' stamp: 'Santiago Festini 10/21/2019 21:03:44'!
value

	^value! !


!Deposit methodsFor: 'as yet unclassified' stamp: 'Santiago Festini 10/24/2019 15:18:26'!
initializeFor: aValue

	value := aValue ! !

!Deposit methodsFor: 'as yet unclassified' stamp: 'sf 10/26/2019 17:35:18'!
printOn: aReport

	aReport add: ('Deposito por ', (self value printString)).! !

!Deposit methodsFor: 'as yet unclassified' stamp: 'sf 10/26/2019 18:16:46'!
transferNetValueFor: aNetValue

	^ aNetValue.! !


!classDefinition: #TransferenceIn category: #'Portfolio-Solucion'!
AccountTransaction subclass: #TransferenceIn
	instanceVariableNames: 'transference'
	classVariableNames: ''
	poolDictionaries: ''
	category: 'Portfolio-Solucion'!

!TransferenceIn methodsFor: 'value' stamp: 'Santiago Festini 10/24/2019 16:56:34'!
affectBalance: aBalance

	^ aBalance + (transference value).! !

!TransferenceIn methodsFor: 'value' stamp: 'sf 10/26/2019 16:49:22'!
transferenceOut

	^ transference transferenceOut.! !

!TransferenceIn methodsFor: 'value' stamp: 'Santiago Festini 10/24/2019 15:15:50'!
value

	^ transference value.! !


!TransferenceIn methodsFor: 'as yet unclassified' stamp: 'sf 10/26/2019 16:32:44'!
initializeFor: aTransference

	transference := aTransference .

	! !

!TransferenceIn methodsFor: 'as yet unclassified' stamp: 'sf 10/26/2019 17:44:24'!
printOn: aReport

	aReport add: ('Entrada por transferencia de ', (self value printString)).! !

!TransferenceIn methodsFor: 'as yet unclassified' stamp: 'sf 10/26/2019 18:28:34'!
transferNetValueFor: aNetValue

	^ aNetValue + (self value) .! !


!classDefinition: #TransferenceOut category: #'Portfolio-Solucion'!
AccountTransaction subclass: #TransferenceOut
	instanceVariableNames: 'transference'
	classVariableNames: ''
	poolDictionaries: ''
	category: 'Portfolio-Solucion'!

!TransferenceOut methodsFor: 'value' stamp: 'Santiago Festini 10/24/2019 16:56:11'!
affectBalance: aBalance

	^ aBalance + ((transference value) negated).! !

!TransferenceOut methodsFor: 'value' stamp: 'sf 10/26/2019 16:32:44'!
initializeFor: aTransference

	transference := aTransference .! !

!TransferenceOut methodsFor: 'value' stamp: 'sf 10/26/2019 17:44:49'!
printOn: aReport

	aReport add: ('Salida por transferencia de ', (self value printString)).! !

!TransferenceOut methodsFor: 'value' stamp: 'sf 10/26/2019 18:37:34'!
transferNetValueFor: aNetValue

	^ aNetValue - (self value)! !

!TransferenceOut methodsFor: 'value' stamp: 'sf 10/26/2019 16:51:36'!
transferenceIn

	^ transference transferenceIn.! !

!TransferenceOut methodsFor: 'value' stamp: 'Santiago Festini 10/24/2019 16:54:40'!
value

	^ transference value.! !


!classDefinition: #Withdraw category: #'Portfolio-Solucion'!
AccountTransaction subclass: #Withdraw
	instanceVariableNames: 'value'
	classVariableNames: ''
	poolDictionaries: ''
	category: 'Portfolio-Solucion'!

!Withdraw methodsFor: 'balance' stamp: 'HAW 5/25/2019 11:25:15'!
affectBalance: aBalance

	^aBalance - value! !


!Withdraw methodsFor: 'value' stamp: 'Santiago Festini 10/21/2019 21:04:00'!
value

	^value! !


!Withdraw methodsFor: 'as yet unclassified' stamp: 'Santiago Festini 10/24/2019 15:18:32'!
initializeFor: aValue

	value := aValue ! !

!Withdraw methodsFor: 'as yet unclassified' stamp: 'sf 10/26/2019 17:43:58'!
printOn: aReport

	aReport add: ('Extraccion por ', (self value printString)).! !

!Withdraw methodsFor: 'as yet unclassified' stamp: 'sf 10/26/2019 18:17:16'!
transferNetValueFor: aNetValue.

	^ aNetValue .! !


!classDefinition: #SummaryReport category: #'Portfolio-Solucion'!
Object subclass: #SummaryReport
	instanceVariableNames: 'account'
	classVariableNames: ''
	poolDictionaries: ''
	category: 'Portfolio-Solucion'!

!SummaryReport methodsFor: 'as yet unclassified' stamp: 'sf 10/26/2019 17:33:09'!
accountOperations

	| accountOperations transactions |
	
	transactions := account transactions .
	accountOperations := OrderedCollection new.
	
	transactions do: [ :aTransaction | aTransaction printOn: accountOperations ].

	accountOperations add: ('Balance = ', (account balance printString)).
	
	^ accountOperations.! !

!SummaryReport methodsFor: 'as yet unclassified' stamp: 'sf 10/26/2019 17:04:21'!
initializeFor: anAccount

	account := anAccount .! !

"-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- "!

!classDefinition: 'SummaryReport class' category: #'Portfolio-Solucion'!
SummaryReport class
	instanceVariableNames: ''!

!SummaryReport class methodsFor: 'as yet unclassified' stamp: 'sf 10/26/2019 17:03:53'!
for: anAccount

	^ self new initializeFor: anAccount.! !


!classDefinition: #TransferNet category: #'Portfolio-Solucion'!
Object subclass: #TransferNet
	instanceVariableNames: 'account'
	classVariableNames: ''
	poolDictionaries: ''
	category: 'Portfolio-Solucion'!

!TransferNet methodsFor: 'as yet unclassified' stamp: 'sf 10/26/2019 18:01:37'!
initializeFor:anAccount

	account := anAccount.! !

!TransferNet methodsFor: 'as yet unclassified' stamp: 'sf 10/26/2019 18:32:49'!
value

	| transactions |
	
	transactions := account transactions .
	
	^transactions 
		inject: 0
		into: [:netValue :aTransaction | aTransaction transferNetValueFor: netValue.].
	! !

"-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- "!

!classDefinition: 'TransferNet class' category: #'Portfolio-Solucion'!
TransferNet class
	instanceVariableNames: ''!

!TransferNet class methodsFor: 'as yet unclassified' stamp: 'sf 10/26/2019 18:01:13'!
for: anAccount

	^ self new initializeFor: anAccount .! !


!classDefinition: #Transference category: #'Portfolio-Solucion'!
Object subclass: #Transference
	instanceVariableNames: 'value transferenceOut transferenceIn'
	classVariableNames: ''
	poolDictionaries: ''
	category: 'Portfolio-Solucion'!

!Transference methodsFor: 'as yet unclassified' stamp: 'sf 10/26/2019 16:50:40'!
initializeWith: anAmountOfMoney from: aSenderAccount to: aReceiverAccount

	| transferIn transferOut |
	value := anAmountOfMoney .
	
	transferOut := TransferenceOut for: self.
	transferIn := TransferenceIn for: self.
		
	aSenderAccount register: (transferOut).
	aReceiverAccount register: (transferIn).
	
	transferenceOut := transferOut.
	transferenceIn := transferIn.
	
	! !

!Transference methodsFor: 'as yet unclassified' stamp: 'sf 10/26/2019 16:49:57'!
transferenceIn

	^ transferenceIn.! !

!Transference methodsFor: 'as yet unclassified' stamp: 'sf 10/26/2019 16:49:44'!
transferenceOut

	^ transferenceOut.! !

!Transference methodsFor: 'as yet unclassified' stamp: 'Santiago Festini 10/24/2019 16:58:12'!
value
	
	^ value.! !

"-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- "!

!classDefinition: 'Transference class' category: #'Portfolio-Solucion'!
Transference class
	instanceVariableNames: ''!

!Transference class methodsFor: 'as yet unclassified' stamp: 'Santiago Festini 10/24/2019 17:02:40'!
cantTransferThatAmount

	^'You can not transfer that amount!!'! !

!Transference class methodsFor: 'as yet unclassified' stamp: 'sf 10/26/2019 16:26:21'!
cantTransferToTheSameAccount

	^'You can not transfer to that account!!'! !

!Transference class methodsFor: 'as yet unclassified' stamp: 'sf 10/26/2019 16:51:05'!
transfer: anAmountOfMoney from: accountSender to: accountReceiver.
	
	anAmountOfMoney isZero ifTrue: [self error: self cantTransferThatAmount ].
	anAmountOfMoney negative ifTrue: [self error: self cantTransferThatAmount ].
	accountSender = accountReceiver ifTrue: [self error: self cantTransferToTheSameAccount ].	
	^ self new initializeWith: anAmountOfMoney from: accountSender to: accountReceiver .
	! !
