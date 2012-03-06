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
    [super initModule];
    
    [self setModuleIdentity:MODULE_IDENTITY_AUDIO_MODULE];
    [self.serviceThread setName:MODULE_IDENTITY_AUDIO_MODULE];
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
    [super serviceWithCallingThread];
    
    _audioManager = [[CBAVManager alloc] init];
    [_audioManager audioSessionBegin];
    [_audioManager preparePlayAudio:AUDIO_NO_SIGNAL andResourceType:AUDIO_TYPE_CAF];
    [_audioManager audioSessionEnd];
    
    [self listenSignalStrengthChanged];
}

-(void) playSignalStrengthAudio:(NSNumber*) signalVal
{
    // Currently only no signal message will be saved into database.
    NSInteger intVal = [signalVal intValue];
    SIGNAL_QUALITY qualityGrade = [CBTelephonyUtils evaluateSignalQuality:intVal];
    if (qualityGrade == QUALITY_SIGNAL_NO) 
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
}

// Private method
-(void) listenSignalStrengthChanged
{
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(onSignalStrengthChanged:) name:
     NOTIFICATION_ID_SIGNALSTRENGTH_CHANGED object:nil];      
}

// Private method
-(void) onSignalStrengthChanged:(NSNotification *) notification
{
    NSValue *nsValue = [[notification userInfo] objectForKey:NOTIFICATION_KV_SIGNALSTRENGTH_CHANGED]; 
    NSNumber *signalVal = (NSNumber*)nsValue;
    [self performSelectorOnMainThread:@selector(playSignalStrengthAudio:) withObject:(signalVal) waitUntilDone:YES];
}


@end
