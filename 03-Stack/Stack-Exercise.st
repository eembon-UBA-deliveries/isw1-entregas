!classDefinition: #OOStackTest category: 'Stack-Exercise'!
TestCase subclass: #OOStackTest
	instanceVariableNames: ''
	classVariableNames: ''
	poolDictionaries: ''
	category: 'Stack-Exercise'!

!OOStackTest methodsFor: 'test' stamp: 'HernanWilkinson 5/7/2012 11:30'!
test01StackShouldBeEmptyWhenCreated

	| stack |
	
	stack := OOStack new.
	
	self assert: stack isEmpty! !

!OOStackTest methodsFor: 'test' stamp: 'NR 5/13/2020 13:29:55'!
test02PushAddElementsToTheStack

	| stack |
	
	stack := OOStack new.
	stack push: 'something'.
	
	self deny: stack isEmpty! !

!OOStackTest methodsFor: 'test' stamp: 'NR 5/13/2020 13:30:01'!
test03PopRemovesElementsFromTheStack

	| stack |
	
	stack := OOStack new.
	stack push: 'something'.
	stack pop.
	
	self assert: stack isEmpty! !

!OOStackTest methodsFor: 'test' stamp: 'NR 5/13/2020 13:30:09'!
test04PopReturnsLastPushedObject

	| stack pushedObject |
	
	stack := OOStack new.
	pushedObject := 'something'.
	stack push: pushedObject.
	
	self assert: stack pop = pushedObject! !

!OOStackTest methodsFor: 'test' stamp: 'NR 9/16/2021 17:40:17'!
test05StackBehavesLIFO

	| stack firstPushedObject secondPushedObject |
	
	stack := OOStack new.
	firstPushedObject := 'firstSomething'.
	secondPushedObject := 'secondSomething'.
	
	stack push: firstPushedObject.
	stack push: secondPushedObject.
	
	self assert: stack pop = secondPushedObject.
	self assert: stack pop = firstPushedObject.
	self assert: stack isEmpty 
	! !

!OOStackTest methodsFor: 'test' stamp: 'NR 5/13/2020 13:30:20'!
test06TopReturnsLastPushedObject

	| stack pushedObject |
	
	stack := OOStack new.
	pushedObject := 'something'.
	
	stack push: pushedObject.
	
	self assert: stack top = pushedObject.
	! !

!OOStackTest methodsFor: 'test' stamp: 'NR 5/13/2020 13:30:24'!
test07TopDoesNotRemoveObjectFromStack

	| stack pushedObject |
	
	stack := OOStack new.
	pushedObject := 'something'.
	
	stack push: pushedObject.
	
	self assert: stack size = 1.
	stack top.
	self assert: stack size = 1.
	! !

!OOStackTest methodsFor: 'test' stamp: 'HAW 4/14/2017 22:48:26'!
test08CanNotPopWhenThereAreNoObjectsInTheStack

	| stack  |
	
	stack := OOStack new.
	self
		should: [ stack pop ]
		raise: Error - MessageNotUnderstood 
		withExceptionDo: [ :anError |
			self assert: anError messageText = OOStack stackEmptyErrorDescription ]
		
! !

!OOStackTest methodsFor: 'test' stamp: 'NR 5/13/2020 13:30:31'!
test09CanNotPopWhenThereAreNoObjectsInTheStackAndTheStackHadObjects

	| stack  |
	
	stack := OOStack new.
	stack push: 'something'.
	stack pop.
	
	self
		should: [ stack pop ]
		raise: Error - MessageNotUnderstood 
		withExceptionDo: [ :anError |
			self assert: anError messageText = OOStack stackEmptyErrorDescription ]
		
! !

!OOStackTest methodsFor: 'test' stamp: 'HAW 4/14/2017 22:48:44'!
test10CanNotTopWhenThereAreNoObjectsInTheStack

	| stack  |
	
	stack := OOStack new.
	self
		should: [ stack top ]
		raise: Error - MessageNotUnderstood 
		withExceptionDo: [ :anError |
			self assert: anError messageText = OOStack stackEmptyErrorDescription ]
		
! !


!classDefinition: #SentenceFinderByPrefixTest category: 'Stack-Exercise'!
TestCase subclass: #SentenceFinderByPrefixTest
	instanceVariableNames: 'anEmptyStack aNonEmptyStack aNonEmptyStackCopy anEmptyPrefix aPrefixWithSpaces aMatchingPrefix aNonMatchingPrefix aSentenceFinderWithoutSentences aNonMatchingSentenceFinder aMatchingSentenceFinder matchedSentencesOfAMatchingSentenceFinder matchedSentencesOfANonMatchingSentenceFinder'
	classVariableNames: ''
	poolDictionaries: ''
	category: 'Stack-Exercise'!

!SentenceFinderByPrefixTest methodsFor: 'setup' stamp: 'a 9/18/2023 15:34:16'!
setUp
	anEmptyStack := OOStack new.

	aNonEmptyStack := OOStack new.
	aNonEmptyStack push: 'winter is coming'. 
	aNonEmptyStack push: 'The winds of Winter'.
	aNonEmptyStack push: 'winning is everything'.
	aNonEmptyStack push: 'Winter is here'.

	aNonEmptyStackCopy := aNonEmptyStack copy.

	anEmptyPrefix := ''.

	aPrefixWithSpaces := 'Winter is'.

	aMatchingPrefix := 'win'.

	aNonMatchingPrefix := 'thisDoesNotMatch'.

	aSentenceFinderWithoutSentences := SentenceFinderByPrefix withStack: anEmptyStack andPrefix: aMatchingPrefix.

	aNonMatchingSentenceFinder := SentenceFinderByPrefix withStack: aNonEmptyStack andPrefix: aNonMatchingPrefix.

	matchedSentencesOfANonMatchingSentenceFinder := OrderedCollection new.

	aMatchingSentenceFinder := SentenceFinderByPrefix withStack: aNonEmptyStack andPrefix: aMatchingPrefix.

	matchedSentencesOfAMatchingSentenceFinder := #('winter is coming' 'winning is everything') asOrderedCollection.! !


!SentenceFinderByPrefixTest methodsFor: 'test' stamp: 'a 9/18/2023 15:24:21'!
test01PrefixShouldNotBeEmpty
	self
		should: [SentenceFinderByPrefix withStack: aNonEmptyStack andPrefix: anEmptyPrefix]
		raise: Error - MessageNotUnderstood 
		withExceptionDo: [ :anError |
			self assert: anError messageText = SentenceFinderByPrefix prefixShouldNotBeEmpty ].! !

!SentenceFinderByPrefixTest methodsFor: 'test' stamp: 'a 9/18/2023 15:25:00'!
test02PrefixShouldNotContainSpaces
	self
		should: [SentenceFinderByPrefix withStack: aNonEmptyStack andPrefix: aPrefixWithSpaces]
		raise: Error - MessageNotUnderstood 
		withExceptionDo: [ :anError |
			self assert: anError messageText = SentenceFinderByPrefix prefixShouldNotContainSpacesErrorDescription ].! !

!SentenceFinderByPrefixTest methodsFor: 'test' stamp: 'a 9/18/2023 15:33:40'!
test03TheFinderShouldFindAllTheSentencesWithThePrefix
	self assert: (aMatchingSentenceFinder findMatchingSentences = matchedSentencesOfAMatchingSentenceFinder).! !

!SentenceFinderByPrefixTest methodsFor: 'test' stamp: 'MH 9/18/2023 15:02:58'!
test04TheFinderShouldNotModifyTheStackAfterTheSearch
	aMatchingSentenceFinder findMatchingSentences.

	self assert: (self isStack: aNonEmptyStack equalTo: aNonEmptyStackCopy).! !

!SentenceFinderByPrefixTest methodsFor: 'test' stamp: 'a 9/18/2023 15:34:16'!
test05TheFinderShouldNotMatchAnyIfStackEmpty
	self assert: (aSentenceFinderWithoutSentences findMatchingSentences = matchedSentencesOfANonMatchingSentenceFinder).! !

!SentenceFinderByPrefixTest methodsFor: 'test' stamp: 'a 9/18/2023 15:34:16'!
test06TheFinderShouldNotMatchAnyIfNoMatches
	self assert: (aNonMatchingSentenceFinder findMatchingSentences = matchedSentencesOfANonMatchingSentenceFinder).! !


!SentenceFinderByPrefixTest methodsFor: 'auxiliary testing methods' stamp: 'MH 9/18/2023 13:23:00'!
isStack: anOOStack equalTo: anotherOOStack
	| anOOStackCopy anotherOOStackCopy |

	anOOStackCopy := anOOStack.
	anotherOOStackCopy := anotherOOStack .

	[(anOOStackCopy size) > 0 and: [(anotherOOStackCopy size) > 0] and: [anOOStackCopy pop = (anotherOOStackCopy pop)] ] whileTrue.

	^ (anOOStackCopy size) = 0 and: [(anotherOOStackCopy size) = 0].! !


!classDefinition: #OOStack category: 'Stack-Exercise'!
Object subclass: #OOStack
	instanceVariableNames: 'lastElement'
	classVariableNames: ''
	poolDictionaries: ''
	category: 'Stack-Exercise'!

!OOStack methodsFor: 'initialization' stamp: 'MH 9/18/2023 13:20:41'!
initialize
	lastElement := StackOrigin new.! !


!OOStack methodsFor: 'operations' stamp: 'MH 9/15/2023 10:54:49'!
pop
	| elementRemoving |
	elementRemoving := lastElement value.
	lastElement := lastElement previous.
	^ elementRemoving.! !

!OOStack methodsFor: 'operations' stamp: 'a 9/15/2023 14:48:21'!
push: anElement
	lastElement := StackedElement with: anElement nextOf: lastElement.! !


!OOStack methodsFor: 'accessing' stamp: 'MH 9/15/2023 11:02:31'!
isEmpty
	^ self size = 0.! !

!OOStack methodsFor: 'accessing' stamp: 'MH 9/15/2023 11:02:17'!
size
	^ lastElement position.! !

!OOStack methodsFor: 'accessing' stamp: 'MH 9/15/2023 10:56:39'!
top
	^ lastElement value.! !

"-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- "!

!classDefinition: 'OOStack class' category: 'Stack-Exercise'!
OOStack class
	instanceVariableNames: ''!

!OOStack class methodsFor: 'error descriptions' stamp: 'NR 9/14/2023 08:12:21'!
stackEmptyErrorDescription
	
	^ 'stack is empty!!!!!!'! !


!classDefinition: #OOStackElements category: 'Stack-Exercise'!
Object subclass: #OOStackElements
	instanceVariableNames: 'previousElement position'
	classVariableNames: ''
	poolDictionaries: ''
	category: 'Stack-Exercise'!

!OOStackElements methodsFor: 'accessing' stamp: 'MH 9/15/2023 11:00:49'!
position
	self subclassResponsibility.! !

!OOStackElements methodsFor: 'accessing' stamp: 'MH 9/15/2023 10:42:42'!
previous
	self subclassResponsibility.! !

!OOStackElements methodsFor: 'accessing' stamp: 'MH 9/15/2023 11:05:38'!
value
	self subclassResponsibility.! !


!classDefinition: #StackOrigin category: 'Stack-Exercise'!
OOStackElements subclass: #StackOrigin
	instanceVariableNames: ''
	classVariableNames: ''
	poolDictionaries: ''
	category: 'Stack-Exercise'!

!StackOrigin methodsFor: 'accessing' stamp: 'MH 9/15/2023 11:01:07'!
position
	^ 0.! !

!StackOrigin methodsFor: 'accessing' stamp: 'MH 9/15/2023 11:04:49'!
previous
	self error: OOStack stackEmptyErrorDescription.! !

!StackOrigin methodsFor: 'accessing' stamp: 'MH 9/15/2023 11:05:30'!
value
	self error: OOStack stackEmptyErrorDescription.! !


!classDefinition: #StackedElement category: 'Stack-Exercise'!
OOStackElements subclass: #StackedElement
	instanceVariableNames: 'elementValue'
	classVariableNames: ''
	poolDictionaries: ''
	category: 'Stack-Exercise'!

!StackedElement methodsFor: 'initialization' stamp: 'MH 9/15/2023 11:01:30'!
initializeWith: newElement nextOf: previousLastElement
	elementValue := newElement .
	previousElement := previousLastElement.
	position := previousLastElement position + 1.! !


!StackedElement methodsFor: 'accessing' stamp: 'MH 9/15/2023 11:02:00'!
position
	^ position.! !

!StackedElement methodsFor: 'accessing' stamp: 'MH 9/15/2023 10:45:09'!
previous
	^ previousElement.! !

!StackedElement methodsFor: 'accessing' stamp: 'MH 9/15/2023 10:51:33'!
value
	^ elementValue.! !

"-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- "!

!classDefinition: 'StackedElement class' category: 'Stack-Exercise'!
StackedElement class
	instanceVariableNames: ''!

!StackedElement class methodsFor: 'initialize' stamp: 'a 9/15/2023 14:35:48'!
with: newElement nextOf: previousLastElement

	^ self new initializeWith: newElement nextOf: previousLastElement ! !


!classDefinition: #SentenceFinderByPrefix category: 'Stack-Exercise'!
Object subclass: #SentenceFinderByPrefix
	instanceVariableNames: 'aStackOfSentences aSentencePrefix'
	classVariableNames: ''
	poolDictionaries: ''
	category: 'Stack-Exercise'!

!SentenceFinderByPrefix methodsFor: 'operations' stamp: 'MH 9/18/2023 13:33:57'!
findMatchingSentences
	self subclassResponsibility.! !


!SentenceFinderByPrefix methodsFor: 'initialization' stamp: 'MH 9/18/2023 13:45:41'!
initializeSafeWithStack: aStack andPrefix: aPrefix
	aStackOfSentences := aStack.
	aSentencePrefix := aPrefix.! !

"-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- "!

!classDefinition: 'SentenceFinderByPrefix class' category: 'Stack-Exercise'!
SentenceFinderByPrefix class
	instanceVariableNames: ''!

!SentenceFinderByPrefix class methodsFor: 'error descriptions' stamp: 'MH 9/18/2023 15:10:40'!
prefixShouldNotBeEmpty
	^ 'Prefix should not be empty!!'.! !

!SentenceFinderByPrefix class methodsFor: 'error descriptions' stamp: 'MH 9/18/2023 15:10:46'!
prefixShouldNotContainSpacesErrorDescription
	^ 'Prefix should not contain spaces!!'.! !


!SentenceFinderByPrefix class methodsFor: 'instance creation' stamp: 'MH 9/18/2023 13:29:16'!
canHandle: aStack
	self subclassResponsibility.! !

!SentenceFinderByPrefix class methodsFor: 'instance creation' stamp: 'MH 9/18/2023 15:10:52'!
withStack: aStack andPrefix: aPrefix
	(aPrefix isEmpty) ifTrue: [self error: SentenceFinderByPrefix prefixShouldNotBeEmpty ].

	(aPrefix findString: ' ') ~= 0 ifTrue: [ self error: SentenceFinderByPrefix prefixShouldNotContainSpacesErrorDescription ].

	^(SentenceFinderByPrefix allSubclasses detect:[:aClass | aClass canHandle: aStack]) new initializeSafeWithStack: aStack andPrefix: aPrefix.! !


!classDefinition: #SentenceFinderByPrefixWithSentences category: 'Stack-Exercise'!
SentenceFinderByPrefix subclass: #SentenceFinderByPrefixWithSentences
	instanceVariableNames: ''
	classVariableNames: ''
	poolDictionaries: ''
	category: 'Stack-Exercise'!

!SentenceFinderByPrefixWithSentences methodsFor: 'operations' stamp: 'a 9/18/2023 15:43:49'!
findMatchingSentences
	| aSentence aCollectionToReturn |

	aSentence := aStackOfSentences pop.
	
	aCollectionToReturn := (SentenceFinderByPrefix withStack: aStackOfSentences andPrefix: aSentencePrefix) findMatchingSentences.

	(aSentence is: aSentencePrefix substringAt: 1) ifTrue: [aCollectionToReturn add: aSentence].	

	aStackOfSentences push: aSentence.

	^ aCollectionToReturn.! !

"-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- "!

!classDefinition: 'SentenceFinderByPrefixWithSentences class' category: 'Stack-Exercise'!
SentenceFinderByPrefixWithSentences class
	instanceVariableNames: ''!

!SentenceFinderByPrefixWithSentences class methodsFor: 'instance creation' stamp: 'MH 9/18/2023 12:36:37'!
canHandle: aStack
	^ aStack isEmpty not.! !


!classDefinition: #SentenceFinderByPrefixWithoutSentences category: 'Stack-Exercise'!
SentenceFinderByPrefix subclass: #SentenceFinderByPrefixWithoutSentences
	instanceVariableNames: ''
	classVariableNames: ''
	poolDictionaries: ''
	category: 'Stack-Exercise'!

!SentenceFinderByPrefixWithoutSentences methodsFor: 'operations' stamp: 'MH 9/18/2023 13:33:57'!
findMatchingSentences
	^ OrderedCollection new.! !

"-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- "!

!classDefinition: 'SentenceFinderByPrefixWithoutSentences class' category: 'Stack-Exercise'!
SentenceFinderByPrefixWithoutSentences class
	instanceVariableNames: ''!

!SentenceFinderByPrefixWithoutSentences class methodsFor: 'instance creation' stamp: 'MH 9/18/2023 12:36:58'!
canHandle: aStack
	^ aStack isEmpty.! !
