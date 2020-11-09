!classDefinition: #CantSuspend category: 'CodigoRepetido-Ejercicio'!
Error subclass: #CantSuspend
	instanceVariableNames: ''
	classVariableNames: ''
	poolDictionaries: ''
	category: 'CodigoRepetido-Ejercicio'!


!classDefinition: #NotFound category: 'CodigoRepetido-Ejercicio'!
Error subclass: #NotFound
	instanceVariableNames: ''
	classVariableNames: ''
	poolDictionaries: ''
	category: 'CodigoRepetido-Ejercicio'!


!classDefinition: #CustomerBookTest category: 'CodigoRepetido-Ejercicio'!
TestCase subclass: #CustomerBookTest
	instanceVariableNames: ''
	classVariableNames: ''
	poolDictionaries: ''
	category: 'CodigoRepetido-Ejercicio'!

!CustomerBookTest methodsFor: 'tests' stamp: 'EDP 11/9/2020 17:06:19'!
test01AddingCustomerShouldNotTakeMoreThan50Milliseconds

	| customerBook addCustomerJohnLennon |
	
	customerBook := CustomerBook new.
	
	addCustomerJohnLennon := [customerBook addCustomerNamed: 'John Lennon'.].

	self action: addCustomerJohnLennon  shouldNotTakeMoreThan: 50.! !

!CustomerBookTest methodsFor: 'tests' stamp: 'EDP 11/9/2020 17:03:26'!
test02RemovingCustomerShouldNotTakeMoreThan100Milliseconds

	| customerBook paulMcCartney removeCustomerPaulMcCartney |
	
	paulMcCartney := 'Paul McCartney'.
	
	customerBook := self initCustomerBookForTests: paulMcCartney.
	
	removeCustomerPaulMcCartney := [customerBook removeCustomerNamed: paulMcCartney.].

	self action: removeCustomerPaulMcCartney  shouldNotTakeMoreThan: 100.! !

!CustomerBookTest methodsFor: 'tests' stamp: 'MFR 11/8/2020 19:22:14'!
test03CanNotAddACustomerWithEmptyName 

	| customerBook addACustomerWithEmptyName solutionForErrorWhileAddingCustomer |
			
	customerBook := CustomerBook new.
	
	addACustomerWithEmptyName := [customerBook addCustomerNamed: ''. self fail].
	solutionForErrorWhileAddingCustomer := [ :anError | 
										self assert: anError messageText = CustomerBook customerCanNotBeEmptyErrorMessage.
										self assert: customerBook isEmpty ].
	
	self canNotDo: addACustomerWithEmptyName errorHandling: Error solveErrorWith: solutionForErrorWhileAddingCustomer.! !

!CustomerBookTest methodsFor: 'tests' stamp: 'EDP 11/9/2020 17:08:33'!
test04CanNotRemoveAnInvalidCustomer
	
	| customerBook johnLennon removeAnInvalidCustomer solutionForErrorWhileRemovingCustomer |

	johnLennon := 'John Lennon'.
	customerBook := self initCustomerBookForTests: johnLennon.
	
	removeAnInvalidCustomer := [ customerBook removeCustomerNamed: 'Paul McCartney'. self fail ].
	solutionForErrorWhileRemovingCustomer := [ self assert: customerBook numberOfCustomers = 1.
										  self assert: (customerBook includesCustomerNamed: johnLennon) ].
										
	self canNotDo: removeAnInvalidCustomer errorHandling: NotFound solveErrorWith: solutionForErrorWhileRemovingCustomer.! !

!CustomerBookTest methodsFor: 'tests' stamp: 'EDP 11/9/2020 16:49:00'!
test05SuspendingACustomerShouldNotRemoveItFromCustomerBook

	|customerBook paulMcCartney|
	
	paulMcCartney  := 'Paul McCartney'.
	customerBook := self initCustomerBookForTests: paulMcCartney.
	customerBook suspendCustomerNamed: paulMcCartney.
	self manageSuspendedCustomer: 1 from: customerBook.
	
	self assert: (customerBook includesCustomerNamed: paulMcCartney).
	

	
! !

!CustomerBookTest methodsFor: 'tests' stamp: 'EDP 11/9/2020 16:50:38'!
test06RemovingASuspendedCustomerShouldRemoveItFromCustomerBook

	|customerBook paulMcCartney|
	
	paulMcCartney  := 'Paul McCartney'.
	customerBook := self initCustomerBookForTests: paulMcCartney.
	customerBook suspendCustomerNamed: paulMcCartney.
	
	customerBook removeCustomerNamed: paulMcCartney.
	self manageSuspendedCustomer: 0 from: customerBook.
	self deny: (customerBook includesCustomerNamed: paulMcCartney).

	
! !

!CustomerBookTest methodsFor: 'tests' stamp: 'EDP 11/9/2020 16:52:12'!
test07CanNotSuspendAnInvalidCustomer
	
	|customerBook johnLennon|
	
	johnLennon  := 'John Lennon'.
	customerBook := self initCustomerBookForTests: johnLennon.
	
	self canNotSuspend: 'Ringo Starr' from: customerBook.
! !

!CustomerBookTest methodsFor: 'tests' stamp: 'EDP 11/9/2020 16:52:41'!
test08CanNotSuspendAnAlreadySuspendedCustomer

	|customerBook johnLennon|
	
	johnLennon := 'John Lennon'.
	customerBook := self initCustomerBookForTests: johnLennon.
	customerBook suspendCustomerNamed: johnLennon.
	
	self canNotSuspend: johnLennon from: customerBook.
! !


!CustomerBookTest methodsFor: 'testHelpers' stamp: 'EDP 11/3/2020 15:14:06'!
action: anAction shouldNotTakeMoreThan: timeLimit
	
	| millisecondsBeforeRunning millisecondsAfterRunning |
	
	millisecondsBeforeRunning := Time millisecondClockValue * millisecond.
	anAction.
	millisecondsAfterRunning := Time millisecondClockValue * millisecond.
	
	self assert: (millisecondsAfterRunning-millisecondsBeforeRunning) < (timeLimit * millisecond).! !

!CustomerBookTest methodsFor: 'testHelpers' stamp: 'MFR 11/8/2020 19:17:28'!
canNotDo: anAction errorHandling: anExpectedError solveErrorWith: errorSolution
	anAction on: anExpectedError do: errorSolution.! !

!CustomerBookTest methodsFor: 'testHelpers' stamp: 'EDP 11/9/2020 00:45:24'!
canNotSuspend: customer from: customerBook
	
	[ customerBook suspendCustomerNamed: customer.
	self fail ]
		on: CantSuspend 
		do: [ self assert: customerBook numberOfCustomers = 1.
			self assert: (customerBook includesCustomerNamed: 'John Lennon') ]! !

!CustomerBookTest methodsFor: 'testHelpers' stamp: 'EDP 11/9/2020 16:53:09'!
initCustomerBookForTests: customer

	|customerBook|
	
	customerBook := CustomerBook new.
	customerBook addCustomerNamed: customer.
	^customerBook.! !

!CustomerBookTest methodsFor: 'testHelpers' stamp: 'EDP 11/9/2020 00:14:22'!
manageSuspendedCustomer: customerQuantity from: customerBook
	
	self assert: 0 equals: customerBook numberOfActiveCustomers.
	self assert: customerQuantity equals: customerBook numberOfSuspendedCustomers.
	self assert: customerQuantity equals: customerBook numberOfCustomers.! !


!classDefinition: #CustomerBook category: 'CodigoRepetido-Ejercicio'!
Object subclass: #CustomerBook
	instanceVariableNames: 'suspended active'
	classVariableNames: ''
	poolDictionaries: ''
	category: 'CodigoRepetido-Ejercicio'!

!CustomerBook methodsFor: 'initialization' stamp: 'LL 10/30/2020 12:22:04'!
initialize

	active := OrderedCollection new.
	suspended:= OrderedCollection new.! !


!CustomerBook methodsFor: 'customer management' stamp: 'MFR 11/8/2020 20:49:33'!
addCustomerNamed: aName

	aName isEmpty ifTrue: [ self signalCustomerNameCannotBeEmpty ].
	(self includesCustomerNamed: aName) ifTrue: [ self signalCustomerAlreadyExists ].
	active add: aName ! !

!CustomerBook methodsFor: 'customer management' stamp: 'MFR 11/8/2020 20:46:30'!
removeCustomerNamed: aName 
	| customerRemoved |
	customerRemoved  := self removeCustomerNamed: aName from: active.
	customerRemoved ifNotNil: [^aName].
	customerRemoved := self removeCustomerNamed: aName from: suspended.
	customerRemoved ifNotNil: [^aName].
	^ NotFound signal.! !

!CustomerBook methodsFor: 'customer management' stamp: 'NR 4/3/2019 10:14:26'!
suspendCustomerNamed: aName 
	
	(active includes: aName) ifFalse: [^CantSuspend signal].
	
	active remove: aName.
	
	suspended add: aName
! !


!CustomerBook methodsFor: 'accessing' stamp: 'NR 4/3/2019 10:14:26'!
numberOfActiveCustomers
	
	^active size! !

!CustomerBook methodsFor: 'accessing' stamp: 'MFR 11/8/2020 20:19:40'!
numberOfCustomers
	
	^self numberOfActiveCustomers + self numberOfSuspendedCustomers ! !

!CustomerBook methodsFor: 'accessing' stamp: 'NR 9/19/2018 17:36:09'!
numberOfSuspendedCustomers
	
	^suspended size! !


!CustomerBook methodsFor: 'testing' stamp: 'NR 4/3/2019 10:14:26'!
includesCustomerNamed: aName

	^(active includes: aName) or: [ suspended includes: aName ]! !

!CustomerBook methodsFor: 'testing' stamp: 'NR 4/3/2019 10:14:26'!
isEmpty
	
	^active isEmpty and: [ suspended isEmpty ]! !


!CustomerBook methodsFor: 'signal errors' stamp: 'HernanWilkinson 7/6/2011 17:52'!
signalCustomerAlreadyExists 

	self error: self class customerAlreadyExistsErrorMessage! !

!CustomerBook methodsFor: 'signal errors' stamp: 'HernanWilkinson 7/6/2011 17:51'!
signalCustomerNameCannotBeEmpty 

	self error: self class customerCanNotBeEmptyErrorMessage ! !


!CustomerBook methodsFor: 'customer	BookHelpers' stamp: 'MFR 11/8/2020 20:40:02'!
removeCustomerNamed: aName from: customerBookGroup
	1 to: customerBookGroup size do:
		[ :index | 
			aName = (customerBookGroup at: index)
				ifTrue: [
					customerBookGroup removeAt: index.
					^aName
				]
	].
	^nil.! !

"-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- "!

!classDefinition: 'CustomerBook class' category: 'CodigoRepetido-Ejercicio'!
CustomerBook class
	instanceVariableNames: ''!

!CustomerBook class methodsFor: 'error messages' stamp: 'NR 4/30/2020 09:05:18'!
customerAlreadyExistsErrorMessage

	^'Customer Already Exists'! !

!CustomerBook class methodsFor: 'error messages' stamp: 'NR 4/30/2020 09:05:25'!
customerCanNotBeEmptyErrorMessage

	^'Customer Name Cannot Be Empty'! !
