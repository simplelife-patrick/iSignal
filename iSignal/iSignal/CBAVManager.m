//
//  CBAVManager.m
//  iSignal
//
//  Created by Patrick Deng on 12-3-1.
//  Copyright (c) 2012年 CodeBeaver. All rights reserved.
//

#import "CBAVManager.h"

@implementation CBAVManager

// Manual Codes Begin

@synthesize audioPlayer = _audioPlayer;

- (id)init
{
    self = [super init];
    if (self) 
    {
        // Initialization code here.  
    }
    
    return self;
}

// Overrided Method of CBModule protocol
-(void) releaseModule
{
    [super release];
    
    // Release resources here(after [super release])
    [self.audioPlayer release];
}

// Method of CBAVManager
-(void) audioSessionBegin
{    
    [[AVAudioSession sharedInstance] setCategory: AVAudioSessionCategoryPlayback error: nil];
    UInt32 doSetProperty = 1;
    AudioSessionSetProperty (kAudioSessionProperty_OverrideCategoryMixWithOthers, sizeof(doSetProperty), &doSetProperty);
    [[AVAudioSession sharedInstance] setActive: YES error: nil];
}

// Method of CBAVManager
-(void) audioSessionEnd
{
    [[AVAudioSession sharedInstance] setActive: FALSE error: nil];      
}

// Method of CBAVManager
-(BOOL) preparePlayAudio:(NSString*) resourcePath andResourceType:(NSString*) resourceType
{
    NSString *soundPath = [[NSBundle mainBundle] pathForResource:resourcePath ofType:resourceType]; 
    NSURL *soundUrl = [[NSURL alloc] initFileURLWithPath:soundPath]; 
    if(![soundUrl checkResourceIsReachableAndReturnError:nil])
    {
        return FALSE;
    }
    
    if (_audioPlayer) 
    { 
        [_audioPlayer release]; 
    }
    _audioPlayer = [[AVAudioPlayer alloc] initWithContentsOfURL:soundUrl error:nil]; 
    
    [_audioPlayer prepareToPlay];      
    
    [soundUrl release];       
    
    return TRUE;
}

// Method of CBAVManager
-(void) playAudio
{
    [_audioPlayer play]; 
}

// Overrided Method of CBModule protocol
-(void) initModule
{
    [self setModuleIdentity:MODULE_IDENTITY_AV_MANAGER];
    [self.serviceThread setName:MODULE_IDENTITY_AV_MANAGER];
    
    [self setKeepAlive:FALSE];    
}

// Overrided Method of CBModule protocol
-(void) processService
{
    // It's unnecessary here
}

// Manual Codes End

@end
