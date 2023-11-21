!classDefinition: #PersistentSet category: 'CustomerImporter'!
Set subclass: #PersistentSet
	instanceVariableNames: 'session'
	classVariableNames: ''
	poolDictionaries: ''
	category: 'CustomerImporter'!

!PersistentSet methodsFor: 'initialization' stamp: 'HAW 11/14/2023 08:25:31'!
initializeOn: aSession from: aNonPersistentSet

	session := aSession.
	self addAll: aNonPersistentSet ! !


!PersistentSet methodsFor: 'adding' stamp: 'MH 11/16/2023 21:22:33'!
add: newObject

	super add: newObject.
	session addCustomer: newObject.
	
	^newObject! !

"-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- "!

!classDefinition: 'PersistentSet class' category: 'CustomerImporter'!
PersistentSet class
	instanceVariableNames: ''!

!PersistentSet class methodsFor: 'instance creation' stamp: 'HAW 11/14/2023 08:24:32'!
on: aSession

	^self on: aSession from: #()! !

!PersistentSet class methodsFor: 'instance creation' stamp: 'HAW 11/14/2023 08:25:00'!
on: aSession from: aNonPersistentSet

	^self new initializeOn: aSession from: aNonPersistentSet
! !


!classDefinition: #ImportTest category: 'CustomerImporter'!
TestCase subclass: #ImportTest
	instanceVariableNames: 'customerSystem'
	classVariableNames: ''
	poolDictionaries: ''
	category: 'CustomerImporter'!

!ImportTest methodsFor: 'tests' stamp: 'MH 11/20/2023 23:36:34'!
test01ImportValidData

	CustomerImporter valueFrom: self validImportData into: customerSystem.

	self assertImportedRightNumberOfCustomers.
	self assertPepeSanchezWasImportedCorrecty.
	self assertJuanPerezWasImportedCorrectly.! !

!ImportTest methodsFor: 'tests' stamp: 'MH 11/20/2023 23:08:53'!
test02ImportInvalidDataMissingFieldsInCustomer

	self
		shouldFailImporting: self invalidImportDataMissingFieldsInCustomer
		messageText: CustomerImporter missingFieldsInCustomerErrorDescription
		asserting: [ self assertNoCustomerWasImported ]! !

!ImportTest methodsFor: 'tests' stamp: 'MH 11/20/2023 23:09:49'!
test03ImportInvalidDataExtraFieldsInCustomer

	self
		shouldFailImporting: self invalidImportDataExtraFieldsInCustomer
		messageText: CustomerImporter extraFieldsInCustomerErrorDescription
		asserting: [ self assertNoCustomerWasImported ]! !

!ImportTest methodsFor: 'tests' stamp: 'MH 11/20/2023 23:16:58'!
test04ImportInvalidDataMissingFieldsInAddress

	self
		shouldFailImporting: self invalidImportDataMissingFieldsInAddress
		messageText: CustomerImporter missingFieldsInAddressErrorDescription
		asserting: [ self assert: (customerSystem customerWithIdentificationType: 'D' number: '22333444') addresses size equals: 0 ]! !

!ImportTest methodsFor: 'tests' stamp: 'MH 11/20/2023 23:17:13'!
test05ImportInvalidDataExtraFieldsInAddress

	self
		shouldFailImporting: self invalidImportDataExtraFieldsInAddress
		messageText: CustomerImporter extraFieldsInAddressErrorDescription
		asserting: [ self assert: (customerSystem customerWithIdentificationType: 'D' number: '22333444') addresses size equals: 0 ]! !

!ImportTest methodsFor: 'tests' stamp: 'MH 11/20/2023 23:12:20'!
test06ImportInvalidDataFirstLineIsNotACustomer

	self
		shouldFailImporting: self invalidImportDataFirstLineIsNotACustomer
		messageText: CustomerImporter firstLineIsNotACustomerErrorDescription
		asserting: [ self assertNoCustomerWasImported ]! !

!ImportTest methodsFor: 'tests' stamp: 'MH 11/20/2023 23:12:48'!
test07ImportInvalidDataEmptyLine

	self
		shouldFailImporting: self invalidImportDataEmptyLine
		messageText: CustomerImporter emptyLineErrorDescription
		asserting: [ self assertNoCustomerWasImported ]! !

!ImportTest methodsFor: 'tests' stamp: 'MH 11/20/2023 23:13:04'!
test08ImportInvalidDataUnknownLineIdentifier

	self
		shouldFailImporting: self invalidImportDataUnknownLineIdentifier
		messageText: CustomerImporter unknownLineIdentifierErrorDescription
		asserting: [ self assertNoCustomerWasImported ]! !

!ImportTest methodsFor: 'tests' stamp: 'MH 11/20/2023 23:13:23'!
test09ImportInvalidDataIdentifierShouldBeValidAndNotPrefixOfValid

	self
		shouldFailImporting: self invalidImportDataIdentifierShouldBeValidAndNotPrefixOfValid
		messageText: CustomerImporter unknownLineIdentifierErrorDescription
		asserting: [ self assertNoCustomerWasImported ]! !


!ImportTest methodsFor: 'assertions' stamp: 'HAW 5/22/2022 18:22:05'!
assertAddressOf: importedCustomer at: aStreetName hasNumber: aNumber town: aTown zipCode: aZipCode province: aProvince

	| importedAddress |

	importedAddress := importedCustomer addressAt: aStreetName ifNone: [ self fail ].
	self assert: aStreetName equals: importedAddress streetName.
	self assert: aNumber equals: importedAddress streetNumber.
	self assert: aTown equals: importedAddress town.
	self assert: aZipCode equals: importedAddress zipCode.
	self assert: aProvince equals: importedAddress province.

	! !

!ImportTest methodsFor: 'assertions' stamp: 'MH 11/16/2023 21:28:08'!
assertCustomerWithIdentificationType: anIdType number: anIdNumber hasFirstName: aFirstName lastName: aLastName

	| importedCustomer |

	importedCustomer := customerSystem customerWithIdentificationType: anIdType number: anIdNumber.

	self assert: aFirstName equals: importedCustomer firstName.
	self assert: aLastName equals: importedCustomer lastName.
	self assert: anIdType equals: importedCustomer identificationType.
	self assert: anIdNumber equals: importedCustomer identificationNumber.

	^importedCustomer

	! !

!ImportTest methodsFor: 'assertions' stamp: 'MH 11/20/2023 23:19:11'!
assertImportedRightNumberOfCustomers

	^ self assert: 2 equals: (customerSystem numberOfCustomers)! !

!ImportTest methodsFor: 'assertions' stamp: 'HAW 5/22/2022 18:28:45'!
assertJuanPerezWasImportedCorrectly

	| importedCustomer |

	importedCustomer := self assertCustomerWithIdentificationType: 'C' number: '23-25666777-9' hasFirstName: 'Juan' lastName: 'Perez'.
	self assertAddressOf: importedCustomer at: 'Alem' hasNumber: 1122 town: 'CABA' zipCode: 1001 province: 'CABA'
	! !

!ImportTest methodsFor: 'assertions' stamp: 'MH 11/20/2023 23:19:18'!
assertNoCustomerWasImported

	self assert: (customerSystem numberOfCustomers) equals: 0! !

!ImportTest methodsFor: 'assertions' stamp: 'HAW 5/22/2022 18:28:05'!
assertPepeSanchezWasImportedCorrecty

	| importedCustomer |

	importedCustomer := self assertCustomerWithIdentificationType: 'D' number: '22333444' hasFirstName: 'Pepe' lastName: 'Sanchez'.
	self assertAddressOf: importedCustomer at: 'San Martin' hasNumber: 3322 town: 'Olivos' zipCode: 1636 province: 'BsAs'.
	self assertAddressOf: importedCustomer at: 'Maipu' hasNumber: 888 town: 'Florida' zipCode: 1122 province: 'Buenos Aires'.


	! !

!ImportTest methodsFor: 'assertions' stamp: 'MH 11/20/2023 23:07:09'!
shouldFailImporting: aReadStream messageText: anErrorMessageText asserting: anAssertionBlock

	self
		should: [ CustomerImporter valueFrom: aReadStream into: customerSystem ]
		raise: Error - MessageNotUnderstood
		withExceptionDo: [ :anError |
			self assert: anError messageText equals: anErrorMessageText.
			anAssertionBlock value ]! !


!ImportTest methodsFor: 'setUp/tearDown' stamp: 'MH 11/20/2023 23:23:33'!
setUp

	customerSystem := Environment createSystem.
	customerSystem start.
	customerSystem beginTransaction.! !

!ImportTest methodsFor: 'setUp/tearDown' stamp: 'MH 11/16/2023 21:04:12'!
tearDown

	customerSystem commit.
	customerSystem close.
	! !


!ImportTest methodsFor: 'test data' stamp: 'MH 11/16/2023 19:53:42'!
invalidImportDataEmptyLine

	^ ReadStream on:
'
C,Pepe,Sanchez,D,22333444
A,San Martin,3322,Olivos,1636,BsAs
A,Maipu,888,Florida,1122,Buenos Aires
C,Juan,Perez,C,23-25666777-9
A,Alem,1122,CABA,1001,CABA'! !

!ImportTest methodsFor: 'test data' stamp: 'MH 11/16/2023 19:38:05'!
invalidImportDataExtraFieldsInAddress

	^ ReadStream on:
'C,Pepe,Sanchez,D,22333444
A,San Martin,3322,Olivos,1636,BsAs,x
A,Maipu,888,Florida,1122,Buenos Aires
C,Juan,Perez,C,23-25666777-9
A,Alem,1122,CABA,1001,CABA'! !

!ImportTest methodsFor: 'test data' stamp: 'MH 11/16/2023 19:30:31'!
invalidImportDataExtraFieldsInCustomer

	^ ReadStream on:
'C,Pepe,Sanchez,D,22333444,x
A,San Martin,3322,Olivos,1636,BsAs
A,Maipu,888,Florida,1122,Buenos Aires
C,Juan,Perez,C,23-25666777-9
A,Alem,1122,CABA,1001,CABA'! !

!ImportTest methodsFor: 'test data' stamp: 'MH 11/16/2023 19:45:07'!
invalidImportDataFirstLineIsNotACustomer

	^ ReadStream on:
'A,San Martin,3322,Olivos,1636,BsAs
A,Maipu,888,Florida,1122,Buenos Aires
C,Juan,Perez,C,23-25666777-9
A,Alem,1122,CABA,1001,CABA'! !

!ImportTest methodsFor: 'test data' stamp: 'MH 11/16/2023 20:15:53'!
invalidImportDataIdentifierShouldBeValidAndNotPrefixOfValid

	^ ReadStream on:
'CC,Pepe,Sanchez,D,22333444
A,San Martin,3322,Olivos,1636,BsAs
A,Maipu,888,Florida,1122,Buenos Aires
C,Juan,Perez,C,23-25666777-9
A,Alem,1122,CABA,1001,CABA'! !

!ImportTest methodsFor: 'test data' stamp: 'MH 11/16/2023 19:36:10'!
invalidImportDataMissingFieldsInAddress

	^ ReadStream on:
'C,Pepe,Sanchez,D,22333444
A,San Martin,3322,Olivos,1636
A,Maipu,888,Florida,1122,Buenos Aires
C,Juan,Perez,C,23-25666777-9
A,Alem,1122,CABA,1001,CABA'! !

!ImportTest methodsFor: 'test data' stamp: 'MH 11/16/2023 19:21:05'!
invalidImportDataMissingFieldsInCustomer

	^ ReadStream on:
'C,Pepe,Sanchez,D
A,San Martin,3322,Olivos,1636,BsAs
A,Maipu,888,Florida,1122,Buenos Aires
C,Juan,Perez,C,23-25666777-9
A,Alem,1122,CABA,1001,CABA'! !

!ImportTest methodsFor: 'test data' stamp: 'MH 11/16/2023 20:05:31'!
invalidImportDataUnknownLineIdentifier

	^ ReadStream on:
'X,Pepe,Sanchez,D,22333444
A,San Martin,3322,Olivos,1636,BsAs
A,Maipu,888,Florida,1122,Buenos Aires
C,Juan,Perez,C,23-25666777-9
A,Alem,1122,CABA,1001,CABA'! !

!ImportTest methodsFor: 'test data' stamp: 'HAW 5/22/2022 18:08:08'!
validImportData

	^ ReadStream on:
'C,Pepe,Sanchez,D,22333444
A,San Martin,3322,Olivos,1636,BsAs
A,Maipu,888,Florida,1122,Buenos Aires
C,Juan,Perez,C,23-25666777-9
A,Alem,1122,CABA,1001,CABA'! !


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


!Address methodsFor: 'street' stamp: 'HAW 5/22/2022 17:55:46'!
isAt: aStreetName

	^streetName = aStreetName ! !

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

!Customer methodsFor: 'addresses' stamp: 'HAW 5/22/2022 17:55:17'!
addressAt: aStreetName ifNone: aNoneBlock

	^addresses detect: [ :address | address isAt: aStreetName ] ifNone: aNoneBlock ! !

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


!classDefinition: #CustomerImporter category: 'CustomerImporter'!
Object subclass: #CustomerImporter
	instanceVariableNames: 'readStream line inputData newCustomer customerSystem'
	classVariableNames: ''
	poolDictionaries: ''
	category: 'CustomerImporter'!

!CustomerImporter methodsFor: 'initialization' stamp: 'MH 11/16/2023 21:09:07'!
initializeFrom: aReadStream into: aCustomerSystem
	customerSystem := aCustomerSystem.
	readStream := aReadStream.! !


!CustomerImporter methodsFor: 'evaluating' stamp: 'MH 11/16/2023 19:29:27'!
dataNeedsToBeProcessed

	line := readStream nextLine.
	^line notNil! !

!CustomerImporter methodsFor: 'evaluating' stamp: 'MH 11/16/2023 20:16:19'!
inputDataIsACustomer

	^ inputData first = 'C'! !

!CustomerImporter methodsFor: 'evaluating' stamp: 'MH 11/16/2023 20:16:29'!
inputDataIsAnAddress

	^ inputData first = 'A'! !

!CustomerImporter methodsFor: 'evaluating' stamp: 'MH 11/16/2023 20:40:47'!
parseAddress

	| newAddress |

	(inputData size < 6) ifTrue: [ self error: self class missingFieldsInAddressErrorDescription ].
	(inputData size > 6) ifTrue: [ self error: self class extraFieldsInAddressErrorDescription ].
	newCustomer ifNil: [ self error: self class firstLineIsNotACustomerErrorDescription ].
	newAddress := Address new.
	newCustomer addAddress: newAddress.
	newAddress streetName: inputData second.
	newAddress streetNumber: inputData third asNumber .
	newAddress town: inputData fourth.
	newAddress zipCode: inputData fifth asNumber .
	newAddress province: inputData sixth! !

!CustomerImporter methodsFor: 'evaluating' stamp: 'MH 11/16/2023 21:22:33'!
parseCustomer

	(inputData size < 5) ifTrue: [ self error: self class missingFieldsInCustomerErrorDescription ].
	(inputData size > 5) ifTrue: [ self error: self class extraFieldsInCustomerErrorDescription ].
	newCustomer := Customer new.
	newCustomer firstName: inputData second.
	newCustomer lastName: inputData third.
	newCustomer identificationType: inputData fourth.
	newCustomer identificationNumber: inputData fifth.
	customerSystem addCustomer: newCustomer.! !

!CustomerImporter methodsFor: 'evaluating' stamp: 'MH 11/16/2023 20:08:43'!
parseData

	(self inputDataIsACustomer) ifTrue: [ ^self parseCustomer ].
	(self inputDataIsAnAddress) ifTrue: [ ^self parseAddress ].
	self error: self class unknownLineIdentifierErrorDescription.! !

!CustomerImporter methodsFor: 'evaluating' stamp: 'MH 11/16/2023 19:55:43'!
processData

	inputData := line findTokens: $,.
	(inputData isEmpty) ifTrue: [ self error: self class emptyLineErrorDescription ].! !

!CustomerImporter methodsFor: 'evaluating' stamp: 'MH 11/16/2023 19:19:01'!
value

	[ self dataNeedsToBeProcessed ] whileTrue: [
		self processData.
		self parseData.
	].! !

"-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- "!

!classDefinition: 'CustomerImporter class' category: 'CustomerImporter'!
CustomerImporter class
	instanceVariableNames: ''!

!CustomerImporter class methodsFor: 'instance creation' stamp: 'MH 11/16/2023 21:08:56'!
from: aReadStream into: aCustomerSystem
	^self new initializeFrom: aReadStream into: aCustomerSystem! !


!CustomerImporter class methodsFor: 'importing' stamp: 'HAW 5/22/2022 18:11:27'!
valueFrom: aReadStream into: aSession

	^(self from: aReadStream into: aSession) value! !


!CustomerImporter class methodsFor: 'error descriptions' stamp: 'MH 11/16/2023 19:54:26'!
emptyLineErrorDescription

	^'Empty line'! !

!CustomerImporter class methodsFor: 'error descriptions' stamp: 'MH 11/16/2023 19:37:42'!
extraFieldsInAddressErrorDescription

	^'Extra fields in address'! !

!CustomerImporter class methodsFor: 'error descriptions' stamp: 'MH 11/16/2023 19:31:38'!
extraFieldsInCustomerErrorDescription

	^'Extra fields in customer'! !

!CustomerImporter class methodsFor: 'error descriptions' stamp: 'MH 11/16/2023 19:44:33'!
firstLineIsNotACustomerErrorDescription

	^'First line is not a customer'! !

!CustomerImporter class methodsFor: 'error descriptions' stamp: 'MH 11/16/2023 19:34:29'!
missingFieldsInAddressErrorDescription

	^'Missing fields in address'! !

!CustomerImporter class methodsFor: 'error descriptions' stamp: 'MH 11/16/2023 19:26:57'!
missingFieldsInCustomerErrorDescription

	^'Missing fields in customer'! !

!CustomerImporter class methodsFor: 'error descriptions' stamp: 'MH 11/16/2023 20:06:52'!
unknownLineIdentifierErrorDescription

	^'Unknown line identifier'! !


!classDefinition: #CustomerSystem category: 'CustomerImporter'!
Object subclass: #CustomerSystem
	instanceVariableNames: ''
	classVariableNames: ''
	poolDictionaries: ''
	category: 'CustomerImporter'!

!CustomerSystem methodsFor: 'closing' stamp: 'MH 11/20/2023 23:32:26'!
close

	self subclassResponsibility! !


!CustomerSystem methodsFor: 'initialization' stamp: 'MH 11/20/2023 23:32:41'!
start

	self subclassResponsibility! !


!CustomerSystem methodsFor: 'persistance' stamp: 'MH 11/20/2023 23:32:18'!
addCustomer: aCustomer

	self subclassResponsibility! !


!CustomerSystem methodsFor: 'selecting' stamp: 'MH 11/20/2023 23:32:33'!
customerWithIdentificationType: anIdType number: anIdNumber

	self subclassResponsibility! !

!CustomerSystem methodsFor: 'selecting' stamp: 'MH 11/20/2023 23:32:36'!
numberOfCustomers

	self subclassResponsibility! !


!CustomerSystem methodsFor: 'transaction management' stamp: 'MH 11/20/2023 23:32:22'!
beginTransaction

	self subclassResponsibility! !

!CustomerSystem methodsFor: 'transaction management' stamp: 'MH 11/20/2023 23:32:30'!
commit

	self subclassResponsibility! !


!classDefinition: #PersistentCustomerSystem category: 'CustomerImporter'!
CustomerSystem subclass: #PersistentCustomerSystem
	instanceVariableNames: 'session'
	classVariableNames: ''
	poolDictionaries: ''
	category: 'CustomerImporter'!

!PersistentCustomerSystem methodsFor: 'closing' stamp: 'MH 11/16/2023 21:04:26'!
close

	session close! !


!PersistentCustomerSystem methodsFor: 'initialization' stamp: 'MH 11/16/2023 21:25:42'!
start

	session := DataBaseSession for: (Array with: Address with: Customer)! !


!PersistentCustomerSystem methodsFor: 'persistance' stamp: 'MH 11/16/2023 21:22:42'!
addCustomer: aCustomer

	session persist: aCustomer! !


!PersistentCustomerSystem methodsFor: 'selecting' stamp: 'MH 11/16/2023 21:26:59'!
customerWithIdentificationType: anIdType number: anIdNumber

	^ (session
		select: [ :aCustomer | aCustomer identificationType = anIdType and: [ aCustomer identificationNumber = anIdNumber ]]
		ofType: Customer) anyOne! !

!PersistentCustomerSystem methodsFor: 'selecting' stamp: 'MH 11/20/2023 23:18:57'!
numberOfCustomers

	^(session selectAllOfType: Customer) size! !


!PersistentCustomerSystem methodsFor: 'transaction management' stamp: 'MH 11/16/2023 21:00:44'!
beginTransaction

	session beginTransaction! !

!PersistentCustomerSystem methodsFor: 'transaction management' stamp: 'MH 11/16/2023 21:04:21'!
commit

	session commit! !

"-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- "!

!classDefinition: 'PersistentCustomerSystem class' category: 'CustomerImporter'!
PersistentCustomerSystem class
	instanceVariableNames: 'session'!


!classDefinition: #TransientCustomerSystem category: 'CustomerImporter'!
CustomerSystem subclass: #TransientCustomerSystem
	instanceVariableNames: 'customers'
	classVariableNames: ''
	poolDictionaries: ''
	category: 'CustomerImporter'!

!TransientCustomerSystem methodsFor: 'closing' stamp: 'MH 11/20/2023 23:21:58'!
close! !


!TransientCustomerSystem methodsFor: 'initialization' stamp: 'MH 11/16/2023 21:41:04'!
start

	customers := Set new! !


!TransientCustomerSystem methodsFor: 'persistance' stamp: 'MH 11/16/2023 21:41:49'!
addCustomer: aNewCustomer 

	customers add: aNewCustomer! !


!TransientCustomerSystem methodsFor: 'selecting' stamp: 'MH 11/20/2023 23:21:29'!
customerWithIdentificationType: anIdType number: anIdNumber 

	^customers detect: [ :aCustomer | aCustomer identificationType = anIdType and: [ aCustomer identificationNumber = anIdNumber ] ]! !

!TransientCustomerSystem methodsFor: 'selecting' stamp: 'MH 11/20/2023 23:19:48'!
numberOfCustomers

	^customers size! !


!TransientCustomerSystem methodsFor: 'transaction management' stamp: 'MH 11/16/2023 21:41:29'!
beginTransaction! !

!TransientCustomerSystem methodsFor: 'transaction management' stamp: 'MH 11/20/2023 23:21:48'!
commit! !


!classDefinition: #DataBaseSession category: 'CustomerImporter'!
Object subclass: #DataBaseSession
	instanceVariableNames: 'configuration tables id inTransaction closed'
	classVariableNames: ''
	poolDictionaries: ''
	category: 'CustomerImporter'!

!DataBaseSession methodsFor: 'transaction management' stamp: 'HAW 11/14/2023 08:52:25'!
beginTransaction

	inTransaction := true.! !

!DataBaseSession methodsFor: 'transaction management' stamp: 'HAW 11/14/2023 08:52:18'!
commit

	inTransaction := false.! !


!DataBaseSession methodsFor: 'closing' stamp: 'HAW 11/14/2023 08:52:30'!
close

	closed := true.! !


!DataBaseSession methodsFor: 'persistence - private' stamp: 'HAW 11/14/2023 08:49:30'!
assertCanUseDatabase

	self assertIsOpen.
	self assertInTransaction ! !

!DataBaseSession methodsFor: 'persistence - private' stamp: 'HAW 11/14/2023 08:48:43'!
assertInTransaction

	inTransaction ifFalse: [ self error: 'Not in transaction' ].! !

!DataBaseSession methodsFor: 'persistence - private' stamp: 'HAW 11/14/2023 08:48:16'!
assertIsOpen

	closed ifTrue: [ self error: 'Connection with database closed' ].! !

!DataBaseSession methodsFor: 'persistence - private' stamp: 'HAW 11/14/2023 09:09:07'!
assertTypeIsPersisted: aType

	(configuration includes: aType) ifFalse: [ self error: 'Object of type ', aType name, ' are not configured to be persisted' ].! !

!DataBaseSession methodsFor: 'persistence - private' stamp: 'HAW 5/22/2022 00:19:29'!
defineIdOf: anObject

	anObject instVarNamed: 'id' put: (self newIdFor: anObject).! !

!DataBaseSession methodsFor: 'persistence - private' stamp: 'HAW 5/22/2022 00:19:29'!
delay

	(Delay forMilliseconds: 100) wait! !

!DataBaseSession methodsFor: 'persistence - private' stamp: 'HAW 11/14/2023 08:58:59'!
isRelationToPersist: possibleRelation

	^ possibleRelation class = Set! !

!DataBaseSession methodsFor: 'persistence - private' stamp: 'HAW 11/14/2023 08:58:59'!
persistPossibleRelationOf: anObject at: anInstVarOffset

	| possibleRelation |
		
	possibleRelation := anObject instVarAt: anInstVarOffset.
	(self isRelationToPersist: possibleRelation) ifTrue: [ self persistRelationOf: anObject at: anInstVarOffset with: possibleRelation ]! !

!DataBaseSession methodsFor: 'persistence - private' stamp: 'HAW 11/14/2023 08:58:03'!
persistRelationOf: anObject at: anInstVarOffset with: aRelation

	| persistentRelation |
	
	persistentRelation := PersistentSet on: self from: aRelation.
	anObject instVarAt: anInstVarOffset put: persistentRelation! !

!DataBaseSession methodsFor: 'persistence - private' stamp: 'HAW 11/14/2023 08:58:34'!
persistRelationsOf: anObject

	anObject class instVarNamesAndOffsetsDo: [ :anInstVarName :anInstVarOffset | self persistPossibleRelationOf: anObject at: anInstVarOffset]! !

!DataBaseSession methodsFor: 'persistence - private' stamp: 'HAW 11/14/2023 09:06:24'!
tableOfType: aType

	^ tables at: aType ifAbsentPut: [ Set new ]! !


!DataBaseSession methodsFor: 'initialization' stamp: 'HAW 11/14/2023 08:44:19'!
initializeFor: aConfiguration

	configuration := aConfiguration.
	tables := Dictionary new.
	id := 0.
	inTransaction := false.
	closed := false.! !


!DataBaseSession methodsFor: 'id' stamp: 'HAW 5/22/2022 00:19:29'!
newIdFor: anObject

	id := id + 1.
	^id! !


!DataBaseSession methodsFor: 'persistance' stamp: 'HAW 11/14/2023 09:06:24'!
persist: anObject

	| table |

	self assertCanUseDatabase.
	self assertTypeIsPersisted: anObject class.
	self delay.
	
	table := self tableOfType: anObject class.
	self defineIdOf: anObject.
	table add: anObject.
	self persistRelationsOf: anObject.
! !


!DataBaseSession methodsFor: 'selecting' stamp: 'HAW 11/14/2023 09:06:56'!
select: aCondition ofType: aType

	self assertCanUseDatabase.
	self assertTypeIsPersisted: aType.
	self delay.
	
	^(self tableOfType: aType) select: aCondition ! !

!DataBaseSession methodsFor: 'selecting' stamp: 'HAW 11/14/2023 09:07:12'!
selectAllOfType: aType

	self assertCanUseDatabase.
	self assertTypeIsPersisted: aType.
	self delay.
	
	^(self tableOfType: aType) copy ! !

"-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- "!

!classDefinition: 'DataBaseSession class' category: 'CustomerImporter'!
DataBaseSession class
	instanceVariableNames: ''!

!DataBaseSession class methodsFor: 'instance creation' stamp: 'HAW 5/22/2022 00:19:29'!
for: aConfiguration

	^self new initializeFor: aConfiguration! !


!classDefinition: #Environment category: 'CustomerImporter'!
Object subclass: #Environment
	instanceVariableNames: ''
	classVariableNames: ''
	poolDictionaries: ''
	category: 'CustomerImporter'!

"-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- "!

!classDefinition: 'Environment class' category: 'CustomerImporter'!
Environment class
	instanceVariableNames: ''!

!Environment class methodsFor: 'evaluating' stamp: 'MH 11/20/2023 23:26:14'!
isCurrent

	self subclassResponsibility! !


!Environment class methodsFor: 'initialization' stamp: 'MH 11/20/2023 23:28:06'!
createSystem

	^(self allSubclasses detect: [ :aSubclass | aSubclass isCurrent ]) createSystem! !


!classDefinition: #DevelopmentEnvironment category: 'CustomerImporter'!
Environment subclass: #DevelopmentEnvironment
	instanceVariableNames: ''
	classVariableNames: ''
	poolDictionaries: ''
	category: 'CustomerImporter'!

"-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- "!

!classDefinition: 'DevelopmentEnvironment class' category: 'CustomerImporter'!
DevelopmentEnvironment class
	instanceVariableNames: ''!

!DevelopmentEnvironment class methodsFor: 'evaluating' stamp: 'MH 11/20/2023 23:29:52'!
isCurrent

	^(Smalltalk at: #ENV) = 'DEV'! !


!DevelopmentEnvironment class methodsFor: 'initialization' stamp: 'MH 11/20/2023 23:26:45'!
createSystem

	^TransientCustomerSystem new! !


!classDefinition: #IntegrationEnvironment category: 'CustomerImporter'!
Environment subclass: #IntegrationEnvironment
	instanceVariableNames: ''
	classVariableNames: ''
	poolDictionaries: ''
	category: 'CustomerImporter'!

"-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- "!

!classDefinition: 'IntegrationEnvironment class' category: 'CustomerImporter'!
IntegrationEnvironment class
	instanceVariableNames: ''!

!IntegrationEnvironment class methodsFor: 'evaluating' stamp: 'MH 11/20/2023 23:30:04'!
isCurrent

	^(Smalltalk at: #ENV) = 'INT'! !


!IntegrationEnvironment class methodsFor: 'initialization' stamp: 'MH 11/20/2023 23:27:01'!
createSystem

	^PersistentCustomerSystem new! !
