//
//  ConfigurationController.h
//  Turmite Saver
//
//  Created by Michael Ash on Mon Feb 03 2003.
//  Copyright (c) 2003 __MyCompanyName__. All rights reserved.
//

#import <Cocoa/Cocoa.h>


@interface ConfigurationController : NSObject {
	IBOutlet NSWindow *configurationWindow;
	IBOutlet NSPopUpButton *FPSPopup;
	IBOutlet NSPopUpButton *tapeStatesPopup;
	IBOutlet NSPopUpButton *transitionsPopup;
	IBOutlet NSPopUpButton *clearIntervalPopup;
	IBOutlet NSSlider *turmitesSlider;
	IBOutlet NSTextField *turmitesField;
}

+ configurationWindow;
- window;
- (IBAction)okClicked:sender;
- (IBAction)cancelClicked:sender;

@end
