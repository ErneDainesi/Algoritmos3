!classDefinition: #MarsRoverTests category: '05-MarsRover'!
TestCase subclass: #MarsRoverTests
	instanceVariableNames: ''
	classVariableNames: ''
	poolDictionaries: ''
	category: '05-MarsRover'!

!MarsRoverTests methodsFor: 'move forward tests' stamp: 'MFR 12/4/2020 19:25:08'!
test01MarsRoverMovesForwardFacingNorthCorrectly
	
	| marsRover |
	
	marsRover := MarsRover initialPosition: 1@1 facing: #North.
	
	marsRover executeCommand: 'f'.
	
	self assert: (marsRover isOnPosition: 1@2).! !

!MarsRoverTests methodsFor: 'move forward tests' stamp: 'MFR 12/4/2020 19:25:31'!
test02MarsRoverMovesForwardFacingEastCorrectly
	
	| marsRover |
	
	marsRover := MarsRover initialPosition: 1@1 facing: #East.
	
	marsRover executeCommand: 'f'.
	
	self assert: (marsRover isOnPosition: 2@1).! !

!MarsRoverTests methodsFor: 'move forward tests' stamp: 'MFR 12/4/2020 19:25:53'!
test03MarsRoverMovesForwardFacingSouthCorrectly
	
	| marsRover |
	
	marsRover := MarsRover initialPosition: 1@1 facing: #South.
	
	marsRover executeCommand: 'f'.
	
	self assert: (marsRover isOnPosition: 1@0).! !

!MarsRoverTests methodsFor: 'move forward tests' stamp: 'MFR 12/4/2020 19:26:09'!
test04MarsRoverMovesForwardFacingWestCorrectly
	
	| marsRover |
	
	marsRover := MarsRover initialPosition: 1@1 facing: #West.
	
	marsRover executeCommand: 'f'.
	
	self assert: (marsRover isOnPosition: 0@1).! !


!MarsRoverTests methodsFor: 'move backwards tests' stamp: 'MFR 12/4/2020 19:34:02'!
test05MarsRoverMovesBackwardsFacingNorthCorrectly

	| marsRover |
	
	marsRover := MarsRover initialPosition: 1@1 facing: #North.
	
	marsRover executeCommand: 'b'.
	
	self assert: (marsRover isOnPosition: 1@0).! !

!MarsRoverTests methodsFor: 'move backwards tests' stamp: 'MFR 12/4/2020 19:34:29'!
test06MarsRoverMovesBackwardsFacingEastCorrectly

	| marsRover |
	
	marsRover := MarsRover initialPosition: 1@1 facing: #East.
	
	marsRover executeCommand: 'b'.
	
	self assert: (marsRover isOnPosition: 0@1).! !

!MarsRoverTests methodsFor: 'move backwards tests' stamp: 'MFR 12/4/2020 19:34:47'!
test07MarsRoverMovesBackwardsFacingSouthCorrectly

	| marsRover |
	
	marsRover := MarsRover initialPosition: 1@1 facing: #South.
	
	marsRover executeCommand: 'b'.
	
	self assert: (marsRover isOnPosition: 1@2).! !

!MarsRoverTests methodsFor: 'move backwards tests' stamp: 'MFR 12/4/2020 19:35:24'!
test08MarsRoverMovesBackwardsFacingWestCorrectly

	| marsRover |
	
	marsRover := MarsRover initialPosition: 1@1 facing: #West.
	
	marsRover executeCommand: 'b'.
	
	self assert: (marsRover isOnPosition: 2@1).! !


!MarsRoverTests methodsFor: 'rotates towards right tests' stamp: 'MFR 12/4/2020 20:04:34'!
test09MarsRoverRotates90DegreesTowardsRightFacingNorthCorrectly

	| marsRover |
	
	marsRover := MarsRover initialPosition: 1@1 facing: #North.
	
	marsRover executeCommand: 'r'.
	
	self assert: (marsRover isFacing: #East).! !

!MarsRoverTests methodsFor: 'rotates towards right tests' stamp: 'MFR 12/4/2020 20:04:46'!
test10MarsRoverRotates90DegreesTowardsRightFacingEastCorrectly

	| marsRover |
	
	marsRover := MarsRover initialPosition: 1@1 facing: #East.
	
	marsRover executeCommand: 'r'.
	
	self assert: (marsRover isFacing: #South).! !

!MarsRoverTests methodsFor: 'rotates towards right tests' stamp: 'MFR 12/4/2020 20:04:59'!
test11MarsRoverRotates90DegreesTowardsRightFacingSouthCorrectly

	| marsRover |
	
	marsRover := MarsRover initialPosition: 1@1 facing: #South.
	
	marsRover executeCommand: 'r'.
	
	self assert: (marsRover isFacing: #West).! !

!MarsRoverTests methodsFor: 'rotates towards right tests' stamp: 'MFR 12/4/2020 20:05:14'!
test12MarsRoverRotates90DegreesTowardsRightFacingWestCorrectly

	| marsRover |
	
	marsRover := MarsRover initialPosition: 1@1 facing: #West.
	
	marsRover executeCommand: 'r'.
	
	self assert: (marsRover isFacing: #North).! !


!MarsRoverTests methodsFor: 'rotates towards left tests' stamp: 'MFR 12/4/2020 20:05:31'!
test13MarsRoverRotates90DegreesTowardsLeftFacingNorthCorrectly

	| marsRover |
	
	marsRover := MarsRover initialPosition: 1@1 facing: #North.
	
	marsRover executeCommand: 'l'.
	
	self assert: (marsRover isFacing: #West).! !

!MarsRoverTests methodsFor: 'rotates towards left tests' stamp: 'MFR 12/4/2020 20:06:11'!
test14MarsRoverRotates90DegreesTowardsLeftFacingEastCorrectly

	| marsRover |
	
	marsRover := MarsRover initialPosition: 1@1 facing: #East.
	
	marsRover executeCommand: 'l'.
	
	self assert: (marsRover isFacing: #North).! !

!MarsRoverTests methodsFor: 'rotates towards left tests' stamp: 'MFR 12/4/2020 20:06:31'!
test15MarsRoverRotates90DegreesTowardsLeftFacingSouthCorrectly

	| marsRover |
	
	marsRover := MarsRover initialPosition: 1@1 facing: #South.
	
	marsRover executeCommand: 'l'.
	
	self assert: (marsRover isFacing: #East).! !

!MarsRoverTests methodsFor: 'rotates towards left tests' stamp: 'MFR 12/4/2020 20:06:41'!
test16MarsRoverRotates90DegreesTowardsLeftFacingWestCorrectly

	| marsRover |
	
	marsRover := MarsRover initialPosition: 1@1 facing: #West.
	
	marsRover executeCommand: 'l'.
	
	self assert: (marsRover isFacing: #South).! !


!MarsRoverTests methodsFor: 'process commands tests' stamp: 'MFR 12/4/2020 20:36:26'!
test17MarsRoverExecutesMoreThanOneCommandCorrectly

	| marsRover |
	
	marsRover := MarsRover initialPosition: 1@1 facing: #North.
	
	marsRover executeCommand: 'fr'.
	
	self assert: (marsRover isOnPosition: 1@2).
	self assert: (marsRover isFacing: #East).! !

!MarsRoverTests methodsFor: 'process commands tests' stamp: 'MFR 12/4/2020 20:36:59'!
test18MarsRoverStopsProcessingCommandsWhenInvalidCommandIsEntered

	| marsRover |
	
	marsRover := MarsRover initialPosition: 1@1 facing: #North.
	
	marsRover executeCommand: 'fjr'.
	
	self assert: (marsRover isOnPosition: 1@2).
	self deny: (marsRover isFacing: #East).! !


!classDefinition: #MarsRover category: '05-MarsRover'!
Object subclass: #MarsRover
	instanceVariableNames: 'position cardinalPointFaced'
	classVariableNames: ''
	poolDictionaries: ''
	category: '05-MarsRover'!

!MarsRover methodsFor: 'commands' stamp: 'MFR 12/4/2020 20:34:40'!
executeCommand: aSequenceOfCommands

	| commandSequenceIndex |
	
	commandSequenceIndex := 1.
	
	aSequenceOfCommands size timesRepeat: [ | aCommand |
		aCommand := aSequenceOfCommands at: commandSequenceIndex.
		
		aCommand = $f ifTrue: [
			cardinalPointFaced = #North ifTrue: [position := (position x)@(position y + 1).].
			cardinalPointFaced = #East ifTrue: [position := (position x + 1)@(position y).].
			cardinalPointFaced = #South ifTrue: [position := (position x)@(position y - 1).].
			cardinalPointFaced = #West ifTrue: [position := (position x - 1)@(position y).].
		] ifFalse: [
			aCommand = $b ifTrue: [
				cardinalPointFaced = #North ifTrue: [position := (position x)@(position y - 1).].	
				cardinalPointFaced = #East ifTrue: [position := (position x - 1)@(position y).].
				cardinalPointFaced = #South ifTrue: [position := (position x)@(position y + 1).].
				cardinalPointFaced = #West ifTrue: [position := (position x + 1)@(position y).].
			] ifFalse: [
				aCommand = $r ifTrue: [
					cardinalPointFaced = #North ifTrue: [cardinalPointFaced := #East.] 
						ifFalse: [ cardinalPointFaced = #East ifTrue: [cardinalPointFaced := #South.] 
							ifFalse: [ cardinalPointFaced = #South ifTrue: [cardinalPointFaced := #West.]
								ifFalse: [cardinalPointFaced = #West ifTrue: [cardinalPointFaced := #North.]
								].
							].
						]. 
				] ifFalse: [
					aCommand = $l ifTrue: [
						cardinalPointFaced = #North ifTrue: [cardinalPointFaced := #West.]
							ifFalse: [ cardinalPointFaced = #East ifTrue: [cardinalPointFaced := #North.]
								ifFalse: [ cardinalPointFaced = #South ifTrue: [cardinalPointFaced := #East.]
									ifFalse: [ cardinalPointFaced = #West ifTrue: [cardinalPointFaced := #South.]
								].
							].
						].
					] ifFalse: [^ self.].
				].
			].
		].
		commandSequenceIndex := commandSequenceIndex + 1.
	].! !


!MarsRover methodsFor: 'position' stamp: 'MFR 12/4/2020 19:45:04'!
isFacing: aCardinalPoint
	
	^ cardinalPointFaced = aCardinalPoint.! !

!MarsRover methodsFor: 'position' stamp: 'MFR 12/4/2020 19:18:31'!
isOnPosition: aPosition 
	
	^ position = aPosition.! !


!MarsRover methodsFor: 'initialization' stamp: 'MFR 12/4/2020 19:13:05'!
onInitialPoint: aPosition facing: aCardinalPoint 

	position := aPosition.
	cardinalPointFaced := aCardinalPoint.! !

"-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- "!

!classDefinition: 'MarsRover class' category: '05-MarsRover'!
MarsRover class
	instanceVariableNames: 'position cardinalPointFaced'!

!MarsRover class methodsFor: 'instance creation' stamp: 'MFR 12/4/2020 19:15:37'!
initialPosition: aPosition facing: aCardinalPoint
	
	^self new onInitialPoint: aPosition facing: aCardinalPoint.! !
