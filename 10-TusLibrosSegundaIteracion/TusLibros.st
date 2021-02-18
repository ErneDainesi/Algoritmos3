!classDefinition: #CartTest category: 'TusLibros'!
TestCase subclass: #CartTest
	instanceVariableNames: ''
	classVariableNames: ''
	poolDictionaries: ''
	category: 'TusLibros'!

!CartTest methodsFor: 'tests' stamp: 'LL 1/21/2021 20:09:58'!
test01NewCartIsEmpty

	| cart |
	
	cart := self createCart.
	
	self assert: cart isEmpty.! !

!CartTest methodsFor: 'tests' stamp: 'LL 1/21/2021 20:09:38'!
test02CanAddABookToACart

	| cart |
	cart := self createCart.
	
	cart add: self bookFromTheEditorial.
	
	self deny: cart isEmpty.! !

!CartTest methodsFor: 'tests' stamp: 'LL 1/21/2021 21:25:18'!
test03CannotAddABookNotInCatalog

	| cart bookNotInCatalog |
	cart := self createCart.
	bookNotInCatalog := 'DEF456'.

	self assert: cart isEmptyAfter: [ cart add: bookNotInCatalog ] raisesErrorWithMessage: Cart bookNotInCatalogErrorMessage.
	! !

!CartTest methodsFor: 'tests' stamp: 'LL 1/21/2021 20:12:27'!
test04CanAddTwoCopiesOfABook

	| cart |
	cart := self createCart.
	
	cart add: self bookFromTheEditorial quantity: 2.
	
	self assert: (cart quantityOf: self bookFromTheEditorial) equals: 2.! !

!CartTest methodsFor: 'tests' stamp: 'LL 1/21/2021 21:27:25'!
test05CannotAddNonPositiveNumberOfCopiesOfABook

	| cart |
	cart := self createCart.

	self assert: cart isEmptyAfter: [ cart add: self bookFromTheEditorial quantity: -1 ] raisesErrorWithMessage: Cart invalidNumberOfCopiesErrorMessage.! !

!CartTest methodsFor: 'tests' stamp: 'LL 1/21/2021 21:39:03'!
test06CartRemembersAddedBooks

	| cart |
	cart := self createCart.
	
	cart add: self bookFromTheEditorial quantity: 2.
	cart add: self bookFromTheEditorial quantity: 1.
	
	self assert: (cart includes: self bookFromTheEditorial).
	self assert: (cart quantityOf: self bookFromTheEditorial) equals: 3! !

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

!CartTest methodsFor: 'private' stamp: 'LL 1/21/2021 20:08:01'!
bookFromTheEditorial

	^ 'ABC123'! !

!CartTest methodsFor: 'private' stamp: 'LL 1/21/2021 20:09:10'!
createCart

	| aCatalog |
	aCatalog := Set with: self bookFromTheEditorial.
	^Cart withCatalog: aCatalog.! !


!classDefinition: #CashierTest category: 'TusLibros'!
TestCase subclass: #CashierTest
	instanceVariableNames: ''
	classVariableNames: ''
	poolDictionaries: ''
	category: 'TusLibros'!

!CashierTest methodsFor: 'private' stamp: 'EEDP 2/17/2021 12:13:48'!
assert: aBlockExpectedToFail raisesError: excpectedErrorMessage

	self should: aBlockExpectedToFail 
	raise: Error - MessageNotUnderstood 
	withExceptionDo: [:anError |
		self assert: excpectedErrorMessage equals: anError messageText.
	].! !

!CashierTest methodsFor: 'private' stamp: 'EDP 2/11/2021 21:22:42'!
bookFromTheEditorial

	^ 'ABC123'! !

!CashierTest methodsFor: 'private' stamp: 'EDP 2/11/2021 21:22:32'!
createCart

	| aCatalog |
	aCatalog := Set with: self bookFromTheEditorial.
	^Cart withCatalog: aCatalog.! !


!CashierTest methodsFor: 'tests' stamp: 'EEDP 2/17/2021 12:20:06'!
test01CannotCheckOutEmptyCart

	| cart cashier creditCardExpirationDate creditCardNumber creditCardOwner |
	
	cart := self createCart.
	
	creditCardNumber := '4500000000000000'.
	creditCardExpirationDate := '092021'.
	creditCardOwner := 'Guido Kazcka'.
	
	cashier := Cashier withCart: cart withCreditCardNumber: creditCardNumber validThrough: creditCardExpirationDate from: creditCardOwner.
	
	self assert: [ cashier checkOut ] raisesError: cashier cannotCheckOutEmptyCartErrorDescription.! !

!CashierTest methodsFor: 'tests' stamp: 'EDP 2/15/2021 19:15:17'!
test02CheckOutCartWithOneItemOutputIsCorrect

	| cart cashier creditCardExpirationDate creditCardNumber creditCardOwner |
	
	cart := self createCart.

	cart add: self bookFromTheEditorial.

	creditCardNumber := '4500000000000000'.
	creditCardExpirationDate := '092021'.
	creditCardOwner := 'Guido Kazcka'.

	cashier := Cashier withCart: cart withCreditCardNumber: creditCardNumber validThrough: creditCardExpirationDate from: creditCardOwner.

	self assert: cashier checkOut equals: '0 | TRANSACTION_1_500 pesos'.! !

!CashierTest methodsFor: 'tests' stamp: 'EDP 2/15/2021 19:15:12'!
test03CheckOutWithManyItemsOutputIsCorrect

	| cart cashier creditCardExpirationDate creditCardNumber creditCardOwner |
	
	cart := self createCart.

	cart add: self bookFromTheEditorial.
	cart add: self bookFromTheEditorial.
	
	creditCardNumber := '4500000000000000'.
	creditCardExpirationDate := '092021'.
	creditCardOwner := 'Guido Kazcka'.

	cashier := Cashier withCart: cart withCreditCardNumber: creditCardNumber validThrough: creditCardExpirationDate from: creditCardOwner.

	self assert: cashier checkOut equals: '0 | TRANSACTION_1_1000 pesos'.! !

!CashierTest methodsFor: 'tests' stamp: 'EEDP 2/17/2021 12:28:18'!
test04CashierKeepsTrackOfTransactionsCorectly

	| cart cashier creditCardExpirationDate creditCardNumber creditCardOwner transactions |
	
	cart := self createCart.

	cart add: self bookFromTheEditorial.
	cart add: self bookFromTheEditorial.
	
	creditCardNumber := '4500000000000000'.
	creditCardExpirationDate := '092021'.
	creditCardOwner := 'Guido Kazcka'.

	cashier := Cashier withCart: cart withCreditCardNumber: creditCardNumber validThrough: creditCardExpirationDate from: creditCardOwner.
	
	cashier checkOut.
	
	transactions := OrderedCollection with: 1000 * peso.

	self assert: cashier transactionHistory equals: transactions.! !

!CashierTest methodsFor: 'tests' stamp: 'EEDP 2/17/2021 12:19:31'!
test05CannotCheckOutCartWithInvalidCreditCardNumber

	| cart cashier creditCardExpirationDate creditCardNumber creditCardOwner |
	
	cart := self createCart.

	cart add: self bookFromTheEditorial.
	
	creditCardNumber := '1'.
	creditCardExpirationDate := '092021'.
	creditCardOwner := 'Guido Kazcka'.

	cashier := Cashier withCart: cart withCreditCardNumber: creditCardNumber validThrough: creditCardExpirationDate from: creditCardOwner.
	
	self assert: [ cashier checkOut ] raisesError: cashier cannotCheckOutCartWithInvalidCreditCardNumberErrorDescription.! !

!CashierTest methodsFor: 'tests' stamp: 'EEDP 2/17/2021 12:19:26'!
test06CannotCheckOutCartWithExpiredCreditCard

	| cart cashier creditCardExpirationDate creditCardNumber creditCardOwner |
	
	cart := self createCart.

	cart add: self bookFromTheEditorial.
	
	creditCardNumber := '4500000000000000'.
	creditCardExpirationDate := '092020'.
	creditCardOwner := 'Guido Kazcka'.

	cashier := Cashier withCart: cart withCreditCardNumber: creditCardNumber validThrough: creditCardExpirationDate from: creditCardOwner.
	
	self assert: [ cashier checkOut ] raisesError: cashier cannotCheckOutCartWithExpiredCreditCardErrorDescription.! !

!CashierTest methodsFor: 'tests' stamp: 'EEDP 2/17/2021 12:18:51'!
test07CannotCheckOutCartWithInvalidCreditCardOwner

	| cart cashier creditCardExpirationDate creditCardNumber creditCardOwner |
	
	cart := self createCart.

	cart add: self bookFromTheEditorial.
	
	creditCardNumber := '4500000000000000'.
	creditCardExpirationDate := '092021'.
	creditCardOwner := 'Guido Martin Ezequiel Rodriguez De La Santa Cruz Kazcka'.

	cashier := Cashier withCart: cart withCreditCardNumber: creditCardNumber validThrough: creditCardExpirationDate from: creditCardOwner.
	
	self assert: [ cashier checkOut ] raisesError: cashier cannotCheckOutCartWithInvalidCreditCardOwnerErrorDescription.! !

!CashierTest methodsFor: 'tests' stamp: 'EDP 2/15/2021 19:33:39'!
test08CartIsEmptyAfterCheckingOut

	| cart cashier creditCardExpirationDate creditCardNumber creditCardOwner |
	
	cart := self createCart.

	cart add: self bookFromTheEditorial.
	cart add: self bookFromTheEditorial.
	
	creditCardNumber := '4500000000000000'.
	creditCardExpirationDate := '092021'.
	creditCardOwner := 'Guido Kazcka'.

	cashier := Cashier withCart: cart withCreditCardNumber: creditCardNumber validThrough: creditCardExpirationDate from: creditCardOwner.
	
	cashier checkOut.
	
	self assert: cashier checkIfCartIsEmpty.! !


!classDefinition: #Cart category: 'TusLibros'!
Object subclass: #Cart
	instanceVariableNames: 'books bookCatalog'
	classVariableNames: ''
	poolDictionaries: ''
	category: 'TusLibros'!

!Cart methodsFor: 'initialization' stamp: 'LL 1/21/2021 20:26:42'!
initializeWithCatalog: aBookCatalog
	
	bookCatalog := aBookCatalog.
	books := Bag new! !


!Cart methodsFor: 'adding' stamp: 'LL 1/21/2021 20:24:07'!
add: aBook
	
	self add: aBook quantity: 1.! !

!Cart methodsFor: 'adding' stamp: 'EDP 2/15/2021 17:48:43'!
add: aBook quantity: numberOfBooksToAdd

	self assertIsInCatalog: aBook.
	self assertValidNumberOfCopies: numberOfBooksToAdd.
	
	books add: aBook withOccurrences: numberOfBooksToAdd.! !


!Cart methodsFor: 'accessing' stamp: 'LL 1/20/2021 22:11:43'!
contents
	^books copy! !

!Cart methodsFor: 'accessing' stamp: 'LL 1/21/2021 21:39:26'!
includes: aBook

	^ books includes: aBook! !

!Cart methodsFor: 'accessing' stamp: 'LL 1/20/2021 21:51:06'!
quantityOf: aBook
	
	^books occurrencesOf: aBook! !


!Cart methodsFor: 'testing' stamp: 'LL 1/20/2021 21:33:04'!
isEmpty

	^books isEmpty! !


!Cart methodsFor: 'empty' stamp: 'EDP 2/15/2021 19:30:54'!
emptyCart
	
	books := Bag new.! !


!Cart methodsFor: 'private - assertions' stamp: 'LL 1/21/2021 20:19:45'!
assertIsInCatalog: aBook

	^ (bookCatalog includes: aBook) ifFalse: [ self error: self class bookNotInCatalogErrorMessage ]! !

!Cart methodsFor: 'private - assertions' stamp: 'LL 1/21/2021 21:27:21'!
assertValidNumberOfCopies: numberOfBooksToAdd

	^ numberOfBooksToAdd strictlyPositive ifFalse: [ self error: self class invalidNumberOfCopiesErrorMessage ]! !

"-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- "!

!classDefinition: 'Cart class' category: 'TusLibros'!
Cart class
	instanceVariableNames: ''!

!Cart class methodsFor: 'instance creation' stamp: 'LL 1/20/2021 21:37:38'!
withCatalog: aBookCatalog
 
	^self new initializeWithCatalog: aBookCatalog ! !


!Cart class methodsFor: 'error messages' stamp: 'LL 1/20/2021 21:45:09'!
bookNotInCatalogErrorMessage

	^'Cannot add a book that is not from the editorial'! !

!Cart class methodsFor: 'error messages' stamp: 'LL 1/21/2021 21:27:21'!
invalidNumberOfCopiesErrorMessage

	^'Cannot add zero books'! !


!classDefinition: #Cashier category: 'TusLibros'!
Object subclass: #Cashier
	instanceVariableNames: 'cart ccn cced ccowner priceList transactionsHistory'
	classVariableNames: ''
	poolDictionaries: ''
	category: 'TusLibros'!

!Cashier methodsFor: 'initialization' stamp: 'EDP 2/15/2021 18:44:19'!
withCart: aCart withCreditCardNumber: creditCardNumber validThrough: expirationDate from: creditCardOwner withCataloguePriceList: aCataloguePriceList
	
	cart := aCart.
	ccn := creditCardNumber.
	cced := expirationDate.
	ccowner := creditCardOwner.
	priceList := aCataloguePriceList.
	transactionsHistory := OrderedCollection new.! !


!Cashier methodsFor: 'error descriptions' stamp: 'EDP 2/15/2021 19:00:45'!
cannotCheckOutCartWithExpiredCreditCardErrorDescription

	^ '1 | Credit Card has expired'.! !

!Cashier methodsFor: 'error descriptions' stamp: 'EDP 2/15/2021 18:53:17'!
cannotCheckOutCartWithInvalidCreditCardNumberErrorDescription

	^ '1| Invalid credit card number.'.! !

!Cashier methodsFor: 'error descriptions' stamp: 'EDP 2/15/2021 19:16:24'!
cannotCheckOutCartWithInvalidCreditCardOwnerErrorDescription

	^ '1| Invalid credit card owner.'.! !

!Cashier methodsFor: 'error descriptions' stamp: 'EDP 2/11/2021 21:56:32'!
cannotCheckOutEmptyCartErrorDescription

	^ '1 | Cart is empty'.! !


!Cashier methodsFor: 'accessing' stamp: 'EDP 2/15/2021 19:28:38'!
checkIfCartIsEmpty
	
	^ cart isEmpty.! !

!Cashier methodsFor: 'accessing' stamp: 'EEDP 2/17/2021 20:38:14'!
getCart
	
	^ cart contents.! !

!Cashier methodsFor: 'accessing' stamp: 'EEDP 2/17/2021 20:37:40'!
getCreditCardExpirationDate
	
	^ cced.! !

!Cashier methodsFor: 'accessing' stamp: 'EEDP 2/17/2021 20:37:30'!
getCreditCardNumber
	
	^ ccn.! !

!Cashier methodsFor: 'accessing' stamp: 'EEDP 2/17/2021 20:37:54'!
getCreditCardOwner
	
	^ ccowner.! !

!Cashier methodsFor: 'accessing' stamp: 'EDP 2/15/2021 19:34:15'!
transactionHistory
	
	^ transactionsHistory copy.! !


!Cashier methodsFor: 'check out' stamp: 'EEDP 2/18/2021 16:02:15'!
checkOut
	
	| total cartContent index |
	
	MerchantProcesor for: self.
	
	total := 0 * peso.
	index := 1.
	
	cartContent := (cart contents) contents keys.
	
	
	cartContent size timesRepeat: [ | anItem |
							anItem := cartContent at: index.
							total := total + ( (priceList at: anItem) *  (cart quantityOf: anItem) ).
							index := index + 1].
	
	transactionsHistory add: total.
	
	cart emptyCart.
	
	^ '0 | TRANSACTION_1_', total asString.! !

"-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- "!

!classDefinition: 'Cashier class' category: 'TusLibros'!
Cashier class
	instanceVariableNames: ''!

!Cashier class methodsFor: 'class initialization' stamp: 'EDP 2/15/2021 18:12:35'!
withCart: aCart withCreditCardNumber: creditCardNumber validThrough: expirationDate from: creditCardOwner

	| cataloguePriceList |
	
	cataloguePriceList := Dictionary new.
	cataloguePriceList at: 'ABC123' put: 500 * peso.
	
	^ self new withCart: aCart withCreditCardNumber: creditCardNumber validThrough:  expirationDate from: creditCardOwner withCataloguePriceList: cataloguePriceList.! !


!classDefinition: #MerchantProcesor category: 'TusLibros'!
Object subclass: #MerchantProcesor
	instanceVariableNames: ''
	classVariableNames: ''
	poolDictionaries: ''
	category: 'TusLibros'!

!MerchantProcesor methodsFor: 'validations' stamp: 'EEDP 2/18/2021 15:29:52'!
validateCart: aCart

	aCart isEmpty ifTrue: [ ^ self signalEmptyCartError ].
	! !

!MerchantProcesor methodsFor: 'validations' stamp: 'EEDP 2/18/2021 15:31:47'!
validateCashier: aCashier

	self validateCart: aCashier getCart.
	self validateCreditCardNumber: aCashier getCreditCardNumber.
	self validateCreditCardExpirationDate: aCashier getCreditCardExpirationDate.
	self validateCreditCardOwner: aCashier getCreditCardOwner.! !

!MerchantProcesor methodsFor: 'validations' stamp: 'EEDP 2/18/2021 15:38:22'!
validateCreditCardExpirationDate: anExpirationDate
	
	| month currentDate invertedCced |
	
	month := anExpirationDate copyFrom: 1 to: 2.
	
	currentDate := Date today monthIndex asString, Date today yearNumber asString.	
	(currentDate size = 5) ifTrue: [ currentDate := '0', currentDate ].
	
	currentDate := (currentDate copyFrom: 3 to: 6), (currentDate copyFrom: 1 to: 2).
	invertedCced := (anExpirationDate copyFrom: 3 to: 6), (anExpirationDate copyFrom: 1 to: 2).
	
	^ ( (month > '12') or: (month < '01') or: (currentDate > invertedCced) ) ifTrue: [self invalidCreditCardExpirationDate].! !

!MerchantProcesor methodsFor: 'validations' stamp: 'EEDP 2/18/2021 15:30:03'!
validateCreditCardNumber: aCreditCardNumber

	^ (aCreditCardNumber size < 15 or: aCreditCardNumber size > 16) ifTrue: [self invalidCreditCardNumber].! !

!MerchantProcesor methodsFor: 'validations' stamp: 'EEDP 2/18/2021 15:30:07'!
validateCreditCardOwner: aCreditCardOwner

	^ (aCreditCardOwner size > 30) ifTrue: [self invalidCreditCardOwner].! !


!MerchantProcesor methodsFor: 'error descriptions' stamp: 'EEDP 2/18/2021 14:59:14'!
emptyCartErrorDescription
	
	^ '1 | Cart is empty'.! !

!MerchantProcesor methodsFor: 'error descriptions' stamp: 'EEDP 2/18/2021 15:13:36'!
invalidCreditCardExpirationDateErrorDescription
	
	^ '1 | Credit Card has expired'.! !

!MerchantProcesor methodsFor: 'error descriptions' stamp: 'EEDP 2/18/2021 15:12:47'!
invalidCreditCardNumberErrorDescription
	
	^ '1| Invalid credit card number.'.! !

!MerchantProcesor methodsFor: 'error descriptions' stamp: 'EEDP 2/18/2021 15:16:54'!
invalidCreditCardOwnerErrorDescription
	
	^ '1| Invalid credit card owner.'.! !


!MerchantProcesor methodsFor: 'error signal' stamp: 'EEDP 2/18/2021 15:12:18'!
invalidCreditCardExpirationDate
	
	self error: self invalidCreditCardExpirationDateErrorDescription.! !

!MerchantProcesor methodsFor: 'error signal' stamp: 'EEDP 2/18/2021 15:13:08'!
invalidCreditCardNumber
	
	self error: self invalidCreditCardNumberErrorDescription.! !

!MerchantProcesor methodsFor: 'error signal' stamp: 'EEDP 2/18/2021 15:16:07'!
invalidCreditCardOwner
	
	self error: self invalidCreditCardOwnerErrorDescription.! !

!MerchantProcesor methodsFor: 'error signal' stamp: 'EEDP 2/18/2021 14:58:23'!
signalEmptyCartError
	
	self error: self emptyCartErrorDescription.! !

"-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- "!

!classDefinition: 'MerchantProcesor class' category: 'TusLibros'!
MerchantProcesor class
	instanceVariableNames: ''!

!MerchantProcesor class methodsFor: 'class initialization' stamp: 'EEDP 2/18/2021 15:32:03'!
for: aCashier

	self new validateCashier: aCashier.
! !
