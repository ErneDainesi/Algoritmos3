!classDefinition: #CintaAzul category: 'Factorio'!
DenotativeObject subclass: #CintaAzul
	instanceVariableNames: ''
	classVariableNames: ''
	poolDictionaries: ''
	category: 'Factorio'!

"-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- "!

!classDefinition: 'CintaAzul class' category: 'Factorio'!
CintaAzul class
	instanceVariableNames: 'destino contenido'!

!CintaAzul class methodsFor: 'as yet unclassified' stamp: 'EDP 10/25/2020 17:23:44'!
agregar: unaMena
	contenido add: unaMena.! !

!CintaAzul class methodsFor: 'as yet unclassified' stamp: 'EDP 10/25/2020 17:23:44'!
cantidadDeMenas
	^contenido size.! !

!CintaAzul class methodsFor: 'as yet unclassified' stamp: 'EDP 10/25/2020 17:23:44'!
conectarA: unDestino
	destino := unDestino.! !

!CintaAzul class methodsFor: 'as yet unclassified' stamp: 'MFR 10/28/2020 13:00:05'!
desconectar
	destino := nil.! !

!CintaAzul class methodsFor: 'as yet unclassified' stamp: 'EDP 10/28/2020 14:56:45'!
initializeCollaboratorsFromFile
	"Auto generated method for loading purposes - Do not modify it"

	destino := Contenedor.
	contenido := ((OrderedCollection new)).! !

!CintaAzul class methodsFor: 'as yet unclassified' stamp: 'EDP 10/25/2020 17:23:44'!
transportar
	(self cantidadDeMenas = 0) ifFalse: [destino agregar: contenido removeFirst].! !

!CintaAzul class methodsFor: 'as yet unclassified' stamp: 'EDP 10/25/2020 17:23:44'!
transportarTodo
	[self cantidadDeMenas  > 0] whileTrue: [destino agregar: contenido removeFirst].! !

!CintaAzul class methodsFor: 'as yet unclassified' stamp: 'EDP 10/28/2020 14:54:31'!
vaciar
	contenido := OrderedCollection new.! !


!classDefinition: #CintaRoja category: 'Factorio'!
DenotativeObject subclass: #CintaRoja
	instanceVariableNames: ''
	classVariableNames: ''
	poolDictionaries: ''
	category: 'Factorio'!

"-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- "!

!classDefinition: 'CintaRoja class' category: 'Factorio'!
CintaRoja class
	instanceVariableNames: 'destino contenido'!

!CintaRoja class methodsFor: 'as yet unclassified' stamp: 'MFR 10/25/2020 16:50:14'!
agregar: unaMena
	contenido add: unaMena.! !

!CintaRoja class methodsFor: 'as yet unclassified' stamp: 'MFR 10/25/2020 17:08:20'!
cantidadDeMenas
	^contenido size.! !

!CintaRoja class methodsFor: 'as yet unclassified' stamp: 'MFR 10/25/2020 16:34:15'!
conectarA: unDestino
	destino := unDestino.! !

!CintaRoja class methodsFor: 'as yet unclassified' stamp: 'MFR 10/28/2020 13:00:13'!
desconectar
	destino := nil.! !

!CintaRoja class methodsFor: 'as yet unclassified' stamp: 'EDP 10/28/2020 14:56:45'!
initializeCollaboratorsFromFile
	"Auto generated method for loading purposes - Do not modify it"

	destino := CintaAzul.
	contenido := ((OrderedCollection new)).! !

!CintaRoja class methodsFor: 'as yet unclassified' stamp: 'MFR 10/25/2020 17:09:41'!
transportar
	(self cantidadDeMenas = 0) ifFalse: [destino agregar: contenido removeFirst].! !

!CintaRoja class methodsFor: 'as yet unclassified' stamp: 'MFR 10/25/2020 17:15:25'!
transportarTodo
	[self cantidadDeMenas  > 0] whileTrue: [destino agregar: contenido removeFirst].! !

!CintaRoja class methodsFor: 'as yet unclassified' stamp: 'EDP 10/28/2020 14:54:52'!
vaciar
	contenido := OrderedCollection new.! !


!classDefinition: #Contenedor category: 'Factorio'!
DenotativeObject subclass: #Contenedor
	instanceVariableNames: ''
	classVariableNames: ''
	poolDictionaries: ''
	category: 'Factorio'!

"-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- "!

!classDefinition: 'Contenedor class' category: 'Factorio'!
Contenedor class
	instanceVariableNames: 'contenido'!

!Contenedor class methodsFor: 'as yet unclassified' stamp: 'MFR 10/25/2020 17:06:20'!
agregar: unaMena
	contenido add: unaMena.! !

!Contenedor class methodsFor: 'as yet unclassified' stamp: 'SF 10/23/2020 00:38:00'!
cantidadDe: unaMenaDeMuestra
	^contenido count: [:unaMena | unaMena = unaMenaDeMuestra ].! !

!Contenedor class methodsFor: 'as yet unclassified' stamp: 'SF 10/23/2020 00:38:20'!
cantidadDeMenas
	^contenido size.! !

!Contenedor class methodsFor: 'as yet unclassified' stamp: 'EDP 10/28/2020 14:56:45'!
initializeCollaboratorsFromFile
	"Auto generated method for loading purposes - Do not modify it"

	contenido := ((OrderedCollection new) add: #carbon; add: #hierro; yourself).! !

!Contenedor class methodsFor: 'as yet unclassified' stamp: 'SF 10/23/2020 00:35:51'!
vaciar
	contenido := OrderedCollection new.! !


!classDefinition: #ExtractorDeCarbon category: 'Factorio'!
DenotativeObject subclass: #ExtractorDeCarbon
	instanceVariableNames: ''
	classVariableNames: ''
	poolDictionaries: ''
	category: 'Factorio'!

"-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- "!

!classDefinition: 'ExtractorDeCarbon class' category: 'Factorio'!
ExtractorDeCarbon class
	instanceVariableNames: 'destino'!

!ExtractorDeCarbon class methodsFor: 'as yet unclassified' stamp: 'SF 10/23/2020 00:33:23'!
conectarA: unDestino
	destino := unDestino.! !

!ExtractorDeCarbon class methodsFor: 'as yet unclassified' stamp: 'MFR 10/28/2020 13:00:18'!
desconectar
	destino := nil.! !

!ExtractorDeCarbon class methodsFor: 'as yet unclassified' stamp: 'SF 10/23/2020 00:33:50'!
extraer
	destino agregar: #carbon.! !

!ExtractorDeCarbon class methodsFor: 'as yet unclassified' stamp: 'EDP 10/28/2020 14:56:45'!
initializeCollaboratorsFromFile
	"Auto generated method for loading purposes - Do not modify it"

	destino := CintaAzul.! !


!classDefinition: #ExtractorDeHierro category: 'Factorio'!
DenotativeObject subclass: #ExtractorDeHierro
	instanceVariableNames: ''
	classVariableNames: ''
	poolDictionaries: ''
	category: 'Factorio'!

"-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- "!

!classDefinition: 'ExtractorDeHierro class' category: 'Factorio'!
ExtractorDeHierro class
	instanceVariableNames: 'destino'!

!ExtractorDeHierro class methodsFor: 'as yet unclassified' stamp: 'MFR 10/25/2020 16:24:03'!
conectarA: unDestino
	destino := unDestino.! !

!ExtractorDeHierro class methodsFor: 'as yet unclassified' stamp: 'MFR 10/28/2020 13:00:24'!
desconectar
	destino := nil.! !

!ExtractorDeHierro class methodsFor: 'as yet unclassified' stamp: 'MFR 10/25/2020 16:24:30'!
extraer
	destino agregar: #hierro.! !

!ExtractorDeHierro class methodsFor: 'as yet unclassified' stamp: 'EDP 10/28/2020 14:56:45'!
initializeCollaboratorsFromFile
	"Auto generated method for loading purposes - Do not modify it"

	destino := CintaRoja.! !


!classDefinition: #FactorioTest category: 'Factorio'!
DenotativeObject subclass: #FactorioTest
	instanceVariableNames: ''
	classVariableNames: ''
	poolDictionaries: ''
	category: 'Factorio'!

"-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- "!

!classDefinition: 'FactorioTest class' category: 'Factorio'!
FactorioTest class
	instanceVariableNames: ''!

!FactorioTest class methodsFor: 'escenario 1' stamp: 'SF 10/23/2020 01:01:45'!
configurarCircuitoExtractorCaja.

	Contenedor vaciar.
	ExtractorDeCarbon conectarA: Contenedor.	
! !

!FactorioTest class methodsFor: 'escenario 1' stamp: 'SF 10/23/2020 00:55:32'!
hacerAndarCircuitoExtractorCaja

	ExtractorDeCarbon extraer.
	! !

!FactorioTest class methodsFor: 'escenario 1' stamp: 'SF 10/23/2020 00:53:55'!
test01ExtractorCaja
	self configurarCircuitoExtractorCaja.
	
	self hacerAndarCircuitoExtractorCaja.
	
	Assert that: (Contenedor cantidadDe: #carbon) isEqualTo: 1.
	Assert that: Contenedor cantidadDeMenas isEqualTo: 1.! !


!FactorioTest class methodsFor: 'escenario 2' stamp: 'EDP 10/28/2020 14:55:41'!
configurarCircuitoExtractorCintaCaja
	"Preparamos los objetos"
	Contenedor vaciar.
	CintaAzul vaciar.
	
	"Realizamos las conexiones necesarias"
	ExtractorDeCarbon conectarA: CintaAzul.
	CintaAzul conectarA: Contenedor.
! !

!FactorioTest class methodsFor: 'escenario 2' stamp: 'MFR 10/28/2020 13:01:15'!
hacerAndarCircuitoExtractorCintaCaja

	"Hacemos andar el extractor, asi deja un carbon en la cinta."
	ExtractorDeCarbon extraer.
	
	"Luego hacemos andar la cinta y deberia dejar el carbon en la caja.	"
	CintaAzul transportar.! !

!FactorioTest class methodsFor: 'escenario 2' stamp: 'MFR 10/28/2020 13:01:26'!
test02ExtractorCintaCaja
	self configurarCircuitoExtractorCintaCaja.
	
	self hacerAndarCircuitoExtractorCintaCaja.
	
	Assert that: (Contenedor cantidadDe: #carbon) isEqualTo: 1.
	Assert that: Contenedor cantidadDeMenas isEqualTo: 1.
	Assert that: CintaAzul cantidadDeMenas isEqualTo: 0.! !


!FactorioTest class methodsFor: 'escenario 3' stamp: 'EDP 10/28/2020 14:55:21'!
configurarCircuitoExtractorExtractorCintaCintaCaja

	Contenedor vaciar.
	"Adem�s de vaciar el Contenedor (arriba) tambi�n vaciamos las dos cintas"
	CintaAzul vaciar.
	CintaRoja vaciar.
	"Conectamos el extractor de carbon a una de las cintas"
	ExtractorDeCarbon conectarA: CintaAzul.
	"Conectamos el extractor de hierro a la otra cinta"
	ExtractorDeHierro conectarA: CintaRoja.
	"Ahora conectamos la primer cinta al Contenedor"
	CintaAzul conectarA: Contenedor.
	"Y conectamos la segunda cinta a la primer cinta"
	CintaRoja conectarA: CintaAzul.
	
! !

!FactorioTest class methodsFor: 'escenario 3' stamp: 'EDP 10/28/2020 14:52:57'!
hacerAndarCircuitoExtractorExtractorCintaCintaCaja
	
	"Hacemos andar el extractor, asi deja un carbon en la cinta."
	ExtractorDeCarbon extraer.
	"Lo mismo con el otro extractor, asi deja una mena de hierro en la otra cinta."
	ExtractorDeHierro extraer.
	"Hacemos andar la cinta con la mena de hierro, asi la deposita en la cinta que tiene el carbon."
	CintaRoja transportar.
	"Ahora podemos hacer andar la ultima cinta, la que recibi� primero el carbon"
	"y ahora tambien tiene el hierro y que deje todo en el Contenedor."
	CintaAzul  transportarTodo.
	
	! !

!FactorioTest class methodsFor: 'escenario 3' stamp: 'EDP 10/28/2020 14:33:08'!
test03ExtractorExtractorCintaCintaCaja
	self configurarCircuitoExtractorExtractorCintaCintaCaja.
	
	self hacerAndarCircuitoExtractorExtractorCintaCintaCaja.
	
	Assert that: (Contenedor cantidadDe: #carbon) isEqualTo: 1.
	Assert that: (Contenedor cantidadDe: #hierro) isEqualTo: 1.
	Assert that: Contenedor cantidadDeMenas isEqualTo: 2.
	"Tambien tenemos que chequear que no haya nada en las cintas"
	Assert that: CintaAzul cantidadDeMenas  isEqualTo: 0.
	Assert that: CintaRoja cantidadDeMenas  isEqualTo: 0.! !

CintaAzul initializeAfterFileIn!
CintaRoja initializeAfterFileIn!
Contenedor initializeAfterFileIn!
ExtractorDeCarbon initializeAfterFileIn!
ExtractorDeHierro initializeAfterFileIn!