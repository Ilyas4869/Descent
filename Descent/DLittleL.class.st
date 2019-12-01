"
A little list description language

(author : Aldiss / Brian 
  (serie : helliconia  
   		(title: Le printemps d'helliconia (read: no)  (style: SF) (price: 1))
  	 	(title: Helliconia, l'ete, read: no,  style: SF, price: 1)
 	  	(title: L'hiver d'helliconia, read: no,  style: SF, price: 1))
  (books:
    	( title: L'instant de l'eclipse (read: no)  (style: fantaisie) (price: 1))


Grammar

pair ->  '(' key ':' value following ')'	
following ->   ('(' pair ')') *

A possible variation is to introduce , to avoid ( )

(author : Aldiss / Brian 
  (serie : helliconia  
   		(title: Le printemps d'helliconia, read: no,  style: SF, price: 1)
  	 	(title: Helliconia, l'ete, read: no,  style: SF, price: 1)
 	  	(title: L'hiver d'helliconia, read: no,  style: SF, price: 1))
  (books:
    	( title: L'instant de l'eclipse, read: no,  style: fantaisie, price: 1))




(authors : 
     (author : foo), (author : herbert)
     (serie : helliconia  

Name : letter+digit+'
Separators  : : ( ) , 
Key : Name







DTD
<?xml version=""1.0"" encoding=""UTF-8"" standalone=""yes""?>
<!DOCTYPE liste_de_gens [
 <!ELEMENT liste_de_gens (personne)*>
 <!ELEMENT personne (nom, date_de_naissance?, genre?, numero_de_secu?)>
 <!ELEMENT nom (#PCDATA)>
 <!ELEMENT date_de_naissance (#PCDATA)>
 <!ELEMENT genre (#PCDATA | masculin | féminin) ""féminin"">
 <!ELEMENT numero_de_secu (#PCDATA)>
]>



"
Class {
	#name : #DLittleL,
	#superclass : #Object,
	#instVars : [
		'l'
	],
	#category : #Descent
}

{ #category : #parsing }
DLittleL >> parse2: aString [ 
	l := DLexer new.
	l on: aString.
	l nextToken = $(
		ifTrue: [ 
					| key value sep pair |
					key := l nextToken.
					sep := l nextToken.
					sep = $:
						ifFalse: [ self error: 'Missing :' ]
						ifTrue: [ value := l nextToken.
							pair := DLPair new key: key ; value: value.
							l nextToken = $)
									ifFalse: [ self error: 'Missing )'   ].
					 		^ pair  
					]]
		ifFalse: [ self error: 'Missing (' ]
]

{ #category : #parsing }
DLittleL >> parse3: aString [ 

	l := DLexer new.
	l on: aString.
	^ self scanPair
]

{ #category : #parsing }
DLittleL >> parse4: aString [ 
	| pair |
	l := DLexer new.
	l on: aString.
	l nextToken = $(
		ifFalse: [ self error: 'Missing (' ]
		ifTrue: [ 
			pair := self scanPairBody.
			Transcript show: pair printString.
			^ pair ].
	
]

{ #category : #parsing }
DLittleL >> parse: aString [ 

	l := DLexer new.
	l on: aString.
	^ self scanPair
]

{ #category : #parsing }
DLittleL >> scanPair [
	| pair |
	l nextToken = $(
		ifFalse: [ self error: 'Missing (' ]
		ifTrue: [ 
			pair := self scanPairBody.
			Transcript show: pair printString.
			^ pair ]
]

{ #category : #parsing }
DLittleL >> scanPairBody [
	| key value sep pair |
	key := l nextToken.
	sep := l nextToken.
	sep = $:
		ifFalse: [ self error: 'Missing :' ]
		ifTrue: [ 
				value := l nextToken.
				pair := DLPair new key: key ; value: value.
				l nextToken = $)
					ifFalse: [ self error: 'Missing )'   ].
				^ pair  
		]
]