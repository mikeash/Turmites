//
//  Tape.m
//  Turmite Saver
//
//  Created by Michael Ash on Sun Feb 02 2003.
//  Copyright (c) 2003 __MyCompanyName__. All rights reserved.
//

#import "Tape.h"


@implementation Tape

Pixel32 gColorTable[] = {
	{0, 0, 0, 255},
	{255, 255, 255, 255},
	{255, 0, 0, 255},
	{0, 255, 0, 255},
	{0, 0, 255, 255},
	{255, 0, 255, 255},
	{0, 255, 255, 255},
	{255, 255, 0, 255},
	//{255, 0, 0, 0},
	//{255, 0, 0, 0},
};

int gColorTableEntries = 8;

- initWithNumStates:(int)states size:(int)x :(int)y;
{
	if((self = [self init]))
	{
		xSize = x;
		ySize = y;
		numStates = states;
		tape = malloc(ySize* xSize * sizeof(*tape));
		pixmap = malloc(ySize * xSize * sizeof(*pixmap));
		colorTable = calloc(states, sizeof(*colorTable));
		[self clear];
		int i;
		for(i = 0; i < numStates; i++)
		{
			colorTable[i] = gColorTable[i % gColorTableEntries];
			if(i >= gColorTableEntries)
			{
				colorTable[i].r /= 2;
				colorTable[i].g /= 2;
				colorTable[i].b /= 2;
			}
			//NSLog(@"Set up state %d, color is (%d, %d, %d)", i, colorTable[i].r, colorTable[i].g, colorTable[i].b);			//NSLog(@"%s:%d: colorTable = (%d, %d, %d)", __FUNCTION__, __LINE__, colorTable[i].r, colorTable[i].g, colorTable[i].b);
		}
		imageRep = [[NSBitmapImageRep alloc] initWithBitmapDataPlanes: (unsigned char **)&pixmap
														pixelsWide: xSize
														pixelsHigh: ySize
													 bitsPerSample: 8
												   samplesPerPixel: 4
														  hasAlpha: YES
														  isPlanar: NO
													colorSpaceName: NSDeviceRGBColorSpace
													   bytesPerRow: 0
													  bitsPerPixel: 0];
		//[imageRep setOpaque:NO];
	}
	return self;
}

- (void)clear
{
	int i;
	for(i = 0; i < ySize * xSize; i++)
	{
		pixmap[i].a = 255;
		pixmap[i].r = 0;
		pixmap[i].g = 0;
		pixmap[i].b = 0;

		tape[i] = 0;
	}	
}

- (int)xSize
{
	return xSize;
}

- (int)ySize
{
	return ySize;
}

- (int)tapeAt:(int)x :(int)y
{
	return tape[x + y * xSize];
}

- (void)setTape:(int)t at:(int)x :(int)y
{
	//NSLog(@"%s:%d", __FUNCTION__, __LINE__);
	tape[x + y * xSize] = t;
	pixmap[x + y * xSize] = colorTable[t];
	//NSLog(@"Writing state %d, color is (%d, %d, %d)", t, colorTable[t].r, colorTable[t].g, colorTable[t].b);
}

- (NSBitmapImageRep *)bitmapRep
{
	//NSLog(@"%s:%d", __FUNCTION__, __LINE__);

	return imageRep;
}

- (void)dealloc
{
	free(tape);
	free(pixmap);
	free(colorTable);
	[super dealloc];
}

@end
