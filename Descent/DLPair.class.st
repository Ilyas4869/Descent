"
I represent a pair: a:b and c:d in the following


( a : b )
( a : b ( c : d))
"
Class {
	#name : #DLPair,
	#superclass : #Object,
	#instVars : [
		'key',
		'value'
	],
	#category : #Descent
}

{ #category : #'instance creation' }
DLPair class >> key: aKey value: aValue [ 
	^ self new key: aKey ; value: aValue; yourself
]

{ #category : #accessing }
DLPair >> key [
	^ key
]

{ #category : #accessing }
DLPair >> key: aString [ 
	key := aString
]

{ #category : #printing }
DLPair >> printBodyOn: aStream [

	aStream print: key.
	aStream << ' : '.
	aStream print: value.


]

{ #category : #printing }
DLPair >> printOn: aStream [

	aStream << '('.
	self printBodyOn: aStream.
	aStream << ')'

]

{ #category : #accessing }
DLPair >> value [
	^ value
]

{ #category : #accessing }
DLPair >> value: anObject [
	value := anObject
]