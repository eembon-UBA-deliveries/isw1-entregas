!classDefinition: #ImportTest category: 'CustomerImporter'!
TestCase subclass: #ImportTest
	instanceVariableNames: 'session inputStream'
	classVariableNames: ''
	poolDictionaries: ''
	category: 'CustomerImporter'!

!ImportTest methodsFor: 'as yet unclassified' stamp: 'MH 11/15/2023 13:03:33'!
assertAddress: anAddress hasStreetName: aStreetName streetNumber: aStreetNumber town: aTown zipcode: aZipCode province: aProvince    

	self assert: anAddress streetName equals: aStreetName.
	self assert: anAddress streetNumber equals: aStreetNumber.
	self assert: anAddress town equals: aTown.
	self assert: anAddress zipCode equals: aZipCode.
	self assert: anAddress province equals: aProvince.! !

!ImportTest methodsFor: 'as yet unclassified' stamp: 'MH 11/15/2023 12:56:15'!
assertCustomer: aCustomer hasFirstName: aFirstName lastName: aLastName identificationType: anIdentificationType identificationNumber: anIdentificationNumber    

	self assert: aCustomer firstName equals: aFirstName.
	self assert: aCustomer lastName equals: aLastName.
	self assert: aCustomer identificationType equals: anIdentificationType.
	self assert: aCustomer identificationNumber equals: anIdentificationNumber! !

!ImportTest methodsFor: 'as yet unclassified' stamp: 'MH 11/15/2023 13:20:25'!
assertFirstCustomerWasImportedSuccessfully

	| customers customer address |
	
	customers := self selectCustomersWithIdentificationType: 'D' identificationNumber: '22333444'.
	
	self assert: customers size equals: 1.
	
	customer := customers anyOne.

	self assertCustomer: customer hasFirstName: 'Pepe' lastName: 'Sanchez' identificationType: 'D' identificationNumber: '22333444'.
	
	self assert: customer addresses size equals: 2.

	address := (customer addresses select: [ :anAddress |
			anAddress streetName = 'San Martin']) first.

	self assertAddress: address hasStreetName: 'San Martin' streetNumber: 3322 town: 'Olivos' zipcode: 1636 province: 'BsAs'.
	
	address := (customer addresses select: [ :anAddress |
			anAddress streetName = 'Maipu']) first.
	
	self assertAddress: address hasStreetName: 'Maipu' streetNumber: 888 town: 'Florida' zipcode: 1122 province: 'Buenos Aires'.! !

!ImportTest methodsFor: 'as yet unclassified' stamp: 'MH 11/15/2023 12:50:47'!
assertNumberOfCustomers

	^ self assert: (session selectAllOfType: Customer) size equals: 2! !

!ImportTest methodsFor: 'as yet unclassified' stamp: 'MH 11/15/2023 13:20:31'!
assertSecondCustomerWasImportedSuccessfully

	| customer customers address |

	customers := self selectCustomersWithIdentificationType: 'C' identificationNumber: '23-25666777-9'.
	
	self assert: customers size equals: 1.
	
	customer := customers anyOne.

	self assertCustomer: customer hasFirstName: 'Juan' lastName: 'Perez' identificationType: 'C' identificationNumber: '23-25666777-9'.
	
	self assert: customer addresses size equals: 1.
	
	address := customer addresses anyOne.
	
	self assertAddress: address hasStreetName: 'Alem' streetNumber: 1122 town: 'CABA' zipcode: 1001 province: 'CABA'.! !

!ImportTest methodsFor: 'as yet unclassified' stamp: 'MH 11/15/2023 12:45:54'!
importCustomers
	(CustomerImporter withSession: session andInputStream: inputStream) importCustomers! !

!ImportTest methodsFor: 'as yet unclassified' stamp: 'MH 11/15/2023 13:20:25'!
selectCustomersWithIdentificationType: anIdentificationType identificationNumber: identificationNumber 

	^ session 
		select: [:aCustomer | aCustomer identificationType = anIdentificationType and: [aCustomer identificationNumber = identificationNumber]]
		ofType: Customer! !

!ImportTest methodsFor: 'as yet unclassified' stamp: 'MH 11/15/2023 12:43:29'!
setUp
	
	session := DataBaseSession for: (Array with: Address with: Customer).
	session beginTransaction.
	
	inputStream := UniFileStream new open: 'input.txt' forWrite: false.! !

!ImportTest methodsFor: 'as yet unclassified' stamp: 'MH 11/15/2023 12:43:44'!
tearDown
	
	session commit.
	session close.
	
	inputStream close.! !

!ImportTest methodsFor: 'as yet unclassified' stamp: 'MH 11/15/2023 13:12:01'!
test01Import

	self importCustomers.
	
	self assertNumberOfCustomers.

	self assertFirstCustomerWasImportedSuccessfully.
	
	self assertSecondCustomerWasImportedSuccessfully.! !


!classDefinition: #Address category: 'CustomerImporter'!
Object subclass: #Address
	instanceVariableNames: 'id streetName streetNumber town zipCode province'
	classVariableNames: ''
	poolDictionaries: ''
	category: 'CustomerImporter'!

!Address methodsFor: 'province' stamp: 'HAW 5/22/2022 00:19:29'!
province

	^province! !

!Address methodsFor: 'province' stamp: 'HAW 5/22/2022 00:19:29'!
province: aProvince

	province := aProvince
	! !


!Address methodsFor: 'street' stamp: 'HAW 5/22/2022 00:19:29'!
streetName

	^streetName ! !

!Address methodsFor: 'street' stamp: 'HAW 5/22/2022 00:19:29'!
streetName: aStreetName

	streetName := aStreetName ! !

!Address methodsFor: 'street' stamp: 'HAW 5/22/2022 00:19:29'!
streetNumber

	^streetNumber ! !

!Address methodsFor: 'street' stamp: 'HAW 5/22/2022 00:19:29'!
streetNumber: aStreetNumber

	streetNumber := aStreetNumber ! !


!Address methodsFor: 'twon' stamp: 'HAW 5/22/2022 00:19:29'!
town

	^town! !

!Address methodsFor: 'twon' stamp: 'HAW 5/22/2022 00:19:29'!
town: aTown

	town := aTown! !


!Address methodsFor: 'zip code' stamp: 'HAW 5/22/2022 00:19:29'!
zipCode

	^zipCode! !

!Address methodsFor: 'zip code' stamp: 'HAW 5/22/2022 00:19:29'!
zipCode: aZipCode

	zipCode := aZipCode! !


!classDefinition: #Customer category: 'CustomerImporter'!
Object subclass: #Customer
	instanceVariableNames: 'id firstName lastName identificationType identificationNumber addresses'
	classVariableNames: ''
	poolDictionaries: ''
	category: 'CustomerImporter'!

!Customer methodsFor: 'addresses' stamp: 'HAW 5/22/2022 00:19:29'!
addAddress: anAddress

	addresses add: anAddress ! !

!Customer methodsFor: 'addresses' stamp: 'HAW 5/22/2022 00:19:29'!
addresses

	^ addresses! !


!Customer methodsFor: 'name' stamp: 'HAW 5/22/2022 00:19:29'!
firstName

	^firstName ! !

!Customer methodsFor: 'name' stamp: 'HAW 5/22/2022 00:19:29'!
firstName: aName

	firstName := aName! !

!Customer methodsFor: 'name' stamp: 'HAW 5/22/2022 00:19:29'!
lastName

	^lastName ! !

!Customer methodsFor: 'name' stamp: 'HAW 5/22/2022 00:19:29'!
lastName: aLastName

	lastName := aLastName
! !


!Customer methodsFor: 'identification' stamp: 'HAW 5/22/2022 00:19:29'!
identificationNumber

	^identificationNumber ! !

!Customer methodsFor: 'identification' stamp: 'HAW 5/22/2022 00:19:29'!
identificationNumber: anIdentificationNumber

	identificationNumber := anIdentificationNumber! !

!Customer methodsFor: 'identification' stamp: 'HAW 5/22/2022 00:19:29'!
identificationType

	^identificationType ! !

!Customer methodsFor: 'identification' stamp: 'HAW 5/22/2022 00:19:29'!
identificationType: anIdentificationType

	identificationType := anIdentificationType! !


!Customer methodsFor: 'initialization' stamp: 'HAW 5/22/2022 00:19:29'!
initialize

	super initialize.
	addresses := OrderedCollection new.! !


!Customer methodsFor: 'as yet unclassified' stamp: 'EE 11/13/2023 21:25:32'!
= aCustomer

	^aCustomer firstName = self firstName and:
	[ aCustomer lastName = self lastName ] and:
	[ aCustomer identificationType = self identificationType ] and:
	[ aCustomer identificationNumber = self identificationNumber ]! !

"-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- "!

!classDefinition: 'Customer class' category: 'CustomerImporter'!
Customer class
	instanceVariableNames: ''!


!Customer class methodsFor: 'instance creation' stamp: 'EE 11/13/2023 21:28:42'!
forFirstName: aRenameMe1 lastName: aRenameMe2 identificationType: aRenameMe3 identificationNumber: aRenameMe4 
	"DO NOT FORGET TO RENAME COLLABORATORS AND REMOVE THIS COMMENT!!!!"
	self shouldBeImplemented.
	^self new initializeForFirstName: aRenameMe1 lastName: aRenameMe2 identificationType: aRenameMe3 identificationNumber: aRenameMe4 ! !


!classDefinition: #CustomerImporter category: 'CustomerImporter'!
Object subclass: #CustomerImporter
	instanceVariableNames: 'session inputStream'
	classVariableNames: ''
	poolDictionaries: ''
	category: 'CustomerImporter'!

!CustomerImporter methodsFor: 'initialization' stamp: 'MH 11/15/2023 12:45:54'!
initializeWithSession: aSession andInputStream: anInputStream
	session := aSession.
	inputStream := anInputStream.! !


!CustomerImporter methodsFor: 'evaluating' stamp: 'MH 11/15/2023 12:45:54'!
importCustomers

	"
	self importCustomers
	"
	| newCustomer line |
	
	line := inputStream nextLine.
	[ line notNil ] whileTrue: [
		(line beginsWith: 'C') ifTrue: [ | customerData |
			customerData := line findTokens: $,.
			newCustomer := Customer new.
			newCustomer firstName: customerData second.
			newCustomer lastName: customerData third.
			newCustomer identificationType: customerData fourth.
			newCustomer identificationNumber: customerData fifth.
			session persist: newCustomer ].

		(line beginsWith: 'A') ifTrue: [ | addressData newAddress |
			addressData := line findTokens: $,.
			newAddress := Address new.
			newCustomer addAddress: newAddress.
			newAddress streetName: addressData second.
			newAddress streetNumber: addressData third asNumber .
			newAddress town: addressData fourth.
			newAddress zipCode: addressData fifth asNumber .
			newAddress province: addressData sixth ].

		line := inputStream nextLine. ].! !

"-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- "!

!classDefinition: 'CustomerImporter class' category: 'CustomerImporter'!
CustomerImporter class
	instanceVariableNames: ''!

!CustomerImporter class methodsFor: 'instance creation' stamp: 'MH 11/15/2023 12:45:54'!
withSession: aSession andInputStream: anInputStream
	^self new initializeWithSession: aSession andInputStream: anInputStream! !


!classDefinition: #DataBaseSession category: 'CustomerImporter'!
Object subclass: #DataBaseSession
	instanceVariableNames: 'configuration tables id'
	classVariableNames: ''
	poolDictionaries: ''
	category: 'CustomerImporter'!

!DataBaseSession methodsFor: 'transaction management' stamp: 'HAW 5/22/2022 00:19:29'!
beginTransaction

	! !

!DataBaseSession methodsFor: 'transaction management' stamp: 'HAW 5/22/2022 19:17:36'!
commit

	(tables at: Customer ifAbsent: [#()]) do: [ :aCustomer | self persistAddressesOf: aCustomer ]
	! !


!DataBaseSession methodsFor: 'closing' stamp: 'HAW 5/22/2022 00:19:29'!
close

	! !


!DataBaseSession methodsFor: 'persistence - private' stamp: 'HAW 5/22/2022 00:19:29'!
defineIdOf: anObject

	anObject instVarNamed: 'id' put: (self newIdFor: anObject).! !

!DataBaseSession methodsFor: 'persistence - private' stamp: 'HAW 5/22/2022 00:19:29'!
delay

	(Delay forMilliseconds: 100) wait! !

!DataBaseSession methodsFor: 'persistence - private' stamp: 'HAW 5/22/2022 19:29:06'!
objectsOfType: aType

	^ tables at: aType ifAbsent: [ #() ]! !

!DataBaseSession methodsFor: 'persistence - private' stamp: 'HAW 5/22/2022 00:19:29'!
persistAddressesOf: anObjectWithAddresses

	anObjectWithAddresses addresses do: [ :anAddress | self persist: anAddress ]
	! !


!DataBaseSession methodsFor: 'initialization' stamp: 'HAW 5/22/2022 00:19:29'!
initializeFor: aConfiguration

	configuration := aConfiguration.
	tables := Dictionary new.
	id := 0.! !


!DataBaseSession methodsFor: 'id' stamp: 'HAW 5/22/2022 00:19:29'!
newIdFor: anObject

	id := id + 1.
	^id! !


!DataBaseSession methodsFor: 'persistance' stamp: 'HAW 5/22/2022 00:19:29'!
persist: anObject

	| table |

	self delay.
	table := tables at: anObject class ifAbsentPut: [ Set new ].

	self defineIdOf: anObject.
	table add: anObject.

	(anObject isKindOf: Customer) ifTrue: [ self persistAddressesOf: anObject ].! !


!DataBaseSession methodsFor: 'selecting' stamp: 'HAW 5/22/2022 19:29:06'!
select: aCondition ofType: aType

	self delay.
	^(self objectsOfType: aType) select: aCondition ! !

!DataBaseSession methodsFor: 'selecting' stamp: 'HAW 5/22/2022 19:29:06'!
selectAllOfType: aType

	self delay.
	^(self objectsOfType: aType) copy ! !

"-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- "!

!classDefinition: 'DataBaseSession class' category: 'CustomerImporter'!
DataBaseSession class
	instanceVariableNames: ''!

!DataBaseSession class methodsFor: 'instance creation' stamp: 'HAW 5/22/2022 00:19:29'!
for: aConfiguration

	^self new initializeFor: aConfiguration! !
