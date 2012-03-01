//
//  CBAVManager.h
//  iSignal
//
//  Created by Patrick Deng on 12-3-1.
//  Copyright (c) 2012年 CodeBeaver. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <AVFoundation/AVFoundation.h>
#import <AudioToolbox/AudioToolbox.h>

#import "CBModuleAbstractImpl.h"

#define MODULE_IDENTITY_AV_MANAGER @"AVManager"

// TODO: Implment AVAudioPlayerDelegate protocol later
@interface CBAVManager : CBModuleAbstractImpl <AVAudioPlayerDelegate>

@property (nonatomic, retain, readonly) AVAudioPlayer *audioPlayer;

-(void) audioSessionBegin;
-(void) audioSessionEnd;
-(BOOL) preparePlayAudio:(NSString*) resourcePath andResourceType:(NSString*) resourceType;
-(void) playAudio;

@end
