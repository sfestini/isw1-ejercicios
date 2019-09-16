!classDefinition: #NumeroTest category: #'Numero-Exercise'!
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

!NumeroTest methodsFor: 'tests' stamp: 'NR 9/23/2018 23:47:26'!
test27EnteroSubstractsEnteroCorrectly

	self assert: two - one equals: one! !

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


!classDefinition: #Numero category: #'Numero-Exercise'!
Object subclass: #Numero
	instanceVariableNames: ''
	classVariableNames: ''
	poolDictionaries: ''
	category: 'Numero-Exercise'!

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

!classDefinition: 'Numero class' category: #'Numero-Exercise'!
Numero class
	instanceVariableNames: ''!

!Numero class methodsFor: 'error descriptions' stamp: 'HernanWilkinson 5/7/2016 22:45'!
canNotDivideByZeroErrorDescription

	^'No se puede dividir por cero'! !

!Numero class methodsFor: 'error descriptions' stamp: 'NR 4/8/2019 02:58:13'!
invalidNumberTypeErrorDescription
	^ 'Tipo de número inválido'! !


!classDefinition: #Entero category: #'Numero-Exercise'!
Numero subclass: #Entero
	instanceVariableNames: 'value'
	classVariableNames: ''
	poolDictionaries: ''
	category: 'Numero-Exercise'!

!Entero methodsFor: 'arithmetic operations' stamp: 'Santiago Festini 9/13/2019 16:09:03'!
* aMultiplier 
	
	^aMultiplier multiplicarConEntero: self.! !

!Entero methodsFor: 'arithmetic operations' stamp: 'Santiago Festini 9/12/2019 20:48:24'!
+ anAdder 
	
	^ anAdder sumarConEntero: self! !

!Entero methodsFor: 'arithmetic operations' stamp: 'Santiago Festini 9/12/2019 21:03:11'!
- aSubtrahend 
	^ aSubtrahend restarConEntero: self! !

!Entero methodsFor: 'arithmetic operations' stamp: 'Santiago Festini 9/13/2019 16:16:26'!
/ aDivisor 
	
	^ aDivisor dividirConEntero: self! !

!Entero methodsFor: 'arithmetic operations' stamp: 'HernanWilkinson 5/7/2016 21:55'!
// aDivisor 
	
	^self class with: value // aDivisor integerValue! !

!Entero methodsFor: 'arithmetic operations' stamp: 'Santiago Festini 9/13/2019 16:15:53'!
dividirConEntero: aDivisor 
	
	^Fraccion with: aDivisor over: self! !

!Entero methodsFor: 'arithmetic operations' stamp: 'Santiago Festini 9/13/2019 16:14:52'!
dividirConFraccion: aDivisor

	^ aDivisor numerator / (aDivisor denominator * self)! !

!Entero methodsFor: 'arithmetic operations' stamp: 'Santiago Festini 9/16/2019 12:39:26'!
fibonacci

	^self subclassResponsibility

"	| one two |
	
	one := Entero with: 1.
	two := Entero with: 2.
	
	self isNegative ifTrue: [self error: Entero negativeFibonacciErrorDescription ].	
	(self isZero or: [self isOne]) ifTrue: [^one].
	
	^ (self - one) fibonacci + (self - two) fibonacci"
		! !

!Entero methodsFor: 'arithmetic operations' stamp: 'HernanWilkinson 5/7/2016 21:00'!
greatestCommonDivisorWith: anEntero 
	
	^self class with: (value gcd: anEntero integerValue)! !

!Entero methodsFor: 'arithmetic operations' stamp: 'Santiago Festini 9/16/2019 12:57:21'!
multiplicarConEntero: aMultiplier 
	
	^Entero with: value * aMultiplier integerValue
	! !

!Entero methodsFor: 'arithmetic operations' stamp: 'Santiago Festini 9/13/2019 16:07:48'!
multiplicarConFraccion: aMultiplier

	^(self value * aMultiplier numerator) / aMultiplier denominator.! !

!Entero methodsFor: 'arithmetic operations' stamp: 'Santiago Festini 9/12/2019 21:41:48'!
restarConEntero: aSubtrahend 

	^  self class with: (aSubtrahend integerValue - value).! !

!Entero methodsFor: 'arithmetic operations' stamp: 'Santiago Festini 9/13/2019 17:17:53'!
restarConFraccion: aSubtrahend
	
	^ (aSubtrahend numerator - (self * aSubtrahend denominator)) / (aSubtrahend denominator )
	
	
	! !

!Entero methodsFor: 'arithmetic operations' stamp: 'Santiago Festini 9/16/2019 12:57:08'!
sumarConEntero: anAdder

	^Entero with: value + anAdder integerValue! !

!Entero methodsFor: 'arithmetic operations' stamp: 'Santiago Festini 9/12/2019 22:02:44'!
sumarConFraccion: anAdder 

	^ ((self * anAdder denominator + anAdder numerator) )/ (anAdder denominator)! !


!Entero methodsFor: 'comparing' stamp: 'HernanWilkinson 5/7/2016 21:01'!
= anObject

	^(anObject isKindOf: self class) and: [ value = anObject integerValue ]! !

!Entero methodsFor: 'comparing' stamp: 'HernanWilkinson 5/7/2016 20:17'!
hash

	^value hash! !


!Entero methodsFor: 'initialization' stamp: 'HernanWilkinson 5/7/2016 20:09'!
initalizeWith: aValue 
	
	value := aValue! !


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

"-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- "!

!classDefinition: 'Entero class' category: #'Numero-Exercise'!
Entero class
	instanceVariableNames: ''!

!Entero class methodsFor: 'instance creation' stamp: 'NR 4/8/2019 02:57:57'!
negativeFibonacciErrorDescription
	^ ' Fibonacci no está definido aquí para Enteros Negativos'! !

!Entero class methodsFor: 'instance creation' stamp: 'Santiago Festini 9/16/2019 15:22:24'!
with: aValue 
	
	"Esta verificacion esta puesta por si se equivocan y quieren crear un Entero pasando otra cosa que un Integer - Hernan"
	aValue isInteger ifFalse: [  self error: 'aValue debe ser anInteger' ].
	
	aValue = 0 ifTrue: [^Cero new initialize].
	aValue = 1 ifTrue: [^Uno new initialize].
	aValue < 0 ifTrue: [^Negativo new initializeWith: aValue].
	^Positivo new initializeWith: aValue.! !


!classDefinition: #Cero category: #'Numero-Exercise'!
Entero subclass: #Cero
	instanceVariableNames: ''
	classVariableNames: ''
	poolDictionaries: ''
	category: 'Numero-Exercise'!

!Cero methodsFor: 'initialization' stamp: 'Santiago Festini 9/16/2019 12:33:22'!
initialize

	value := 0.! !


!Cero methodsFor: 'arithmetic operations' stamp: 'Santiago Festini 9/16/2019 14:51:56'!
casosBaseCrearFraccionConNumerador: UnNumerador

	self error: Entero canNotDivideByZeroErrorDescription! !

!Cero methodsFor: 'arithmetic operations' stamp: 'Santiago Festini 9/16/2019 14:41:10'!
crearFraccionConDenominador: unDenominador

	^self

	! !

!Cero methodsFor: 'arithmetic operations' stamp: 'Santiago Festini 9/16/2019 14:51:49'!
crearFraccionConNumerador: unNumerador

	self error: Entero canNotDivideByZeroErrorDescription

	! !

!Cero methodsFor: 'arithmetic operations' stamp: 'Santiago Festini 9/16/2019 12:34:16'!
fibonacci 

	^Entero with: 1.! !


!classDefinition: #Negativo category: #'Numero-Exercise'!
Entero subclass: #Negativo
	instanceVariableNames: ''
	classVariableNames: ''
	poolDictionaries: ''
	category: 'Numero-Exercise'!

!Negativo methodsFor: 'initialization' stamp: 'Santiago Festini 9/16/2019 12:53:26'!
initializeWith: aValue 
	
	value := aValue! !


!Negativo methodsFor: 'arithmetic operations' stamp: 'Santiago Festini 9/16/2019 14:34:19'!
casosBaseCrearFraccionConNumerador: unNumerador

	^unNumerador negated / self negated! !

!Negativo methodsFor: 'arithmetic operations' stamp: 'Santiago Festini 9/16/2019 14:45:25'!
crearFraccionConDenominador: unDenominador

	^Fraccion new initializeWith: self over: unDenominador! !

!Negativo methodsFor: 'arithmetic operations' stamp: 'Santiago Festini 9/16/2019 14:48:05'!
crearFraccionConNumerador: unNumerador

	^unNumerador negated / self negated! !

!Negativo methodsFor: 'arithmetic operations' stamp: 'Santiago Festini 9/16/2019 12:35:49'!
fibonacci

	^self error: Entero negativeFibonacciErrorDescription.! !


!classDefinition: #Positivo category: #'Numero-Exercise'!
Entero subclass: #Positivo
	instanceVariableNames: ''
	classVariableNames: ''
	poolDictionaries: ''
	category: 'Numero-Exercise'!

!Positivo methodsFor: 'initialization' stamp: 'Santiago Festini 9/16/2019 12:53:05'!
initializeWith: aValue 
	
	value := aValue! !


!Positivo methodsFor: 'arithmetic operations' stamp: 'Santiago Festini 9/16/2019 15:06:28'!
casosBaseCrearFraccionConNumerador: unNumerador

	| greatestCommonDivisor numerator denominator |
	
	greatestCommonDivisor := unNumerador greatestCommonDivisorWith: self. 
	numerator := unNumerador // greatestCommonDivisor.
	denominator := self // greatestCommonDivisor.	

	^denominator crearFraccionConNumerador: numerator! !

!Positivo methodsFor: 'arithmetic operations' stamp: 'Santiago Festini 9/16/2019 14:45:12'!
crearFraccionConDenominador: unDenominador

	^Fraccion new initializeWith: self over: unDenominador! !

!Positivo methodsFor: 'arithmetic operations' stamp: 'Santiago Festini 9/16/2019 14:46:25'!
crearFraccionConNumerador: unNumerador

	^unNumerador crearFraccionConDenominador: self! !

!Positivo methodsFor: 'arithmetic operations' stamp: 'Santiago Festini 9/16/2019 13:59:00'!
fibonacci

	| one two |
	
	one := Entero with: 1.
	two := Entero with: 2.
		
	^ (Entero with: (self integerValue - one integerValue)) fibonacci + (Entero with: (self integerValue - two integerValue)) fibonacci
		! !


!classDefinition: #Uno category: #'Numero-Exercise'!
Entero subclass: #Uno
	instanceVariableNames: ''
	classVariableNames: ''
	poolDictionaries: ''
	category: 'Numero-Exercise'!

!Uno methodsFor: 'arithmetic operations' stamp: 'Santiago Festini 9/16/2019 14:24:43'!
casosBaseCrearFraccionConNumerador: unNumerador

	^unNumerador .! !

!Uno methodsFor: 'arithmetic operations' stamp: 'Santiago Festini 9/16/2019 14:45:38'!
crearFraccionConDenominador: unDenominador

	^Fraccion new initializeWith: self over: unDenominador! !

!Uno methodsFor: 'arithmetic operations' stamp: 'Santiago Festini 9/16/2019 14:24:51'!
crearFraccionConNumerador: unNumerador

	^unNumerador .! !

!Uno methodsFor: 'arithmetic operations' stamp: 'Santiago Festini 9/16/2019 12:35:06'!
fibonacci

	^self! !


!Uno methodsFor: 'initialization' stamp: 'Santiago Festini 9/16/2019 12:33:29'!
initialize

	value := 1.! !


!classDefinition: #Fraccion category: #'Numero-Exercise'!
Numero subclass: #Fraccion
	instanceVariableNames: 'numerator denominator'
	classVariableNames: ''
	poolDictionaries: ''
	category: 'Numero-Exercise'!

!Fraccion methodsFor: 'arithmetic operations' stamp: 'Santiago Festini 9/16/2019 13:54:24'!
* aMultiplier 
	
	^aMultiplier multiplicarConFraccion: self
	! !

!Fraccion methodsFor: 'arithmetic operations' stamp: 'Santiago Festini 9/12/2019 20:57:04'!
+ anAdder 
	
	^ anAdder sumarConFraccion: self
	! !

!Fraccion methodsFor: 'arithmetic operations' stamp: 'Santiago Festini 9/12/2019 21:01:51'!
- aSubtrahend 
	
	^ aSubtrahend restarConFraccion:  self! !

!Fraccion methodsFor: 'arithmetic operations' stamp: 'Santiago Festini 9/13/2019 16:20:01'!
/ aDivisor 
	
	^ aDivisor dividirConFraccion: self ! !

!Fraccion methodsFor: 'arithmetic operations' stamp: 'Santiago Festini 9/13/2019 16:21:11'!
dividirConEntero: aDivisor

	^ aDivisor * (self denominator / self numerator ) ! !

!Fraccion methodsFor: 'arithmetic operations' stamp: 'Santiago Festini 9/13/2019 16:19:29'!
dividirConFraccion: aDivisor

	^ aDivisor * ( self denominator / self numerator )! !

!Fraccion methodsFor: 'arithmetic operations' stamp: 'Santiago Festini 9/13/2019 16:11:19'!
multiplicarConEntero: aMultiplier

	^ self numerator * aMultiplier / self denominator ! !

!Fraccion methodsFor: 'arithmetic operations' stamp: 'Santiago Festini 9/16/2019 15:05:52'!
multiplicarConFraccion: aMultiplier 
	
	^(numerator * aMultiplier numerator) / (denominator * aMultiplier denominator)
	! !

!Fraccion methodsFor: 'arithmetic operations' stamp: 'Santiago Festini 9/13/2019 17:18:15'!
restarConEntero: aSubtrahend 
	
	^ ((aSubtrahend * denominator ) - numerator  )/ denominator 
! !

!Fraccion methodsFor: 'arithmetic operations' stamp: 'Santiago Festini 9/12/2019 21:51:49'!
restarConFraccion: aSubtrahend 
	
	| newNumerator newDenominator |
	
	newNumerator :=  (denominator * aSubtrahend numerator) - (numerator * aSubtrahend denominator).
	newDenominator := denominator * aSubtrahend denominator.
	
	^newNumerator / newDenominator 
! !

!Fraccion methodsFor: 'arithmetic operations' stamp: 'Santiago Festini 9/12/2019 21:54:05'!
sumarConEntero: anAdder

	^ ((anAdder * denominator) + numerator) / denominator.! !

!Fraccion methodsFor: 'arithmetic operations' stamp: 'Santiago Festini 9/12/2019 20:51:31'!
sumarConFraccion: anAdder

	| newNumerator newDenominator |
	
	newNumerator := (numerator * anAdder denominator) + (denominator * anAdder numerator).
	newDenominator := denominator * anAdder denominator.
	
	^newNumerator / newDenominator ! !


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

!classDefinition: 'Fraccion class' category: #'Numero-Exercise'!
Fraccion class
	instanceVariableNames: ''!

!Fraccion class methodsFor: 'intance creation' stamp: 'Santiago Festini 9/16/2019 14:52:49'!
with: aDividend over: aDivisor

	^ aDivisor casosBaseCrearFraccionConNumerador: aDividend.! !
