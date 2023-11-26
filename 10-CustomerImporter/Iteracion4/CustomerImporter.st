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


!PersistentSet methodsFor: 'adding' stamp: 'HAW 11/14/2023 08:23:40'!
add: newObject

	super add: newObject.
	session persist: newObject.
	
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
	instanceVariableNames: 'system'
	classVariableNames: ''
	poolDictionaries: ''
	category: 'CustomerImporter'!

!ImportTest methodsFor: 'tests - supplier' stamp: 'MH 11/26/2023 16:52:59'!
test01SupplierImportsCorrectly

	| supplier |

	SupplierImporter valueFrom: (self supplierData) into: system.

	self assert: system numberOfSuppliers equals: 1.
	
	supplier := self assertSupplierWithIdentificationType: 'D' number: '123' hasName: 'Supplier1'.
	self assert: (supplier isAddressesEmpty).
	self assert: (supplier isCustomersEmpty).! !

!ImportTest methodsFor: 'tests - supplier' stamp: 'MH 11/26/2023 16:46:28'!
test02NewCustomerImportsCorrectly

	| supplier |
	
	SupplierImporter valueFrom: (self supplierWithNewCustomerImportData) into: system.
	
	supplier := system supplierWithIdentificationType: 'D' number: '123'. 
	self assertCustomerOf: supplier hasIdentificationType: 'D' number: '22333444' hasFirstName: 'Pepe' lastName: 'Sanchez'.
	self assertCustomerWithIdentificationType: 'D' number: '22333444' hasFirstName: 'Pepe' lastName: 'Sanchez'.! !

!ImportTest methodsFor: 'tests - supplier' stamp: 'MH 11/26/2023 16:47:01'!
test03ExistingCustomerImportsCorrectly

	| supplier |

	CustomerImporter valueFrom: (self existingCustomerData) into: system.
	SupplierImporter valueFrom: (self supplierWithExistingCustomerImportData) into: system .
	
	supplier := system supplierWithIdentificationType: 'D' number: '123'. 
	self assertCustomerOf: supplier hasIdentificationType: 'D' number: '5456774' hasFirstName: 'Pepe' lastName: 'Sanchez'.! !

!ImportTest methodsFor: 'tests - supplier' stamp: 'MH 11/26/2023 16:47:27'!
test04AddressImportsCorrectly

	| supplier |
	
	SupplierImporter valueFrom: (self supplierWithAddressImportData) into: system.
	
	supplier := system supplierWithIdentificationType: 'D' number: '123'. 
	self assertAddressOf: supplier at: 'San Martin' hasNumber: 3322 town: 'Olivos' zipCode: 1636 province: 'BsAs'.! !

!ImportTest methodsFor: 'tests - supplier' stamp: 'MH 11/26/2023 17:23:22'!
test05CanNotImportAddressWithoutSupplier

	self
		shouldFailImportingSuppliersFrom: self addressWithoutSupplierData
		messageText: SupplierImporter canNotImportAddressWithoutSupplierErrorDescription
		asserting: [ self assertNoSupplierWasImported ].! !

!ImportTest methodsFor: 'tests - supplier' stamp: 'MH 11/26/2023 17:24:05'!
test06CanNotImportExistingCustomerThatDoesNotExist

	self
		shouldFailImportingSuppliersFrom: self existingCustomerThatDoesNotExistData
		messageText: SupplierImporter existingCustomerThatDoesNotExistErrorDescription
		asserting: [ self assertNoCustomerWasImported ].! !

!ImportTest methodsFor: 'tests - supplier' stamp: 'MH 11/26/2023 17:24:31'!
test07CanNotImportNewCustomerRecordWithLessThanFiveFields

	self
		shouldFailImportingSuppliersFrom: self newCustomerRecordWithLessThanFiveFields
		messageText: SupplierImporter invalidNewCustomerRecordErrorDescription
		asserting: [ self assertNoCustomerWasImported ]! !

!ImportTest methodsFor: 'tests - supplier' stamp: 'MH 11/26/2023 17:25:38'!
test08CanNotImportNewCustomerRecordWithMoreThanFiveFields

	self
		shouldFailImportingSuppliersFrom: self newCustomerRecordWithMoreThanFiveFields
		messageText: SupplierImporter invalidNewCustomerRecordErrorDescription
		asserting: [ self assertNoCustomerWasImported ]! !

!ImportTest methodsFor: 'tests - supplier' stamp: 'MH 11/26/2023 17:28:11'!
test09CanNotImportExistingCustomerRecordWithLessThanThreeFields

	self
		shouldFailImportingSuppliersFrom: self existingCustomerRecordWithLessThanThreeFields
		messageText: SupplierImporter invalidExistingCustomerRecordErrorDescription
		asserting: [ self assertNoCustomerWasImported ]! !

!ImportTest methodsFor: 'tests - supplier' stamp: 'MH 11/26/2023 17:31:13'!
test10CanNotImportExistingCustomerRecordWithMoreThanThreeFields

	self
		shouldFailImportingSuppliersFrom: self existingCustomerRecordWithMoreThanThreeFields
		messageText: SupplierImporter invalidExistingCustomerRecordErrorDescription
		asserting: [ self assertNoCustomerWasImported ]! !


!ImportTest methodsFor: 'tests' stamp: 'HAW 5/22/2022 21:15:52'!
test01ValidDataIsImportedCorrectly

	CustomerImporter valueFrom: self validImportData into: system..

	self assertImportedRightNumberOfCustomers.
	self assertPepeSanchezWasImportedCorrecty.
	self assertJuanPerezWasImportedCorrectly ! !

!ImportTest methodsFor: 'tests' stamp: 'HAW 5/22/2022 21:15:52'!
test02CanNotImportAddressWithoutCustomer

	self
		should: [ CustomerImporter valueFrom: self addressWithoutCustomerData into: system. ]
		raise: Error - MessageNotUnderstood
		withMessageText: CustomerImporter canNotImportAddressWithoutCustomerErrorDescription

	! !

!ImportTest methodsFor: 'tests' stamp: 'HAW 5/22/2022 19:56:58'!
test03DoesNotImportRecordsStartingWithCButMoreCharacters

	self
		shouldFailImporting: self invalidCustomerRecordStartData
		messageText: CustomerImporter invalidRecordTypeErrorDescription
		asserting: [ self assertNoCustomerWasImported ]

	! !

!ImportTest methodsFor: 'tests' stamp: 'HAW 5/22/2022 19:49:03'!
test04DoesNotImportRecordsStartingWithAButMoreCharacters

	self
		shouldFailImporting: self invalidAddressRecordStartData
		messageText: CustomerImporter invalidRecordTypeErrorDescription
		asserting: [ self assertImportedOneCustomerWithoutAddress ]

	! !

!ImportTest methodsFor: 'tests' stamp: 'HAW 5/22/2022 19:49:36'!
test05CanNotImportAddressRecordWithLessThanSixFields

	self
		shouldFailImporting: self addressRecordWithLessThanSixFields
		messageText: CustomerImporter invalidAddressRecordErrorDescription
		asserting: [ self assertImportedOneCustomerWithoutAddress ]

	! !

!ImportTest methodsFor: 'tests' stamp: 'HAW 5/22/2022 19:51:14'!
test06CanNotImportAddressRecordWithMoreThanSixFields

	self
		shouldFailImporting: self addressRecordWithMoreThanSixFields
		messageText: CustomerImporter invalidAddressRecordErrorDescription
		asserting: [ self assertImportedOneCustomerWithoutAddress ]

	! !

!ImportTest methodsFor: 'tests' stamp: 'HAW 5/22/2022 19:56:58'!
test07CanNotImportCustomerRecordWithLessThanFiveFields

	self
		shouldFailImporting: self customerRecordWithLessThanFiveFields
		messageText: CustomerImporter invalidCustomerRecordErrorDescription
		asserting: [ self assertNoCustomerWasImported ]

	! !

!ImportTest methodsFor: 'tests' stamp: 'HAW 5/22/2022 19:56:58'!
test08CanNotImportCustomerRecordWithMoreThanFiveFields

	self
		shouldFailImporting: self customerRecordWithMoreThanFiveFields
		messageText: CustomerImporter invalidCustomerRecordErrorDescription
		asserting: [ self assertNoCustomerWasImported ]

	! !

!ImportTest methodsFor: 'tests' stamp: 'HAW 5/22/2022 20:01:43'!
test09CannotImportEmptyLine

	self
		shouldFailImporting: self emptyLine
		messageText: CustomerImporter invalidRecordTypeErrorDescription
		asserting: [ self assertNoCustomerWasImported ]

	! !


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

!ImportTest methodsFor: 'assertions' stamp: 'MH 11/26/2023 16:55:42'!
assertCustomerOf: importedSupplier hasIdentificationType: anIdType number: anIdNumber hasFirstName: aFirstName lastName: aLastName

	| importedCustomer |

	importedCustomer := importedSupplier customerWithIdentificationType: anIdType number: anIdNumber ifNone: [ self fail ].

	self assert: aFirstName equals: importedCustomer firstName.
	self assert: aLastName equals: importedCustomer lastName.
	self assert: (importedCustomer isIdentifiedAs: anIdType numbered: anIdNumber).

	^importedCustomer! !

!ImportTest methodsFor: 'assertions' stamp: 'MH 11/26/2023 16:55:58'!
assertCustomerWithIdentificationType: anIdType number: anIdNumber hasFirstName: aFirstName lastName: aLastName

	| importedCustomer |

	importedCustomer := system customerWithIdentificationType: anIdType number: anIdNumber.

	self assert: aFirstName equals: importedCustomer firstName.
	self assert: aLastName equals: importedCustomer lastName.
	self assert: (importedCustomer isIdentifiedAs: anIdType numbered: anIdNumber).

	^importedCustomer

	! !

!ImportTest methodsFor: 'assertions' stamp: 'HAW 5/22/2022 21:34:37'!
assertImportedOneCustomerWithoutAddress

	| importedCustomer |

	self assert: 1 equals: system numberOfCustomers.
	importedCustomer := system customerWithIdentificationType: 'D' number: '22333444'.
	self assert: importedCustomer isAddressesEmpty
	! !

!ImportTest methodsFor: 'assertions' stamp: 'HAW 5/22/2022 21:33:18'!
assertImportedRightNumberOfCustomers

	^ self assert: 2 equals: system numberOfCustomers! !

!ImportTest methodsFor: 'assertions' stamp: 'HAW 5/22/2022 18:28:45'!
assertJuanPerezWasImportedCorrectly

	| importedCustomer |

	importedCustomer := self assertCustomerWithIdentificationType: 'C' number: '23-25666777-9' hasFirstName: 'Juan' lastName: 'Perez'.
	self assertAddressOf: importedCustomer at: 'Alem' hasNumber: 1122 town: 'CABA' zipCode: 1001 province: 'CABA'
	! !

!ImportTest methodsFor: 'assertions' stamp: 'HAW 5/22/2022 21:33:24'!
assertNoCustomerWasImported

	^ self assert: 0 equals: system numberOfCustomers! !

!ImportTest methodsFor: 'assertions' stamp: 'MH 11/26/2023 17:22:15'!
assertNoSupplierWasImported

	^ self assert: 0 equals: system numberOfSuppliers! !

!ImportTest methodsFor: 'assertions' stamp: 'HAW 5/22/2022 18:28:05'!
assertPepeSanchezWasImportedCorrecty

	| importedCustomer |

	importedCustomer := self assertCustomerWithIdentificationType: 'D' number: '22333444' hasFirstName: 'Pepe' lastName: 'Sanchez'.
	self assertAddressOf: importedCustomer at: 'San Martin' hasNumber: 3322 town: 'Olivos' zipCode: 1636 province: 'BsAs'.
	self assertAddressOf: importedCustomer at: 'Maipu' hasNumber: 888 town: 'Florida' zipCode: 1122 province: 'Buenos Aires'.


	! !

!ImportTest methodsFor: 'assertions' stamp: 'MH 11/26/2023 16:52:40'!
assertSupplierWithIdentificationType: anIdType number: anIdNumber hasName: aName

	| importedSupplier |

	importedSupplier := system supplierWithIdentificationType: anIdType number: anIdNumber.

	self assert: (importedSupplier isIdentifiedAs: anIdType numbered: anIdNumber).
	self assert: (importedSupplier isNamed: aName).

	^importedSupplier! !

!ImportTest methodsFor: 'assertions' stamp: 'MH 11/26/2023 17:15:18'!
shouldFailImporting: aReadStream messageText: anErrorMessageText asserting: anAssertionBlock

	self
		should: [ CustomerImporter valueFrom: aReadStream into: system. ]
		raise: Error - MessageNotUnderstood
		withExceptionDo: [ :anError |
			self assert: anError messageText equals: anErrorMessageText.
			anAssertionBlock value ]

	! !

!ImportTest methodsFor: 'assertions' stamp: 'MH 11/26/2023 17:20:38'!
shouldFailImportingSuppliersFrom: aReadStream messageText: anErrorMessageText asserting: anAssertionBlock

	self
		should: [ SupplierImporter valueFrom: aReadStream into: system. ]
		raise: Error - MessageNotUnderstood
		withExceptionDo: [ :anError |
			self assert: anError messageText equals: anErrorMessageText.
			anAssertionBlock value ]

	! !


!ImportTest methodsFor: 'setUp/tearDown' stamp: 'HAW 5/22/2022 21:36:16'!
setUp

	system := Environment current createCustomerSystem.
	system start.
	system beginTransaction.
! !

!ImportTest methodsFor: 'setUp/tearDown' stamp: 'HAW 5/22/2022 20:12:16'!
tearDown

	system commit.
	system stop
	! !


!ImportTest methodsFor: 'test data' stamp: 'HAW 5/22/2022 19:41:20'!
addressRecordWithLessThanSixFields

	^ReadStream on: 'C,Pepe,Sanchez,D,22333444
A,San Martin,3322,Olivos,1636'! !

!ImportTest methodsFor: 'test data' stamp: 'HAW 5/22/2022 19:51:35'!
addressRecordWithMoreThanSixFields

	^ReadStream on: 'C,Pepe,Sanchez,D,22333444
A,San Martin,3322,Olivos,1636,BsAs,x'! !

!ImportTest methodsFor: 'test data' stamp: 'HAW 5/22/2022 19:14:13'!
addressWithoutCustomerData

	^ReadStream on: 'A,San Martin,3322,Olivos,1636,BsAs'! !

!ImportTest methodsFor: 'test data' stamp: 'EE 11/23/2023 20:48:25'!
addressWithoutSupplierData

	^ReadStream on: 'A,San Martin,3322,Olivos,1636,BsAs'! !

!ImportTest methodsFor: 'test data' stamp: 'HAW 5/22/2022 19:53:41'!
customerRecordWithLessThanFiveFields

	^ReadStream on: 'C,Pepe,Sanchez,D'! !

!ImportTest methodsFor: 'test data' stamp: 'HAW 5/22/2022 19:55:59'!
customerRecordWithMoreThanFiveFields

	^ReadStream on: 'C,Pepe,Sanchez,D,22333444,x'! !

!ImportTest methodsFor: 'test data' stamp: 'HAW 5/22/2022 20:02:57'!
emptyLine

	^ReadStream on: '
'! !

!ImportTest methodsFor: 'test data' stamp: 'MH 11/26/2023 16:44:09'!
existingCustomerData

	^ ReadStream on: 'C,Pepe,Sanchez,D,5456774'! !

!ImportTest methodsFor: 'test data' stamp: 'MH 11/26/2023 17:28:58'!
existingCustomerRecordWithLessThanThreeFields

	^ReadStream on: 'S,Supplier1,D,123
EC,D'! !

!ImportTest methodsFor: 'test data' stamp: 'MH 11/26/2023 17:31:40'!
existingCustomerRecordWithMoreThanThreeFields

	^ReadStream on: 'S,Supplier1,D,123
EC,D,5456774,x'! !

!ImportTest methodsFor: 'test data' stamp: 'MH 11/26/2023 15:53:03'!
existingCustomerThatDoesNotExistData

	^ReadStream on:
'S,Supplier1,D,123
EC,D,5456774'! !

!ImportTest methodsFor: 'test data' stamp: 'HAW 5/22/2022 19:34:25'!
invalidAddressRecordStartData

	^ReadStream on: 'C,Pepe,Sanchez,D,22333444
AA,San Martin,3322,Olivos,1636,BsAs'! !

!ImportTest methodsFor: 'test data' stamp: 'HAW 5/22/2022 19:22:55'!
invalidCustomerRecordStartData

	^ReadStream on: 'CC,Pepe,Sanchez,D,22333444'! !

!ImportTest methodsFor: 'test data' stamp: 'MH 11/26/2023 17:16:26'!
newCustomerRecordWithLessThanFiveFields

	^ReadStream on: 'S,Supplier1,D,123
NC,Pepe,Sanchez,D'! !

!ImportTest methodsFor: 'test data' stamp: 'MH 11/26/2023 17:26:17'!
newCustomerRecordWithMoreThanFiveFields

	^ReadStream on: 'S,Supplier1,D,123
NC,Pepe,Sanchez,D,22333444,x'! !

!ImportTest methodsFor: 'test data' stamp: 'MH 11/26/2023 16:40:27'!
supplierData

	^ ReadStream on: 'S,Supplier1,D,123'! !

!ImportTest methodsFor: 'test data' stamp: 'MH 11/26/2023 16:45:59'!
supplierWithAddressImportData

	^ ReadStream on:
'S,Supplier1,D,123
NC,Pepe,Sanchez,D,22333444
A,San Martin,3322,Olivos,1636,BsAs'! !

!ImportTest methodsFor: 'test data' stamp: 'MH 11/26/2023 16:47:01'!
supplierWithExistingCustomerImportData

	^ ReadStream  on:
'S,Supplier1,D,123
EC,D,5456774'! !

!ImportTest methodsFor: 'test data' stamp: 'MH 11/26/2023 16:46:28'!
supplierWithNewCustomerImportData

	^ ReadStream on:
'S,Supplier1,D,123
NC,Pepe,Sanchez,D,22333444'.! !

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


!classDefinition: #AddressImporter category: 'CustomerImporter'!
Object subclass: #AddressImporter
	instanceVariableNames: 'csvImporter'
	classVariableNames: ''
	poolDictionaries: ''
	category: 'CustomerImporter'!

!AddressImporter methodsFor: 'initialization' stamp: 'EE 11/23/2023 20:32:43'!
initializeFor: aCSVImporter

	csvImporter := aCSVImporter! !


!AddressImporter methodsFor: 'assertions' stamp: 'EE 11/23/2023 20:34:15'!
assertPartyWasImported

	^ csvImporter party ifNil: [ self error: self canNotImportAddressWithoutPartyErrorDescription ]! !

!AddressImporter methodsFor: 'assertions' stamp: 'EE 11/23/2023 20:15:23'!
assertValidAddressRecord: aRecord

	^ aRecord size ~= 6 ifTrue: [ self error: self class invalidAddressRecordErrorDescription ]! !


!AddressImporter methodsFor: 'evaluating' stamp: 'EE 11/23/2023 20:34:05'!
importAddressFromRecord: aRecord

	| newAddress |

	self assertPartyWasImported.
	self assertValidAddressRecord: aRecord.

	newAddress := Address new.
	csvImporter party addAddress: newAddress.
	newAddress streetName: aRecord second.
	newAddress streetNumber: aRecord third asNumber .
	newAddress town: aRecord fourth.
	newAddress zipCode: aRecord fifth asNumber .
	newAddress province: aRecord sixth.! !


!AddressImporter methodsFor: 'error messages' stamp: 'EE 11/23/2023 20:34:31'!
canNotImportAddressWithoutPartyErrorDescription

	^csvImporter class canNotImportAddressWithoutPartyErrorDescription! !

"-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- "!

!classDefinition: 'AddressImporter class' category: 'CustomerImporter'!
AddressImporter class
	instanceVariableNames: ''!

!AddressImporter class methodsFor: 'error messages' stamp: 'EE 11/23/2023 20:16:22'!
invalidAddressRecordErrorDescription

	^'Address record has to have six fields'! !


!AddressImporter class methodsFor: 'instance creation' stamp: 'EE 11/23/2023 20:32:24'!
for: aCSVImporter

	^self new initializeFor: aCSVImporter! !


!classDefinition: #CSVImporter category: 'CustomerImporter'!
Object subclass: #CSVImporter
	instanceVariableNames: 'readStream system record line'
	classVariableNames: ''
	poolDictionaries: ''
	category: 'CustomerImporter'!

!CSVImporter methodsFor: 'initialization' stamp: 'EE 11/23/2023 18:33:56'!
initializeFrom: aReadStream into: aCustomerSystem

	readStream := aReadStream.
	system := aCustomerSystem ! !


!CSVImporter methodsFor: 'evaluating' stamp: 'EE 11/23/2023 18:34:01'!
value

	[ self hasLineToImport ] whileTrue: [
		self createRecord.
		self importRecord ].

	! !


!CSVImporter methodsFor: 'evaluating - private' stamp: 'EE 11/23/2023 18:34:15'!
assertRecordNotEmpty

	record isEmpty ifTrue: [ self error: self class invalidRecordTypeErrorDescription ]! !

!CSVImporter methodsFor: 'evaluating - private' stamp: 'EE 11/23/2023 18:34:19'!
createRecord

	^ record := line findTokens: $,! !

!CSVImporter methodsFor: 'evaluating - private' stamp: 'EE 11/23/2023 18:34:22'!
hasLineToImport

	line := readStream nextLine.
	^line notNil! !

!CSVImporter methodsFor: 'evaluating - private' stamp: 'EE 11/23/2023 19:09:54'!
importRecord

	self subclassResponsibility! !


!CSVImporter methodsFor: 'error handling - private' stamp: 'EE 11/23/2023 20:33:00'!
party

	self subclassResponsibility! !

"-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- "!

!classDefinition: 'CSVImporter class' category: 'CustomerImporter'!
CSVImporter class
	instanceVariableNames: ''!

!CSVImporter class methodsFor: 'instance creation' stamp: 'EE 11/23/2023 19:06:40'!
from: aReadStream into: aCustomerSystem

	^self new initializeFrom: aReadStream into: aCustomerSystem! !


!CSVImporter class methodsFor: 'error messages' stamp: 'EE 11/23/2023 19:06:46'!
invalidRecordTypeErrorDescription

	^'Invalid record type'! !


!CSVImporter class methodsFor: 'importing' stamp: 'EE 11/23/2023 19:06:49'!
valueFrom: aReadStream into: aCustomerSystem

	^(self from: aReadStream into: aCustomerSystem) value! !


!classDefinition: #CustomerImporter category: 'CustomerImporter'!
CSVImporter subclass: #CustomerImporter
	instanceVariableNames: 'newCustomer'
	classVariableNames: ''
	poolDictionaries: ''
	category: 'CustomerImporter'!

!CustomerImporter methodsFor: 'customer' stamp: 'HAW 5/22/2022 19:59:39'!
assertValidCustomerRecord

	^ record size ~= 5 ifTrue: [ self error: self class invalidCustomerRecordErrorDescription ]! !

!CustomerImporter methodsFor: 'customer' stamp: 'MH 11/26/2023 16:29:28'!
importCustomer

	self assertValidCustomerRecord.

	newCustomer := Customer new.
	newCustomer firstName: record second.
	newCustomer lastName: record third.
	newCustomer identificationType: record fourth.
	newCustomer identificationNumber: record fifth.
	system addCustomer: newCustomer! !

!CustomerImporter methodsFor: 'customer' stamp: 'HAW 5/22/2022 19:23:55'!
isCustomerRecord

	^ record first = 'C'! !


!CustomerImporter methodsFor: 'address' stamp: 'EE 11/23/2023 20:36:34'!
importAddress
	
	(AddressImporter for: self) importAddressFromRecord: record! !

!CustomerImporter methodsFor: 'address' stamp: 'HAW 5/22/2022 19:37:45'!
isAddressRecord

	^ record first = 'A'! !


!CustomerImporter methodsFor: 'evaluating - private' stamp: 'EE 11/23/2023 19:09:54'!
importRecord

	self assertRecordNotEmpty.

	self isCustomerRecord ifTrue: [ ^self importCustomer ].
	self isAddressRecord ifTrue: [ ^self importAddress ].

	self error: self class invalidRecordTypeErrorDescription! !


!CustomerImporter methodsFor: 'error handling - private' stamp: 'EE 11/23/2023 20:33:21'!
party

	^newCustomer! !

"-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- "!

!classDefinition: 'CustomerImporter class' category: 'CustomerImporter'!
CustomerImporter class
	instanceVariableNames: ''!

!CustomerImporter class methodsFor: 'error messages' stamp: 'EE 11/23/2023 20:35:54'!
canNotImportAddressWithoutCustomerErrorDescription

	^'Cannot import address without customer'! !

!CustomerImporter class methodsFor: 'error messages' stamp: 'EE 11/23/2023 20:37:15'!
canNotImportAddressWithoutPartyErrorDescription

	^self canNotImportAddressWithoutCustomerErrorDescription! !

!CustomerImporter class methodsFor: 'error messages' stamp: 'EE 11/23/2023 20:22:29'!
invalidAddressRecordErrorDescription

	^AddressImporter invalidAddressRecordErrorDescription! !

!CustomerImporter class methodsFor: 'error messages' stamp: 'HAW 5/22/2022 19:53:56'!
invalidCustomerRecordErrorDescription

	^'Invalid Customer record'! !


!classDefinition: #SupplierImporter category: 'CustomerImporter'!
CSVImporter subclass: #SupplierImporter
	instanceVariableNames: 'newSupplier'
	classVariableNames: ''
	poolDictionaries: ''
	category: 'CustomerImporter'!

!SupplierImporter methodsFor: 'address' stamp: 'EE 11/23/2023 20:36:26'!
importAddress

	(AddressImporter for: self) importAddressFromRecord: record! !

!SupplierImporter methodsFor: 'address' stamp: 'EE 11/23/2023 19:28:50'!
isAddressRecord

	^ record first = 'A'! !


!SupplierImporter methodsFor: 'new customer' stamp: 'MH 11/26/2023 17:26:47'!
assertValidNewCustomerRecord

	^ record size ~= 5 ifTrue: [ self error: self class invalidNewCustomerRecordErrorDescription ]! !

!SupplierImporter methodsFor: 'new customer' stamp: 'MH 11/26/2023 17:10:34'!
importNewCustomer

	| newCustomer |
	
	self assertValidNewCustomerRecord.

	newCustomer := Customer new.
	newSupplier addCustomer: newCustomer.
	newCustomer firstName: record second.
	newCustomer lastName: record third.
	newCustomer identificationType: record fourth.
	newCustomer identificationNumber: record fifth.
	
	system addCustomer: newCustomer! !

!SupplierImporter methodsFor: 'new customer' stamp: 'EE 11/23/2023 18:50:21'!
isNewCustomerRecord

	^ record first = 'NC'! !


!SupplierImporter methodsFor: 'existing customer' stamp: 'MH 11/26/2023 16:12:22'!
assertExistingCustomerExists

	(system existsCustomerWithIdentificationType: (record second) number: (record third)) ifFalse: [ self error: self class existingCustomerThatDoesNotExistErrorDescription ]! !

!SupplierImporter methodsFor: 'existing customer' stamp: 'MH 11/26/2023 17:32:03'!
assertValidExistingCustomerRecord

	^ record size ~= 3 ifTrue: [ self error: self class invalidExistingCustomerRecordErrorDescription ]! !

!SupplierImporter methodsFor: 'existing customer' stamp: 'MH 11/26/2023 17:30:17'!
importExistingCustomer

	| newCustomer |
	
	self assertValidExistingCustomerRecord.
	self assertExistingCustomerExists.

	newCustomer := system customerWithIdentificationType: record second number: record third.

	newSupplier addCustomer: newCustomer.! !

!SupplierImporter methodsFor: 'existing customer' stamp: 'EE 11/23/2023 19:18:19'!
isExistingCustomerRecord

	^ record first = 'EC'! !


!SupplierImporter methodsFor: 'evaluating - private' stamp: 'EE 11/23/2023 19:28:05'!
importRecord

	self isSupplierRecord ifTrue: [ ^self importSupplier ].
	self isNewCustomerRecord ifTrue: [ ^self importNewCustomer ].
	self isExistingCustomerRecord ifTrue: [ ^self importExistingCustomer ].
	self isAddressRecord ifTrue: [ ^self importAddress ].! !


!SupplierImporter methodsFor: 'supplier' stamp: 'EE 11/23/2023 18:53:53'!
importSupplier

	newSupplier := Supplier new.
	newSupplier name: record second.
	newSupplier identificationType: record third.
	newSupplier identificationNumber: record fourth.
	system addSupplier: newSupplier! !

!SupplierImporter methodsFor: 'supplier' stamp: 'EE 11/23/2023 18:11:06'!
isSupplierRecord

	^ record first = 'S'! !


!SupplierImporter methodsFor: 'error handling - private' stamp: 'EE 11/23/2023 20:33:31'!
party

	^newSupplier! !

"-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- "!

!classDefinition: 'SupplierImporter class' category: 'CustomerImporter'!
SupplierImporter class
	instanceVariableNames: ''!

!SupplierImporter class methodsFor: 'error messages' stamp: 'EE 11/23/2023 20:47:18'!
canNotImportAddressWithoutPartyErrorDescription

	^self canNotImportAddressWithoutSupplierErrorDescription! !

!SupplierImporter class methodsFor: 'error messages' stamp: 'EE 11/23/2023 20:47:35'!
canNotImportAddressWithoutSupplierErrorDescription

	^'Cannot import address without supplier'! !

!SupplierImporter class methodsFor: 'error messages' stamp: 'MH 11/26/2023 15:54:11'!
existingCustomerThatDoesNotExistErrorDescription

	^'Can not add an existing customer that does not exist'! !

!SupplierImporter class methodsFor: 'error messages' stamp: 'MH 11/26/2023 17:29:46'!
invalidExistingCustomerRecordErrorDescription

	^'Invalid existing Customer record'! !

!SupplierImporter class methodsFor: 'error messages' stamp: 'MH 11/26/2023 17:19:24'!
invalidNewCustomerRecordErrorDescription

	^'Invalid new Customer record'! !


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

!Environment methodsFor: 'customer system' stamp: 'HAW 5/22/2022 21:41:06'!
createCustomerSystem

	self subclassResponsibility ! !

"-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- "!

!classDefinition: 'Environment class' category: 'CustomerImporter'!
Environment class
	instanceVariableNames: ''!

!Environment class methodsFor: 'current' stamp: 'HAW 5/22/2022 21:37:10'!
current

	^(self subclasses detect: [ :anEnvironmentClass | anEnvironmentClass isCurrent ]) new! !

!Environment class methodsFor: 'current' stamp: 'HAW 11/23/2023 16:44:46'!
environmentKey

	^ #ENV! !

!Environment class methodsFor: 'current' stamp: 'HAW 11/23/2023 16:44:46'!
environmentVariable

	^ Smalltalk at: self environmentKey! !

!Environment class methodsFor: 'current' stamp: 'HAW 11/23/2023 16:44:09'!
identifier

	self subclassResponsibility! !

!Environment class methodsFor: 'current' stamp: 'HAW 5/22/2022 21:41:36'!
isCurrent

	self subclassResponsibility ! !

!Environment class methodsFor: 'current' stamp: 'HAW 11/23/2023 16:46:01'!
makeCurrent

	"
	Tener en cuenta que en Smalltalk se podría poner directamente la clase de environment,
	esto es DevelopmentEnvironment o IntegrationEnvironmet o hasta una instancia de ellas,
	pero se está simulando el hecho de que esto esté definido por fuera del sistema, como una
	variable del sistema operativo - Hernan"
	
	Smalltalk at: self environmentKey put: self identifier! !


!classDefinition: #DevelopmentEnvironment category: 'CustomerImporter'!
Environment subclass: #DevelopmentEnvironment
	instanceVariableNames: ''
	classVariableNames: ''
	poolDictionaries: ''
	category: 'CustomerImporter'!

!DevelopmentEnvironment methodsFor: 'customer system' stamp: 'MH 11/26/2023 16:36:24'!
createCustomerSystem

	^TransientPartySystem new! !

"-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- "!

!classDefinition: 'DevelopmentEnvironment class' category: 'CustomerImporter'!
DevelopmentEnvironment class
	instanceVariableNames: ''!

!DevelopmentEnvironment class methodsFor: 'current' stamp: 'HAW 11/23/2023 16:42:50'!
identifier

	^ #DEV! !

!DevelopmentEnvironment class methodsFor: 'current' stamp: 'HAW 11/23/2023 16:43:52'!
isCurrent

	"
	self makeCurrent
	"
	^self environmentVariable = self identifier! !


!classDefinition: #IntegrationEnvironment category: 'CustomerImporter'!
Environment subclass: #IntegrationEnvironment
	instanceVariableNames: ''
	classVariableNames: ''
	poolDictionaries: ''
	category: 'CustomerImporter'!

!IntegrationEnvironment methodsFor: 'customer system' stamp: 'MH 11/26/2023 16:36:12'!
createCustomerSystem

	^PersistentPartySystem new! !

"-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- "!

!classDefinition: 'IntegrationEnvironment class' category: 'CustomerImporter'!
IntegrationEnvironment class
	instanceVariableNames: ''!

!IntegrationEnvironment class methodsFor: 'current' stamp: 'HAW 11/23/2023 16:43:07'!
identifier

	^ #INT! !

!IntegrationEnvironment class methodsFor: 'current' stamp: 'HAW 11/23/2023 16:44:04'!
isCurrent

	"
	self makeCurrent
	"
	^self environmentVariable = self identifier! !


!classDefinition: #Party category: 'CustomerImporter'!
Object subclass: #Party
	instanceVariableNames: 'addresses identificationNumber identificationType id'
	classVariableNames: ''
	poolDictionaries: ''
	category: 'CustomerImporter'!

!Party methodsFor: 'addresses' stamp: 'EE 11/23/2023 19:57:47'!
addAddress: anAddress

	addresses add: anAddress ! !

!Party methodsFor: 'addresses' stamp: 'EE 11/23/2023 19:57:52'!
addressAt: aStreetName ifNone: aNoneBlock

	^addresses detect: [ :address | address isAt: aStreetName ] ifNone: aNoneBlock ! !

!Party methodsFor: 'addresses' stamp: 'EE 11/23/2023 19:57:55'!
addresses

	^ addresses! !

!Party methodsFor: 'addresses' stamp: 'EE 11/23/2023 19:58:14'!
isAddressesEmpty

	^addresses isEmpty ! !


!Party methodsFor: 'initialization' stamp: 'EE 11/23/2023 19:58:23'!
initialize

	super initialize.
	addresses := OrderedCollection new.! !


!Party methodsFor: 'identification' stamp: 'EE 11/23/2023 20:02:12'!
identificationNumber: anIdentificationNumber

	identificationNumber := anIdentificationNumber! !

!Party methodsFor: 'identification' stamp: 'EE 11/23/2023 20:02:19'!
identificationType: anIdentificationType

	identificationType := anIdentificationType! !

!Party methodsFor: 'identification' stamp: 'MH 11/26/2023 16:58:53'!
isIdentifiedAs: anIDType numbered: anIDNumber 
	^identificationType = anIDType and: [ identificationNumber = anIDNumber ]! !


!classDefinition: #Customer category: 'CustomerImporter'!
Party subclass: #Customer
	instanceVariableNames: 'firstName lastName'
	classVariableNames: ''
	poolDictionaries: ''
	category: 'CustomerImporter'!

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


!classDefinition: #Supplier category: 'CustomerImporter'!
Party subclass: #Supplier
	instanceVariableNames: 'name customers'
	classVariableNames: ''
	poolDictionaries: ''
	category: 'CustomerImporter'!

!Supplier methodsFor: 'customers' stamp: 'EE 11/23/2023 18:54:17'!
addCustomer: aNewCustomer
	customers add: aNewCustomer! !

!Supplier methodsFor: 'customers' stamp: 'MH 11/26/2023 16:56:38'!
customerWithIdentificationType: anIdType number: anIdNumber ifNone: aNoneBlock 

	^customers detect: [ :customer | customer isIdentifiedAs: anIdType numbered: anIdNumber ] ifNone: aNoneBlock ! !

!Supplier methodsFor: 'customers' stamp: 'EE 11/23/2023 19:59:49'!
isCustomersEmpty
	^customers isEmpty ! !


!Supplier methodsFor: 'name' stamp: 'EE 11/23/2023 20:01:26'!
isNamed: aName
	^name = aName
	! !

!Supplier methodsFor: 'name' stamp: 'EE 11/23/2023 18:20:45'!
name: aName
	name := aName .! !


!Supplier methodsFor: 'initialization' stamp: 'EE 11/23/2023 18:54:55'!
initialize

	super initialize.
	customers := OrderedCollection new.! !


!classDefinition: #PartySystem category: 'CustomerImporter'!
Object subclass: #PartySystem
	instanceVariableNames: ''
	classVariableNames: ''
	poolDictionaries: ''
	category: 'CustomerImporter'!

!PartySystem methodsFor: 'customers' stamp: 'MH 11/26/2023 16:29:27'!
addCustomer: aCustomer

	self subclassResponsibility ! !

!PartySystem methodsFor: 'customers' stamp: 'HAW 5/22/2022 21:18:38'!
customerWithIdentificationType: anIdType number: anIdNumber

	self subclassResponsibility ! !

!PartySystem methodsFor: 'customers' stamp: 'MH 11/26/2023 16:59:33'!
filterBlockForPartysOfType: anIdType number: anIdNumber

	^ [ :aParty | aParty isIdentifiedAs: anIdType numbered: anIdNumber ]! !

!PartySystem methodsFor: 'customers' stamp: 'HAW 5/22/2022 21:18:51'!
numberOfCustomers

	self subclassResponsibility ! !


!PartySystem methodsFor: 'transactions' stamp: 'HAW 5/22/2022 21:18:04'!
beginTransaction

	self subclassResponsibility ! !

!PartySystem methodsFor: 'transactions' stamp: 'HAW 5/22/2022 21:18:16'!
commit

	self subclassResponsibility ! !


!PartySystem methodsFor: 'system lifecycle' stamp: 'HAW 5/22/2022 21:18:10'!
start

	self subclassResponsibility ! !

!PartySystem methodsFor: 'system lifecycle' stamp: 'HAW 5/22/2022 21:18:13'!
stop

	self subclassResponsibility ! !


!PartySystem methodsFor: 'suppliers' stamp: 'MH 11/26/2023 16:35:05'!
addSupplier: aNewSupplier

	self subclassResponsibility! !

!PartySystem methodsFor: 'suppliers' stamp: 'MH 11/26/2023 16:35:13'!
numberOfSuppliers

	self subclassResponsibility! !

!PartySystem methodsFor: 'suppliers' stamp: 'MH 11/26/2023 16:35:18'!
supplierWithIdentificationType: anIdType number: anIdNumber

	self subclassResponsibility! !


!classDefinition: #PersistentPartySystem category: 'CustomerImporter'!
PartySystem subclass: #PersistentPartySystem
	instanceVariableNames: 'session'
	classVariableNames: ''
	poolDictionaries: ''
	category: 'CustomerImporter'!

!PersistentPartySystem methodsFor: 'customers' stamp: 'MH 11/26/2023 16:29:27'!
addCustomer: aCustomer

	^session persist: aCustomer ! !

!PersistentPartySystem methodsFor: 'customers' stamp: 'MH 11/26/2023 16:59:58'!
customerWithIdentificationType: anIdType number: anIdNumber

	^(session
		select: (self filterBlockForPartysOfType: anIdType number: anIdNumber)
		ofType: Customer) anyOne! !

!PersistentPartySystem methodsFor: 'customers' stamp: 'MH 11/26/2023 17:00:12'!
existsCustomerWithIdentificationType: anIdType number: anIdNumber

	^(session
		select: (self filterBlockForPartysOfType: anIdType number: anIdNumber)
		ofType: Customer) isEmpty not! !

!PersistentPartySystem methodsFor: 'customers' stamp: 'HAW 5/22/2022 21:08:47'!
numberOfCustomers

	^(session selectAllOfType: Customer) size! !


!PersistentPartySystem methodsFor: 'transactions' stamp: 'HAW 5/22/2022 20:12:39'!
beginTransaction

	session beginTransaction.
! !

!PersistentPartySystem methodsFor: 'transactions' stamp: 'HAW 5/22/2022 20:13:00'!
commit

	session commit ! !


!PersistentPartySystem methodsFor: 'system lifecycle' stamp: 'EE 11/23/2023 21:27:40'!
start

	session := DataBaseSession for: (Array with: Address with: Customer with: Supplier).
	! !

!PersistentPartySystem methodsFor: 'system lifecycle' stamp: 'HAW 5/22/2022 20:13:10'!
stop

	session close! !


!PersistentPartySystem methodsFor: 'suppliers' stamp: 'EE 11/23/2023 21:17:14'!
addSupplier: aSupplier 

	^session persist: aSupplier! !

!PersistentPartySystem methodsFor: 'suppliers' stamp: 'EE 11/23/2023 21:34:10'!
numberOfSuppliers

	^(session selectAllOfType: Supplier) size! !

!PersistentPartySystem methodsFor: 'suppliers' stamp: 'MH 11/26/2023 17:00:23'!
supplierWithIdentificationType: anIdType number: anIdNumber 

	^(session
		select: (self filterBlockForPartysOfType: anIdType number: anIdNumber)
		ofType: Supplier) anyOne! !


!classDefinition: #TransientPartySystem category: 'CustomerImporter'!
PartySystem subclass: #TransientPartySystem
	instanceVariableNames: 'customers suppliers'
	classVariableNames: ''
	poolDictionaries: ''
	category: 'CustomerImporter'!

!TransientPartySystem methodsFor: 'system lifecycle' stamp: 'EE 11/23/2023 18:26:24'!
start

	customers := OrderedCollection new.
	suppliers := OrderedCollection new.! !

!TransientPartySystem methodsFor: 'system lifecycle' stamp: 'EE 11/23/2023 19:24:27'!
stop

	customers := nil.
	suppliers := nil.! !


!TransientPartySystem methodsFor: 'transactions' stamp: 'HAW 5/22/2022 21:21:20'!
beginTransaction

	! !

!TransientPartySystem methodsFor: 'transactions' stamp: 'HAW 5/22/2022 21:23:01'!
commit

	! !


!TransientPartySystem methodsFor: 'customers' stamp: 'MH 11/26/2023 16:29:28'!
addCustomer: aCustomer

	customers add: aCustomer ! !

!TransientPartySystem methodsFor: 'customers' stamp: 'MH 11/26/2023 16:37:54'!
customerWithIdentificationType: anIdType number: anIdNumber

	^customers detect: (self filterBlockForPartysOfType: anIdType number: anIdNumber)! !

!TransientPartySystem methodsFor: 'customers' stamp: 'MH 11/26/2023 16:37:54'!
existsCustomerWithIdentificationType: anIdType number: anIdNumber

	^customers anySatisfy: (self filterBlockForPartysOfType: anIdType number: anIdNumber)! !

!TransientPartySystem methodsFor: 'customers' stamp: 'HAW 5/22/2022 21:21:43'!
numberOfCustomers

	^customers size! !


!TransientPartySystem methodsFor: 'suppliers' stamp: 'EE 11/23/2023 18:25:58'!
addSupplier: aNewSupplier
	suppliers add: aNewSupplier ! !

!TransientPartySystem methodsFor: 'suppliers' stamp: 'EE 11/23/2023 18:26:48'!
numberOfSuppliers
	
	^suppliers size. ! !

!TransientPartySystem methodsFor: 'suppliers' stamp: 'MH 11/26/2023 16:37:54'!
supplierWithIdentificationType: anIdType number: anIdNumber 
	^suppliers detect: (self filterBlockForPartysOfType: anIdType number: anIdNumber)! !
