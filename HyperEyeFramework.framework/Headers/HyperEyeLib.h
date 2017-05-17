//
//  HyperEyeLib.h
//  HyperEyeLib
//
//  Created by Konstantin Kalinin on 5/16/17.
//  Copyright © 2017 SQUARE NEST RESEARCH LABS, LLC. All rights reserved.
//

#import <Foundation/Foundation.h>

@class SQNHyperEyeReader;

@protocol SQNHyperEyeReaderDelegate <NSObject>
@optional
// Called every time when a new code is recognized.
// When code is disappeared, is called once with zero code.
- (void)hyperEyeReader:(SQNHyperEyeReader *)reader hasRecognizedHyperEyeCode:(UInt64)code;
// Called when detected a new distance to object.
// - (void)hyperEyeReader:(SQNHyperEyeReader *)reader hasDetectedHyperEyePosition:(kSQNHyperEyePositions)position;
@end

@interface SQNHyperEyeReader : NSObject

@property (weak, nonatomic) id<SQNHyperEyeReaderDelegate> delegate;
@property (assign, nonatomic) CGRect cameraTrackerFrame;
@property (readonly, atomic) bool isFrameProcessing;

@property (assign, nonatomic) CGFloat zoom;

- (SQNHyperEyeReader *)initWithGPUImageVideoCamera:(id)camera;
- (void) dealloc;

- (void) beginFrameProcessing;
- (void) stopFrameProcessing;

- (void) requestSavingImageToCameraRoll;

@end
