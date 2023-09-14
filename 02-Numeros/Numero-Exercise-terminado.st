!classDefinition: #NumeroTest category: 'Numero-Exercise'!
TestCase subclass: #NumeroTest
	instanceVariableNames: 'zero one two four oneFifth oneHalf five twoFifth twoTwentyfifth fiveHalfs three eight negativeOne negativeTwo'
	classVariableNames: ''
	poolDictionaries: ''
	category: 'Numero-Exercise'!

!NumeroTest methodsFor: 'tests' stamp: 'HernanWilkinson 5/7/2016 20:11'!
test01isCeroReturnsTrueWhenAskToZero

	self assert: zero isZero! !

!NumeroTest methodsFor: 'tests' stamp: 'HernanWilkinson 5/7/2016 20:12'!
test02isCeroReturnsFalseWhenAskToOthersButZero

	self deny: one isZero! !

!NumeroTest methodsFor: 'tests' stamp: 'HernanWilkinson 5/7/2016 20:13'!
test03isOneReturnsTrueWhenAskToOne

	self assert: one isOne! !

!NumeroTest methodsFor: 'tests' stamp: 'HernanWilkinson 5/7/2016 20:13'!
test04isOneReturnsFalseWhenAskToOtherThanOne

	self deny: zero isOne! !

!NumeroTest methodsFor: 'tests' stamp: 'HernanWilkinson 5/7/2016 20:14'!
test05EnteroAddsWithEnteroCorrectly

	self assert: one + one equals: two! !

!NumeroTest methodsFor: 'tests' stamp: 'HernanWilkinson 5/7/2016 20:18'!
test06EnteroMultipliesWithEnteroCorrectly

	self assert: two * two equals: four! !

!NumeroTest methodsFor: 'tests' stamp: 'HernanWilkinson 5/7/2016 20:20'!
test07EnteroDividesEnteroCorrectly

	self assert: two / two equals: one! !

!NumeroTest methodsFor: 'tests' stamp: 'HernanWilkinson 5/7/2016 20:38'!
test08FraccionAddsWithFraccionCorrectly
"
    La suma de fracciones es:
	 
	a/b + c/d = (a.d + c.b) / (b.d)
	 
	SI ESTAN PENSANDO EN LA REDUCCION DE FRACCIONES NO SE PREOCUPEN!!
	TODAVIA NO SE ESTA TESTEANDO ESE CASO
"
	| sevenTenths |

	sevenTenths := (Entero with: 7) / (Entero with: 10).

	self assert: oneFifth + oneHalf equals: sevenTenths! !

!NumeroTest methodsFor: 'tests' stamp: 'HernanWilkinson 5/7/2016 20:52'!
test09FraccionMultipliesWithFraccionCorrectly
"
    La multiplicacion de fracciones es:
	 
	(a/b) * (c/d) = (a.c) / (b.d)
"

	self assert: oneFifth * twoFifth equals: twoTwentyfifth! !

!NumeroTest methodsFor: 'tests' stamp: 'HernanWilkinson 5/7/2016 20:56'!
test10FraccionDividesFraccionCorrectly
"
    La division de fracciones es:
	 
	(a/b) / (c/d) = (a.d) / (b.c)
"

	self assert: oneHalf / oneFifth equals: fiveHalfs! !

!NumeroTest methodsFor: 'tests' stamp: 'HernanWilkinson 5/7/2016 21:07'!
test11EnteroAddsFraccionCorrectly
"
	Ahora empieza la diversion!!
"

	self assert: one + oneFifth equals: (Entero with: 6) / (Entero with: 5)! !

!NumeroTest methodsFor: 'tests' stamp: 'HernanWilkinson 5/7/2016 21:07'!
test12FraccionAddsEnteroCorrectly

	self assert: oneFifth + one equals: (Entero with: 6) / (Entero with: 5)! !

!NumeroTest methodsFor: 'tests' stamp: 'HernanWilkinson 5/7/2016 21:50'!
test13EnteroMultipliesFraccionCorrectly

	self assert: two * oneFifth equals: twoFifth ! !

!NumeroTest methodsFor: 'tests' stamp: 'HernanWilkinson 5/7/2016 21:52'!
test14FraccionMultipliesEnteroCorrectly

	self assert: oneFifth * two equals: twoFifth ! !

!NumeroTest methodsFor: 'tests' stamp: 'HernanWilkinson 5/7/2016 21:57'!
test15EnteroDividesFraccionCorrectly

	self assert: one / twoFifth equals: fiveHalfs  ! !

!NumeroTest methodsFor: 'tests' stamp: 'HernanWilkinson 5/7/2016 21:59'!
test16FraccionDividesEnteroCorrectly

	self assert: twoFifth / five equals: twoTwentyfifth ! !

!NumeroTest methodsFor: 'tests' stamp: 'HernanWilkinson 5/7/2016 22:38'!
test17AFraccionCanBeEqualToAnEntero

	self assert: two equals: four / two! !

!NumeroTest methodsFor: 'tests' stamp: 'HernanWilkinson 5/7/2016 22:39'!
test18AparentFraccionesAreEqual

	self assert: oneHalf equals: two / four! !

!NumeroTest methodsFor: 'tests' stamp: 'HernanWilkinson 5/7/2016 22:40'!
test19AddingFraccionesCanReturnAnEntero

	self assert: oneHalf + oneHalf equals: one! !

!NumeroTest methodsFor: 'tests' stamp: 'HernanWilkinson 5/7/2016 22:42'!
test20MultiplyingFraccionesCanReturnAnEntero

	self assert: (two/five) * (five/two) equals: one! !

!NumeroTest methodsFor: 'tests' stamp: 'HernanWilkinson 5/7/2016 22:42'!
test21DividingFraccionesCanReturnAnEntero

	self assert: oneHalf / oneHalf equals: one! !

!NumeroTest methodsFor: 'tests' stamp: 'HernanWilkinson 5/7/2016 22:43'!
test22DividingEnterosCanReturnAFraccion

	self assert: two / four equals: oneHalf! !

!NumeroTest methodsFor: 'tests' stamp: 'HernanWilkinson 5/7/2016 22:46'!
test23CanNotDivideEnteroByZero

	self 
		should: [ one / zero ]
		raise: Error
		withExceptionDo: [ :anError | self assert: anError messageText equals: Numero canNotDivideByZeroErrorDescription ]
	! !

!NumeroTest methodsFor: 'tests' stamp: 'HernanWilkinson 5/7/2016 22:46'!
test24CanNotDivideFraccionByZero

	self 
		should: [ oneHalf / zero ]
		raise: Error
		withExceptionDo: [ :anError | self assert: anError messageText equals: Numero canNotDivideByZeroErrorDescription ]
	! !

!NumeroTest methodsFor: 'tests' stamp: 'HernanWilkinson 5/7/2016 22:50'!
test25AFraccionCanNotBeZero

	self deny: oneHalf isZero! !

!NumeroTest methodsFor: 'tests' stamp: 'HernanWilkinson 5/7/2016 22:50'!
test26AFraccionCanNotBeOne

	self deny: oneHalf isOne! !

!NumeroTest methodsFor: 'tests' stamp: 'NR 4/15/2021 16:45:35'!
test27EnteroSubstractsEnteroCorrectly

	self assert: four - one equals: three! !

!NumeroTest methodsFor: 'tests' stamp: 'NR 9/23/2018 23:47:41'!
test28FraccionSubstractsFraccionCorrectly
	
	self assert: twoFifth - oneFifth equals: oneFifth.! !

!NumeroTest methodsFor: 'tests' stamp: 'NR 9/23/2018 23:48:00'!
test29EnteroSubstractsFraccionCorrectly

	self assert: one - oneHalf equals: oneHalf! !

!NumeroTest methodsFor: 'tests' stamp: 'HAW 9/24/2018 08:48:05'!
test30FraccionSubstractsEnteroCorrectly

	| sixFifth |
	
	sixFifth := (Entero with: 6) / (Entero with: 5).
	
	self assert: sixFifth - one equals: oneFifth! !

!NumeroTest methodsFor: 'tests' stamp: 'HAW 9/24/2018 08:48:08'!
test31SubstractingFraccionesCanReturnAnEntero

	| threeHalfs |
	
	threeHalfs := (Entero with: 3) / (Entero with: 2).
	
	self assert: threeHalfs - oneHalf equals: one.! !

!NumeroTest methodsFor: 'tests' stamp: 'NR 9/23/2018 23:48:48'!
test32SubstractingSameEnterosReturnsZero

	self assert: one - one equals: zero.! !

!NumeroTest methodsFor: 'tests' stamp: 'NR 9/23/2018 23:49:01'!
test33SubstractingSameFraccionesReturnsZero

	self assert: oneHalf - oneHalf equals: zero.! !

!NumeroTest methodsFor: 'tests' stamp: 'HAW 9/24/2018 08:48:14'!
test34SubstractingAHigherValueToANumberReturnsANegativeNumber

	| negativeThreeHalfs |
	
	negativeThreeHalfs := (Entero with: -3) / (Entero with: 2).	

	self assert: one - fiveHalfs equals: negativeThreeHalfs.! !

!NumeroTest methodsFor: 'tests' stamp: 'NR 9/23/2018 23:49:23'!
test35FibonacciZeroIsOne

	self assert: zero fibonacci equals: one! !

!NumeroTest methodsFor: 'tests' stamp: 'NR 9/23/2018 23:49:32'!
test36FibonacciOneIsOne

	self assert: one fibonacci equals: one! !

!NumeroTest methodsFor: 'tests' stamp: 'NR 9/23/2018 23:49:39'!
test37FibonacciEnteroReturnsAddingPreviousTwoFibonacciEnteros

	self assert: four fibonacci equals: five.
	self assert: three fibonacci equals: three. 
	self assert: five fibonacci equals: four fibonacci + three fibonacci.! !

!NumeroTest methodsFor: 'tests' stamp: 'NR 9/23/2018 23:49:47'!
test38FibonacciNotDefinedForNegativeNumbers

	self 
		should: [negativeOne fibonacci]
		raise: Error
		withExceptionDo: [ :anError | self assert: anError messageText equals: Entero negativeFibonacciErrorDescription ].! !

!NumeroTest methodsFor: 'tests' stamp: 'NR 9/23/2018 23:49:55'!
test39NegationOfEnteroIsCorrect

	self assert: two negated equals: negativeTwo.
		! !

!NumeroTest methodsFor: 'tests' stamp: 'NR 9/23/2018 23:50:03'!
test40NegationOfFraccionIsCorrect

	self assert: oneHalf negated equals: negativeOne / two.! !

!NumeroTest methodsFor: 'tests' stamp: 'NR 9/23/2018 23:50:11'!
test41SignIsCorrectlyAssignedToFractionWithTwoNegatives

	self assert: oneHalf equals: (negativeOne / negativeTwo)! !

!NumeroTest methodsFor: 'tests' stamp: 'NR 9/23/2018 23:50:17'!
test42SignIsCorrectlyAssignedToFractionWithNegativeDivisor

	self assert: oneHalf negated equals: (one / negativeTwo)! !


!NumeroTest methodsFor: 'setup' stamp: 'NR 9/23/2018 23:46:28'!
setUp

	zero := Entero with: 0.
	one := Entero with: 1.
	two := Entero with: 2.
	three:= Entero with: 3.
	four := Entero with: 4.
	five := Entero with: 5.
	eight := Entero with: 8.
	negativeOne := Entero with: -1.
	negativeTwo := Entero with: -2.
	
	oneHalf := one / two.
	oneFifth := one / five.
	twoFifth := two / five.
	twoTwentyfifth := two / (Entero with: 25).
	fiveHalfs := five / two.
	! !


!classDefinition: #Numero category: 'Numero-Exercise'!
Object subclass: #Numero
	instanceVariableNames: ''
	classVariableNames: ''
	poolDictionaries: ''
	category: 'Numero-Exercise'!

!Numero methodsFor: 'arithmetic auxiliar methods' stamp: 'a 9/12/2023 12:56:37'!
addAFraccion: aFractionToBeAdded

	self subclassResponsibility ! !

!Numero methodsFor: 'arithmetic auxiliar methods' stamp: 'a 9/12/2023 12:56:42'!
addAnEntero: anIntegerToBeAdded

	self subclassResponsibility ! !

!Numero methodsFor: 'arithmetic auxiliar methods' stamp: 'a 9/12/2023 12:56:47'!
divideAFraccion: aFractionToBeDivided

	self subclassResponsibility ! !

!Numero methodsFor: 'arithmetic auxiliar methods' stamp: 'a 9/12/2023 12:56:52'!
divideAnEntero: anIntegerToBeDivided

	self subclassResponsibility ! !

!Numero methodsFor: 'arithmetic auxiliar methods' stamp: 'a 9/12/2023 12:57:01'!
multiplyAFraccion: aFractionToBeMultiplied

	self subclassResponsibility ! !

!Numero methodsFor: 'arithmetic auxiliar methods' stamp: 'a 9/12/2023 12:57:07'!
multiplyAnEntero: anIntegerToBeMultiplied

	self subclassResponsibility ! !

!Numero methodsFor: 'arithmetic auxiliar methods' stamp: 'a 9/12/2023 12:57:11'!
substractAFraccion: aFractionToBeSubstracted

	self subclassResponsibility ! !

!Numero methodsFor: 'arithmetic auxiliar methods' stamp: 'a 9/12/2023 12:57:16'!
substractAnEntero: anIntegerToBeSubstracted

	self subclassResponsibility ! !


!Numero methodsFor: 'arithmetic operations' stamp: 'HernanWilkinson 5/7/2016 22:48'!
* aMultiplier

	self subclassResponsibility ! !

!Numero methodsFor: 'arithmetic operations' stamp: 'HernanWilkinson 5/7/2016 22:49'!
+ anAdder

	self subclassResponsibility ! !

!Numero methodsFor: 'arithmetic operations' stamp: 'NR 9/23/2018 22:21:28'!
- aSubtrahend

	self subclassResponsibility ! !

!Numero methodsFor: 'arithmetic operations' stamp: 'HernanWilkinson 5/7/2016 22:49'!
/ aDivisor

	self subclassResponsibility ! !

!Numero methodsFor: 'arithmetic operations' stamp: 'HernanWilkinson 5/7/2016 22:48'!
invalidNumberType

	self error: self class invalidNumberTypeErrorDescription! !

!Numero methodsFor: 'arithmetic operations' stamp: 'NR 9/23/2018 23:37:13'!
negated
	
	^self * (Entero with: -1)! !


!Numero methodsFor: 'testing' stamp: 'NR 9/23/2018 23:36:49'!
isNegative

	self subclassResponsibility ! !

!Numero methodsFor: 'testing' stamp: 'HernanWilkinson 5/7/2016 22:49'!
isOne

	self subclassResponsibility ! !

!Numero methodsFor: 'testing' stamp: 'HernanWilkinson 5/7/2016 22:49'!
isZero

	self subclassResponsibility ! !

"-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- "!

!classDefinition: 'Numero class' category: 'Numero-Exercise'!
Numero class
	instanceVariableNames: ''!

!Numero class methodsFor: 'error descriptions' stamp: 'NR 4/15/2021 16:42:02'!
canNotDivideByZeroErrorDescription

	^'No se puede dividir por cero!!!!!!'! !

!Numero class methodsFor: 'error descriptions' stamp: 'NR 4/15/2021 16:42:09'!
invalidNumberTypeErrorDescription
	
	^ 'Tipo de número inválido!!!!!!'! !


!classDefinition: #Entero category: 'Numero-Exercise'!
Numero subclass: #Entero
	instanceVariableNames: 'value'
	classVariableNames: ''
	poolDictionaries: ''
	category: 'Numero-Exercise'!

!Entero methodsFor: 'arithmetic operations' stamp: 'a 9/12/2023 13:10:39'!
* aMultiplier 
	^ aMultiplier  multiplyAnEntero: self
	! !

!Entero methodsFor: 'arithmetic operations' stamp: 'a 9/12/2023 12:42:34'!
+ anAdder 
	
	^ anAdder addAnEntero: self
	
	
! !

!Entero methodsFor: 'arithmetic operations' stamp: 'a 9/12/2023 13:10:50'!
- aSubtrahend 
	^ aSubtrahend substractAnEntero: self
	! !

!Entero methodsFor: 'arithmetic operations' stamp: 'a 9/12/2023 13:10:59'!
/ aDivisor

	^ aDivisor divideAnEntero: self
	! !

!Entero methodsFor: 'arithmetic operations' stamp: 'HernanWilkinson 5/7/2016 21:55'!
// aDivisor 
	
	^self class with: value // aDivisor integerValue! !

!Entero methodsFor: 'arithmetic operations' stamp: 'MH 9/13/2023 12:26:53'!
fibonacci
	self subclassResponsibility! !

!Entero methodsFor: 'arithmetic operations' stamp: 'HernanWilkinson 5/7/2016 21:00'!
greatestCommonDivisorWith: anEntero 
	
	^self class with: (value gcd: anEntero integerValue)! !


!Entero methodsFor: 'comparing' stamp: 'HernanWilkinson 5/7/2016 21:01'!
= anObject

	^(anObject isKindOf: self class) and: [ value = anObject integerValue ]! !

!Entero methodsFor: 'comparing' stamp: 'HernanWilkinson 5/7/2016 20:17'!
hash

	^value hash! !


!Entero methodsFor: 'initialization' stamp: 'HernanWilkinson 5/7/2016 20:09'!
initalizeWith: aValue 
	
	value := aValue! !


!Entero methodsFor: 'general auxiliar methods' stamp: 'MH 9/13/2023 12:36:32'!
ifNegativeDo: aReturningClosure otherwiseRun: otherClosure
	self subclassResponsibility.! !

!Entero methodsFor: 'general auxiliar methods' stamp: 'MH 9/13/2023 12:40:37'!
ifOneDo: aReturningClosure otherwiseRun: otherClosure
	self subclassResponsibility.! !

!Entero methodsFor: 'general auxiliar methods' stamp: 'MH 9/13/2023 12:37:10'!
ifZeroDo: aReturningClosure otherwiseRun: otherClosure
	self subclassResponsibility.! !


!Entero methodsFor: 'value' stamp: 'HernanWilkinson 5/7/2016 21:02'!
integerValue

	"Usamos integerValue en vez de value para que no haya problemas con el mensaje value implementado en Object - Hernan"
	
	^value! !


!Entero methodsFor: 'printing' stamp: 'HAW 9/24/2018 08:53:19'!
printOn: aStream

	aStream print: value ! !


!Entero methodsFor: 'testing' stamp: 'NR 9/23/2018 22:17:55'!
isNegative
	
	^value < 0! !

!Entero methodsFor: 'testing' stamp: 'HernanWilkinson 5/7/2016 20:14'!
isOne
	
	^value = 1! !

!Entero methodsFor: 'testing' stamp: 'HernanWilkinson 5/7/2016 20:12'!
isZero
	
	^value = 0! !


!Entero methodsFor: 'arithmetic auxiliar methods' stamp: 'MH 9/13/2023 13:08:40'!
addAFraccion: aFractionToBeAdded
	^ Fraccion with: ((self * aFractionToBeAdded denominator) + aFractionToBeAdded numerator) over: aFractionToBeAdded denominator.! !

!Entero methodsFor: 'arithmetic auxiliar methods' stamp: 'MH 9/13/2023 13:26:56'!
addAnEntero: anIntegerToBeAdded
	^ self class with: value + anIntegerToBeAdded integerValue.! !

!Entero methodsFor: 'arithmetic auxiliar methods' stamp: 'MH 9/13/2023 13:09:17'!
divideAFraccion: aFractionToBeDivided
	^ Fraccion with: aFractionToBeDivided numerator over: (aFractionToBeDivided denominator * self).! !

!Entero methodsFor: 'arithmetic auxiliar methods' stamp: 'MH 9/13/2023 13:09:35'!
divideAnEntero: anIntegerToBeDivided
	^ Fraccion with: anIntegerToBeDivided over: self.! !

!Entero methodsFor: 'arithmetic auxiliar methods' stamp: 'MH 9/13/2023 13:09:58'!
multiplyAFraccion: aFractionToBeMultiplied
	 ^ Fraccion with: (aFractionToBeMultiplied numerator * self ) over: aFractionToBeMultiplied denominator.! !

!Entero methodsFor: 'arithmetic auxiliar methods' stamp: 'MH 9/13/2023 13:27:05'!
multiplyAnEntero: anIntegerToBeMultiplied
	^ self class with: (value * anIntegerToBeMultiplied integerValue).! !

!Entero methodsFor: 'arithmetic auxiliar methods' stamp: 'MH 9/13/2023 13:10:47'!
substractAFraccion: aFractionToBeSubstracted
	| newDenominator newNumerator |

	newNumerator := aFractionToBeSubstracted numerator - (self * aFractionToBeSubstracted denominator).
	newDenominator := aFractionToBeSubstracted denominator.

	^ Fraccion with: newNumerator over: newDenominator.! !

!Entero methodsFor: 'arithmetic auxiliar methods' stamp: 'MH 9/13/2023 13:26:45'!
substractAnEntero: anIntegerToBeSubstracted
	^ self class with: anIntegerToBeSubstracted integerValue - value.! !

"-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- "!

!classDefinition: 'Entero class' category: 'Numero-Exercise'!
Entero class
	instanceVariableNames: ''!

!Entero class methodsFor: 'instance creation' stamp: 'NR 4/15/2021 16:42:24'!
negativeFibonacciErrorDescription
	^ ' Fibonacci no está definido aquí para Enteros Negativos!!!!!!'! !

!Entero class methodsFor: 'instance creation' stamp: 'a 9/11/2023 21:14:47'!
with: aValue 
	
	"Esta verificacion esta puesta por si se equivocan y quieren crear un Entero pasando otra cosa que un Integer - Hernan"
	"Modificamos el with- Mati y Eitan"
	aValue isInteger ifFalse: [  self error: 'aValue debe ser anInteger' ].
	
	aValue = 0 ifTrue: [^Cero new initalizeWith: aValue].
	
	aValue = 1 ifTrue: [^Uno new initalizeWith: aValue].
	
	aValue < 0 ifTrue: [^Negativo new initalizeWith: aValue].
	
	^PositivosMayoresAUno new initalizeWith: aValue! !


!classDefinition: #Cero category: 'Numero-Exercise'!
Entero subclass: #Cero
	instanceVariableNames: ''
	classVariableNames: ''
	poolDictionaries: ''
	category: 'Numero-Exercise'!

!Cero methodsFor: 'arithmetic auxiliar methods' stamp: 'a 9/12/2023 12:42:52'!
divideAFraccion: aFractionToBeDivided
		self error: Numero canNotDivideByZeroErrorDescription! !

!Cero methodsFor: 'arithmetic auxiliar methods' stamp: 'a 9/12/2023 12:43:13'!
divideAnEntero: anIntegerToBeDivided
	self error: Numero canNotDivideByZeroErrorDescription! !


!Cero methodsFor: 'arithmetic operations' stamp: 'a 9/11/2023 21:17:26'!
fibonacci

	^ Entero with: 1.
	! !


!Cero methodsFor: 'general auxiliar methods' stamp: 'MH 9/13/2023 12:38:28'!
ifNegativeDo: aReturningClosure otherwiseRun: otherClosure
	otherClosure value.! !

!Cero methodsFor: 'general auxiliar methods' stamp: 'MH 9/13/2023 12:40:51'!
ifOneDo: aReturningClosure otherwiseRun: otherClosure
	otherClosure value.! !

!Cero methodsFor: 'general auxiliar methods' stamp: 'MH 9/13/2023 12:39:01'!
ifZeroDo: aReturningClosure otherwiseRun: otherClosure
	aReturningClosure value.! !


!classDefinition: #Negativo category: 'Numero-Exercise'!
Entero subclass: #Negativo
	instanceVariableNames: ''
	classVariableNames: ''
	poolDictionaries: ''
	category: 'Numero-Exercise'!

!Negativo methodsFor: 'arithmetic operations' stamp: 'a 9/11/2023 21:15:45'!
fibonacci

	self error: Entero negativeFibonacciErrorDescription 	
! !


!Negativo methodsFor: 'general auxiliar methods' stamp: 'MH 9/13/2023 12:39:46'!
ifNegativeDo: aReturningClosure otherwiseRun: otherClosure
	aReturningClosure value.! !

!Negativo methodsFor: 'general auxiliar methods' stamp: 'MH 9/13/2023 12:41:09'!
ifOneDo: aReturningClosure otherwiseRun: otherClosure
	otherClosure value.! !

!Negativo methodsFor: 'general auxiliar methods' stamp: 'MH 9/13/2023 12:41:15'!
ifZeroDo: aReturningClosure otherwiseRun: otherClosure
	otherClosure value.! !


!classDefinition: #Positivo category: 'Numero-Exercise'!
Entero subclass: #Positivo
	instanceVariableNames: ''
	classVariableNames: ''
	poolDictionaries: ''
	category: 'Numero-Exercise'!

!Positivo methodsFor: 'arithmetic operations' stamp: 'MH 9/13/2023 12:48:38'!
fibonacci
	self subclassResponsibility! !


!classDefinition: #PositivosMayoresAUno category: 'Numero-Exercise'!
Positivo subclass: #PositivosMayoresAUno
	instanceVariableNames: ''
	classVariableNames: ''
	poolDictionaries: ''
	category: 'Numero-Exercise'!

!PositivosMayoresAUno methodsFor: 'arithmetic operations' stamp: 'MH 9/13/2023 12:27:10'!
fibonacci
	| one two |
	
	one := Entero with: 1.
	two := Entero with: 2.
	
	^ (self - one) fibonacci + (self - two) fibonacci! !


!PositivosMayoresAUno methodsFor: 'general auxiliar methods' stamp: 'MH 9/13/2023 12:41:44'!
ifNegativeDo: aReturningClosure otherwiseRun: otherClosure
	otherClosure value.! !

!PositivosMayoresAUno methodsFor: 'general auxiliar methods' stamp: 'MH 9/13/2023 12:41:51'!
ifOneDo: aReturningClosure otherwiseRun: otherClosure
	otherClosure value.! !

!PositivosMayoresAUno methodsFor: 'general auxiliar methods' stamp: 'MH 9/13/2023 12:41:56'!
ifZeroDo: aReturningClosure otherwiseRun: otherClosure
	otherClosure value.! !


!classDefinition: #Uno category: 'Numero-Exercise'!
Positivo subclass: #Uno
	instanceVariableNames: ''
	classVariableNames: ''
	poolDictionaries: ''
	category: 'Numero-Exercise'!

!Uno methodsFor: 'arithmetic auxiliar methods' stamp: 'a 9/12/2023 12:42:52'!
divideAFraccion: aFractionToBeDivided
	^ aFractionToBeDivided ! !

!Uno methodsFor: 'arithmetic auxiliar methods' stamp: 'a 9/12/2023 12:43:13'!
divideAnEntero: anIntegerToBeDivided
	^ anIntegerToBeDivided 
! !


!Uno methodsFor: 'arithmetic operations' stamp: 'a 9/11/2023 21:17:43'!
fibonacci

	^ Entero with: 1.
	! !


!Uno methodsFor: 'general auxiliar methods' stamp: 'MH 9/13/2023 12:42:38'!
ifNegativeDo: aReturningClosure otherwiseRun: otherClosure
	otherClosure value.! !

!Uno methodsFor: 'general auxiliar methods' stamp: 'MH 9/13/2023 12:42:45'!
ifOneDo: aReturningClosure otherwiseRun: otherClosure
	aReturningClosure value.! !

!Uno methodsFor: 'general auxiliar methods' stamp: 'MH 9/13/2023 12:42:32'!
ifZeroDo: aReturningClosure otherwiseRun: otherClosure
	otherClosure value.! !


!classDefinition: #Fraccion category: 'Numero-Exercise'!
Numero subclass: #Fraccion
	instanceVariableNames: 'numerator denominator'
	classVariableNames: ''
	poolDictionaries: ''
	category: 'Numero-Exercise'!

!Fraccion methodsFor: 'arithmetic auxiliar methods' stamp: 'a 9/14/2023 13:01:15'!
addAFraccion: aFractionToBeAdded
	| newNumerator newDenominator |
	
	newNumerator := (numerator * aFractionToBeAdded denominator) + (denominator * aFractionToBeAdded numerator).
	newDenominator := denominator * aFractionToBeAdded denominator.

	
	^ self class with: newNumerator over: newDenominator. ! !

!Fraccion methodsFor: 'arithmetic auxiliar methods' stamp: 'a 9/14/2023 13:05:40'!
addAnEntero: anIntegerToBeAdded
	^ anIntegerToBeAdded  addAFraccion: self ! !

!Fraccion methodsFor: 'arithmetic auxiliar methods' stamp: 'MH 9/13/2023 13:20:38'!
divideAFraccion: aFractionToBeDivided
	^ self class with: (aFractionToBeDivided numerator * denominator) over: (aFractionToBeDivided denominator * numerator).! !

!Fraccion methodsFor: 'arithmetic auxiliar methods' stamp: 'MH 9/13/2023 13:14:24'!
divideAnEntero: anIntegerToBeDivided
	^ self class with: (anIntegerToBeDivided * denominator) over: numerator.! !

!Fraccion methodsFor: 'arithmetic auxiliar methods' stamp: 'MH 9/13/2023 13:14:32'!
multiplyAFraccion: aFractionToBeMultiplied
	^ self class with: (numerator * aFractionToBeMultiplied numerator) over: (denominator * aFractionToBeMultiplied denominator).! !

!Fraccion methodsFor: 'arithmetic auxiliar methods' stamp: 'a 9/14/2023 13:05:49'!
multiplyAnEntero: anIntegerToBeMultiplied
	^ anIntegerToBeMultiplied multiplyAFraccion: self! !

!Fraccion methodsFor: 'arithmetic auxiliar methods' stamp: 'MH 9/13/2023 13:17:58'!
substractAFraccion: aFractionToBeSubstracted
	| newDenominator newNumerator |

	newNumerator := (denominator * aFractionToBeSubstracted numerator) - (numerator * aFractionToBeSubstracted denominator) .
	newDenominator := denominator * aFractionToBeSubstracted denominator.

	^ self class with: newNumerator over: newDenominator.! !

!Fraccion methodsFor: 'arithmetic auxiliar methods' stamp: 'MH 9/13/2023 13:18:27'!
substractAnEntero: anIntegerToBeSubstracted
	|  newDenominator newNumerator |

	newNumerator :=(anIntegerToBeSubstracted  * denominator) -  numerator.  
	newDenominator := denominator .

	^ self class with: newNumerator over: newDenominator.! !


!Fraccion methodsFor: 'arithmetic operations' stamp: 'a 9/12/2023 13:15:34'!
* aMultiplier 
	^ aMultiplier multiplyAFraccion: self
	
	! !

!Fraccion methodsFor: 'arithmetic operations' stamp: 'a 9/12/2023 12:42:18'!
+ anAdder 
	
	^anAdder addAFraccion: self
	! !

!Fraccion methodsFor: 'arithmetic operations' stamp: 'a 9/12/2023 13:14:14'!
- aSubtrahend 


	^ aSubtrahend substractAFraccion: self
! !

!Fraccion methodsFor: 'arithmetic operations' stamp: 'a 9/12/2023 13:14:21'!
/ aDivisor 
	^ aDivisor divideAFraccion: self
	! !


!Fraccion methodsFor: 'comparing' stamp: 'HernanWilkinson 5/7/2016 20:42'!
= anObject

	^(anObject isKindOf: self class) and: [ (numerator * anObject denominator) = (denominator * anObject numerator) ]! !

!Fraccion methodsFor: 'comparing' stamp: 'HernanWilkinson 5/7/2016 20:50'!
hash

	^(numerator hash / denominator hash) hash! !


!Fraccion methodsFor: 'accessing' stamp: 'HernanWilkinson 5/7/2016 21:56'!
denominator

	^ denominator! !

!Fraccion methodsFor: 'accessing' stamp: 'HernanWilkinson 5/7/2016 21:56'!
numerator

	^ numerator! !


!Fraccion methodsFor: 'initialization' stamp: 'HernanWilkinson 5/7/2016 22:54'!
initializeWith: aNumerator over: aDenominator

	"Estas precondiciones estan por si se comenten errores en la implementacion - Hernan"
	aNumerator isZero ifTrue: [ self error: 'una fraccion no puede ser cero' ].
	aDenominator isOne ifTrue: [ self error: 'una fraccion no puede tener denominador 1 porque sino es un entero' ].
	
	numerator := aNumerator.
	denominator := aDenominator ! !


!Fraccion methodsFor: 'testing' stamp: 'NR 9/23/2018 23:41:38'!
isNegative
	
	^numerator < 0! !

!Fraccion methodsFor: 'testing' stamp: 'HernanWilkinson 5/7/2016 22:51'!
isOne
	
	^false! !

!Fraccion methodsFor: 'testing' stamp: 'HernanWilkinson 5/7/2016 22:51'!
isZero
	
	^false! !


!Fraccion methodsFor: 'printing' stamp: 'HAW 9/24/2018 08:54:46'!
printOn: aStream

	aStream 
		print: numerator;
		nextPut: $/;
		print: denominator ! !

"-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- "!

!classDefinition: 'Fraccion class' category: 'Numero-Exercise'!
Fraccion class
	instanceVariableNames: ''!

!Fraccion class methodsFor: 'intance creation' stamp: 'MH 9/13/2023 12:46:30'!
with: aDividend over: aDivisor

	| greatestCommonDivisor numerator denominator |
	
	aDivisor ifZeroDo: [ self error: self canNotDivideByZeroErrorDescription ] otherwiseRun: [
		aDividend ifZeroDo: [ ^aDividend ] otherwiseRun: [
			aDivisor ifNegativeDo: [ ^aDividend negated / aDivisor negated ] otherwiseRun: [
				greatestCommonDivisor := aDividend greatestCommonDivisorWith: aDivisor. 
				numerator := aDividend // greatestCommonDivisor.
				denominator := aDivisor // greatestCommonDivisor.
				
				denominator ifOneDo: [ ^numerator ] otherwiseRun: [
					^self new initializeWith: numerator over: denominator
				].
			].
		].
	].! !
