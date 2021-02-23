!classDefinition: #CartTest category: 'TusLibros'!
TestCase subclass: #CartTest
	instanceVariableNames: 'objectsFactory'
	classVariableNames: ''
	poolDictionaries: ''
	category: 'TusLibros'!

!CartTest methodsFor: 'tests' stamp: 'LL 2/16/2021 19:50:24'!
setUp

	objectsFactory := PublisherTestObjectsFactory new! !

!CartTest methodsFor: 'tests' stamp: 'LL 1/21/2021 20:09:58'!
test01NewCartIsEmpty

	| cart |
	
	cart := self createCart.
	
	self assert: cart isEmpty.! !

!CartTest methodsFor: 'tests' stamp: 'LL 2/16/2021 19:50:24'!
test02CanAddABookToACart

	| cart |
	cart := self createCart.
	
	cart add: objectsFactory bookFromTheEditorial.
	
	self deny: cart isEmpty.! !

!CartTest methodsFor: 'tests' stamp: 'LL 1/21/2021 21:25:18'!
test03CannotAddABookNotInCatalog

	| cart bookNotInCatalog |
	cart := self createCart.
	bookNotInCatalog := 'DEF456'.

	self assert: cart isEmptyAfter: [ cart add: bookNotInCatalog ] raisesErrorWithMessage: Cart bookNotInCatalogErrorMessage.
	! !

!CartTest methodsFor: 'tests' stamp: 'LL 2/16/2021 19:50:24'!
test04CanAddTwoCopiesOfABook

	| cart |
	cart := self createCart.
	
	cart add: objectsFactory bookFromTheEditorial quantity: 2.
	
	self assert: (cart quantityOf: objectsFactory bookFromTheEditorial) equals: 2.! !

!CartTest methodsFor: 'tests' stamp: 'LL 2/16/2021 19:50:24'!
test05CannotAddNonPositiveNumberOfCopiesOfABook

	| cart |
	cart := self createCart.

	self assert: cart isEmptyAfter: [ cart add: objectsFactory bookFromTheEditorial quantity: -1 ] raisesErrorWithMessage: Cart invalidNumberOfCopiesErrorMessage.! !

!CartTest methodsFor: 'tests' stamp: 'LL 2/16/2021 19:50:24'!
test06CartRemembersAddedBooks

	| cart |
	cart := self createCart.
	
	cart add: objectsFactory bookFromTheEditorial quantity: 2.
	cart add: objectsFactory bookFromTheEditorial quantity: 1.
	
	self assert: (cart includes: objectsFactory bookFromTheEditorial).
	self assert: (cart quantityOf: objectsFactory bookFromTheEditorial) equals: 3! !

!CartTest methodsFor: 'tests' stamp: 'LL 1/21/2021 21:26:35'!
test07CannotAddTwoCopiesOfABookNotInCatalog

	| cart bookNotInCatalog |
	cart := self createCart.
	bookNotInCatalog := 'DEF123'.
	
	self assert: cart isEmptyAfter: [ cart add: bookNotInCatalog quantity: 2 ] raisesErrorWithMessage: Cart bookNotInCatalogErrorMessage.! !


!CartTest methodsFor: 'private' stamp: 'LL 1/21/2021 21:24:13'!
assert: cart isEmptyAfter: blockExpectedToFail raisesErrorWithMessage: errorMessage
	
	self should: blockExpectedToFail raise: Error withExceptionDo: [ :anException |
		self assert: anException messageText equals: errorMessage.
		self assert: cart isEmpty.
	]! !

!CartTest methodsFor: 'private' stamp: 'LL 2/16/2021 19:50:24'!
createCart

	^ objectsFactory anEmptyCart! !


!classDefinition: #CashierTest category: 'TusLibros'!
TestCase subclass: #CashierTest
	instanceVariableNames: 'objectsFactory merchantProcessorBehaviour'
	classVariableNames: ''
	poolDictionaries: ''
	category: 'TusLibros'!

!CashierTest methodsFor: 'tests' stamp: 'LL 2/16/2021 19:50:04'!
setUp

	objectsFactory := PublisherTestObjectsFactory new.
	merchantProcessorBehaviour := [ :anAmountToDebit :aCreditCard |  ]! !

!CashierTest methodsFor: 'tests' stamp: 'LL 2/16/2021 19:51:40'!
test01CannotCheckoutAnEmptyCart

	| cart salesBook cashier |
	cart := objectsFactory anEmptyCart.
	salesBook := objectsFactory anEmptySalesBook.
	cashier := Cashier registeringSalesOn: salesBook.
	
	self should: [ self cashier: cashier checkout: cart ]
		raise: Error - MessageNotUnderstood 
		withExceptionDo: [ :anException |
			self assert: anException messageText equals: Cashier cannotCheckoutAnEmptyCart.
			self assert: salesBook isEmpty
		]! !

!CashierTest methodsFor: 'tests' stamp: 'LL 2/16/2021 19:50:05'!
test02TotalIsCalculatedCorrectlyAfterCheckout

	| cart ticket cashier |
	cart := objectsFactory cartWithABook.
	cashier := objectsFactory aCashier.
	
	ticket := self cashier: cashier checkout: cart.
	
	self assert: objectsFactory bookFromTheEditorialPrice equals: ticket value.! !

!CashierTest methodsFor: 'tests' stamp: 'LL 2/16/2021 19:51:50'!
test03CannotCheckoutIfCardIsExpired

	| cart cashier merchantProcessorWasContacted salesBook |
	cart := objectsFactory cartWithABook.
	salesBook := objectsFactory anEmptySalesBook.
	cashier := Cashier registeringSalesOn: salesBook.
	
	merchantProcessorWasContacted := false.
	self merchantProcessorBehaviour: [ :amountToDebit :aCreditCard |  merchantProcessorWasContacted := true ].
	
	self should: [ self cashier: cashier checkout: cart debitingOn: objectsFactory anExpiredCreditCard ]
		raise: Error - MessageNotUnderstood 
		withExceptionDo: [ :anException |
			self assert: anException messageText equals: Cashier cannotCheckoutUsingAnExpiredCard.
			self deny: merchantProcessorWasContacted.
			self assert: salesBook isEmpty.
		]! !

!CashierTest methodsFor: 'tests' stamp: 'LL 2/16/2021 23:04:34'!
test04CheckoutDebitsCreditCardUsingMerchantProcessor

	| cart ticket cashier debitedAmountFromCreditCard debitedCreditCard creditCard |
	cart := objectsFactory cartWithABook.
	cashier := objectsFactory aCashier.
	creditCard := objectsFactory aValidCreditCard.
		
	self merchantProcessorBehaviour: [ :anAmountToDebit :aCreditCard | 
		debitedAmountFromCreditCard := anAmountToDebit.
		debitedCreditCard := aCreditCard.
	].
	
	ticket := self cashier: cashier checkout: cart debitingOn: creditCard.
	
	self assert: debitedAmountFromCreditCard equals: ticket value.
	self assert: debitedCreditCard equals: creditCard.! !

!CashierTest methodsFor: 'tests' stamp: 'LL 2/16/2021 19:51:58'!
test05CheckoutFailsIfMerchantProcessorCantProcessPayment

	| cart cashier salesBook |
	cart := objectsFactory cartWithABook.
	salesBook := objectsFactory anEmptySalesBook.
	cashier := Cashier registeringSalesOn: salesBook.
	
	self merchantProcessorBehaviour: [ :anAmountToDebit :aCreditCard | Error new signal ].
	
	self should: [ self cashier: cashier checkout: cart ]
		raise: Error - MessageNotUnderstood 
		withExceptionDo: [ :exceptionRaised | 
			self assert: exceptionRaised messageText equals: Cashier couldNotProcessPaymentErrorMessage.
			self assert: salesBook isEmpty.
		]! !

!CashierTest methodsFor: 'tests' stamp: 'LL 2/16/2021 19:52:03'!
test06CheckingOutACartRegistersASale

	| cart cashier ticket salesBook |
	cart := objectsFactory cartWithABook.
	salesBook := objectsFactory anEmptySalesBook.
	cashier := Cashier registeringSalesOn: salesBook.	
	
	ticket := self cashier: cashier checkout: cart.
	
	self assert: salesBook size equals: 1.
	self assert: salesBook first equals: ticket.! !


!CashierTest methodsFor: 'merchat processor protocol' stamp: 'LL 1/24/2021 18:26:00'!
debit: anAmountToDebit from: aCreditCard

	^merchantProcessorBehaviour value: anAmountToDebit value: aCreditCard! !


!CashierTest methodsFor: 'change mp behaviour' stamp: 'LL 1/24/2021 18:26:00'!
merchantProcessorBehaviour: newBehaviour

	merchantProcessorBehaviour := newBehaviour! !


!CashierTest methodsFor: 'private' stamp: 'LL 2/16/2021 19:50:05'!
cashier: cashier checkout: cart

	^self cashier: cashier checkout: cart debitingOn: objectsFactory aValidCreditCard! !

!CashierTest methodsFor: 'private' stamp: 'LL 2/16/2021 19:50:04'!
cashier: cashier checkout: cart debitingOn: aCreditCard

	^cashier checkout: cart payingWith: aCreditCard through: self merchantProcessorForTest on: objectsFactory now.! !

!CashierTest methodsFor: 'private' stamp: 'LL 2/16/2021 18:29:57'!
merchantProcessorForTest
	
	^self! !


!classDefinition: #CreditCardTest category: 'TusLibros'!
TestCase subclass: #CreditCardTest
	instanceVariableNames: ''
	classVariableNames: ''
	poolDictionaries: ''
	category: 'TusLibros'!

!CreditCardTest methodsFor: 'tests' stamp: 'LL 1/24/2021 18:15:23'!
test01CreditCardOwnerNameCannotBeBlank

	^self should: [ CreditCard of: '' number: 11111111 expiringOn: (FixedGregorianDate today) monthOfYear ] 
		raise: Error - MessageNotUnderstood 
		withExceptionDo: [ :exceptionRaised | 
			self assert: exceptionRaised messageText equals: CreditCard nameCannotBeBlankErrorMessage.
		]! !


!classDefinition: #TusLibrosSalesSystemTest category: 'TusLibros'!
TestCase subclass: #TusLibrosSalesSystemTest
	instanceVariableNames: ''
	classVariableNames: ''
	poolDictionaries: ''
	category: 'TusLibros'!

!TusLibrosSalesSystemTest methodsFor: 'private' stamp: 'MFR 2/22/2021 20:57:20'!
aGroupOfUsers
	
	| users |
	
	users := Dictionary new.
	
	users at: 'John Lennon' put: '1234'.
	users at: 'Guido Kaczka' put: '1234'.
	users at: 'Leonardo Pisculichi' put: '1234'.
	
	^ users.! !

!TusLibrosSalesSystemTest methodsFor: 'private' stamp: 'MFR 2/22/2021 20:43:23'!
assert: aBlockExpectedToFail raisesError: excpectedErrorMessage

	self should: aBlockExpectedToFail 
	raise: Error - MessageNotUnderstood 
	withExceptionDo: [:anError |
		self assert: excpectedErrorMessage equals: anError messageText.
	].! !


!TusLibrosSalesSystemTest methodsFor: 'as yet unclassified' stamp: 'MFR 2/22/2021 21:07:02'!
test01CannotCreateCartWithInvalidId

	| salesSystem invalidId password |
	
	salesSystem := TusLibrosSalesSystem withUsers: (self aGroupOfUsers).
	
	invalidId := '1234'.
	password  := '4321'.
	
	self assert: [ salesSystem createCartFor: invalidId withPassword: password. ] raisesError: salesSystem invalidCredentialsErrorDescription.! !

!TusLibrosSalesSystemTest methodsFor: 'as yet unclassified' stamp: 'MFR 2/22/2021 21:18:04'!
test02NewlyCreatedCartIsEmpty

	| salesSystem validId password |
	
	salesSystem := TusLibrosSalesSystem withUsers: (self aGroupOfUsers).
	
	validId := 'John Lennon'.
	password  := '1234'.
	
	salesSystem createCartFor: validId withPassword: password.
	
	self assert: (salesSystem listCart: 1) isEmpty.! !

!TusLibrosSalesSystemTest methodsFor: 'as yet unclassified' stamp: 'MFR 2/23/2021 15:21:39'!
test03CanAddToCartOneBook

	| salesSystem validId password objectsFactory listedCart |
	
	salesSystem := TusLibrosSalesSystem withUsers: (self aGroupOfUsers).
	
	objectsFactory := PublisherTestObjectsFactory new.
	
	validId := 'John Lennon'.
	password  := '1234'.
	
	salesSystem createCartFor: validId withPassword: password.
	
	salesSystem addToCart: 1 book: objectsFactory bookFromTheEditorial quantity: 1.
	
	listedCart := salesSystem listCart: 1.
	
	self assert: listedCart includes: objectsFactory bookFromTheEditorial.
	self assert: (listedCart occurrencesOf: objectsFactory bookFromTheEditorial) equals: 1.! !

!TusLibrosSalesSystemTest methodsFor: 'as yet unclassified' stamp: 'MFR 2/23/2021 15:33:34'!
test04CannotAddToAnInvalidCart

	| salesSystem objectsFactory |
	
	salesSystem := TusLibrosSalesSystem withUsers: (self aGroupOfUsers).
	
	objectsFactory := PublisherTestObjectsFactory new.

	self assert: [ salesSystem addToCart: 1 book: objectsFactory bookFromTheEditorial quantity: 1. ] raisesError: salesSystem invalidCartErrorDescription.! !

!TusLibrosSalesSystemTest methodsFor: 'as yet unclassified' stamp: 'MFR 2/23/2021 15:33:26'!
test05CannotListAnInvalidCart

	| salesSystem |
	
	salesSystem := TusLibrosSalesSystem withUsers: (self aGroupOfUsers).

	self assert: [ salesSystem listCart: 1.] raisesError: salesSystem invalidCartErrorDescription.! !

!TusLibrosSalesSystemTest methodsFor: 'as yet unclassified' stamp: 'MFR 2/23/2021 18:27:31'!
test06CanCheckOutAValidCartWithOneBook
	
	| salesSystem validId password objectsFactory expirationDate listOfPurchases |
	
	salesSystem := TusLibrosSalesSystem withUsers: (self aGroupOfUsers).
	objectsFactory := PublisherTestObjectsFactory new.
	listOfPurchases := OrderedCollection with: 100 * peso with: 'ABC123 1'.
	
	validId := 'Guido Kaczka'.
	password  := '1234'.
	
	salesSystem createCartFor: validId withPassword: password.
	salesSystem addToCart: 1 book: objectsFactory bookFromTheEditorial quantity: 1.
	expirationDate := (FixedGregorianDate today next: GregorianMonth oneMonth) monthOfYear.
	
	salesSystem checkOutCart: 1 creditCardNumber: 11111111 creditCardExpirationDate: expirationDate creditCardOwner: validId.
	
	self assert: (salesSystem listPurchasesOf: validId withPassword: password) equals: listOfPurchases.! !

!TusLibrosSalesSystemTest methodsFor: 'as yet unclassified' stamp: 'MFR 2/23/2021 18:27:40'!
test07CanCheckOutAValidCartWithTwoBooks
	
	| salesSystem validId password objectsFactory expirationDate listOfPurchases |
	
	salesSystem := TusLibrosSalesSystem withUsers: (self aGroupOfUsers).
	objectsFactory := PublisherTestObjectsFactory new.
	listOfPurchases := OrderedCollection with: 200 * peso with: 'ABC123 2'.
	
	validId := 'Guido Kaczka'.
	password  := '1234'.
	
	salesSystem createCartFor: validId withPassword: password.
	salesSystem addToCart: 1 book: objectsFactory bookFromTheEditorial quantity: 2.
	expirationDate := (FixedGregorianDate today next: GregorianMonth oneMonth) monthOfYear.
	
	salesSystem checkOutCart: 1 creditCardNumber: 11111111 creditCardExpirationDate: expirationDate creditCardOwner: validId.
	
	self assert: (salesSystem listPurchasesOf: validId withPassword: password) equals: listOfPurchases.! !


!classDefinition: #Cart category: 'TusLibros'!
Object subclass: #Cart
	instanceVariableNames: 'books bookCatalog'
	classVariableNames: ''
	poolDictionaries: ''
	category: 'TusLibros'!

!Cart methodsFor: 'initialization' stamp: 'LL 1/25/2021 18:50:24'!
initializeWithCatalog: aBookCatalog
	
	bookCatalog := aBookCatalog.
	books := Bag new.! !


!Cart methodsFor: 'adding' stamp: 'LL 1/21/2021 20:24:07'!
add: aBook
	
	self add: aBook quantity: 1.! !

!Cart methodsFor: 'adding' stamp: 'LL 1/21/2021 20:23:42'!
add: aBook quantity: numberOfBooksToAdd

	self assertIsInCatalog: aBook.
	self assertValidNumberOfCopies: numberOfBooksToAdd.
	
	books add: aBook withOccurrences: numberOfBooksToAdd.! !


!Cart methodsFor: 'accessing' stamp: 'MFR 2/23/2021 15:08:09'!
contents
	
	^ books copy.! !

!Cart methodsFor: 'accessing' stamp: 'LL 1/20/2021 21:51:06'!
quantityOf: aBook
	
	^books occurrencesOf: aBook! !

!Cart methodsFor: 'accessing' stamp: 'LL 1/24/2021 17:42:15'!
total
	
	^books sum: [ :aBook | bookCatalog at: aBook ].! !


!Cart methodsFor: 'testing' stamp: 'LL 1/21/2021 21:39:26'!
includes: aBook

	^ books includes: aBook! !

!Cart methodsFor: 'testing' stamp: 'LL 1/20/2021 21:33:04'!
isEmpty

	^books isEmpty! !


!Cart methodsFor: 'private - assertions' stamp: 'LL 1/24/2021 15:49:03'!
assertIsInCatalog: aBook

	^ (bookCatalog includesKey: aBook) ifFalse: [ self error: self class bookNotInCatalogErrorMessage ]! !

!Cart methodsFor: 'private - assertions' stamp: 'LL 1/21/2021 21:27:21'!
assertValidNumberOfCopies: numberOfBooksToAdd

	^ numberOfBooksToAdd strictlyPositive ifFalse: [ self error: self class invalidNumberOfCopiesErrorMessage ]! !

"-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- "!

!classDefinition: 'Cart class' category: 'TusLibros'!
Cart class
	instanceVariableNames: ''!

!Cart class methodsFor: 'instance creation' stamp: 'LL 1/25/2021 18:29:34'!
acceptingItemsOf: aBookCatalog
 
	^self new initializeWithCatalog: aBookCatalog ! !


!Cart class methodsFor: 'error messages' stamp: 'LL 1/20/2021 21:45:09'!
bookNotInCatalogErrorMessage

	^'Cannot add a book that is not from the editorial'! !

!Cart class methodsFor: 'error messages' stamp: 'LL 1/21/2021 21:27:21'!
invalidNumberOfCopiesErrorMessage

	^'Cannot add zero books'! !


!classDefinition: #Cashier category: 'TusLibros'!
Object subclass: #Cashier
	instanceVariableNames: 'salesBook'
	classVariableNames: ''
	poolDictionaries: ''
	category: 'TusLibros'!

!Cashier methodsFor: 'initialization' stamp: 'LL 1/25/2021 18:49:19'!
initializeWithSalesBook: aSalesBook

	salesBook := aSalesBook! !


!Cashier methodsFor: 'checkout' stamp: 'LL 1/25/2021 23:10:38'!
checkout: aCart payingWith: aCreditCard through: aMerchantProcessor on: aCheckoutDateTime  

	| ticket |
	self assertCanCheckout: aCart using: aCreditCard on: aCheckoutDateTime.
	
	ticket := aCart total.
	
	self debit: ticket value from: aCreditCard using: aMerchantProcessor.
	
	self registerSale: ticket.
	
	^ticket! !


!Cashier methodsFor: 'assertions' stamp: 'LL 1/25/2021 23:10:22'!
assertCanCheckout: aCart using: aCreditCard on: aDateTime 

	self assertContainsBooks: aCart.
	self assertIsNotExpired: aCreditCard on: aDateTime! !

!Cashier methodsFor: 'assertions' stamp: 'LL 1/24/2021 17:45:42'!
assertContainsBooks: aCart

	^ aCart isEmpty ifTrue: [	 self error: Cashier cannotCheckoutAnEmptyCart ]! !

!Cashier methodsFor: 'assertions' stamp: 'LL 1/25/2021 23:11:12'!
assertIsNotExpired: aCreditCard on: aDateTime 

	^ (aCreditCard isExpiredOn: aDateTime) ifTrue: [ self error: Cashier cannotCheckoutUsingAnExpiredCard ]! !


!Cashier methodsFor: 'private' stamp: 'LL 1/24/2021 18:23:28'!
debit: anAmount from: aCreditCard using: aMerchantProcessor

	^ [ aMerchantProcessor debit: anAmount from: aCreditCard ]
		on: Error - MessageNotUnderstood 
		do: [ :exceptionRaised |
			self error: self class couldNotProcessPaymentErrorMessage.
		]! !

!Cashier methodsFor: 'private' stamp: 'LL 1/25/2021 19:50:24'!
registerSale: ticket

	^ salesBook add: ticket! !

"-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- "!

!classDefinition: 'Cashier class' category: 'TusLibros'!
Cashier class
	instanceVariableNames: ''!

!Cashier class methodsFor: 'as yet unclassified' stamp: 'LL 1/21/2021 21:50:07'!
cannotCheckoutAnEmptyCart
	^'Cannot checkout an empty cart'! !

!Cashier class methodsFor: 'as yet unclassified' stamp: 'LL 1/24/2021 16:44:06'!
cannotCheckoutUsingAnExpiredCard

	^'Cannot checkout using an expired card'! !

!Cashier class methodsFor: 'as yet unclassified' stamp: 'LL 1/24/2021 18:13:36'!
couldNotProcessPaymentErrorMessage

	^'Cart was rejected'! !

!Cashier class methodsFor: 'as yet unclassified' stamp: 'LL 1/25/2021 18:48:59'!
registeringSalesOn: aSalesBook

	^ self new initializeWithSalesBook: aSalesBook.! !


!classDefinition: #CreditCard category: 'TusLibros'!
Object subclass: #CreditCard
	instanceVariableNames: 'creditCardNumber owner expirationDate'
	classVariableNames: ''
	poolDictionaries: ''
	category: 'TusLibros'!

!CreditCard methodsFor: 'initialization' stamp: 'LL 2/16/2021 18:05:42'!
initializeOf: aPerson number: aCreditCardNumber expiringOn: aMonthOfYear 

	owner := aPerson.
	creditCardNumber := aCreditCardNumber.
	expirationDate := aMonthOfYear.! !


!CreditCard methodsFor: 'testing' stamp: 'LL 2/16/2021 18:05:42'!
isExpiredOn: aDateTime

	^ aDateTime > (expirationDate lastDate)! !

"-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- "!

!classDefinition: 'CreditCard class' category: 'TusLibros'!
CreditCard class
	instanceVariableNames: ''!

!CreditCard class methodsFor: 'instance creation' stamp: 'LL 1/24/2021 18:15:40'!
of: nameOfTheOwner number: aCreditCardNumber expiringOn: aMonthOfYear

	nameOfTheOwner isEmpty ifTrue: [ self error: self nameCannotBeBlankErrorMessage ].
	
	^self new initializeOf: nameOfTheOwner number: aCreditCardNumber expiringOn: aMonthOfYear ! !


!CreditCard class methodsFor: 'as yet unclassified' stamp: 'LL 1/24/2021 18:01:14'!
nameCannotBeBlankErrorMessage

	^'Name cannot be blank'! !


!classDefinition: #MerchantProcessorSimulator category: 'TusLibros'!
Object subclass: #MerchantProcessorSimulator
	instanceVariableNames: 'wasContacted paymentAllowed'
	classVariableNames: ''
	poolDictionaries: ''
	category: 'TusLibros'!

!MerchantProcessorSimulator methodsFor: 'initialization' stamp: 'MFR 2/23/2021 16:58:33'!
simulate
	
	wasContacted := false.
	paymentAllowed := true.! !


!MerchantProcessorSimulator methodsFor: 'main protocol' stamp: 'MFR 2/23/2021 16:59:00'!
behaviour

	^wasContacted! !

!MerchantProcessorSimulator methodsFor: 'main protocol' stamp: 'MFR 2/23/2021 16:58:53'!
changeBehaviourToTrue

	wasContacted := true.! !

!MerchantProcessorSimulator methodsFor: 'main protocol' stamp: 'MFR 2/23/2021 16:58:19'!
debit: anAmountToDebit from: aCreditCard

	^ (self behaviour) ifFalse: [ Error new signal.].! !

"-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- "!

!classDefinition: 'MerchantProcessorSimulator class' category: 'TusLibros'!
MerchantProcessorSimulator class
	instanceVariableNames: ''!

!MerchantProcessorSimulator class methodsFor: 'initialization' stamp: 'MFR 2/23/2021 17:04:03'!
simulation

	^ self new simulate.! !


!classDefinition: #PublisherTestObjectsFactory category: 'TusLibros'!
Object subclass: #PublisherTestObjectsFactory
	instanceVariableNames: ''
	classVariableNames: ''
	poolDictionaries: ''
	category: 'TusLibros'!

!PublisherTestObjectsFactory methodsFor: 'as yet unclassified' stamp: 'LL 2/16/2021 19:41:18'!
aCashier

	| salesBook |
	salesBook := OrderedCollection new.
	^ Cashier registeringSalesOn: salesBook.! !

!PublisherTestObjectsFactory methodsFor: 'as yet unclassified' stamp: 'LL 2/16/2021 19:45:08'!
aValidCreditCard

	| nextMonth |
	nextMonth := (FixedGregorianDate today next: GregorianMonth oneMonth) monthOfYear.
	^CreditCard of: 'Juan Perez' number: 11111111 expiringOn: nextMonth.! !

!PublisherTestObjectsFactory methodsFor: 'as yet unclassified' stamp: 'LL 1/25/2021 18:29:34'!
anEmptyCart

	| aCatalog |
	aCatalog := Dictionary newFromPairs: {self bookFromTheEditorial. self bookFromTheEditorialPrice}.
	^Cart acceptingItemsOf: aCatalog.! !

!PublisherTestObjectsFactory methodsFor: 'as yet unclassified' stamp: 'LL 2/16/2021 19:51:21'!
anEmptySalesBook

	^OrderedCollection new.! !

!PublisherTestObjectsFactory methodsFor: 'as yet unclassified' stamp: 'LL 2/16/2021 19:43:38'!
anExpiredCreditCard
	
	| lastMonth |
	lastMonth := (FixedGregorianDate today previous: GregorianMonth oneMonth) monthOfYear.
	^CreditCard of: 'Juan Perez' number: 11111111 expiringOn: lastMonth.! !

!PublisherTestObjectsFactory methodsFor: 'as yet unclassified' stamp: 'LL 1/24/2021 15:59:26'!
bookFromTheEditorial

	^ 'ABC123'! !

!PublisherTestObjectsFactory methodsFor: 'as yet unclassified' stamp: 'LL 1/24/2021 17:11:28'!
bookFromTheEditorialPrice

	^ 1000 * peso! !

!PublisherTestObjectsFactory methodsFor: 'as yet unclassified' stamp: 'LL 2/16/2021 19:46:27'!
cartWithABook

	| cart |
	cart := self anEmptyCart.
	cart add: self bookFromTheEditorial.
	^cart! !

!PublisherTestObjectsFactory methodsFor: 'as yet unclassified' stamp: 'LL 2/16/2021 19:48:31'!
now 

	^GregorianDateTime now! !


!classDefinition: #TusLibrosSalesSystem category: 'TusLibros'!
Object subclass: #TusLibrosSalesSystem
	instanceVariableNames: 'users cartIds cartsInSystem catalogue cartsOfUsers usersOfCarts salesHistory'
	classVariableNames: ''
	poolDictionaries: ''
	category: 'TusLibros'!

!TusLibrosSalesSystem methodsFor: 'private - error descriptions' stamp: 'MFR 2/23/2021 15:28:30'!
invalidCartErrorDescription

	^ 'Invalid Cart ID'! !

!TusLibrosSalesSystem methodsFor: 'private - error descriptions' stamp: 'MFR 2/22/2021 21:06:53'!
invalidCredentialsErrorDescription
	
	^ 'Invalid credentials'! !


!TusLibrosSalesSystem methodsFor: 'createCart' stamp: 'MFR 2/23/2021 17:22:16'!
createCartFor: aUserId withPassword: aPassword 
	
	| cart |
	
	self checkUserId: aUserId withPassword: aPassword.
	
	cart := Cart acceptingItemsOf: self catalogue.
	
	cartsInSystem at: cartIds put: cart.
	(cartsOfUsers at: aUserId) add: cartIds.
	usersOfCarts at: cartIds put: aUserId.
	cartIds := cartIds + 1.! !


!TusLibrosSalesSystem methodsFor: 'private - error signals' stamp: 'MFR 2/23/2021 15:28:48'!
signalInvalidCartId

	self error: self invalidCartErrorDescription.! !

!TusLibrosSalesSystem methodsFor: 'private - error signals' stamp: 'MFR 2/22/2021 21:03:07'!
signalInvalidCredentials

	self error: self invalidCredentialsErrorDescription.! !


!TusLibrosSalesSystem methodsFor: 'private - assertions' stamp: 'MFR 2/23/2021 15:30:19'!
checkCartId: aCartId
	
	cartsInSystem at: aCartId ifAbsent: [ self signalInvalidCartId ].
	! !

!TusLibrosSalesSystem methodsFor: 'private - assertions' stamp: 'MFR 2/23/2021 18:36:23'!
checkUserId: aUserId withPassword: aPassword 
	
	(( users at: aUserId ifAbsent: [ self signalInvalidCredentials ]) = aPassword ) ifFalse: [self signalInvalidCredentials.].
	! !


!TusLibrosSalesSystem methodsFor: 'initialization' stamp: 'MFR 2/23/2021 18:33:26'!
with: aGroupOfUsers

	users := aGroupOfUsers.
	cartIds := 1.
	cartsInSystem := Dictionary new.
	cartsOfUsers := Dictionary new.
	salesHistory := Dictionary new.
	usersOfCarts := Dictionary new.
	catalogue := Dictionary newFromPairs: {self bookFromTheEditorial. self bookFromTheEditorialPrice}.
	aGroupOfUsers keysDo: [ :aUser |
							cartsOfUsers at: aUser put: OrderedCollection new. 
							salesHistory at: aUser put: Dictionary new.
							(salesHistory at: aUser) at: 'TOTAL' put: 0 * peso.
						].! !


!TusLibrosSalesSystem methodsFor: 'private' stamp: 'MFR 2/22/2021 21:28:50'!
bookFromTheEditorial

	^ 'ABC123'.! !

!TusLibrosSalesSystem methodsFor: 'private' stamp: 'MFR 2/22/2021 21:28:46'!
bookFromTheEditorialPrice

	^ 100 * peso.! !

!TusLibrosSalesSystem methodsFor: 'private' stamp: 'MFR 2/22/2021 21:30:05'!
catalogue

	^ catalogue copy.! !


!TusLibrosSalesSystem methodsFor: 'listCart' stamp: 'MFR 2/23/2021 15:33:13'!
listCart: cartId
	
	self checkCartId: cartId.
	
	^ (cartsInSystem at: cartId) contents.! !


!TusLibrosSalesSystem methodsFor: 'addToCart' stamp: 'MFR 2/23/2021 15:30:45'!
addToCart: aCartId book: aBook quantity: aQuantity
	
	| cart |
	
	self checkCartId: aCartId.
	
	cart := cartsInSystem at: aCartId.
	
	cart add: aBook quantity: aQuantity.! !


!TusLibrosSalesSystem methodsFor: 'listPurchases' stamp: 'MFR 2/23/2021 18:26:52'!
listPurchasesOf: aUser withPassword: aPassword
	
	| listOfPurchases |

	listOfPurchases := OrderedCollection new.
		
	(salesHistory at: aUser) valuesDo: [ :anElement |
								(anElement isKindOf: Bag) 
								ifTrue: 
									[(anElement contents) keysDo: [ :aKey | listOfPurchases add: (aKey,' ',((anElement occurrencesOf: aKey) asString))]]
								ifFalse: 
									[listOfPurchases add: anElement].
								].
	
	^listOfPurchases.! !


!TusLibrosSalesSystem methodsFor: 'checkOutCart' stamp: 'MFR 2/23/2021 18:01:58'!
checkOutCart: aCartId creditCardNumber: creditCardNumber creditCardExpirationDate: expirationDate creditCardOwner: creditCardOwner 
	
	| salesBook cashier cart creditCard merchantProcessor ticket userSalesHistory total |
	
	salesBook := OrderedCollection new.
	cashier := Cashier registeringSalesOn: salesBook.
	cart := cartsInSystem at: aCartId.
	creditCard := CreditCard of: creditCardOwner number: creditCardNumber expiringOn: expirationDate.
	merchantProcessor := MerchantProcessorSimulator simulation.
	merchantProcessor changeBehaviourToTrue.
	
	ticket := cashier checkout: cart payingWith: creditCard through: merchantProcessor on: GregorianDateTime now.
	
	userSalesHistory := (salesHistory at: (usersOfCarts at: aCartId)).
	
	userSalesHistory at: aCartId put: cart contents.
	total := (userSalesHistory at: 'TOTAL').
	userSalesHistory at: 'TOTAL' put: (total + ticket).! !

"-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- "!

!classDefinition: 'TusLibrosSalesSystem class' category: 'TusLibros'!
TusLibrosSalesSystem class
	instanceVariableNames: ''!

!TusLibrosSalesSystem class methodsFor: 'initialization' stamp: 'MFR 2/23/2021 17:15:16'!
withUsers: aGroupOfUsers
 
	^ self new with: aGroupOfUsers.! !
