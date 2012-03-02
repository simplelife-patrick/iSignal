//
//  ISAudioModule.m
//  iSignal
//
//  Created by Patrick Deng on 12-3-2.
//  Copyright (c) 2012年 CodeBeaver. All rights reserved.
//

#import "ISAudioModule.h"

@implementation ISAudioModule

@synthesize audioManager = _audioManager;

// Overrided Method of CBModuleAbstractImpl
-(void) initModule
{    
    [self setModuleIdentity:MODULE_IDENTITY_AUDIO_MODULE];
    [self setKeepAlive:FALSE];  
}

// Overrided Method of CBModuleAbstractImpl
-(void) releaseModule
{
    [super releaseModule];
    
    [_audioManager release];    
}

// Overrided Method of CBModuleAbstractImpl
-(void) serviceWithCallingThread
{
    _audioManager = [[CBAVManager alloc] init];
    [_audioManager audioSessionBegin];
    [_audioManager preparePlayAudio:AUDIO_NO_SIGNAL andResourceType:AUDIO_TYPE_CAF];
    [_audioManager audioSessionEnd];       
}

-(void) playNoSignalAudio
{
    if([ISAppConfigs isRingAlarmOn])
    {
        [_audioManager playAudio]; 
    }
    
    if([ISAppConfigs isVibrateAlarmOn])
    {
        AudioServicesPlaySystemSound(kSystemSoundID_Vibrate);                
    }    
}



@end
