//
//  Turmite_SaverView.h
//  Turmite Saver
//
//  Created by Michael Ash on Sun Feb 02 2003.
//  Copyright (c) 2003, __MyCompanyName__. All rights reserved.
//

#import <ScreenSaver/ScreenSaver.h>


@class Tape;

extern NSString *FPSKey;
extern NSString *NumTapeStatesKey;
extern NSString *NumTransitionsKey;
extern NSString *NumTurmitesKey;
extern NSString *ClearScreenIntervalKey;

extern NSString *PrefsChangedNotification;

@interface Turmite_SaverView : ScreenSaverView 
{
	Tape *tape;
	NSMutableArray *turmites;

	NSTimer *clearTimer;
	//NSRect drawingRect;
}

- (void)setNeedsDisplayAt:(int)x :(int)y;

@end
