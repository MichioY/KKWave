//
//  ViewController.m
//  ElectricWave
//
//  Created by SuperDry on 18/08/2017.
//  Copyright © 2017 Michio. All rights reserved.
//

#import "ViewController.h"
#import "NSString+Time2Code.h"
#import <AudioUnit/AudioUnit.h>
#import <AVFoundation/AVFoundation.h>
#import <AudioToolbox/AudioToolbox.h>

// Bus 0 is used for the output side, bus 1 is used to get audio input.
#define kOutputBus 0
#define kInputBus 1

@interface ViewController ()
@property (weak, nonatomic) IBOutlet UILabel *timeLabel;

@property (nonatomic, assign) AudioUnit rioUnit;
@property (nonatomic, assign) AudioBufferList bufferList;

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
    
    [self initAudio];
    
    [NSString timeToCodeWithTime:[NSDate date]];
    
    
//    [NetworkClock sharedNetworkClock].getNTPDateDelegate = self;
    

}

- (void)initAudio{
    //iOS Audio Unit(一)
    //http://www.jianshu.com/p/5d18180c69b8
    //iOS音频开发:使用底层AudioUnit库实现录音和播放
    //http://blog.sina.com.cn/s/blog_942d71bb0102w9sg.html
    //    iOS音频开发学习
    //http://www.jianshu.com/p/8c7a616b30f1
    //音频处理
    //http://blog.csdn.net/zengconggen/article/category/1152863/2
    //iOS 工程自动化 - 思路整理
//    https://mp.weixin.qq.com/s/tkTo6WCsvDPZEME0oCAFDQ
    
    OSStatus status;
    AudioComponentInstance audioUnit;
    
    AudioComponentDescription desc;
    desc.componentType = kAudioUnitType_Output;
    desc.componentSubType = kAudioUnitSubType_RemoteIO;
    desc.componentFlags = 0;
    desc.componentFlagsMask = 0;
    desc.componentManufacturer = kAudioUnitManufacturer_Apple;
    
    AudioComponent inputComponent = AudioComponentFindNext(NULL, &desc);
    status = AudioComponentInstanceNew(inputComponent, &audioUnit);
//    checkStatus(status);
    
    UInt32 flag = 1;
    status = AudioUnitSetProperty(audioUnit,
                                  kAudioOutputUnitProperty_EnableIO,
                                  kAudioUnitScope_Input,
                                  kInputBus,
                                  &flag,
                                  sizeof(flag));
    //    checkStatus(status);
    status = AudioUnitSetProperty(audioUnit,
                                  kAudioOutputUnitProperty_EnableIO,
                                  kAudioUnitScope_Output,
                                  kOutputBus,
                                  &flag,
                                  sizeof(flag));
    
    
//    (AudioStreamBasicDescription) _format = {
//        mSampleRate = 44100
//        mFormatID = kAudioFormatLinearPCM
//        mFormatFlags = kAudioFormatFlagIsSignedInteger | kAudioFormatFlagIsPacked
//        mBytesPerPacket = 1
//        mFramesPerPacket = 1152
//        mBytesPerFrame = 0
//        mChannelsPerFrame = 2
//        mBitsPerChannel = 0
//        mReserved = 0
//    }
    
    // Describe format

    AudioStreamBasicDescription audioFormat;
    audioFormat.mSampleRate                 = 68500.00;
    audioFormat.mFormatID                   = kAudioFormatLinearPCM;
    audioFormat.mFormatFlags                = kAudioFormatFlagIsSignedInteger | kAudioFormatFlagIsPacked;
    audioFormat.mFramesPerPacket    = 1;
    audioFormat.mChannelsPerFrame   = 1;
    audioFormat.mBitsPerChannel             = 16;
    audioFormat.mBytesPerPacket             = 2;
    audioFormat.mBytesPerFrame              = 2;
    
    // Apply format
    status = AudioUnitSetProperty(audioUnit,
                                  kAudioUnitProperty_StreamFormat,
                                  kAudioUnitScope_Output,
                                  kInputBus,
                                  &audioFormat,
                                  sizeof(audioFormat));
//    checkStatus(status);
    status = AudioUnitSetProperty(audioUnit,
                                  kAudioUnitProperty_StreamFormat,
                                  kAudioUnitScope_Input,
                                  kOutputBus,
                                  &audioFormat,
                                  sizeof(audioFormat));
//    checkStatus(status);
    
    // Set input callback
//    AURenderCallbackStruct callbackStruct;
//    callbackStruct.inputProc = recordingCallback;
//    callbackStruct.inputProcRefCon = self;
//    status = AudioUnitSetProperty(audioUnit,
//                                  kAudioOutputUnitProperty_SetInputCallback,
//                                  kAudioUnitScope_Global,
//                                  kInputBus,
//                                  &callbackStruct,
//                                  sizeof(callbackStruct));
////    checkStatus(status);
//    
//    // Set output callback
//    callbackStruct.inputProc = playbackCallback;
//    callbackStruct.inputProcRefCon = self;
//    status = AudioUnitSetProperty(audioUnit,
//                                  kAudioUnitProperty_SetRenderCallback,
//                                  kAudioUnitScope_Global,
//                                  kOutputBus,
//                                  &callbackStruct,
//                                  sizeof(callbackStruct));
////    checkStatus(status);
}
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)playTimeCoder:(NSString *)coder{
    
//# 打开声音输出流
//# p = pyaudio.PyAudio()
//# stream = p.open(format = 8,
//#                 channels = 1,
//#                 rate = samp_rate,
//#                 output = True)
//    
//# while True:
//#     date_time = datetime.datetime.now()+dt
//#     print date_time
//#     sec = (date_time.second+1)%20
//#     code_str = time2code(date_time)
//#     start = sec * samp_rate
//#     for i in xrange((start), SAMPLE_LEN):
//#         #if i % div == 0:value = -value#carrier generate
//#         value = ampl * int(math.cos(math.pi / float(div) * float(i)))
//#         pulse = (i - sec * samp_rate)/(samp_rate / 10)
//#         packed_value = struct.pack('h', int(pulse >= int(code_str[sec]))*value)
//#         stream.write(packed_value)
//#         if i % samp_rate == 0 and i != start:
//#             sec = sec + 1
    
    NSError *error;
    
}

- (BOOL)IOUnit{
    
    // create IO Unit
//    BOOL result = NO;
//    OSStatus status;
//    AudioComponentInstance mVoipUnit;
//    
//    AudioComponentDescription outputDescription = {0};
//    outputDescription.componentType = kAudioUnitType_Output;
//    outputDescription.componentSubType = kAudioUnitSubType_RemoteIO;
//    outputDescription.componentManufacturer = kAudioUnitManufacturer_Apple;
//    outputDescription.componentFlags = 0;
//    outputDescription.componentFlagsMask = 0;
//    AudioComponent comp = AudioComponentFindNext(NULL, &outputDescription);
//    
//    
//    result = checkstatus(AudioComponentInstanceNew(comp, &mVoipUnit), @"couldn't create a new instance of RemoteIO");
//    if (!result) return result;
//
//    // config IO Enable status
//    UInt32 flag = 1;
//    result = CheckOSStatus(AudioUnitSetProperty(mVoipUnit, kAudioOutputUnitProperty_EnableIO, kAudioUnitScope_Output, kOutputBus, &flag, sizeof(flag)), @"could not enable output on RemoteIO");
//    if (!result) return result;
//    
//    result = CheckOSStatus(AudioUnitSetProperty(mVoipUnit, kAudioOutputUnitProperty_EnableIO, kAudioUnitScope_Input, kInputBus, &flag, sizeof(flag)),                  @"AudioUnitSetProperty EnableIO");
//    if (!result) return result;
//    
//    // Config default format
//    result = CheckOSStatus(AudioUnitSetProperty(mVoipUnit, kAudioUnitProperty_StreamFormat, kAudioUnitScope_Output, kInputBus, &inputAudioDescription, sizeof(inputAudioDescription)), @"couldn't set the input client format on RemoteIO");
//    if (!result) return result;
//    result = CheckOSStatus(AudioUnitSetProperty(mVoipUnit, kAudioUnitProperty_StreamFormat, kAudioUnitScope_Input, kOutputBus, &outputAudioDescription, sizeof(outputAudioDescription)), @"couldn't set the output client format on RemoteIO");
//    if (!result) return result;
//    
//    // Set the MaximumFramesPerSlice property. This property is used to describe to an audio unit the maximum number
//    // of samples it will be asked to produce on any single given call to AudioUnitRender
//    UInt32 maxFramesPerSlice = 4096;
//    result = CheckOSStatus(AudioUnitSetProperty(mVoipUnit, kAudioUnitProperty_MaximumFramesPerSlice, kAudioUnitScope_Global, 0, &maxFramesPerSlice, sizeof(UInt32)), @"couldn't set max frames per slice on RemoteIO");
//    if (!result) return result;
//    
//    // Set the record callback
//    AURenderCallbackStruct recordCallback;
//    recordCallback.inputProc = recordCallbackFunc;
//    recordCallback.inputProcRefCon = (__bridge void * _Nullable)(self);
//    result = CheckOSStatus(AudioUnitSetProperty(mVoipUnit, kAudioOutputUnitProperty_SetInputCallback, kAudioUnitScope_Global, kInputBus, &recordCallback, sizeof(recordCallback)), @"couldn't set record callback on RemoteIO");
//    if (!result) return result;
//    
//    // Set the playback callback
//    AURenderCallbackStruct playbackCallback;
//    playbackCallback.inputProc = playbackCallbackFunc;
//    playbackCallback.inputProcRefCon = (__bridge void * _Nullable)(self);
//    result = CheckOSStatus(AudioUnitSetProperty(mVoipUnit, kAudioUnitProperty_SetRenderCallback, kAudioUnitScope_Global, kOutputBus, &playbackCallback, sizeof(playbackCallback)), @"couldn't set playback callback on RemoteIO");
//    if (!result) return result;
//    
//    // set buffer allocate
//    flag = 0;
//    result = CheckOSStatus(AudioUnitSetProperty(mVoipUnit,
//                                                kAudioUnitProperty_ShouldAllocateBuffer,
//                                                kAudioUnitScope_Output,
//                                                kInputBus,
//                                                &flag,
//                                                sizeof(flag)), @"couldn't set property for ShouldAllocateBuffer");
//    if (!result) return result;
//    
//    // Initialize the output IO instance
//    result = CheckOSStatus(AudioUnitInitialize(mVoipUnit), @"couldn't initialize VoiceProcessingIO instance");
//    if (!result) return result;
//    
    return YES;
}

#pragma mark- getntpdatedelegate
-(void)getNTPDate:(NSDate *)date
{
//    NSString *strDate = [GameUtils NSDateToNSString:date];
//    self.timeLabel.text = strDate;
//    NSLog(@"%@", date);
}
-(IBAction)getServerDate
{
//    [[NetworkClock sharedNetworkClock] updateDate];
}
@end
