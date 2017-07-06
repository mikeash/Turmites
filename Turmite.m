//
//  Turmite.m
//  Turmite Saver
//
//  Created by Michael Ash on Sun Feb 02 2003.
//  Copyright (c) 2003 __MyCompanyName__. All rights reserved.
//

#import "Turmite.h"
#import "Tape.h"
#import "Turmite_SaverView.h"


@implementation Turmite

- initWithTape:(Tape *)t numTransitions:(int)numTrans numTapeStates:(int)numTapeStates
{
	if((self = [self init]))
	{
		tape = t;
		xSize = [tape xSize];
		ySize = [tape ySize];
		direction = random() % 4;
		numTransitions = numTrans;
		transitions = malloc(numTransitions * numTapeStates * sizeof(*transitions));
		int i;
		for(i = 0; i < numTransitions * numTapeStates; i++)
		{
			transitions[i].newState = random() % numTransitions;
			transitions[i].writeState = random() % numTapeStates;
			transitions[i].move = (random() % 3) - 1;
		}
		xLoc = random() % xSize;
		yLoc = random() % ySize;
	}
	return self;
}

- (void)stepWithView:view
{
	//NSLog(@"%s:%d", __FUNCTION__, __LINE__);
	Transition trans = transitions[state + [tape tapeAt:xLoc :yLoc] * numTransitions];
	state = trans.newState;
	[tape setTape:trans.writeState at:xLoc :yLoc];
	[view setNeedsDisplayAt:xLoc :yLoc];
	direction += trans.move;
	if(direction < 0)
		direction = 3;
	else if(direction >= 4)
		direction = 0;
	switch(direction)
	{
		case 0:
			xLoc++;
			if(xLoc >= xSize)
				xLoc = 0;
			break;
		case 1:
			xLoc--;
			if(xLoc < 0)
				xLoc = xSize - 1;
			break;
		case 2:
			yLoc++;
			if(yLoc >= ySize)
				yLoc = 0;
			break;
		case 3:
			yLoc--;
			if(yLoc < 0)
				yLoc = ySize - 1;
			break;
	}
}

- (void)dealloc
{
	free(transitions);
	[super dealloc];
}

@end
