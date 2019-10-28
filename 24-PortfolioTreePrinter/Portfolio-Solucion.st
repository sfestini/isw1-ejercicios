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


!classDefinition: #PortfolioTreeReportTest category: #'Portfolio-Solucion'!
TestCase subclass: #PortfolioTreeReportTest
	instanceVariableNames: ''
	classVariableNames: ''
	poolDictionaries: ''
	category: 'Portfolio-Solucion'!

!PortfolioTreeReportTest methodsFor: 'testing' stamp: 'Santiago Festini 10/28/2019 16:55:45'!
test01EmptyPortfolioOnlyShowsThePortfolioName

	| portfolio portfolioTreeReport treeReport |
	
	portfolio := Portfolio named: 'portfolio familiar'.
	portfolioTreeReport := PortfolioTreeReport for: portfolio .
	
	treeReport := OrderedCollection new.
	treeReport add: '''portfolio familiar'''.
	
	self assert: treeReport equals: portfolioTreeReport value.! !

!PortfolioTreeReportTest methodsFor: 'testing' stamp: 'Santiago Festini 10/28/2019 16:55:45'!
test02PortfolioWithOneAccountOnlyShowsThePortfolioNameAndTheAccountName

	| portfolio portfolioTreeReport account treeReport |
	
	account := ReceptiveAccount named: 'Cuenta Mia'.
	
	portfolio := Portfolio named: 'portfolio familiar' for: account .
	
	portfolioTreeReport := PortfolioTreeReport for: portfolio .
	
	treeReport:= OrderedCollection new .
	treeReport add: '''portfolio familiar'''. 
	treeReport add: '	''Cuenta Mia'''.
	
	self assert: treeReport equals: portfolioTreeReport value.! !

!PortfolioTreeReportTest methodsFor: 'testing' stamp: 'Santiago Festini 10/28/2019 16:55:45'!
test03PortfolioWithManyAccountsOnlyShowsThePortfolioNameAndTheAccountsNames

	| portfolio portfolioTreeReport account1 account2 treeReport |
	
	account1 := ReceptiveAccount named: 'Cuenta Mia'.
	account2 := ReceptiveAccount named: 'Cuenta Hijo'.
		
	portfolio := Portfolio named: 'portfolio familiar' with: account1 with: account2 .
	
	portfolioTreeReport := PortfolioTreeReport for: portfolio .
	
	treeReport:= OrderedCollection new .
	treeReport add: '''portfolio familiar'''. 
	treeReport add: '	''Cuenta Mia'''.
	treeReport add: '	''Cuenta Hijo'''.
	
	self assert: treeReport equals: portfolioTreeReport value.! !

!PortfolioTreeReportTest methodsFor: 'testing' stamp: 'Santiago Festini 10/28/2019 16:55:45'!
test04PortfolioWithEmptyPortfolioShowsTheNameOfThePortfolios

	| mainPortfolio portfolioTreeReport portfolio treeReport |
	
	portfolio := Portfolio named: 'Portfolio hijos'.
		
	mainPortfolio := Portfolio named: 'Portfolio familiar' for: portfolio .
	
	portfolioTreeReport := PortfolioTreeReport for: mainPortfolio .
	
	treeReport:= OrderedCollection new .
	treeReport add: '''Portfolio familiar'''. 
	treeReport add: '	''Portfolio hijos'''.
	
	self assert: treeReport equals: portfolioTreeReport value.! !

!PortfolioTreeReportTest methodsFor: 'testing' stamp: 'Santiago Festini 10/28/2019 16:55:45'!
test05PortfolioWithNotEmptyPortfolioShowsTheNameOfThePortfoliosAndAccountsHierarchy

	| mainPortfolio portfolioTreeReport portfolio treeReport  account|
	
	account := ReceptiveAccount named: 'Cuenta Juan'.
	
	portfolio := Portfolio named: 'Portfolio hijos' for: account .
		
	mainPortfolio := Portfolio named: 'Portfolio familiar' for: portfolio .
	
	portfolioTreeReport := PortfolioTreeReport for: mainPortfolio .
	
	treeReport:= OrderedCollection new .
	treeReport add: '''Portfolio familiar'''. 
	treeReport add: '	''Portfolio hijos'''.
	treeReport add: '		''Cuenta Juan'''.
		
	self assert: treeReport equals: portfolioTreeReport value.! !


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


!classDefinition: #SummaryReportTest category: #'Portfolio-Solucion'!
TestCase subclass: #SummaryReportTest
	instanceVariableNames: ''
	classVariableNames: ''
	poolDictionaries: ''
	category: 'Portfolio-Solucion'!

!SummaryReportTest methodsFor: 'testing' stamp: 'Santiago Festini 10/28/2019 16:55:59'!
test01SummaryReportOfEmptyAccountPrintsOnlyBalanceAsZero

	| account report accountOperations |
	
	account := ReceptiveAccount new.
	report := SummaryReport for: account .
	
	accountOperations := OrderedCollection new.
	
	accountOperations add: 'Balance = 0'.
	
	self assert: report value equals: accountOperations.
	
	
	! !

!SummaryReportTest methodsFor: 'testing' stamp: 'Santiago Festini 10/28/2019 16:55:59'!
test02SummaryReportOfAccountWithDepositPrintsDeposit

	| account report accountOperations |
	
	account := ReceptiveAccount new.
	report := SummaryReport for: account .
	Deposit register: 100 on: account .
	
	accountOperations := OrderedCollection new.
	accountOperations add: 'Deposito por 100'.
	accountOperations add: 'Balance = 100'.
	
	self assert: report value equals: accountOperations.
	
	
	! !

!SummaryReportTest methodsFor: 'testing' stamp: 'Santiago Festini 10/28/2019 16:55:59'!
test03SummaryReportOfAccountWithWithdrawPrintsWithdraw

	| account report accountOperations |
	
	account := ReceptiveAccount new.
	report := SummaryReport for: account .
	Withdraw register: 100 on: account .
	
	accountOperations := OrderedCollection new.
	accountOperations add: 'Extraccion por 100'.
	accountOperations add: 'Balance = -100'.
	
	self assert: report value equals: accountOperations.
	
	
	! !

!SummaryReportTest methodsFor: 'testing' stamp: 'Santiago Festini 10/28/2019 16:55:59'!
test04SummaryReportOfAccountWithTransferenceInPrintsTransferenceIn

	| report accountOperations accountReceiver accountSender |
	
	accountSender := ReceptiveAccount new.
	accountReceiver := ReceptiveAccount new.
	report := SummaryReport for: accountReceiver .
	Transference transfer: 50 from: accountSender to: accountReceiver.
	
	accountOperations := OrderedCollection new.
	accountOperations add: 'Entrada por transferencia de 50'.
	accountOperations add: 'Balance = 50'.
	
	self assert: report value equals: accountOperations.
	
	
	! !

!SummaryReportTest methodsFor: 'testing' stamp: 'Santiago Festini 10/28/2019 16:55:59'!
test05SummaryReportOfAccountWithTransferenceOutPrintsTransferenceOut

	| report accountOperations accountReceiver accountSender |
	
	accountSender := ReceptiveAccount new.
	accountReceiver := ReceptiveAccount new.
	report := SummaryReport for: accountSender .
	Transference transfer: 50 from: accountSender to: accountReceiver.
	
	accountOperations := OrderedCollection new.
	accountOperations add: 'Salida por transferencia de 50'.
	accountOperations add: 'Balance = -50'.
	
	self assert: report value equals: accountOperations.
	
	
	! !

!SummaryReportTest methodsFor: 'testing' stamp: 'Santiago Festini 10/28/2019 16:55:59'!
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
	
	self assert: report value equals: accountOperations.
	
	
	! !


!classDefinition: #TransferNetTest category: #'Portfolio-Solucion'!
TestCase subclass: #TransferNetTest
	instanceVariableNames: ''
	classVariableNames: ''
	poolDictionaries: ''
	category: 'Portfolio-Solucion'!

!TransferNetTest methodsFor: 'testing' stamp: 'sf 10/27/2019 18:17:08'!
test01TransferNetForAnAccountWithoutTransactionsIsZero

	| account transferNet |
	
	account := ReceptiveAccount new.
	transferNet := TransferNetReport for: account.
	
	self assert: 0 equals: (transferNet value).! !

!TransferNetTest methodsFor: 'testing' stamp: 'sf 10/27/2019 18:17:08'!
test02TransferNetForAnAccountWithOnlyATransferenceInIsTheTransferenceValue

	| receiverAccount senderAccount transferNet |
	
	receiverAccount := ReceptiveAccount new.
	senderAccount := ReceptiveAccount new.
	transferNet := TransferNetReport for: receiverAccount .

	Transference transfer: 50 from: senderAccount to: receiverAccount .
	
	self assert: 50 equals: (transferNet value).! !

!TransferNetTest methodsFor: 'testing' stamp: 'sf 10/27/2019 18:17:08'!
test03TransferNetForAnAccountDoesNotTakeIntoAccountDeposits

	| account transferNet |
	
	account := ReceptiveAccount new.
	transferNet := TransferNetReport for: account.

	Deposit register: 100 on: account .
	
	self assert: 0 equals: (transferNet value).! !

!TransferNetTest methodsFor: 'testing' stamp: 'sf 10/27/2019 18:17:08'!
test04TransferNetForAnAccountDoesNotTakeIntoAccountWithdraws

	| account transferNet |
	
	account := ReceptiveAccount new.
	transferNet := TransferNetReport for: account.

	Withdraw register: 100 on: account .
	
	self assert: 0 equals: (transferNet value).! !

!TransferNetTest methodsFor: 'testing' stamp: 'sf 10/27/2019 18:17:08'!
test05TransferNetForAnAccountWithOnlyATransferenceOutIsTheTransferenceValue

	| receiverAccount senderAccount transferNet |
	
	receiverAccount := ReceptiveAccount new.
	senderAccount := ReceptiveAccount new.
	transferNet := TransferNetReport for: senderAccount.

	Transference transfer: 50 from: senderAccount to: receiverAccount .
	
	self assert: -50 equals: (transferNet value).! !

!TransferNetTest methodsFor: 'testing' stamp: 'sf 10/27/2019 18:17:08'!
test06TransferNetForAnAccountWithManyTransactionsOnlyConsidersTheTransferences

	| transferNetAccount otherAccount transferNet |
	
	transferNetAccount := ReceptiveAccount new.
	otherAccount := ReceptiveAccount new.
	transferNet := TransferNetReport for: transferNetAccount .

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
	instanceVariableNames: 'name'
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


!Account methodsFor: 'initialization' stamp: 'sf 10/27/2019 18:12:44'!
named: aName

	name := aName .! !


!Account methodsFor: 'transactions' stamp: 'HAW 5/25/2019 12:23:27'!
addTransactionsTo: aCollectionOfTransactions

	self subclassResponsibility ! !

!Account methodsFor: 'transactions' stamp: 'HAW 5/25/2019 12:23:15'!
transactions

	self subclassResponsibility ! !

!Account methodsFor: 'transactions' stamp: 'sf 10/27/2019 16:38:50'!
transactionsDo: aClosure

	^ self transactions do: aClosure.! !


!Account methodsFor: 'composition' stamp: 'HAW 5/25/2019 12:24:04'!
addedTo: aPortfolio

	self subclassResponsibility ! !


!Account methodsFor: 'accessing' stamp: 'sf 10/27/2019 18:33:40'!
name

	^ name! !


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


!Portfolio methodsFor: 'report' stamp: 'Santiago Festini 10/28/2019 15:58:37'!
reportOn: aContainer for: aReport

	^ aReport evaluatePortfolio: self to: aContainer .! !


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


!Portfolio methodsFor: 'account' stamp: 'Santiago Festini 10/28/2019 15:28:08'!
accountsDo: aClosure

	^ accounts do: aClosure.! !

"-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- "!

!classDefinition: 'Portfolio class' category: #'Portfolio-Solucion'!
Portfolio class
	instanceVariableNames: ''!

!Portfolio class methodsFor: 'as yet unclassified' stamp: 'HAW 5/25/2019 11:48:55'!
canNotAddAccountErrorMessage
	
	^'Can not add repeated account to a portfolio'! !

!Portfolio class methodsFor: 'as yet unclassified' stamp: 'sf 10/27/2019 18:09:47'!
for: anAccount

	^self new 
		named: 'Unnamed Portfolio';
		add: anAccount;
		yourself! !

!Portfolio class methodsFor: 'as yet unclassified' stamp: 'Santiago Festini 10/28/2019 15:11:08'!
named: aName

	^self new 
		named: aName;
		yourself! !

!Portfolio class methodsFor: 'as yet unclassified' stamp: 'Santiago Festini 10/28/2019 15:11:47'!
named: aName for: anAccount

	^self new 
		named: aName;
		add: anAccount;
		yourself! !

!Portfolio class methodsFor: 'as yet unclassified' stamp: 'sf 10/27/2019 18:08:42'!
named: aName with: anAccount with: anotherAccount

	^self new 
		named: aName;
		add: anAccount;
		add: anotherAccount;
		yourself! !

!Portfolio class methodsFor: 'as yet unclassified' stamp: 'sf 10/27/2019 18:09:20'!
with: anAccount with: anotherAccount

	^self new 
		named: 'Unnamed Portfolio';
		add: anAccount;
		add: anotherAccount;
		yourself! !


!classDefinition: #ReceptiveAccount category: #'Portfolio-Solucion'!
Account subclass: #ReceptiveAccount
	instanceVariableNames: 'transactions'
	classVariableNames: ''
	poolDictionaries: ''
	category: 'Portfolio-Solucion'!

!ReceptiveAccount methodsFor: 'initialization' stamp: 'sf 10/27/2019 18:23:39'!
initialize

	super initialize.
	
	name := 'Unnamed Account'.
	transactions := OrderedCollection new.! !

!ReceptiveAccount methodsFor: 'initialization' stamp: 'sf 10/27/2019 18:22:42'!
initializeWith: aName

	super initialize.
	
	name := aName .
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


!ReceptiveAccount methodsFor: 'report' stamp: 'Santiago Festini 10/28/2019 15:58:37'!
reportOn: aContainer for: aReport

	^ aReport evaluateReceptiveAccount: self to: aContainer.! !

"-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- "!

!classDefinition: 'ReceptiveAccount class' category: #'Portfolio-Solucion'!
ReceptiveAccount class
	instanceVariableNames: ''!

!ReceptiveAccount class methodsFor: 'as yet unclassified' stamp: 'sf 10/27/2019 18:21:49'!
named: aName

	^ self new initializeWith: aName .
! !


!classDefinition: #AccountTransaction category: #'Portfolio-Solucion'!
Object subclass: #AccountTransaction
	instanceVariableNames: ''
	classVariableNames: ''
	poolDictionaries: ''
	category: 'Portfolio-Solucion'!

!AccountTransaction methodsFor: 'initialization' stamp: 'Santiago Festini 10/24/2019 15:18:17'!
initializeFor: aValue

	^ self subclassResponsibility .! !


!AccountTransaction methodsFor: 'report' stamp: 'sf 10/27/2019 16:40:08'!
reportOn: aContainer for: aReport

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


!Deposit methodsFor: 'initialization' stamp: 'Santiago Festini 10/24/2019 15:18:26'!
initializeFor: aValue

	value := aValue ! !


!Deposit methodsFor: 'report' stamp: 'sf 10/27/2019 16:41:06'!
reportOn: aContainer for: aReport

	^ aReport evaluateDeposit: self on: aContainer .! !


!classDefinition: #TransferenceIn category: #'Portfolio-Solucion'!
AccountTransaction subclass: #TransferenceIn
	instanceVariableNames: 'transference'
	classVariableNames: ''
	poolDictionaries: ''
	category: 'Portfolio-Solucion'!

!TransferenceIn methodsFor: 'accessing' stamp: 'sf 10/26/2019 16:49:22'!
transferenceOut

	^ transference transferenceOut.! !


!TransferenceIn methodsFor: 'report' stamp: 'sf 10/27/2019 16:41:38'!
reportOn: aContainer for: aReport

	^ aReport evaluateTransferenceIn: self on: aContainer .! !


!TransferenceIn methodsFor: 'balance' stamp: 'Santiago Festini 10/24/2019 16:56:34'!
affectBalance: aBalance

	^ aBalance + (transference value).! !


!TransferenceIn methodsFor: 'value' stamp: 'Santiago Festini 10/24/2019 15:15:50'!
value

	^ transference value.! !


!TransferenceIn methodsFor: 'initialization' stamp: 'sf 10/26/2019 16:32:44'!
initializeFor: aTransference

	transference := aTransference .

	! !


!classDefinition: #TransferenceOut category: #'Portfolio-Solucion'!
AccountTransaction subclass: #TransferenceOut
	instanceVariableNames: 'transference'
	classVariableNames: ''
	poolDictionaries: ''
	category: 'Portfolio-Solucion'!

!TransferenceOut methodsFor: 'initialization' stamp: 'sf 10/26/2019 16:32:44'!
initializeFor: aTransference

	transference := aTransference .! !


!TransferenceOut methodsFor: 'accessing' stamp: 'sf 10/26/2019 16:51:36'!
transferenceIn

	^ transference transferenceIn.! !


!TransferenceOut methodsFor: 'value' stamp: 'Santiago Festini 10/24/2019 16:54:40'!
value

	^ transference value.! !


!TransferenceOut methodsFor: 'balance' stamp: 'Santiago Festini 10/24/2019 16:56:11'!
affectBalance: aBalance

	^ aBalance + ((transference value) negated).! !


!TransferenceOut methodsFor: 'report' stamp: 'sf 10/27/2019 16:41:50'!
reportOn: aContainer for: aReport

	^ aReport evaluateTransferenceOut: self on: aContainer .! !


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


!Withdraw methodsFor: 'initialization' stamp: 'Santiago Festini 10/24/2019 15:18:32'!
initializeFor: aValue

	value := aValue ! !


!Withdraw methodsFor: 'report' stamp: 'sf 10/27/2019 16:42:10'!
reportOn: aContainer for: aReport

	^ aReport evaluateWithdraw: self on: aContainer .! !


!classDefinition: #BankReport category: #'Portfolio-Solucion'!
Object subclass: #BankReport
	instanceVariableNames: 'account'
	classVariableNames: ''
	poolDictionaries: ''
	category: 'Portfolio-Solucion'!

!BankReport methodsFor: 'initialization' stamp: 'sf 10/27/2019 17:31:43'!
initializeFor: anAccount

	account := anAccount .! !


!BankReport methodsFor: 'transactions reporting' stamp: 'sf 10/27/2019 17:35:12'!
evaluateDeposit: aDeposit on: aContainer

	^ self subclassResponsibility .! !

!BankReport methodsFor: 'transactions reporting' stamp: 'sf 10/27/2019 17:35:37'!
evaluateTransferenceIn: aTransferenceIn on: aContainer

	^ self subclassResponsibility .! !

!BankReport methodsFor: 'transactions reporting' stamp: 'sf 10/27/2019 17:35:49'!
evaluateTransferenceOut: aTransferenceOut on: aContainer

	^ self subclassResponsibility .! !

!BankReport methodsFor: 'transactions reporting' stamp: 'sf 10/27/2019 17:35:24'!
evaluateWithdraw: aWithdraw on: aContainer

	^ self subclassResponsibility .! !

"-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- "!

!classDefinition: 'BankReport class' category: #'Portfolio-Solucion'!
BankReport class
	instanceVariableNames: ''!

!BankReport class methodsFor: 'instance creation' stamp: 'sf 10/27/2019 18:28:34'!
for: anAccount

	^ self new initializeFor: anAccount.! !


!classDefinition: #PortfolioTreeReport category: #'Portfolio-Solucion'!
BankReport subclass: #PortfolioTreeReport
	instanceVariableNames: ''
	classVariableNames: ''
	poolDictionaries: ''
	category: 'Portfolio-Solucion'!

!PortfolioTreeReport methodsFor: 'as yet unclassified' stamp: 'Santiago Festini 10/28/2019 16:11:14'!
evaluatePortfolio: aReceptiveAccount to: aContainer

	| myContainer |
	
	aContainer add: (aReceptiveAccount name).
	myContainer := OrderedCollection new.
	aContainer add: myContainer.	
	aReceptiveAccount accountsDo: [:anAccount | anAccount reportOn: myContainer for: self].	
	 
	! !

!PortfolioTreeReport methodsFor: 'as yet unclassified' stamp: 'Santiago Festini 10/28/2019 16:11:43'!
evaluateReceptiveAccount: aReceptiveAccount to: aContainer

	aContainer add: (aReceptiveAccount name).
	 
	! !

!PortfolioTreeReport methodsFor: 'as yet unclassified' stamp: 'Santiago Festini 10/28/2019 16:50:50'!
printAccount: anAccount withDepth: aDepth on: aContainer

	| res |
	
	res := ''.

	aDepth timesRepeat: [res := ('	' , res).].
	
	res := (res , anAccount name).
	
	aContainer add: res.
	

	! !

!PortfolioTreeReport methodsFor: 'as yet unclassified' stamp: 'Santiago Festini 10/28/2019 16:51:47'!
printOrderedCollection: aReport withDepth: aDepth on: aContainer
	
	aReport do:[:anAccount | (anAccount isKindOf: String) ifTrue: [self printAccount: anAccount withDepth: (aDepth) on: aContainer]
							   ifFalse: [self printOrderedCollection: anAccount withDepth: (aDepth +1) on: aContainer]. ].

	

	! !

!PortfolioTreeReport methodsFor: 'as yet unclassified' stamp: 'Santiago Festini 10/28/2019 16:55:45'!
value
	|treeReport myContainer res |
	
	treeReport := OrderedCollection new.
	treeReport add: account name.
	
	myContainer := OrderedCollection new.
	treeReport add: myContainer .
	
	account accountsDo: [:anAccount | anAccount reportOn: myContainer for: self.].
	
	res := OrderedCollection new.
	
	self printOrderedCollection: treeReport withDepth: 0 on: res .
	
	^ res.
	
	
	 
	! !


!classDefinition: #SummaryReport category: #'Portfolio-Solucion'!
BankReport subclass: #SummaryReport
	instanceVariableNames: ''
	classVariableNames: ''
	poolDictionaries: ''
	category: 'Portfolio-Solucion'!

!SummaryReport methodsFor: 'transactions reporting' stamp: 'sf 10/27/2019 16:44:51'!
evaluateDeposit: aDeposit on: aContainer 

	aContainer add: ('Deposito por ', (aDeposit value printString)).! !

!SummaryReport methodsFor: 'transactions reporting' stamp: 'sf 10/27/2019 16:43:45'!
evaluateTransferenceIn: aTransferenceIn on: aContainer 

	aContainer add: ('Entrada por transferencia de ', (aTransferenceIn value printString)).! !

!SummaryReport methodsFor: 'transactions reporting' stamp: 'sf 10/27/2019 16:44:21'!
evaluateTransferenceOut: aTransferenceOut on: aContainer 

	aContainer add: ('Salida por transferencia de ', (aTransferenceOut value printString)).! !

!SummaryReport methodsFor: 'transactions reporting' stamp: 'sf 10/27/2019 16:45:13'!
evaluateWithdraw: aWithdraw on: aContainer 

	aContainer add: ('Extraccion por ', (aWithdraw value printString)).! !


!SummaryReport methodsFor: 'account operations' stamp: 'Santiago Festini 10/28/2019 16:55:59'!
value

	| accountOperations |
	
	accountOperations := OrderedCollection new.
	
	account transactionsDo: [ :aTransaction | aTransaction reportOn: accountOperations for: self].

	accountOperations add: ('Balance = ', (account balance printString)).
	
	^ accountOperations.! !


!classDefinition: #TransferNetReport category: #'Portfolio-Solucion'!
BankReport subclass: #TransferNetReport
	instanceVariableNames: ''
	classVariableNames: ''
	poolDictionaries: ''
	category: 'Portfolio-Solucion'!

!TransferNetReport methodsFor: 'value' stamp: 'sf 10/27/2019 17:29:16'!
value

	| accountTransferences |
	
	accountTransferences := OrderedCollection new.
	
	account transactionsDo: [ :aTransaction | aTransaction reportOn: accountTransferences for: self].
	
	^ accountTransferences sum: [:aTransferenceValue | aTransferenceValue] ifEmpty: [^0].
	! !


!TransferNetReport methodsFor: 'transactions reporting' stamp: 'sf 10/27/2019 16:54:40'!
evaluateDeposit: aDeposit on: aContainer 

	! !

!TransferNetReport methodsFor: 'transactions reporting' stamp: 'sf 10/27/2019 17:02:46'!
evaluateTransferenceIn: aTransferenceIn on: aContainer 

	aContainer add: aTransferenceIn value.

	! !

!TransferNetReport methodsFor: 'transactions reporting' stamp: 'sf 10/27/2019 17:03:01'!
evaluateTransferenceOut: aTransferenceOut on: aContainer 

	aContainer add: aTransferenceOut value negated.

	! !

!TransferNetReport methodsFor: 'transactions reporting' stamp: 'sf 10/27/2019 16:54:51'!
evaluateWithdraw: aWithdraw on: aContainer 

	! !


!classDefinition: #Transference category: #'Portfolio-Solucion'!
Object subclass: #Transference
	instanceVariableNames: 'value transferenceOut transferenceIn'
	classVariableNames: ''
	poolDictionaries: ''
	category: 'Portfolio-Solucion'!

!Transference methodsFor: 'value' stamp: 'Santiago Festini 10/24/2019 16:58:12'!
value
	
	^ value.! !


!Transference methodsFor: 'accessing' stamp: 'sf 10/26/2019 16:49:57'!
transferenceIn

	^ transferenceIn.! !

!Transference methodsFor: 'accessing' stamp: 'sf 10/26/2019 16:49:44'!
transferenceOut

	^ transferenceOut.! !


!Transference methodsFor: 'initialization' stamp: 'sf 10/26/2019 16:50:40'!
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

"-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- "!

!classDefinition: 'Transference class' category: #'Portfolio-Solucion'!
Transference class
	instanceVariableNames: ''!

!Transference class methodsFor: 'error messages' stamp: 'Santiago Festini 10/24/2019 17:02:40'!
cantTransferThatAmount

	^'You can not transfer that amount!!'! !

!Transference class methodsFor: 'error messages' stamp: 'sf 10/26/2019 16:26:21'!
cantTransferToTheSameAccount

	^'You can not transfer to that account!!'! !


!Transference class methodsFor: 'instance creation' stamp: 'sf 10/26/2019 16:51:05'!
transfer: anAmountOfMoney from: accountSender to: accountReceiver.
	
	anAmountOfMoney isZero ifTrue: [self error: self cantTransferThatAmount ].
	anAmountOfMoney negative ifTrue: [self error: self cantTransferThatAmount ].
	accountSender = accountReceiver ifTrue: [self error: self cantTransferToTheSameAccount ].	
	^ self new initializeWith: anAmountOfMoney from: accountSender to: accountReceiver .
	! !
