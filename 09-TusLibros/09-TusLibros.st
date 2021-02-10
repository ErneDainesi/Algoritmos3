!classDefinition: #CartTests category: '09-TusLibros'!
TestCase subclass: #CartTests
	instanceVariableNames: ''
	classVariableNames: ''
	poolDictionaries: ''
	category: '09-TusLibros'!

!CartTests methodsFor: 'testing' stamp: 'EEDP 2/10/2021 18:08:30'!
test01

	| cart clientId clientPass |
	
	clientId := '123'.
	clientPass := '123'.
	cart := Cart id: clientId password: clientPass.
	
	self assert: cart elementsInCart equals: 0.! !

!CartTests methodsFor: 'testing' stamp: 'EEDP 2/10/2021 18:31:27'!
test02

	| cart clientId clientPass isbn |
	
	clientId := '123'.
	clientPass := '123'.
	cart := Cart id: clientId password: clientPass.
	isbn := '456'.
	cart addElement: isbn quantity: 1. 
	
	self assert: (cart has: 1 element: isbn).! !


!classDefinition: #Cart category: '09-TusLibros'!
Object subclass: #Cart
	instanceVariableNames: 'id password elements'
	classVariableNames: ''
	poolDictionaries: ''
	category: '09-TusLibros'!

!Cart methodsFor: 'initialization' stamp: 'EEDP 2/10/2021 18:21:16'!
id: anId password: aPassword elements: aCollection

	id := anId.
	password := aPassword.
	elements := aCollection.! !


!Cart methodsFor: 'as yet unclassified' stamp: 'EEDP 2/10/2021 18:21:37'!
elementsInCart
	
	^ elements size! !

"-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- "!

!classDefinition: 'Cart class' category: '09-TusLibros'!
Cart class
	instanceVariableNames: ''!

!Cart class methodsFor: 'instance creation' stamp: 'EEDP 2/10/2021 18:20:19'!
id: anId password: aPassword 
	
	^self new id: anId password: aPassword elements: OrderedCollection new.! !
