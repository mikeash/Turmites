//
//  Turmite.h
//  Turmite Saver
//
//  Created by Michael Ash on Sun Feb 02 2003.
//  Copyright (c) 2003 __MyCompanyName__. All rights reserved.
//

#import <Foundation/Foundation.h>

typedef struct
{
	int newState;
	int writeState;
	int move;
} Transition;

@class Tape;

@interface Turmite : NSObject {
	Tape *tape;
	int xLoc, yLoc;
	int direction;
	int xSize, ySize;
	Transition *transitions;
	int numTransitions;
	int state;
}

- initWithTape:(Tape *)t numTransitions:(int)numTrans numTapeStates:(int)numTapeStates;
- (void)stepWithView:view;

@end
