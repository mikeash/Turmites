//
//  ConfigurationController.m
//  Turmite Saver
//
//  Created by Michael Ash on Mon Feb 03 2003.
//  Copyright (c) 2003 __MyCompanyName__. All rights reserved.
//

#import "ConfigurationController.h"
#import "Turmite_SaverView.h"

@implementation ConfigurationController

+ configurationWindow
{
	ConfigurationController *controller = [[[self alloc] init] autorelease];
	return [controller window];
}

- init
{
	if((self = [super init]))
	{
		[NSBundle loadNibNamed:@"ConfigureSheet" owner:self];
		int FPS = [[NSUserDefaults standardUserDefaults] integerForKey:FPSKey];
		if(FPS == 0)
			[FPSPopup selectItemAtIndex:[FPSPopup indexOfItemWithTag:1]];
		else
			[FPSPopup selectItemWithTitle:[NSString stringWithFormat:@"%d", FPS]];

		[tapeStatesPopup selectItemWithTitle:[NSString stringWithFormat:@"%d", [[NSUserDefaults standardUserDefaults] integerForKey:NumTapeStatesKey]]];
		[transitionsPopup selectItemWithTitle:[NSString stringWithFormat:@"%d", [[NSUserDefaults standardUserDefaults] integerForKey:NumTransitionsKey]]];
		[clearIntervalPopup selectItemWithTitle:[NSString stringWithFormat:@"%d", [[NSUserDefaults standardUserDefaults] integerForKey:ClearScreenIntervalKey]/60]];
		int numTurmites = [[NSUserDefaults standardUserDefaults] integerForKey:NumTurmitesKey];
		[turmitesSlider setIntValue:numTurmites];
		[turmitesField setIntValue:numTurmites];

		[self retain];
	}
	return self;
}

- window
{
	return configurationWindow;
}

- (IBAction)okClicked:sender
{
	if([[FPSPopup selectedItem] tag] == 1)
		[[NSUserDefaults standardUserDefaults] setInteger:0 forKey:FPSKey];
	else
		[[NSUserDefaults standardUserDefaults] setInteger:[[[FPSPopup selectedItem] title] intValue] forKey:FPSKey];

	[[NSUserDefaults standardUserDefaults] setInteger:[[[tapeStatesPopup selectedItem] title] intValue] forKey:NumTapeStatesKey];
	[[NSUserDefaults standardUserDefaults] setInteger:[[[transitionsPopup selectedItem] title] intValue] forKey:NumTransitionsKey];
	[[NSUserDefaults standardUserDefaults] setInteger:[[[clearIntervalPopup selectedItem] title] intValue]*60 forKey:ClearScreenIntervalKey];
	[[NSUserDefaults standardUserDefaults] setInteger:[turmitesField intValue] forKey:NumTurmitesKey];
	[[NSUserDefaults standardUserDefaults] synchronize];
	[[NSNotificationCenter defaultCenter] postNotificationName:PrefsChangedNotification object:self];
	
	[NSApp endSheet:configurationWindow];
	[self autorelease];
}

- (IBAction)cancelClicked:sender
{
	[NSApp endSheet:configurationWindow];
	[self autorelease];
}

- (void)dealloc
{
	[configurationWindow release];
	[super dealloc];
}

@end
