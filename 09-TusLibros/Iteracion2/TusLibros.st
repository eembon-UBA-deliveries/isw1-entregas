!classDefinition: #TusLibrosTest category: 'TusLibros'!
TestCase subclass: #TusLibrosTest
	instanceVariableNames: ''
	classVariableNames: ''
	poolDictionaries: ''
	category: 'TusLibros'!

!TusLibrosTest methodsFor: 'support' stamp: 'MH 11/2/2023 19:31:23'!
cartWithAnItem

	^self createCart add: self itemSellByTheStore! !

!TusLibrosTest methodsFor: 'support' stamp: 'MH 11/2/2023 19:32:36'!
cartWithMultipleItems
	
	^self createCart add: self itemSellByTheStore; add: self item2SellByTheStore! !

!TusLibrosTest methodsFor: 'support' stamp: 'MH 11/4/2023 23:05:46'!
createCart
	
	^Cart acceptingItemsOf: self defaultPriceList! !

!TusLibrosTest methodsFor: 'support' stamp: 'MH 11/4/2023 23:35:38'!
createCashierForMultipleItems
	
	^Cashier withPricesOf: self defaultPriceList for: self cartWithMultipleItems withCard: self unexpiredCard atDate: self currentMonthOfYear through: MerchantProcessor new! !

!TusLibrosTest methodsFor: 'support' stamp: 'MH 11/4/2023 23:35:41'!
createCashierForOneItem
	
	^Cashier withPricesOf: self defaultPriceList for: self cartWithAnItem withCard: self unexpiredCard atDate: self currentMonthOfYear through: MerchantProcessor new! !

!TusLibrosTest methodsFor: 'support' stamp: 'MH 11/4/2023 23:46:52'!
createCashierInsufficientFundsInCards
	
	^Cashier withPricesOf: self defaultPriceList for: self cartWithAnItem withCard: self unexpiredCard  atDate: self currentMonthOfYear through: self merchantProcessorInsufficientFunds! !

!TusLibrosTest methodsFor: 'support' stamp: 'MH 11/4/2023 23:46:48'!
createCashierStolenCards
	
	^Cashier withPricesOf: self defaultPriceList for: self cartWithAnItem withCard: self unexpiredCard  atDate: self currentMonthOfYear through: self merchantProcessorStolenCard! !

!TusLibrosTest methodsFor: 'support' stamp: 'MH 11/4/2023 23:35:34'!
createCashierWithEmptyCart
	
	^Cashier withPricesOf: self defaultPriceList for: self createCart withCard: self unexpiredCard atDate: self currentMonthOfYear through: MerchantProcessor new! !

!TusLibrosTest methodsFor: 'support' stamp: 'MH 11/4/2023 23:35:45'!
createCashierWithExpiredCard
	
	^Cashier withPricesOf: self defaultPriceList for: self cartWithAnItem withCard: self expiredCard atDate: self currentMonthOfYear through: MerchantProcessor new! !

!TusLibrosTest methodsFor: 'support' stamp: 'MH 11/2/2023 20:58:37'!
currentMonthOfYear

	^GregorianMonthOfYear current! !

!TusLibrosTest methodsFor: 'support' stamp: 'MH 11/2/2023 19:09:34'!
defaultPriceList

	^Dictionary newFromPairs: (Array with: self itemSellByTheStore with: 50 with: self item2SellByTheStore with: 100)! !

!TusLibrosTest methodsFor: 'support' stamp: 'MH 11/2/2023 18:48:04'!
expiredCard
	
	^Card expiringOn: (GregorianMonthOfYear current previous)! !

!TusLibrosTest methodsFor: 'support' stamp: 'MH 11/2/2023 19:09:00'!
item2SellByTheStore
	
	^ 'validBook2'! !

!TusLibrosTest methodsFor: 'support' stamp: 'HernanWilkinson 6/17/2013 17:44'!
itemNotSellByTheStore
	
	^'invalidBook'! !

!TusLibrosTest methodsFor: 'support' stamp: 'HernanWilkinson 6/17/2013 17:43'!
itemSellByTheStore
	
	^ 'validBook'! !

!TusLibrosTest methodsFor: 'support' stamp: 'MH 11/4/2023 23:45:10'!
merchantProcessor

	^MerchantProcessor new! !

!TusLibrosTest methodsFor: 'support' stamp: 'MH 11/4/2023 23:44:44'!
merchantProcessorInsufficientFunds

	^MerchantProcessor withCustomConfig: [ self error: Cashier insufficientFundsErrorMessage ].! !

!TusLibrosTest methodsFor: 'support' stamp: 'MH 11/4/2023 23:45:02'!
merchantProcessorStolenCard

	^MerchantProcessor withCustomConfig: [ self error: Cashier stolenCardErrorMessage ].! !

!TusLibrosTest methodsFor: 'support' stamp: 'MH 11/2/2023 18:49:14'!
unexpiredCard
	
	^Card expiringOn: (GregorianMonthOfYear current next)! !


!TusLibrosTest methodsFor: 'tests - it1' stamp: 'HernanWilkinson 6/17/2013 17:08'!
test01NewCartsAreCreatedEmpty

	self assert: self createCart isEmpty! !

!TusLibrosTest methodsFor: 'tests - it1' stamp: 'HernanWilkinson 6/17/2013 17:45'!
test02CanNotAddItemsThatDoNotBelongToStore

	| cart |
	
	cart := self createCart.
	
	self 
		should: [ cart add: self itemNotSellByTheStore ]
		raise: Error - MessageNotUnderstood
		withExceptionDo: [ :anError |
			self assert: anError messageText = cart invalidItemErrorMessage.
			self assert: cart isEmpty ]! !

!TusLibrosTest methodsFor: 'tests - it1' stamp: 'HernanWilkinson 6/17/2013 17:43'!
test03AfterAddingAnItemTheCartIsNotEmptyAnymore

	| cart |
	
	cart := self createCart.
	
	cart add: self itemSellByTheStore.
	self deny: cart isEmpty ! !

!TusLibrosTest methodsFor: 'tests - it1' stamp: 'HAW 11/2/2023 17:12:35'!
test04CanNotAddNonPositiveNumberOfItems

	| cart |
	
	cart := self createCart.
	
	self 
		should: [cart add: self itemSellByTheStore withOcurrences: 0  ]
		raise: Error - MessageNotUnderstood
		withExceptionDo: [ :anError |
			self assert: anError messageText = cart invalidQuantityErrorMessage.
			self assert: cart isEmpty ]! !

!TusLibrosTest methodsFor: 'tests - it1' stamp: 'HAW 11/2/2023 17:12:46'!
test05CanNotAddMoreThanOneItemNotSellByTheStore

	| cart |
	
	cart := self createCart.
	
	self 
		should: [cart add:  self itemNotSellByTheStore withOcurrences: 2  ]
		raise: Error - MessageNotUnderstood
		withExceptionDo: [ :anError |
			self assert: anError messageText = cart invalidItemErrorMessage.
			self assert: cart isEmpty ]! !

!TusLibrosTest methodsFor: 'tests - it1' stamp: 'HernanWilkinson 6/17/2013 17:43'!
test06CartRemembersAddedItems

	| cart |
	
	cart := self createCart.
	
	cart add: self itemSellByTheStore.
	self assert: (cart includes: self itemSellByTheStore)! !

!TusLibrosTest methodsFor: 'tests - it1' stamp: 'HernanWilkinson 6/17/2013 17:43'!
test07CartDoesNotHoldNotAddedItems

	| cart |
	
	cart := self createCart.
	
	self deny: (cart includes: self itemSellByTheStore)! !

!TusLibrosTest methodsFor: 'tests - it1' stamp: 'HAW 11/2/2023 17:12:59'!
test08CartRemembersTheNumberOfAddedItems

	| cart |
	
	cart := self createCart.
	
	cart add: self itemSellByTheStore withOcurrences: 2.
	self assert: (cart occurrencesOf: self itemSellByTheStore) = 2! !


!TusLibrosTest methodsFor: 'tests - it2' stamp: 'MH 11/2/2023 21:13:46'!
test01CashierCanNotCheckoutAnEmptyCart

	self 
		should: [ self createCashierWithEmptyCart ]
		raise: Error - MessageNotUnderstood
		withExceptionDo: [ :anError |
			self assert: anError messageText = Cashier emptyCartErrorMessage. ]! !

!TusLibrosTest methodsFor: 'tests - it2' stamp: 'MH 11/2/2023 21:09:01'!
test02CashierCanNotAcceptAnExpiredCard

	self 
		should: [ self createCashierWithExpiredCard ]
		raise: Error - MessageNotUnderstood
		withExceptionDo: [ :anError |
			self assert: anError messageText = Cashier expiredCardErrorMessage ]! !

!TusLibrosTest methodsFor: 'tests - it2' stamp: 'MH 11/2/2023 21:10:35'!
test03CashierCanCheckoutACartWithOneItem

	self
		assert: self createCashierForOneItem checkout
		equals: 50! !

!TusLibrosTest methodsFor: 'tests - it2' stamp: 'MH 11/2/2023 21:33:56'!
test04CashierCanCheckoutACartWithMultipleItems

	self
		assert: self createCashierForMultipleItems checkout
		equals: 150! !

!TusLibrosTest methodsFor: 'tests - it2' stamp: 'MH 11/4/2023 23:47:07'!
test05CanNotCheckoutWithAStolenCard
	
	self 
		should: [ self createCashierStolenCards checkout ]
		raise: Error - MessageNotUnderstood
		withExceptionDo: [ :anError |
			self assert: anError messageText = Cashier stolenCardErrorMessage. ]! !

!TusLibrosTest methodsFor: 'tests - it2' stamp: 'MH 11/4/2023 23:47:29'!
test06CanNotCheckoutWithACardWithoutFunds
	
	self 
		should: [ self createCashierInsufficientFundsInCards checkout ]
		raise: Error - MessageNotUnderstood
		withExceptionDo: [ :anError |
			self assert: anError messageText = Cashier insufficientFundsErrorMessage. ]! !


!classDefinition: #Card category: 'TusLibros'!
Object subclass: #Card
	instanceVariableNames: 'expiration'
	classVariableNames: ''
	poolDictionaries: ''
	category: 'TusLibros'!

!Card methodsFor: 'evaluating' stamp: 'MH 11/2/2023 20:57:26'!
expiredBefore: aDate

	^expiration < aDate! !


!Card methodsFor: 'initialization' stamp: 'MH 11/2/2023 20:57:33'!
initializeExpiringOn: aMonthOfYear 

	expiration := aMonthOfYear! !

"-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- "!

!classDefinition: 'Card class' category: 'TusLibros'!
Card class
	instanceVariableNames: ''!

!Card class methodsFor: 'instance creation' stamp: 'MH 11/2/2023 20:57:42'!
expiringOn: aMonthOfYear

	^self new initializeExpiringOn: aMonthOfYear! !


!classDefinition: #Cart category: 'TusLibros'!
Object subclass: #Cart
	instanceVariableNames: 'catalog items'
	classVariableNames: ''
	poolDictionaries: ''
	category: 'TusLibros'!

!Cart methodsFor: 'accessing' stamp: 'MH 11/2/2023 19:24:27'!
items

	^items! !


!Cart methodsFor: 'adding' stamp: 'HAW 11/2/2023 17:13:30'!
add: anItem

	^ self add: anItem withOcurrences: 1 ! !

!Cart methodsFor: 'adding' stamp: 'HAW 11/2/2023 17:13:19'!
add: anItem withOcurrences: aQuantity

	self assertIsValidQuantity: aQuantity.
	self assertIsValidItem: anItem.

	items add: anItem withOccurrences: aQuantity .
	! !


!Cart methodsFor: 'assertions' stamp: 'HernanWilkinson 6/17/2013 17:51'!
assertIsValidItem: anItem

	(catalog includes: anItem) ifFalse: [ self error: self invalidItemErrorMessage ]! !

!Cart methodsFor: 'assertions' stamp: 'HernanWilkinson 6/17/2013 17:51'!
assertIsValidQuantity: aQuantity

	aQuantity strictlyPositive ifFalse: [ self error: self invalidQuantityErrorMessage ]! !


!Cart methodsFor: 'error messages' stamp: 'HernanWilkinson 6/17/2013 17:45'!
invalidItemErrorMessage
	
	^'Item is not in catalog'! !

!Cart methodsFor: 'error messages' stamp: 'HernanWilkinson 6/17/2013 17:45'!
invalidQuantityErrorMessage
	
	^'Invalid number of items'! !


!Cart methodsFor: 'initialization' stamp: 'MH 11/4/2023 23:06:39'!
initializeAcceptingItemsOf: aPriceList

	catalog := aPriceList keys.
	items := OrderedCollection new.! !


!Cart methodsFor: 'queries' stamp: 'HernanWilkinson 6/17/2013 17:45'!
occurrencesOf: anItem

	^items occurrencesOf: anItem  ! !


!Cart methodsFor: 'testing' stamp: 'HernanWilkinson 6/17/2013 17:44'!
includes: anItem

	^items includes: anItem ! !

!Cart methodsFor: 'testing' stamp: 'HernanWilkinson 6/17/2013 17:44'!
isEmpty
	
	^items isEmpty ! !

"-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- "!

!classDefinition: 'Cart class' category: 'TusLibros'!
Cart class
	instanceVariableNames: ''!

!Cart class methodsFor: 'instance creation' stamp: 'MH 11/4/2023 23:06:06'!
acceptingItemsOf: aPriceList

	^self new initializeAcceptingItemsOf: aPriceList ! !


!classDefinition: #Cashier category: 'TusLibros'!
Object subclass: #Cashier
	instanceVariableNames: 'priceList cart card date merchantProcessor'
	classVariableNames: ''
	poolDictionaries: ''
	category: 'TusLibros'!

!Cashier methodsFor: 'evaluating' stamp: 'MH 11/2/2023 19:28:36'!
priceOf: anItem 

	^priceList at: anItem! !


!Cashier methodsFor: 'initialization' stamp: 'MH 11/4/2023 23:29:31'!
initializeWithPricesOf: aPriceList for: aCart withCard: aCard atDate: aDate through: aMerchantProcessor

	priceList := aPriceList.
	cart := aCart.
	card := aCard.
	date := aDate.
	merchantProcessor := aMerchantProcessor.! !


!Cashier methodsFor: 'payment' stamp: 'MH 11/4/2023 23:32:25'!
checkout

	| amount |

	amount := cart items sum: [ :anItem | self priceOf: anItem ].

	^merchantProcessor debit: amount from: card! !

"-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- "!

!classDefinition: 'Cashier class' category: 'TusLibros'!
Cashier class
	instanceVariableNames: ''!

!Cashier class methodsFor: 'instance creation' stamp: 'MH 11/4/2023 23:29:10'!
withPricesOf: aPriceList for: aCart withCard: aCard atDate: aDate through: aMerchantProcessor

	(aCart isEmpty) ifTrue: [ self error: Cashier emptyCartErrorMessage ].
	(aCard expiredBefore: aDate) ifTrue: [ self error: Cashier expiredCardErrorMessage ].

	^self new initializeWithPricesOf: aPriceList for: aCart withCard: aCard atDate: aDate through: aMerchantProcessor! !


!Cashier class methodsFor: 'error messages' stamp: 'MH 11/2/2023 21:04:22'!
emptyCartErrorMessage

	^'Cart should not be empty!!'! !

!Cashier class methodsFor: 'error messages' stamp: 'MH 11/2/2023 21:04:30'!
expiredCardErrorMessage

	^'Expired card can not pay cart'! !

!Cashier class methodsFor: 'error messages' stamp: 'MH 11/4/2023 23:38:26'!
insufficientFundsErrorMessage

	^'Insufficient funds!!'! !

!Cashier class methodsFor: 'error messages' stamp: 'MH 11/4/2023 23:31:50'!
stolenCardErrorMessage

	^'Stolen card!!'! !


!classDefinition: #MerchantProcessor category: 'TusLibros'!
Object subclass: #MerchantProcessor
	instanceVariableNames: 'customConfig'
	classVariableNames: ''
	poolDictionaries: ''
	category: 'TusLibros'!

!MerchantProcessor methodsFor: 'initialization' stamp: 'MH 11/4/2023 23:36:20'!
initializeWithCustomConfig: aClosure 

	customConfig := aClosure.! !


!MerchantProcessor methodsFor: 'payment' stamp: 'MH 11/4/2023 23:36:15'!
debit: anAmount from: aCard

	customConfig value.
	^anAmount! !

"-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- "!

!classDefinition: 'MerchantProcessor class' category: 'TusLibros'!
MerchantProcessor class
	instanceVariableNames: ''!

!MerchantProcessor class methodsFor: 'instance creation' stamp: 'MH 11/4/2023 23:30:25'!
withCustomConfig: aClosure 

	^self new initializeWithCustomConfig: aClosure! !
