//
//  Tape.h
//  Turmite Saver
//
//  Created by Michael Ash on Sun Feb 02 2003.
//  Copyright (c) 2003 __MyCompanyName__. All rights reserved.
//

#import <Cocoa/Cocoa.h>


typedef struct
{
	unsigned char r, g, b, a;
} Pixel32;

@interface Tape : NSObject {
	int *tape;
	Pixel32 *pixmap;
	Pixel32 *colorTable;
	int numStates;
	int xSize, ySize;
	NSBitmapImageRep *imageRep;
}

- initWithNumStates:(int)states size:(int)x :(int)y;
- (void)clear;
- (int)xSize;
- (int)ySize;
- (int)tapeAt:(int)x :(int)y;
- (void)setTape:(int)t at:(int)x :(int)y;
- (NSBitmapImageRep *)bitmapRep;

@end
