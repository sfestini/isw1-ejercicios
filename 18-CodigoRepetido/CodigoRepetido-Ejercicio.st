!classDefinition: #CantSuspend category: #'CodigoRepetido-Ejercicio'!
Error subclass: #CantSuspend
	instanceVariableNames: ''
	classVariableNames: ''
	poolDictionaries: ''
	category: 'CodigoRepetido-Ejercicio'!


!classDefinition: #NotFound category: #'CodigoRepetido-Ejercicio'!
Error subclass: #NotFound
	instanceVariableNames: ''
	classVariableNames: ''
	poolDictionaries: ''
	category: 'CodigoRepetido-Ejercicio'!


!classDefinition: #CustomerBookTest category: #'CodigoRepetido-Ejercicio'!
TestCase subclass: #CustomerBookTest
	instanceVariableNames: ''
	classVariableNames: ''
	poolDictionaries: ''
	category: 'CodigoRepetido-Ejercicio'!

!CustomerBookTest methodsFor: 'testing' stamp: 'Santiago Festini 9/9/2019 10:17:32'!
test01AddingCustomerShouldNotTakeMoreThan50Milliseconds

	| customerBook |
	
	customerBook := CustomerBook new.
	
	^ self doing: [customerBook addCustomerNamed: 'John Lennon'.] takesLessThan: 50 inUnit: millisecond.
	
	
! !

!CustomerBookTest methodsFor: 'testing' stamp: 'Santiago Festini 9/9/2019 10:17:42'!
test02RemovingCustomerShouldNotTakeMoreThan100Milliseconds

	| customerBook paulMcCartney |
	
	customerBook := CustomerBook new.
	paulMcCartney := 'Paul McCartney'.
	
	customerBook addCustomerNamed: paulMcCartney.
	
	^ self doing: [customerBook removeCustomerNamed: paulMcCartney .] takesLessThan: 100 inUnit: millisecond.
		  
	
! !

!CustomerBookTest methodsFor: 'testing' stamp: 'Santiago Festini 9/9/2019 10:17:50'!
test03CanNotAddACustomerWithEmptyName 

	| customerBook|
			
	customerBook := CustomerBook new.

	^self tryToDo: [customerBook addCustomerNamed: '']
					ifItFailsCatch: Error
					andAssert: [ :anError | 
			self assert: anError messageText = CustomerBook customerCanNotBeEmptyErrorMessage.
			self assert: customerBook isEmpty]
					
		! !

!CustomerBookTest methodsFor: 'testing' stamp: 'Santiago Festini 9/9/2019 10:17:57'!
test04CanNotRemoveAnInvalidCustomer
	
	| customerBook johnLennon |
			
	customerBook := CustomerBook new.
	johnLennon := 'John Lennon'.
	customerBook addCustomerNamed: johnLennon.
	
	^self tryToDo: [customerBook removeCustomerNamed: 'Paul McCartney'.]
					  ifItFailsCatch: NotFound
					  andAssert: [ :anError | 
			self assert: customerBook numberOfCustomers = 1.
			self assert: (customerBook includesCustomerNamed: johnLennon) ]
	
! !

!CustomerBookTest methodsFor: 'testing' stamp: 'Santiago Festini 9/9/2019 10:18:04'!
test05SuspendingACustomerShouldNotRemoveItFromCustomerBook

	| customerBook paulMcCartney|
	
	customerBook := CustomerBook new.
	paulMcCartney := 'Paul McCartney'.
	
	customerBook addCustomerNamed: paulMcCartney.
	customerBook suspendCustomerNamed: paulMcCartney.
	
	self checkNumberOfActiveCustomers: 0
	andNumberOfSuspendedCustomers: 1 
	andNumberOfTotalCustomers: 1
	inBook: customerBook.
	self assert: (customerBook includesCustomerNamed: paulMcCartney).
	
	

	
! !

!CustomerBookTest methodsFor: 'testing' stamp: 'Santiago Festini 9/9/2019 10:18:12'!
test06RemovingASuspendedCustomerShouldRemoveItFromCustomerBook

	| customerBook paulMcCartney|
	
	customerBook := CustomerBook new.
	paulMcCartney := 'Paul McCartney'.
	
	customerBook addCustomerNamed: paulMcCartney.
	customerBook suspendCustomerNamed: paulMcCartney.
	customerBook removeCustomerNamed: paulMcCartney.
	
	self checkNumberOfActiveCustomers: 0
	andNumberOfSuspendedCustomers: 0
	andNumberOfTotalCustomers: 0
	inBook: customerBook.
	self deny: (customerBook includesCustomerNamed: paulMcCartney).


	
! !

!CustomerBookTest methodsFor: 'testing' stamp: 'Santiago Festini 9/9/2019 10:18:20'!
test07CanNotSuspendAnInvalidCustomer
	
	| customerBook johnLennon |
			
	customerBook := CustomerBook new.
	johnLennon := 'John Lennon'.
	customerBook addCustomerNamed: johnLennon.
	
	^self tryToDo: [customerBook suspendCustomerNamed: 'Paul McCartney'.]
					ifItFailsCatch: CantSuspend 
					andAssert: [ :anError | 
			self assert: customerBook numberOfCustomers = 1.
			self assert: (customerBook includesCustomerNamed: johnLennon) ]
	

! !

!CustomerBookTest methodsFor: 'testing' stamp: 'Santiago Festini 9/9/2019 10:18:27'!
test08CanNotSuspendAnAlreadySuspendedCustomer
	
	| customerBook johnLennon |
			
	customerBook := CustomerBook new.
	johnLennon := 'John Lennon'.
	customerBook addCustomerNamed: johnLennon.
	customerBook suspendCustomerNamed: johnLennon.
	
	^self tryToDo: [customerBook suspendCustomerNamed: johnLennon.]
					ifItFailsCatch: CantSuspend 
					andAssert: [ :anError | 
			self assert: customerBook numberOfCustomers = 1.
			self assert: (customerBook includesCustomerNamed: johnLennon) ]
	
	
! !


!CustomerBookTest methodsFor: 'toolsForTesting' stamp: 'Santiago Festini 9/4/2019 15:56:37'!
checkNumberOfActiveCustomers: activeCustomers andNumberOfSuspendedCustomers: suspendedCustomers andNumberOfTotalCustomers: totalCustomers inBook: aBook
	
	self assert: activeCustomers = aBook numberOfActiveCustomers.
	self assert: suspendedCustomers = aBook numberOfSuspendedCustomers.
	self assert: totalCustomers = aBook numberOfCustomers.! !

!CustomerBookTest methodsFor: 'toolsForTesting' stamp: 'Santiago Festini 9/4/2019 15:51:53'!
doing: aBlock takesLessThan: time inUnit: unit
	|millisecondsBeforeRunning millisecondsAfterRunning|


	millisecondsBeforeRunning := Time millisecondClockValue * unit.
	aBlock value.
	millisecondsAfterRunning := Time millisecondClockValue * unit.
	
	^self assert: (millisecondsAfterRunning-millisecondsBeforeRunning) < (time * unit)! !

!CustomerBookTest methodsFor: 'toolsForTesting' stamp: 'Santiago Festini 9/4/2019 15:52:04'!
tryToDo: aBlock ifItFailsCatch: exception andAssert: assertBlock
	
	^[ aBlock value.
	self fail ]
		on: exception 
		do: [assertBlock].
! !


!classDefinition: #CustomerBook category: #'CodigoRepetido-Ejercicio'!
Object subclass: #CustomerBook
	instanceVariableNames: 'suspended active'
	classVariableNames: ''
	poolDictionaries: ''
	category: 'CodigoRepetido-Ejercicio'!

!CustomerBook methodsFor: 'testing' stamp: 'NR 4/3/2019 10:14:26'!
includesCustomerNamed: aName

	^(active includes: aName) or: [ suspended includes: aName ]! !

!CustomerBook methodsFor: 'testing' stamp: 'NR 4/3/2019 10:14:26'!
isEmpty
	
	^active isEmpty and: [ suspended isEmpty ]! !


!CustomerBook methodsFor: 'initialization' stamp: 'NR 4/3/2019 10:14:26'!
initialize

	super initialize.
	active := OrderedCollection new.
	suspended:= OrderedCollection new.! !


!CustomerBook methodsFor: 'customer management' stamp: 'Santiago Festini 9/3/2019 15:55:10'!
addCustomerNamed: aName

	aName isEmpty ifTrue: [ self signalCustomerNameCannotBeEmpty ].
	(self includesCustomerNamed: aName) ifTrue: [ self signalCustomerAlreadyExists ].
	
	active add: aName ! !

!CustomerBook methodsFor: 'customer management' stamp: 'NR 4/3/2019 10:14:26'!
numberOfActiveCustomers
	
	^active size! !

!CustomerBook methodsFor: 'customer management' stamp: 'Santiago Festini 9/4/2019 15:49:33'!
numberOfCustomers
	
	^self numberOfActiveCustomers + self numberOfSuspendedCustomers.! !

!CustomerBook methodsFor: 'customer management' stamp: 'NR 9/19/2018 17:36:09'!
numberOfSuspendedCustomers
	
	^suspended size! !

!CustomerBook methodsFor: 'customer management' stamp: 'Santiago Festini 9/9/2019 10:16:54'!
removeCustomerNamed: customerName 
	
	 active remove: customerName ifAbsent: [
		suspended remove: customerName ifAbsent:[
			^NotFound signal.]].
	
! !

!CustomerBook methodsFor: 'customer management' stamp: 'HernanWilkinson 7/6/2011 17:52'!
signalCustomerAlreadyExists 

	self error: self class customerAlreadyExistsErrorMessage! !

!CustomerBook methodsFor: 'customer management' stamp: 'HernanWilkinson 7/6/2011 17:51'!
signalCustomerNameCannotBeEmpty 

	self error: self class customerCanNotBeEmptyErrorMessage ! !

!CustomerBook methodsFor: 'customer management' stamp: 'Santiago Festini 9/9/2019 10:17:07'!
suspendCustomerNamed: aName 
	
	
	active remove: aName ifAbsent:[^CantSuspend signal].
	
	suspended add: aName
! !


"-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- "!

!classDefinition: 'CustomerBook class' category: #'CodigoRepetido-Ejercicio'!
CustomerBook class
	instanceVariableNames: ''!

!CustomerBook class methodsFor: 'error messages' stamp: 'NR 9/2/2019 14:41:10'!
customerAlreadyExistsErrorMessage

	^'Customer Already Exists.'! !

!CustomerBook class methodsFor: 'error messages' stamp: 'NR 9/2/2019 14:41:16'!
customerCanNotBeEmptyErrorMessage

	^'Customer Name Cannot Be Empty.'! !
