"
This class contains tests of a parser for a little parenthesised language.
"
Class {
	#name : #DLittleLParserTest,
	#superclass : #TestCase,
	#category : #'Descent-Parser'
}

{ #category : #tests }
DLittleLParserTest >> testParseFullExample [
	| p list |
	p := DLittleLParser new. 
	list := p parse: '(author : Aldiss 
  (serie : helliconia  
   		(title: Printempts (read: no) (style: SF) (price: 1))
  	 	(title: Helliconia (read: no)  (style: SF) (price: 1)
 	  	(title: hiver (read: no)  (style: SF) (price: 1))))
  (books : bla
    	( title: eclipse (read: no)  (style: fantaisie) (price: 1))))'.
	self assert: list prettyPrintString equals: 
'(author : Aldiss
(serie : helliconia
(title : Printempts
(read : no) (style : SF) (price : 1)) (title : Helliconia
(read : no) (style : SF) (price : 1) (title : hiver
(read : no) (style : SF) (price : 1)))) (books : bla
(title : eclipse
(read : no) (style : fantaisie) (price : 1))))'
]

{ #category : #tests }
DLittleLParserTest >> testParseSimplePair [
	| p pair |
	p := DLittleLParser new. 
	pair := p parse: '(read: 1)'.
	self assert: pair key equals: 'read'.
	self assert: pair value equals: '1'.
	self assert: pair printString equals: '(read : 1)'
]

{ #category : #tests }
DLittleLParserTest >> testParseSimplePairWithRest [
	| p list |
	p := DLittleLParser new. 
	list := p parse: '(firstKey : firstValue (secondKey: secondValue))'.
	self assert: list key equals: 'firstKey'.
	self assert: list value equals: 'firstValue'.
	self assert: list restIsEmpty not.
	self assert: list printString equals: '(firstKey : firstValue (secondKey : secondValue))'
]

{ #category : #tests }
DLittleLParserTest >> testParseSimplePairWithRest2 [
	| p list |
	p := DLittleLParser new. 
	list := p parse: '(firstKey : firstValue (secondKey : secondValue (key : val)))'.
	self assert: list printString equals: '(firstKey : firstValue (secondKey : secondValue (key : val)))'
]

{ #category : #tests }
DLittleLParserTest >> testParseSimplePairWithRestList [
	| p list |
	p := DLittleLParser new. 
	list := p parse: '(firstKey : firstValue (secondKey: secondValue) (thirdKey : thirdValue))'.
	self assert: list key equals: 'firstKey'.
	self assert: list value equals: 'firstValue'.
	self assert: list restIsEmpty not.
	
	self assert: list printString equals: '(firstKey : firstValue (secondKey : secondValue) (thirdKey : thirdValue))'
]