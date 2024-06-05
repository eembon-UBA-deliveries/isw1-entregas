!classDefinition: #TusLibrosTests category: #'TusLibros-Iteracion1'!
TestCase subclass: #TusLibrosTests
	instanceVariableNames: ''
	classVariableNames: ''
	poolDictionaries: ''
	category: 'TusLibros-Iteracion1'!

!TusLibrosTests methodsFor: 'tests' stamp: 'EE 6/5/2024 18:51:43'!
newCart

	^ Cart withCatalog: self catalog .! !

!TusLibrosTests methodsFor: 'tests' stamp: 'EE 6/5/2024 18:51:28'!
test01CartsAreCreatedEmpty
	self assert: self newCart isEmpty. ! !

!TusLibrosTests methodsFor: 'tests' stamp: 'EE 6/5/2024 18:58:28'!
test02CanAddToCartABook
	| cart |
	cart :=  self newCart.
	cart add: self bookInCatalog.
	self deny: cart isEmpty. ! !

!TusLibrosTests methodsFor: 'tests' stamp: 'EE 6/5/2024 18:58:28'!
test03CanAddToCartManyCopiesOfABook
	| cart |
	cart :=  self newCart.
	cart add: self bookInCatalog withOccurrences: 2 .
	self assert: cart listCart equals: self bookInCatalog  asString , '|2'. ! !

!TusLibrosTests methodsFor: 'tests' stamp: 'EE 6/5/2024 18:59:12'!
test04CanAddToCartDiferntsBookAndListThemInOrder
	| cart |
	cart :=  self newCart.
	cart add: self bookInCatalog withOccurrences: 2 .
	cart add: self anOtherBookInCatalog. 
	self assert: cart listCart equals: self bookInCatalog  asString , '|2|', self anOtherBookInCatalog asString , '|1'. ! !

!TusLibrosTests methodsFor: 'tests' stamp: 'EE 6/5/2024 18:58:27'!
test05CannotAddANegativeOrZeroQuantityOfABook
	| cart |
	cart :=  self newCart.
	self should: [cart add: self bookInCatalog withOccurrences:  -1] raise: Error - MessageNotUnderstood withMessageText: Cart cannotAddANegativeOrZeroQuantityErrorDescription.
	self should: [cart add: self bookInCatalog withOccurrences:  0] raise: Error - MessageNotUnderstood withMessageText: Cart cannotAddANegativeOrZeroQuantityErrorDescription.! !

!TusLibrosTests methodsFor: 'tests' stamp: 'EE 6/5/2024 18:51:28'!
test06ListOfAnEmptyCartIsEmpty
	self assert: self newCart listCart isEmpty. ! !

!TusLibrosTests methodsFor: 'tests' stamp: 'EE 6/5/2024 18:41:51'!
test07CannotAddABookThatIsNotInTheCatalog
	| cart |
	cart := Cart withCatalog: self catalog.
	
	self should: [cart add: self bookThatIsntInCatalog] raise:  Error - MessageNotUnderstood withMessageText: Cart bookIsNotInCatalogErrorDescription. 
	! !

!TusLibrosTests methodsFor: 'tests' stamp: 'EE 6/5/2024 19:05:08'!
test08CannotAddABookAfterCheckOutIsDone
	| cart |
	cart := Cart withCatalog: self catalog.
	cart add: self bookInCatalog .
	cart checkOut. 
	
	self should: [cart add: self anOtherBookInCatalog ] raise:  Error - MessageNotUnderstood withMessageText: Cart cannotAddABookAfterCheckOutErrorDescription. 
	! !


!TusLibrosTests methodsFor: 'books' stamp: 'EE 6/5/2024 18:59:11'!
anOtherBookInCatalog
	^#anOtherBook! !

!TusLibrosTests methodsFor: 'books' stamp: 'EE 6/5/2024 18:58:27'!
bookInCatalog

	^ #Book! !

!TusLibrosTests methodsFor: 'books' stamp: 'EE 6/5/2024 18:49:15'!
bookThatIsntInCatalog
	^#InvalidBook! !

!TusLibrosTests methodsFor: 'books' stamp: 'EE 6/5/2024 18:59:12'!
catalog
	^{self bookInCatalog . self anOtherBookInCatalog }.! !


!classDefinition: #Cart category: #'TusLibros-Iteracion1'!
Object subclass: #Cart
	instanceVariableNames: 'books occurrences catalog checkOutIsDone'
	classVariableNames: ''
	poolDictionaries: ''
	category: 'TusLibros-Iteracion1'!

!Cart methodsFor: 'testing' stamp: 'EE 6/2/2024 11:36:04'!
isEmpty
	^books isEmpty .! !

!Cart methodsFor: 'testing' stamp: 'EE 6/2/2024 12:12:18'!
occurrencesOf: aBook 
	^occurrences at: aBook ! !


!Cart methodsFor: 'add' stamp: 'EE 6/5/2024 19:03:25'!
add: aBook 
	self assertCheckOutIsNotDone. 
	self assertBookIsInCatalog: aBook .
	^self add: aBook withOccurrences: 1.! !

!Cart methodsFor: 'add' stamp: 'EE 6/2/2024 12:15:47'!
add: aBook withOccurrences: aQuantity 
	aQuantity > 0 ifFalse: [self error: self class cannotAddANegativeOrZeroQuantityErrorDescription ].
	occurrences at: aBook put: aQuantity .
	^books add: aBook
	! !


!Cart methodsFor: 'initialization' stamp: 'EE 6/5/2024 19:04:42'!
initializeWithCatalog: aCatalog 
	books := OrderedCollection new.
occurrences := Dictionary new. .
	catalog := aCatalog.
	checkOutIsDone := false.! !


!Cart methodsFor: 'listCart' stamp: 'EE 6/2/2024 12:00:58'!
listCart
	^'|' join: (books collect: [:aBook | aBook asString , '|' , (self occurrencesOf: aBook) asString])! !


!Cart methodsFor: 'asserts' stamp: 'EE 6/5/2024 18:50:01'!
assertBookIsInCatalog: aBook 
	(catalog includes: aBook) ifFalse: [self error: self class bookIsNotInCatalogErrorDescription ].! !

!Cart methodsFor: 'asserts' stamp: 'EE 6/5/2024 19:04:15'!
assertCheckOutIsNotDone
	checkOutIsDone ifTrue: [self error: self class cannotAddABookAfterCheckOutErrorDescription ]! !


!Cart methodsFor: 'checkOut' stamp: 'EE 6/5/2024 19:02:06'!
checkOut
	checkOutIsDone := true .! !

"-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- "!

!classDefinition: 'Cart class' category: #'TusLibros-Iteracion1'!
Cart class
	instanceVariableNames: ''!

!Cart class methodsFor: 'error description' stamp: 'EE 6/5/2024 18:45:36'!
bookIsNotInCatalogErrorDescription
	^'Cannot add a book that is not in the catalog'! !

!Cart class methodsFor: 'error description' stamp: 'EE 6/5/2024 19:02:46'!
cannotAddABookAfterCheckOutErrorDescription
	^'Cannot add a book after the check out is done'! !

!Cart class methodsFor: 'error description' stamp: 'EE 6/2/2024 12:14:15'!
cannotAddANegativeOrZeroQuantityErrorDescription
	^'Cannot add a negative quantity of a book'! !


!Cart class methodsFor: 'instance creation' stamp: 'EE 6/5/2024 18:42:50'!
withCatalog: aCatalog 
	^self new initializeWithCatalog: aCatalog ! !
