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

!CustomerBookTest methodsFor: 'testing' stamp: 'a 9/7/2023 11:29:36'!
test01AddingCustomerShouldNotTakeMoreThan50Milliseconds

	| customerBook  closureToCheck timeToCheck|
	
	customerBook := CustomerBook new.
	
	closureToCheck := [customerBook addCustomerNamed: 'John Lennon'.].
	
	timeToCheck :=  self executionTimeOf: closureToCheck .
	
	self assert: 
	(self thisTime: timeToCheck isLessThanThisAmountOfMilliseconds: 50)
	
! !

!CustomerBookTest methodsFor: 'testing' stamp: 'a 9/7/2023 11:28:28'!
test02RemovingCustomerShouldNotTakeMoreThan100Milliseconds

	| customerBook closureToCheck timeToCheck  |
	
	customerBook := CustomerBook new.
	
	customerBook addCustomerNamed: 'Paul McCartney'.
	
	closureToCheck := [customerBook removeCustomerNamed: 'Paul McCartney'.].
	
	timeToCheck := self executionTimeOf: closureToCheck .
	
	self assert:  
	(self thisTime: timeToCheck isLessThanThisAmountOfMilliseconds: 100)
	
! !

!CustomerBookTest methodsFor: 'testing' stamp: 'HernanWilkinson 5/9/2012 18:12'!
test03CanNotAddACustomerWithEmptyName 

	| customerBook |
			
	customerBook := CustomerBook new.

	[ customerBook addCustomerNamed: ''.
	self fail ]
		on: Error 
		do: [ :anError | 
			self assert: anError messageText = CustomerBook customerCanNotBeEmptyErrorMessage.
			self assert: customerBook isEmpty ]! !

!CustomerBookTest methodsFor: 'testing' stamp: 'a 9/7/2023 11:39:13'!
test04CanNotRemoveAnInvalidCustomer
	
	| customerBook johnLennon |
			
	customerBook := CustomerBook new.
	johnLennon := 'John Lennon'.
	customerBook addCustomerNamed: johnLennon.
	
	self checkInTheBook:  customerBook thatHasTheCustomers: #(johnLennon)  theClosure:
	[customerBook removeCustomerNamed: 'Paul McCartney']  gettingTheResult: NotFound.
	
! !

!CustomerBookTest methodsFor: 'testing' stamp: 'NR 4/3/2019 10:50:25'!
test05SuspendingACustomerShouldNotRemoveItFromCustomerBook

	| customerBook paulMcCartney|
	
	customerBook := CustomerBook new.
	paulMcCartney := 'Paul McCartney'.
	
	customerBook addCustomerNamed: paulMcCartney.
	customerBook suspendCustomerNamed: paulMcCartney.
	
	self assert: 0 equals: customerBook numberOfActiveCustomers.
	self assert: 1 equals: customerBook numberOfSuspendedCustomers.
	self assert: 1 equals: customerBook numberOfCustomers.
	self assert: (customerBook includesCustomerNamed: paulMcCartney).
	

	
! !

!CustomerBookTest methodsFor: 'testing' stamp: 'NR 4/3/2019 10:50:28'!
test06RemovingASuspendedCustomerShouldRemoveItFromCustomerBook

	| customerBook paulMcCartney|
	
	customerBook := CustomerBook new.
	paulMcCartney := 'Paul McCartney'.
	
	customerBook addCustomerNamed: paulMcCartney.
	customerBook suspendCustomerNamed: paulMcCartney.
	customerBook removeCustomerNamed: paulMcCartney.
	
	self assert: 0 equals: customerBook numberOfActiveCustomers.
	self assert: 0 equals: customerBook numberOfSuspendedCustomers.
	self assert: 0 equals: customerBook numberOfCustomers.
	self deny: (customerBook includesCustomerNamed: paulMcCartney).


	
! !

!CustomerBookTest methodsFor: 'testing' stamp: 'a 9/7/2023 11:41:25'!
test07CanNotSuspendAnInvalidCustomer
	
	| customerBook johnLennon |
			
	customerBook := CustomerBook new.
	johnLennon := 'John Lennon'.
	customerBook addCustomerNamed: johnLennon.
	
	self checkInTheBook: customerBook thatHasTheCustomers: #(johnLennon) theClosure: [customerBook suspendCustomerNamed: 'George Harrison'] gettingTheResult:  CantSuspend.
	
	! !

!CustomerBookTest methodsFor: 'testing' stamp: 'a 9/7/2023 11:42:01'!
test08CanNotSuspendAnAlreadySuspendedCustomer
	
	| customerBook johnLennon |
			
	customerBook := CustomerBook new.
	johnLennon := 'John Lennon'.
	customerBook addCustomerNamed: johnLennon.
	customerBook suspendCustomerNamed: johnLennon.
	
	self checkInTheBook: customerBook thatHasTheCustomers: #(johnLennon) theClosure: [customerBook suspendCustomerNamed: johnLennon] gettingTheResult:  CantSuspend.
	
	! !


!CustomerBookTest methodsFor: 'auxiliaries' stamp: 'a 9/7/2023 11:47:10'!
checkInTheBook: customerBook ifIncludesTheCustomers: customerNameCollection 
	^ (customerNameCollection detect: 
	[:customerName | (customerBook includesCustomerNamed: customerName ) = False] 
	ifNone: ['They are all included'] ) =  'They are all included'! !

!CustomerBookTest methodsFor: 'auxiliaries' stamp: 'a 9/7/2023 11:47:21'!
checkInTheBook: customerBook thatHasTheCustomers: customerNameCollection theClosure: aClosure gettingTheResult: aResult
	
	| numberOfCustomers |
	numberOfCustomers := customerBook  numberOfCustomers.
	
	[ aClosure value.
	self fail ]
		on: aResult 
		do: [ :anError |  
			self assert: customerBook numberOfCustomers = numberOfCustomers .
			
			self assert: 
			(self checkInTheBook: customerBook ifIncludesTheCustomers: customerNameCollection ). ]! !

!CustomerBookTest methodsFor: 'auxiliaries' stamp: 'a 9/7/2023 11:23:22'!
executionTimeOf: aClosure

	| millisecondsBeforeRunning millisecondsAfterRunning |
	
	millisecondsBeforeRunning := Time millisecondClockValue * millisecond.
	aClosure value.
	millisecondsAfterRunning := Time millisecondClockValue * millisecond.
	
		^ (millisecondsAfterRunning-millisecondsBeforeRunning) 
	! !

!CustomerBookTest methodsFor: 'auxiliaries' stamp: 'a 9/7/2023 11:25:56'!
thisTime: time isLessThanThisAmountOfMilliseconds: amount 

	^ (time ) < (amount * millisecond)
	
	! !


!classDefinition: #CustomerBook category: 'CodigoRepetido-Ejercicio'!
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


!CustomerBook methodsFor: 'initialization' stamp: 'NR 9/17/2020 07:23:04'!
initialize

	active := OrderedCollection new.
	suspended:= OrderedCollection new.! !


!CustomerBook methodsFor: 'customer management' stamp: 'NR 4/3/2019 10:14:26'!
addCustomerNamed: aName

	aName isEmpty ifTrue: [ self signalCustomerNameCannotBeEmpty ].
	((active includes: aName) or: [suspended includes: aName]) ifTrue: [ self signalCustomerAlreadyExists ].
	
	active add: aName ! !

!CustomerBook methodsFor: 'customer management' stamp: 'NR 4/3/2019 10:14:26'!
numberOfActiveCustomers
	
	^active size! !

!CustomerBook methodsFor: 'customer management' stamp: 'NR 4/3/2019 10:14:26'!
numberOfCustomers
	
	^active size + suspended size! !

!CustomerBook methodsFor: 'customer management' stamp: 'NR 9/19/2018 17:36:09'!
numberOfSuspendedCustomers
	
	^suspended size! !

!CustomerBook methodsFor: 'customer management' stamp: 'a 9/7/2023 12:01:42'!
removeCustomerNamed: aName

	self fromTheList: active removeAfterCheckThatIncludes: aName orDoThis: [
		self fromTheList: suspended removeAfterCheckThatIncludes: aName  orDoThis: [
			^ NotFound signal.
			].
		].
! !

!CustomerBook methodsFor: 'customer management' stamp: 'HernanWilkinson 7/6/2011 17:52'!
signalCustomerAlreadyExists 

	self error: self class customerAlreadyExistsErrorMessage! !

!CustomerBook methodsFor: 'customer management' stamp: 'HernanWilkinson 7/6/2011 17:51'!
signalCustomerNameCannotBeEmpty 

	self error: self class customerCanNotBeEmptyErrorMessage ! !

!CustomerBook methodsFor: 'customer management' stamp: 'NR 4/3/2019 10:14:26'!
suspendCustomerNamed: aName 
	
	(active includes: aName) ifFalse: [^CantSuspend signal].
	
	active remove: aName.
	
	suspended add: aName
! !


!CustomerBook methodsFor: 'auxiliaries' stamp: 'a 9/7/2023 11:59:19'!
fromTheList: anOrderedCollection removeAfterCheckThatIncludes: anElement orDoThis: aClosure
	1 to: anOrderedCollection size do: 
	[ :index |
		anElement = (anOrderedCollection at: index)
			ifTrue: [
				anOrderedCollection removeAt: index.
				^ anElement 
			] 
	].

	aClosure value.! !

"-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- "!

!classDefinition: 'CustomerBook class' category: 'CodigoRepetido-Ejercicio'!
CustomerBook class
	instanceVariableNames: ''!

!CustomerBook class methodsFor: 'error messages' stamp: 'NR 9/4/2023 17:02:48'!
customerAlreadyExistsErrorMessage

	^'Customer already exists!!!!!!'! !

!CustomerBook class methodsFor: 'error messages' stamp: 'NR 9/4/2023 17:02:52'!
customerCanNotBeEmptyErrorMessage

	^'Customer name cannot be empty!!!!!!'! !
