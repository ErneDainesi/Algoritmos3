!classDefinition: #CartTests category: '09-TusLibros'!
TestCase subclass: #CartTests
	instanceVariableNames: ''
	classVariableNames: ''
	poolDictionaries: ''
	category: '09-TusLibros'!

!CartTests methodsFor: 'testing' stamp: 'MFR 2/10/2021 19:20:35'!
test01

	| cart clientId clientPass |
	
	clientId := '123'.
	clientPass := '123'.
	cart := Cart id: clientId password: clientPass.
	
	self assert: cart quantityOfElementsInCart equals: 0.! !

!CartTests methodsFor: 'testing' stamp: 'MFR 2/10/2021 19:25:52'!
test02

	| cart clientId clientPass isbn |
	
	clientId := '123'.
	clientPass := '123'.
	cart := Cart id: clientId password: clientPass.
	isbn := '456'.
	cart addToCart: isbn quantity: 1. 
	
	self assert: (cart has: 1 element: isbn).! !

!CartTests methodsFor: 'testing' stamp: 'MFR 2/10/2021 19:47:34'!
test03

	| cart clientId clientPass firstIsbn secondIsbn |
	
	clientId := '123'.
	clientPass := '123'.
	cart := Cart id: clientId password: clientPass.
	firstIsbn := '456'.
	cart addToCart: firstIsbn quantity: 2. 
	secondIsbn := '789'.
	cart addToCart: secondIsbn quantity: 1.
	
	self assert: (cart has: 2 element: firstIsbn).
	self assert: cart quantityOfElementsInCart equals: 3.! !

!CartTests methodsFor: 'testing' stamp: 'MFR 2/10/2021 20:37:13'!
test04

	| cart clientId clientPass isbn |
	
	clientId := '123'.
	clientPass := '123'.
	cart := Cart id: clientId password: clientPass.
	isbn := '456'.
	
	self should: [ cart addToCart: isbn quantity: 0 ]
		raise: Error - MessageNotUnderstood 
		withExceptionDo: [ :anError |
			self assert: cart cannotAddToCartQuantityBelowOneErrorDescription equals: anError messageText.
			self assert: cart quantityOfElementsInCart equals: 0.
		].! !

!CartTests methodsFor: 'testing' stamp: 'MFR 2/10/2021 21:18:44'!
test05

	| cart clientId clientPass isbn |
	
	clientId := '123'.
	clientPass := '123'.
	cart := Cart id: clientId password: clientPass.
	isbn := '123'.
	
	self should: [ cart addToCart: isbn quantity: 1 ]
		raise: Error - MessageNotUnderstood 
		withExceptionDo: [ :anError |
			self assert: cart cannotAddToCartElementNotInCatalogueErrorDescription equals: anError messageText.
			self assert: cart quantityOfElementsInCart equals: 0.
		].! !

!CartTests methodsFor: 'testing' stamp: 'MFR 2/10/2021 21:25:06'!
test06

	| cart clientId clientPass emptyCartList |
	
	clientId := '123'.
	clientPass := '123'.
	cart := Cart id: clientId password: clientPass.
	emptyCartList := OrderedCollection new.
	
	self assert: cart quantityOfElementsInCart equals: 0.
	self assert: cart listCart equals: emptyCartList.! !

!CartTests methodsFor: 'testing' stamp: 'MFR 2/10/2021 21:27:16'!
test07

	| cart clientId clientPass isbn cartList |
	
	clientId := '123'.
	clientPass := '123'.
	cart := Cart id: clientId password: clientPass.
	isbn := '456'.
	cart addToCart: isbn quantity: 1. 
	cartList := OrderedCollection new.
	cartList add: '456 | 1'.

	self assert: cart listCart equals: cartList.! !

!CartTests methodsFor: 'testing' stamp: 'MFR 2/10/2021 21:33:14'!
test08

	| cart clientId clientPass cartList firstIsbn secondIsbn |
	
	clientId := '123'.
	clientPass := '123'.
	cart := Cart id: clientId password: clientPass.
	
	cartList := OrderedCollection new.
	cartList add: '456 | 2'.
	cartList add: '789 | 1'.
	
	firstIsbn := '456'.
	cart addToCart: firstIsbn quantity: 1. 
	secondIsbn := '789'.
	cart addToCart: secondIsbn quantity: 1.
	cart addToCart: firstIsbn quantity: 1.

	self assert: cart listCart equals: cartList.! !

!CartTests methodsFor: 'testing' stamp: 'MFR 2/11/2021 10:44:51'!
test09

	| cart clientId clientPass isbn cced ccn cco |
	
	clientId := '123'.
	clientPass := '123'.
	cart := Cart id: clientId password: clientPass.
	isbn := '456'.
	cart addToCart: isbn quantity: 1.
	ccn := '1234567890123456'.
	cced := '092021'.
	cco := 'Guido Kaczka'. 
	
	self assert: (cart has: 1 element: isbn).
	self assert: (cart checkOutCartWithCreditCardNumber: ccn validThrough: cced ownedBy: cco) equals: 'TRANSACTION_123'.! !

!CartTests methodsFor: 'testing' stamp: 'MFR 2/11/2021 10:44:56'!
test10

	| cart clientId clientPass  cced ccn cco |
	
	clientId := '123'.
	clientPass := '123'.
	cart := Cart id: clientId password: clientPass.
	ccn := '1234567890123456'.
	cced := '092021'.
	cco := 'Guido Kaczka'.
	
	self should: [ cart checkOutCartWithCreditCardNumber: ccn validThrough: cced ownedBy: cco]
		raise: Error - MessageNotUnderstood 
		withExceptionDo: [ :anError |
			self assert: cart quantityOfElementsInCart equals: 0.
			self assert: cart cannotCheckOutEmptyCartErrorDescription equals: anError messageText.
		].! !

!CartTests methodsFor: 'testing' stamp: 'MFR 2/11/2021 10:45:00'!
test11

	| cart clientId clientPass  cced ccn cco isbn |
	
	clientId := '123'.
	clientPass := '123'.
	cart := Cart id: clientId password: clientPass.
	isbn := '456'.
	cart addToCart: isbn quantity: 1.
	ccn := '12345678901234567'.
	cced := '092021'.
	cco := 'Guido Kaczka'.
	
	self should: [ cart checkOutCartWithCreditCardNumber: ccn validThrough: cced ownedBy: cco]
		raise: Error - MessageNotUnderstood 
		withExceptionDo: [ :anError |
			self assert: cart cannotCheckOutCartWithInvalidCreditCardNumberErrorDescription equals: anError messageText.
		].! !

!CartTests methodsFor: 'testing' stamp: 'MFR 2/11/2021 10:57:17'!
test12

	| cart clientId clientPass  cced ccn cco isbn |
	
	clientId := '123'.
	clientPass := '123'.
	cart := Cart id: clientId password: clientPass.
	isbn := '456'.
	cart addToCart: isbn quantity: 1.
	ccn := '1234567890123456'.
	cced := '132021'.
	cco := 'Guido Kaczka'.
	
	self should: [ cart checkOutCartWithCreditCardNumber: ccn validThrough: cced ownedBy: cco]
		raise: Error - MessageNotUnderstood 
		withExceptionDo: [ :anError |
			self assert: cart cannotCheckOutCartWithInvalidCreditCardExpirationMonthErrorDescription equals: anError messageText.
		].! !

!CartTests methodsFor: 'testing' stamp: 'MFR 2/11/2021 10:45:08'!
test13

	| cart clientId clientPass  cced ccn cco isbn |
	
	clientId := '123'.
	clientPass := '123'.
	cart := Cart id: clientId password: clientPass.
	isbn := '456'.
	cart addToCart: isbn quantity: 1.
	ccn := '1234567890123456'.
	cced := '012021'.
	cco := 'Guido Kaczka'.
	
	self should: [ cart checkOutCartWithCreditCardNumber: ccn validThrough: cced ownedBy: cco]
		raise: Error - MessageNotUnderstood 
		withExceptionDo: [ :anError |
			self assert: cart cannotCheckOutCartWithInvalidCreditCardExpirationDateErrorDescription equals: anError messageText.
		].! !

!CartTests methodsFor: 'testing' stamp: 'MFR 2/11/2021 10:45:13'!
test14

	| cart clientId clientPass  cced ccn cco isbn |
	
	clientId := '123'.
	clientPass := '123'.
	cart := Cart id: clientId password: clientPass.
	isbn := '456'.
	cart addToCart: isbn quantity: 1.
	ccn := '1234567890123456'.
	cced := '092021'.
	cco := 'Guido Emliano Agustin Martinez Kaczka'.
	
	self should: [ cart checkOutCartWithCreditCardNumber: ccn validThrough: cced ownedBy: cco]
		raise: Error - MessageNotUnderstood 
		withExceptionDo: [ :anError |
			self assert: cart cannotCheckOutCartWithInvalidCreditCardOwnerErrorDescription equals: anError messageText.
		].! !


!classDefinition: #Cart category: '09-TusLibros'!
Object subclass: #Cart
	instanceVariableNames: 'id password elements catalogue'
	classVariableNames: ''
	poolDictionaries: ''
	category: '09-TusLibros'!

!Cart methodsFor: 'initialization' stamp: 'MFR 2/10/2021 21:17:12'!
id: anId password: aPassword elements: aCollection

	id := anId.
	password := aPassword.
	elements := aCollection.
	catalogue := TusLibrosCatalogue initialize.! !


!Cart methodsFor: 'assertions' stamp: 'MFR 2/10/2021 21:56:33'!
assertCartIsNotEmpty

	^ (elements size < 1) ifTrue: [self signalCannotCheckOutCart].! !

!Cart methodsFor: 'assertions' stamp: 'MFR 2/11/2021 10:44:29'!
assertCreditCardDateIsValid: cced
	
	| currentDate |

	currentDate := Date today monthIndex asString,Date today yearNumber asString.		
	(currentDate size = 5) ifTrue: [ currentDate := '0',currentDate ].
	
	^ (currentDate > cced) ifTrue: [self signalInvalidCreditCardExpirationDate].! !

!Cart methodsFor: 'assertions' stamp: 'MFR 2/11/2021 10:56:59'!
assertCreditCardExpirationMonthIsValid: cced
	
	| month |
	
	month := cced copyFrom: 1 to: 2.
			
	^ ((month > '12') or: (month < '01')) ifTrue: [self signalInvalidCreditCardExpirationMonth].! !

!Cart methodsFor: 'assertions' stamp: 'MFR 2/11/2021 09:46:13'!
assertCreditCardNumberIsValid: ccn

	^ (ccn size > 16) ifTrue: [self signalInvalidCreditCardNumber].! !

!Cart methodsFor: 'assertions' stamp: 'MFR 2/10/2021 21:17:34'!
assertElementIsInCatalogue: anElement

	^ (catalogue bookIsInCatalogue: anElement) ifFalse: [ self signalElementNotInCatalogue ].

	! !

!Cart methodsFor: 'assertions' stamp: 'MFR 2/11/2021 10:29:19'!
assertOwnerIsValid: cco

	^ (cco size > 30) ifTrue: [self signalInvalidCreditCardOwner].! !

!Cart methodsFor: 'assertions' stamp: 'MFR 2/10/2021 20:35:51'!
assertQuantityCanBeAddedToCart: aQuantity

	^ (aQuantity < 1) ifTrue: [self signalCannotAddToCart].! !


!Cart methodsFor: 'error signal' stamp: 'MFR 2/10/2021 20:36:12'!
signalCannotAddToCart

	self error: self cannotAddToCartQuantityBelowOneErrorDescription.! !

!Cart methodsFor: 'error signal' stamp: 'MFR 2/10/2021 21:57:00'!
signalCannotCheckOutCart

	self error: self cannotCheckOutEmptyCartErrorDescription.! !

!Cart methodsFor: 'error signal' stamp: 'MFR 2/10/2021 21:05:35'!
signalElementNotInCatalogue

	self error: self cannotAddToCartElementNotInCatalogueErrorDescription.! !

!Cart methodsFor: 'error signal' stamp: 'MFR 2/11/2021 10:34:59'!
signalInvalidCreditCardExpirationDate

	self error: self cannotCheckOutCartWithInvalidCreditCardExpirationDateErrorDescription.! !

!Cart methodsFor: 'error signal' stamp: 'MFR 2/11/2021 10:12:54'!
signalInvalidCreditCardExpirationMonth

	self error: self cannotCheckOutCartWithInvalidCreditCardExpirationMonthErrorDescription.! !

!Cart methodsFor: 'error signal' stamp: 'MFR 2/11/2021 09:47:09'!
signalInvalidCreditCardNumber

	self error: self cannotCheckOutCartWithInvalidCreditCardNumberErrorDescription.! !

!Cart methodsFor: 'error signal' stamp: 'MFR 2/11/2021 10:29:39'!
signalInvalidCreditCardOwner

	self error: self cannotCheckOutCartWithInvalidCreditCardOwnerErrorDescription.! !


!Cart methodsFor: 'error descriptions' stamp: 'MFR 2/10/2021 21:06:06'!
cannotAddToCartElementNotInCatalogueErrorDescription

	^ '1 | Element not included in catalogue'.! !

!Cart methodsFor: 'error descriptions' stamp: 'MFR 2/10/2021 20:36:16'!
cannotAddToCartQuantityBelowOneErrorDescription

	^ '1 | Quantity of books lower than 1'.! !

!Cart methodsFor: 'error descriptions' stamp: 'MFR 2/11/2021 10:33:14'!
cannotCheckOutCartWithInvalidCreditCardExpirationDateErrorDescription

	^ '1 | Credit Card is expired'.! !

!Cart methodsFor: 'error descriptions' stamp: 'MFR 2/11/2021 10:13:22'!
cannotCheckOutCartWithInvalidCreditCardExpirationMonthErrorDescription

	^ '1 | Expiration month is invalid'! !

!Cart methodsFor: 'error descriptions' stamp: 'MFR 2/11/2021 09:47:30'!
cannotCheckOutCartWithInvalidCreditCardNumberErrorDescription

	^ '1 | Credit Card Number is invalid'.! !

!Cart methodsFor: 'error descriptions' stamp: 'MFR 2/11/2021 10:31:43'!
cannotCheckOutCartWithInvalidCreditCardOwnerErrorDescription

	^ '1 | Credit Card Owner`s name is above 30 characters'.! !

!Cart methodsFor: 'error descriptions' stamp: 'MFR 2/10/2021 21:57:42'!
cannotCheckOutEmptyCartErrorDescription

	^ '1 | Cart is empty'.! !


!Cart methodsFor: 'accessing' stamp: 'MFR 2/10/2021 21:02:42'!
addToCart: anElement quantity: aQuantity 
	
	self assertQuantityCanBeAddedToCart: aQuantity.
	self assertElementIsInCatalogue: anElement.

	aQuantity timesRepeat: [elements add: anElement.].! !

!Cart methodsFor: 'accessing' stamp: 'MFR 2/11/2021 10:49:15'!
checkOutCartWithCreditCardNumber: ccn validThrough: cced ownedBy: cco

	self assertCartIsNotEmpty.
	self assertCreditCardNumberIsValid: ccn.
	
	self assertCreditCardExpirationMonthIsValid: cced.
	
	self assertCreditCardDateIsValid: cced.
	self assertOwnerIsValid: cco.	

	^ 'TRANSACTION_',id! !

!Cart methodsFor: 'accessing' stamp: 'MFR 2/10/2021 19:48:32'!
has: aQuantity element: anElement 
	
	^ (elements occurrencesOf: anElement) = aQuantity.! !

!Cart methodsFor: 'accessing' stamp: 'MFR 2/10/2021 21:42:13'!
listCart

	| list index elementsSorted | 
	
	list := OrderedCollection new.
	index := 1.
	
	elementsSorted := elements sort.
	
	[ index <= elements size] whileTrue: [ | occurence element |
									element := elementsSorted at: index.
									occurence := elementsSorted occurrencesOf: element.
									list add: (element asString, ' | ', occurence asString).
									index := index + occurence.
									].
	
	^ list.! !

!Cart methodsFor: 'accessing' stamp: 'MFR 2/10/2021 19:20:35'!
quantityOfElementsInCart
	
	^ elements size! !

"-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- "!

!classDefinition: 'Cart class' category: '09-TusLibros'!
Cart class
	instanceVariableNames: ''!

!Cart class methodsFor: 'instance creation' stamp: 'EEDP 2/10/2021 18:20:19'!
id: anId password: aPassword 
	
	^self new id: anId password: aPassword elements: OrderedCollection new.! !



!classDefinition: #TusLibrosCatalogue category: '09-TusLibros'!
Object subclass: #TusLibrosCatalogue
	instanceVariableNames: 'catalogue'
	classVariableNames: ''
	poolDictionaries: ''
	category: '09-TusLibros'!

!TusLibrosCatalogue methodsFor: 'initialization' stamp: 'MFR 2/10/2021 21:11:58'!
initializeWith: aCatalogue
	
	catalogue := aCatalogue.
	
	catalogue add: '456'.
	catalogue add: '789'.! !


!TusLibrosCatalogue methodsFor: 'accessing' stamp: 'MFR 2/10/2021 21:13:08'!
bookIsInCatalogue: anElement

	^ catalogue includes: anElement.! !

"-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- "!

!classDefinition: 'TusLibrosCatalogue class' category: '09-TusLibros'!
TusLibrosCatalogue class
	instanceVariableNames: ''!

!TusLibrosCatalogue class methodsFor: 'as yet unclassified' stamp: 'MFR 2/10/2021 21:10:32'!
initialize

	^ self new initializeWith: OrderedCollection new.! !

TusLibrosCatalogue initialize!