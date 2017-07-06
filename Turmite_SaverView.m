//
//  Turmite_SaverView.m
//  Turmite Saver
//
//  Created by Michael Ash on Sun Feb 02 2003.
//  Copyright (c) 2003, __MyCompanyName__. All rights reserved.
//

#import "Turmite_SaverView.h"
#import "Tape.h"
#import "Turmite.h"
#import "ConfigurationController.h"


@implementation Turmite_SaverView

NSString *FPSKey = @"Turmites Saver FPS";
NSString *NumTapeStatesKey = @"Turmites Saver NumTapeStates";
NSString *NumTransitionsKey = @"Turmites Saver NumTransitions";
NSString *NumTurmitesKey = @"Turmites Saver NumTurmites";
NSString *ClearScreenIntervalKey = @"Turmites Saver ClearScreenInterval";

NSString *PrefsChangedNotification = @"Turmites Saver Prefs Changed";

+ (void)initialize
{
	NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults];
    NSDictionary *appDefaults = [NSDictionary
        dictionaryWithObjectsAndKeys:
		[NSNumber numberWithInt:30], FPSKey,
		[NSNumber numberWithInt:4], NumTapeStatesKey,
		[NSNumber numberWithInt:16], NumTransitionsKey,
		[NSNumber numberWithInt:8], NumTurmitesKey,
		[NSNumber numberWithInt:600], ClearScreenIntervalKey,
		nil];
	[defaults registerDefaults:appDefaults];
}

/*+ (NSBackingStoreType)backingStoreType
{
	return NSBackingStoreRetained;
}*/

/*+ (BOOL)performGammaFade
{
	return NO;
}

- (BOOL)isOpaque
{
	return NO;
}*/

- (void)generateTurmites
{
	[turmites removeAllObjects];
	int numTurmites = [[NSUserDefaults standardUserDefaults] integerForKey:NumTurmitesKey];
	int i;
	for(i = 0; i < numTurmites; i++)
	{
		Turmite *turmite = [[Turmite alloc] initWithTape:tape numTransitions:[[NSUserDefaults standardUserDefaults] integerForKey:NumTransitionsKey] numTapeStates:[[NSUserDefaults standardUserDefaults] integerForKey:NumTapeStatesKey]];
		[turmites addObject:turmite];
		[turmite release];
	}
}

- (void)reset
{
	[clearTimer invalidate];
	[clearTimer release];
	clearTimer = nil;
	[tape release];
	tape = nil;
	
	int FPS = [[NSUserDefaults standardUserDefaults] integerForKey:FPSKey];
	if(FPS != 0)
		[self setAnimationTimeInterval:1/(float)FPS];
	else
		[self setAnimationTimeInterval:0];

	NSRect frame = [self bounds];
	tape = [[Tape alloc] initWithNumStates:[[NSUserDefaults standardUserDefaults] integerForKey:NumTapeStatesKey] size:frame.size.width/2 :frame.size.height/2];
	//drawingRect.origin = frame.origin;
	//drawingRect.size.width = [tape xSize] * 2;
	//drawingRect.size.height = [tape ySize] * 2;
	
	[self generateTurmites];
	int clearScreenInterval = [[NSUserDefaults standardUserDefaults] integerForKey:ClearScreenIntervalKey];
	if(clearScreenInterval != 0)
		clearTimer = [[NSTimer scheduledTimerWithTimeInterval:clearScreenInterval target:self selector:@selector(clearScreen:) userInfo:nil repeats:YES] retain];
	[self display];
}

- (id)initWithFrame:(NSRect)frame isPreview:(BOOL)isPreview
{
    self = [super initWithFrame:frame isPreview:isPreview];
    if (self) {
		srandom(time(0));
		[[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(prefsChanged:) name:PrefsChangedNotification object:nil];
		//NSRect bounds = [self bounds];
		//[self setBounds:NSMakeRect(bounds.origin.x, bounds.origin.y, bounds.size.width/2.0, bounds.size.height/2.0)];
		//[self scaleUnitSquareToSize:NSMakeSize(2.0, 2.0)];
		turmites = [[NSMutableArray alloc] init];
		[self reset];
    }
    return self;
}

- (void)prefsChanged:(NSNotification *)notification
{
	[self reset];
}

- (void)clearScreen:info
{
	[tape clear];
	[self generateTurmites];
	[self display];
}

- (void)setNeedsDisplayAt:(int)x :(int)y
{
	[self displayRect:NSMakeRect(x*2, [self bounds].size.height - y*2 - 5, 10, 10)];
}

- (void)startAnimation
{
    [super startAnimation];
    /*if (![self isPreview])
    {
        [[self window] setBackgroundColor: [NSColor clearColor]];
        [[self window] setOpaque: NO];
    }*/
}

- (void)stopAnimation
{
    [super stopAnimation];
	[clearTimer invalidate];
	[clearTimer release];
	clearTimer = nil;
}

- (void)drawRect:(NSRect)rect
{
    [super drawRect:rect];
	/*NSBitmapImageRep *rep = [tape bitmapRep];
	NSImage *image = [[NSImage alloc] initWithSize:[rep size]];
	[image addRepresentation:rep];
	[image drawInRect:[self bounds] fromRect:[self bounds] operation:NSCompositeSourceAtop fraction:1.0];
	[image release];*/
	[[tape bitmapRep] drawInRect:[self bounds]];
	//[[tape bitmapRep] draw];
}

- (void)animateOneFrame
{
	[turmites makeObjectsPerformSelector:@selector(stepWithView:) withObject:self];
	//[self displayIfNeeded];
    return;
}

- (BOOL)hasConfigureSheet
{
    return YES;
}

- (NSWindow*)configureSheet
{
    return [ConfigurationController configurationWindow];
}

- (void)dealloc
{
	[turmites release];
	[tape release];
	[super dealloc];
}

@end
