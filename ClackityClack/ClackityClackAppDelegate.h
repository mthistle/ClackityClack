//
//  ClackityClackAppDelegate.h
//  ClackityClack
//
//  Created by Mark Thistle on 11-09-10.
//  Copyright 2011 __MyCompanyName__. All rights reserved.
//

#import <Cocoa/Cocoa.h>

@interface ClackityClackAppDelegate : NSObject <NSApplicationDelegate, NSSoundDelegate> {
    NSWindow *window;
    NSSound  *key;
}

@property (assign) IBOutlet NSWindow *window;

@end
