!classDefinition: #I category: 'Numeros Naturales'!
DenotativeObject subclass: #I
	instanceVariableNames: ''
	classVariableNames: ''
	poolDictionaries: ''
	category: 'Numeros Naturales'!

"-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- "!

!classDefinition: 'I class' category: 'Numeros Naturales'!
I class
	instanceVariableNames: 'sucesor'!

!I class methodsFor: 'as yet unclassified' stamp: 'e 8/28/2023 15:13:22'!
* aNaturalNumber
	^ aNaturalNumber 
		! !

!I class methodsFor: 'as yet unclassified' stamp: 'a 8/31/2023 15:44:50'!
+ aNaturalNumber
	^aNaturalNumber next
		! !

!I class methodsFor: 'as yet unclassified' stamp: 'a 9/3/2023 11:57:05'!
- unRestando

	self error: (self descripcionDeErrorDeNumerosNegativosNoSoportados) ! !

!I class methodsFor: 'as yet unclassified' stamp: 'a 9/3/2023 17:02:13'!
/ unDivisor
	unDivisor  = I 
	ifFalse: [self error: (self descripcionDeErrorDeNoSePuedeDividirPorUnNumeroMayor )].
				      
	^I
	
		 
		
		
	! !

!I class methodsFor: 'as yet unclassified' stamp: 'a 9/3/2023 16:51:36'!
< unNatural
   	^(unNatural = I) = false
	
		
		
	! !

!I class methodsFor: 'as yet unclassified' stamp: 'a 9/3/2023 12:03:53'!
descripcionDeErrorDeNoSePuedeDividirPorUnNumeroMayor
	^ 'Un numero no se puede dividir por un número mayor'! !

!I class methodsFor: 'as yet unclassified' stamp: 'a 9/3/2023 11:57:11'!
descripcionDeErrorDeNumerosNegativosNoSoportados
	^'No se soportan números negativos'! !

!I class methodsFor: 'as yet unclassified' stamp: 'e 8/28/2023 20:40:38'!
dividiteA: unDividendo
	^ unDividendo
		
		
	! !

!I class methodsFor: 'as yet unclassified' stamp: 'a 9/3/2023 16:54:39'!
eresMayorA: unNatural
   	^false 
	
		
		
	! !

!I class methodsFor: 'as yet unclassified' stamp: 'a 8/31/2023 15:45:07'!
next
	
	sucesor  
			ifNotNil: 
			[^sucesor] 
			ifNil: 
			[ sucesor := self cloneNamed: 	 self name, 'I'.  
			  sucesor previous: self. 
			  ^sucesor.]. 
		 
	 
		! !

!I class methodsFor: 'as yet unclassified' stamp: 'a 8/31/2023 15:44:40'!
restateA: aNaturalNumber

	^aNaturalNumber previous
		! !


!I class methodsFor: '--** private fileout/in **--' stamp: 'a 9/3/2023 18:33:50'!
initializeCollaboratorsFromFile
	"Auto generated method for loading purposes - Do not modify it"

	sucesor := II.! !


!classDefinition: #II category: 'Numeros Naturales'!
DenotativeObject subclass: #II
	instanceVariableNames: ''
	classVariableNames: ''
	poolDictionaries: ''
	category: 'Numeros Naturales'!

"-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- "!

!classDefinition: 'II class' category: 'Numeros Naturales'!
II class
	instanceVariableNames: 'sucesor previo'!

!II class methodsFor: 'as yet unclassified' stamp: 's 8/31/2023 20:10:53'!
* aNaturalNumber
	^  self previous * aNaturalNumber + aNaturalNumber  ! !

!II class methodsFor: 'as yet unclassified' stamp: 'a 9/3/2023 11:30:06'!
+ aNaturalNumber
	^  self previous + aNaturalNumber next ! !

!II class methodsFor: 'as yet unclassified' stamp: 's 8/24/2023 21:54:36'!
- aNaturalNumber
 	^ aNaturalNumber restateA: self! !

!II class methodsFor: 'as yet unclassified' stamp: 'e 8/28/2023 20:56:48'!
/ unDivisor
	^ unDivisor dividiteA: self
	
		
	! !

!II class methodsFor: 'as yet unclassified' stamp: 'a 9/3/2023 16:54:27'!
< unNatural

	^unNatural eresMayorA: self ! !

!II class methodsFor: 'as yet unclassified' stamp: 'a 9/3/2023 12:02:29'!
descripcionDeErrorDeNoSePuedeDividirPorUnNumeroMayor
	^ 'Un numero no se puede dividir por un número mayor'! !

!II class methodsFor: 'as yet unclassified' stamp: 'a 9/3/2023 16:58:03'!
dividiteA: unDividendo

	unDividendo = self  ifTrue:  [^I].
	
	(unDividendo < self)	 ifTrue: [self error: self descripcionDeErrorDeNoSePuedeDividirPorUnNumeroMayor].

 	^ (unDividendo - self) / self + I
		
	! !

!II class methodsFor: 'as yet unclassified' stamp: 'a 9/3/2023 16:54:01'!
eresMayorA: unNatural

	^ (unNatural previous) < (self previous )! !

!II class methodsFor: 'as yet unclassified' stamp: 'a 8/31/2023 15:45:22'!
next
	sucesor 
		ifNil:    
		[ sucesor := II createChildNamed: 	 self name , 'I' .  
		  sucesor previous: self.
		  ^sucesor.]
		ifNotNil:
		[^sucesor].
		 
	 
		! !

!II class methodsFor: 'as yet unclassified' stamp: 'a 8/31/2023 14:30:19'!
previous
 
	^previo! !

!II class methodsFor: 'as yet unclassified' stamp: 'a 9/3/2023 11:27:53'!
previous: previoAMi
	
	previo := previoAMi 
				! !

!II class methodsFor: 'as yet unclassified' stamp: 'a 8/31/2023 15:43:18'!
restateA: aNaturalNumber

	^ aNaturalNumber previous  - self previous! !


!II class methodsFor: '--** private fileout/in **--' stamp: 'a 9/3/2023 18:33:50'!
initializeCollaboratorsFromFile
	"Auto generated method for loading purposes - Do not modify it"

	sucesor := III.
	previo := I.! !


!classDefinition: #III category: 'Numeros Naturales'!
II subclass: #III
	instanceVariableNames: ''
	classVariableNames: ''
	poolDictionaries: ''
	category: 'Numeros Naturales'!

"-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- "!

!classDefinition: 'III class' category: 'Numeros Naturales'!
III class
	instanceVariableNames: ''!

!III class methodsFor: '--** private fileout/in **--' stamp: 'a 9/3/2023 18:33:50'!
initializeCollaboratorsFromFile
	"Auto generated method for loading purposes - Do not modify it"

	sucesor := IIII.
	previo := II.! !


!classDefinition: #IIII category: 'Numeros Naturales'!
II subclass: #IIII
	instanceVariableNames: ''
	classVariableNames: ''
	poolDictionaries: ''
	category: 'Numeros Naturales'!

"-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- "!

!classDefinition: 'IIII class' category: 'Numeros Naturales'!
IIII class
	instanceVariableNames: ''!

!IIII class methodsFor: '--** private fileout/in **--' stamp: 'a 9/3/2023 18:33:50'!
initializeCollaboratorsFromFile
	"Auto generated method for loading purposes - Do not modify it"

	sucesor := nil.
	previo := III.! !

I initializeAfterFileIn!
II initializeAfterFileIn!
III initializeAfterFileIn!
IIII initializeAfterFileIn!