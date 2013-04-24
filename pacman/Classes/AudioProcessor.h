//
//  AudioProcessor.h
//  MicInput
//
//  Created by Stefan Popp on 21.09.11.
//  Copyright 2011 http://http://www.stefanpopp.de/2011/capture-iphone-microphone//2011/capture-iphone-microphone/ . All rights reserved.
//

#import <Foundation/Foundation.h>
#import <AudioToolbox/AudioToolbox.h>

#define kOutputBus 0
#define kInputBus 1

// our default sample rate
#define SAMPLE_RATE 44100.00

@interface AudioProcessor : NSObject
{
    // Audio unit
    AudioComponentInstance audioUnit;
    
    // Audio buffers
	AudioBuffer audioBuffer;
    
    // gain
    float gain;
}

@property (readonly) AudioBuffer audioBuffer;
@property (readonly) AudioComponentInstance audioUnit;
@property (nonatomic) float gain;
@property (nonatomic, assign) BOOL enablePlayback;
@property (nonatomic, readonly) float decibelsLevel;

-(AudioProcessor*)init;

-(void)initializeAudio;
-(void)processBuffer: (AudioBufferList*) audioBufferList;

// control object
-(void)start;
-(void)stop;

// gain
-(void)setGain:(float)gainValue;
-(float)getGain;

// error managment
-(void)hasError:(int)statusCode:(char*)file:(int)line;

+(AudioProcessor *) sharedAudioProcessor;

@end
