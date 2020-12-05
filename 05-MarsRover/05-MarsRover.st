!classDefinition: #MarsRoverTests category: '05-MarsRover'!
TestCase subclass: #MarsRoverTests
	instanceVariableNames: ''
	classVariableNames: ''
	poolDictionaries: ''
	category: '05-MarsRover'!

!MarsRoverTests methodsFor: 'move forward tests' stamp: 'MFR 12/5/2020 16:07:59'!
test01MarsRoverMovesForwardFacingNorthCorrectly
	
	| marsRover |
	
	marsRover := MarsRover initialPosition: 1@1 controlledBy: NorthMovementControls new.
	
	marsRover executeCommand: 'f'.
	
	self assert: (marsRover isOnPosition: 1@2).! !

!MarsRoverTests methodsFor: 'move forward tests' stamp: 'MFR 12/5/2020 16:07:58'!
test02MarsRoverMovesForwardFacingEastCorrectly
	
	| marsRover |
	
	marsRover := MarsRover initialPosition: 1@1 controlledBy: EastMovementControls new.
	
	marsRover executeCommand: 'f'.
	
	self assert: (marsRover isOnPosition: 2@1).! !

!MarsRoverTests methodsFor: 'move forward tests' stamp: 'MFR 12/5/2020 16:07:59'!
test03MarsRoverMovesForwardFacingSouthCorrectly
	
	| marsRover |
	
	marsRover := MarsRover initialPosition: 1@1 controlledBy: SouthMovementControls new.
	
	marsRover executeCommand: 'f'.
	
	self assert: (marsRover isOnPosition: 1@0).! !

!MarsRoverTests methodsFor: 'move forward tests' stamp: 'MFR 12/5/2020 16:07:58'!
test04MarsRoverMovesForwardFacingWestCorrectly
	
	| marsRover |
	
	marsRover := MarsRover initialPosition: 1@1 controlledBy: WestMovementControls new.
	
	marsRover executeCommand: 'f'.
	
	self assert: (marsRover isOnPosition: 0@1).! !


!MarsRoverTests methodsFor: 'move backwards tests' stamp: 'MFR 12/5/2020 16:07:58'!
test05MarsRoverMovesBackwardsFacingNorthCorrectly

	| marsRover |
	
	marsRover := MarsRover initialPosition: 1@1 controlledBy: NorthMovementControls new.
	
	marsRover executeCommand: 'b'.
	
	self assert: (marsRover isOnPosition: 1@0).! !

!MarsRoverTests methodsFor: 'move backwards tests' stamp: 'MFR 12/5/2020 16:07:59'!
test06MarsRoverMovesBackwardsFacingEastCorrectly

	| marsRover |
	
	marsRover := MarsRover initialPosition: 1@1 controlledBy: EastMovementControls new.
	
	marsRover executeCommand: 'b'.
	
	self assert: (marsRover isOnPosition: 0@1).! !

!MarsRoverTests methodsFor: 'move backwards tests' stamp: 'MFR 12/5/2020 16:07:58'!
test07MarsRoverMovesBackwardsFacingSouthCorrectly

	| marsRover |
	
	marsRover := MarsRover initialPosition: 1@1 controlledBy: SouthMovementControls new.
	
	marsRover executeCommand: 'b'.
	
	self assert: (marsRover isOnPosition: 1@2).! !

!MarsRoverTests methodsFor: 'move backwards tests' stamp: 'MFR 12/5/2020 16:07:59'!
test08MarsRoverMovesBackwardsFacingWestCorrectly

	| marsRover |
	
	marsRover := MarsRover initialPosition: 1@1 controlledBy: WestMovementControls new.
	
	marsRover executeCommand: 'b'.
	
	self assert: (marsRover isOnPosition: 2@1).! !


!MarsRoverTests methodsFor: 'rotates towards right tests' stamp: 'MFR 12/5/2020 16:09:20'!
test09MarsRoverRotates90DegreesTowardsRightFacingNorthCorrectly

	| marsRover |
	
	marsRover := MarsRover initialPosition: 1@1 controlledBy: NorthMovementControls new.
	
	marsRover executeCommand: 'r'.
	
	self assert: (marsRover isControlledBy: EastMovementControls).! !

!MarsRoverTests methodsFor: 'rotates towards right tests' stamp: 'MFR 12/5/2020 16:09:20'!
test10MarsRoverRotates90DegreesTowardsRightFacingEastCorrectly

	| marsRover |
	
	marsRover := MarsRover initialPosition: 1@1 controlledBy: EastMovementControls new.
	
	marsRover executeCommand: 'r'.
	
	self assert: (marsRover isControlledBy: SouthMovementControls).! !

!MarsRoverTests methodsFor: 'rotates towards right tests' stamp: 'MFR 12/5/2020 16:09:20'!
test11MarsRoverRotates90DegreesTowardsRightFacingSouthCorrectly

	| marsRover |
	
	marsRover := MarsRover initialPosition: 1@1 controlledBy: SouthMovementControls new.
	
	marsRover executeCommand: 'r'.
	
	self assert: (marsRover isControlledBy: WestMovementControls).! !

!MarsRoverTests methodsFor: 'rotates towards right tests' stamp: 'MFR 12/5/2020 16:09:20'!
test12MarsRoverRotates90DegreesTowardsRightFacingWestCorrectly

	| marsRover |
	
	marsRover := MarsRover initialPosition: 1@1 controlledBy: WestMovementControls new.
	
	marsRover executeCommand: 'r'.
	
	self assert: (marsRover isControlledBy: NorthMovementControls).! !


!MarsRoverTests methodsFor: 'rotates towards left tests' stamp: 'MFR 12/5/2020 16:09:20'!
test13MarsRoverRotates90DegreesTowardsLeftFacingNorthCorrectly

	| marsRover |
	
	marsRover := MarsRover initialPosition: 1@1 controlledBy: NorthMovementControls new.
	
	marsRover executeCommand: 'l'.
	
	self assert: (marsRover isControlledBy: WestMovementControls).! !

!MarsRoverTests methodsFor: 'rotates towards left tests' stamp: 'MFR 12/5/2020 16:09:20'!
test14MarsRoverRotates90DegreesTowardsLeftFacingEastCorrectly

	| marsRover |
	
	marsRover := MarsRover initialPosition: 1@1 controlledBy: EastMovementControls new.
	
	marsRover executeCommand: 'l'.
	
	self assert: (marsRover isControlledBy: NorthMovementControls).! !

!MarsRoverTests methodsFor: 'rotates towards left tests' stamp: 'MFR 12/5/2020 16:09:20'!
test15MarsRoverRotates90DegreesTowardsLeftFacingSouthCorrectly

	| marsRover |
	
	marsRover := MarsRover initialPosition: 1@1 controlledBy: SouthMovementControls new.
	
	marsRover executeCommand: 'l'.
	
	self assert: (marsRover isControlledBy: EastMovementControls).! !

!MarsRoverTests methodsFor: 'rotates towards left tests' stamp: 'MFR 12/5/2020 16:09:20'!
test16MarsRoverRotates90DegreesTowardsLeftFacingWestCorrectly

	| marsRover |
	
	marsRover := MarsRover initialPosition: 1@1 controlledBy: WestMovementControls new.
	
	marsRover executeCommand: 'l'.
	
	self assert: (marsRover isControlledBy: SouthMovementControls).! !


!MarsRoverTests methodsFor: 'process commands tests' stamp: 'MFR 12/5/2020 16:09:20'!
test17MarsRoverExecutesMoreThanOneCommandCorrectly

	| marsRover |
	
	marsRover := MarsRover initialPosition: 1@1 controlledBy: NorthMovementControls new.
	
	marsRover executeCommand: 'fr'.
	
	self assert: (marsRover isOnPosition: 1@2).
	self assert: (marsRover isControlledBy: EastMovementControls).! !

!MarsRoverTests methodsFor: 'process commands tests' stamp: 'MFR 12/5/2020 16:09:20'!
test18MarsRoverStopsProcessingCommandsWhenInvalidCommandIsEntered

	| marsRover |
	
	marsRover := MarsRover initialPosition: 1@1 controlledBy: NorthMovementControls new.
	
	marsRover executeCommand: 'fjr'.
	
	self assert: (marsRover isOnPosition: 1@2).
	self deny: (marsRover isControlledBy: EastMovementControls).! !


!classDefinition: #MarsRover category: '05-MarsRover'!
Object subclass: #MarsRover
	instanceVariableNames: 'position remoteController'
	classVariableNames: ''
	poolDictionaries: ''
	category: '05-MarsRover'!

!MarsRover methodsFor: 'commands' stamp: 'MFR 12/5/2020 16:17:32'!
executeCommand: aSequenceOfCommands

	| commandSequenceIndex |
	
	commandSequenceIndex := 1.
	
	aSequenceOfCommands size timesRepeat: [ | aCommand |
		aCommand := aSequenceOfCommands at: commandSequenceIndex.
		
		aCommand = $f ifTrue: [
			remoteController moveMarsRoverForward: self.
		] ifFalse: [
			aCommand = $b ifTrue: [
				remoteController moveMarsRoverBackwards: self.
			] ifFalse: [
				aCommand = $r ifTrue: [
					remoteController rotateMarsRoverTowardsRight: self.
				] ifFalse: [
					aCommand = $l ifTrue: [
						remoteController rotateMarsRoverTowardsLeft: self.
					] ifFalse: [^ self.].
				].
			].
		].
		commandSequenceIndex := commandSequenceIndex + 1.
	].! !


!MarsRover methodsFor: 'position' stamp: 'MFR 12/5/2020 16:13:00'!
changeRemoteControls: aRemoteControl
	
	remoteController := aRemoteControl.! !

!MarsRover methodsFor: 'position' stamp: 'MFR 12/5/2020 15:35:41'!
decreaseXCoordinate
	
	position := (position x - 1)@(position y).! !

!MarsRover methodsFor: 'position' stamp: 'MFR 12/5/2020 15:34:22'!
decreaseYCoordinate
	
	position := (position x)@(position y - 1).! !

!MarsRover methodsFor: 'position' stamp: 'MFR 12/4/2020 21:35:16'!
increaseXCoordinate
	
	position := (position x + 1)@(position y).! !

!MarsRover methodsFor: 'position' stamp: 'MFR 12/4/2020 21:34:30'!
increaseYCoordinate
	
	position := (position x)@(position y + 1).! !

!MarsRover methodsFor: 'position' stamp: 'MFR 12/5/2020 16:09:36'!
isControlledBy: aRemoteControl
	
	^ remoteController isKindOf: aRemoteControl.! !

!MarsRover methodsFor: 'position' stamp: 'MFR 12/4/2020 19:18:31'!
isOnPosition: aPosition 
	
	^ position = aPosition.! !


!MarsRover methodsFor: 'initialization' stamp: 'MFR 12/5/2020 16:06:32'!
onInitialPoint: aPosition controlledBy: aRemoteController

	position := aPosition.
	remoteController := aRemoteController.! !

"-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- "!

!classDefinition: 'MarsRover class' category: '05-MarsRover'!
MarsRover class
	instanceVariableNames: ''!

!MarsRover class methodsFor: 'instance creation' stamp: 'MFR 12/5/2020 16:08:15'!
initialPosition: aPosition controlledBy: aRemoteController
	
	^self new onInitialPoint: aPosition controlledBy: aRemoteController.! !


!classDefinition: #MarsRoverRemoteControl category: '05-MarsRover'!
Object subclass: #MarsRoverRemoteControl
	instanceVariableNames: ''
	classVariableNames: ''
	poolDictionaries: ''
	category: '05-MarsRover'!

!MarsRoverRemoteControl methodsFor: 'movement' stamp: 'MFR 12/5/2020 16:17:13'!
moveMarsRoverBackwards: aMarsRover

	self subclassResponsibility ! !

!MarsRoverRemoteControl methodsFor: 'movement' stamp: 'MFR 12/5/2020 16:16:59'!
moveMarsRoverForward: aMarsRover

	self subclassResponsibility ! !

!MarsRoverRemoteControl methodsFor: 'movement' stamp: 'MFR 12/5/2020 16:17:24'!
rotateMarsRoverTowardsLeft: aMarsRover

	self subclassResponsibility ! !

!MarsRoverRemoteControl methodsFor: 'movement' stamp: 'MFR 12/5/2020 16:17:32'!
rotateMarsRoverTowardsRight: aMarsRover

	self subclassResponsibility ! !


!classDefinition: #EastMovementControls category: '05-MarsRover'!
MarsRoverRemoteControl subclass: #EastMovementControls
	instanceVariableNames: ''
	classVariableNames: ''
	poolDictionaries: ''
	category: '05-MarsRover'!

!EastMovementControls methodsFor: 'movement' stamp: 'MFR 12/5/2020 16:17:13'!
moveMarsRoverBackwards: aMarsRover

	aMarsRover decreaseXCoordinate.! !

!EastMovementControls methodsFor: 'movement' stamp: 'MFR 12/5/2020 16:16:59'!
moveMarsRoverForward: aMarsRover

	aMarsRover increaseXCoordinate.! !

!EastMovementControls methodsFor: 'movement' stamp: 'MFR 12/5/2020 16:17:24'!
rotateMarsRoverTowardsLeft: aMarsRover

	aMarsRover changeRemoteControls: NorthMovementControls new.! !

!EastMovementControls methodsFor: 'movement' stamp: 'MFR 12/5/2020 16:17:32'!
rotateMarsRoverTowardsRight: aMarsRover

	aMarsRover changeRemoteControls: SouthMovementControls new.! !


!classDefinition: #NorthMovementControls category: '05-MarsRover'!
MarsRoverRemoteControl subclass: #NorthMovementControls
	instanceVariableNames: ''
	classVariableNames: ''
	poolDictionaries: ''
	category: '05-MarsRover'!

!NorthMovementControls methodsFor: 'movement' stamp: 'MFR 12/5/2020 16:17:13'!
moveMarsRoverBackwards: aMarsRover

	aMarsRover decreaseYCoordinate.! !

!NorthMovementControls methodsFor: 'movement' stamp: 'MFR 12/5/2020 16:16:59'!
moveMarsRoverForward: aMarsRover

	aMarsRover increaseYCoordinate.! !

!NorthMovementControls methodsFor: 'movement' stamp: 'MFR 12/5/2020 16:17:24'!
rotateMarsRoverTowardsLeft: aMarsRover

	aMarsRover changeRemoteControls: WestMovementControls new.! !

!NorthMovementControls methodsFor: 'movement' stamp: 'MFR 12/5/2020 16:17:32'!
rotateMarsRoverTowardsRight: aMarsRover

	aMarsRover changeRemoteControls: EastMovementControls new.! !


!classDefinition: #SouthMovementControls category: '05-MarsRover'!
MarsRoverRemoteControl subclass: #SouthMovementControls
	instanceVariableNames: ''
	classVariableNames: ''
	poolDictionaries: ''
	category: '05-MarsRover'!

!SouthMovementControls methodsFor: 'movement' stamp: 'MFR 12/5/2020 16:17:13'!
moveMarsRoverBackwards: aMarsRover

	aMarsRover increaseYCoordinate.! !

!SouthMovementControls methodsFor: 'movement' stamp: 'MFR 12/5/2020 16:16:59'!
moveMarsRoverForward: aMarsRover
	
	aMarsRover decreaseYCoordinate.! !

!SouthMovementControls methodsFor: 'movement' stamp: 'MFR 12/5/2020 16:17:24'!
rotateMarsRoverTowardsLeft: aMarsRover

	aMarsRover changeRemoteControls: EastMovementControls new.! !

!SouthMovementControls methodsFor: 'movement' stamp: 'MFR 12/5/2020 16:17:32'!
rotateMarsRoverTowardsRight: aMarsRover

	aMarsRover changeRemoteControls: WestMovementControls new.! !


!classDefinition: #WestMovementControls category: '05-MarsRover'!
MarsRoverRemoteControl subclass: #WestMovementControls
	instanceVariableNames: ''
	classVariableNames: ''
	poolDictionaries: ''
	category: '05-MarsRover'!

!WestMovementControls methodsFor: 'movement' stamp: 'MFR 12/5/2020 16:17:13'!
moveMarsRoverBackwards: aMarsRover

	aMarsRover increaseXCoordinate.! !

!WestMovementControls methodsFor: 'movement' stamp: 'MFR 12/5/2020 16:16:59'!
moveMarsRoverForward: aMarsRover

	aMarsRover decreaseXCoordinate.! !

!WestMovementControls methodsFor: 'movement' stamp: 'MFR 12/5/2020 16:17:24'!
rotateMarsRoverTowardsLeft: aMarsRover

	aMarsRover changeRemoteControls: SouthMovementControls new.! !

!WestMovementControls methodsFor: 'movement' stamp: 'MFR 12/5/2020 16:17:32'!
rotateMarsRoverTowardsRight: aMarsRover

	aMarsRover changeRemoteControls: NorthMovementControls new.! !
