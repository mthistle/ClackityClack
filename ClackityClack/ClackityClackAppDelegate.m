//
//  ClackityClackAppDelegate.m
//  ClackityClack
//
//  Created by Mark Thistle on 11-09-10.
//  Copyright 2011 __MyCompanyName__. All rights reserved.
//

#import "ClackityClackAppDelegate.h"


@interface ClackityClackAppDelegate ()

- (void)playSound;
- (void)stopSound;
- (BOOL)installKeyIntercepter;

@end

@implementation ClackityClackAppDelegate

@synthesize window;

- (void)applicationDidFinishLaunching:(NSNotification *)aNotification
{
    // Insert code here to initialize your application
    key = [NSSound soundNamed:@"ClackMediumLength"];
    [key setDelegate:self];
    NSLog(@"Sound loaded: %@", key? @"YES" : @"NO");
    [self installKeyIntercepter];
}

static CGEventRef event_tap_callback(CGEventTapProxy proxy, CGEventType type, CGEventRef event, void *refcon) {
    ClackityClackAppDelegate *app = (ClackityClackAppDelegate*)refcon;
    [app playSound];
    return event;
}

- (void)playSound {
    if (key) {
        [key play];
    }
}

- (void)stopSound {
    [key stop];
}

- (void)sound:(NSSound *)sound didFinishPlaying:(BOOL)finishedPlaying {
    
}

- (BOOL)installKeyIntercepter {
    CGEventMask keyboardMask = CGEventMaskBit(kCGEventKeyDown);
    CFMachPortRef mMachPortRef =  CGEventTapCreate(
                                     kCGAnnotatedSessionEventTap,
                                     kCGTailAppendEventTap, // kCGHeadInsertEventTap
                                     kCGEventTapOptionListenOnly,
                                     keyboardMask,
                                     (CGEventTapCallBack)event_tap_callback,
                                     self );
    if (!mMachPortRef)
        NSLog(@"logNeedAssistiveDevice: Can't install keyboard hook.");
    else
        CFRelease(mMachPortRef);
    
    CFRunLoopSourceRef mKeyboardEventSrc = CFMachPortCreateRunLoopSource(kCFAllocatorDefault, mMachPortRef, 0);
    if ( !mKeyboardEventSrc )
        return NO;
    
    CFRunLoopRef runLoop = CFRunLoopGetCurrent();
    if ( !runLoop )
        return NO;
    
    CFRunLoopAddSource(runLoop,  mKeyboardEventSrc, kCFRunLoopDefaultMode);
    return YES;
}

@end
