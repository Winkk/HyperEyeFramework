HyperEyeReader Core Library
===
### Reference Application

A project named  [HyperEyeReaderExample](https://github.com/Winkk/HyperEyeReaderExample) in Winkk repository demonstrates how does HyperEyeReader technology work and can be used as a reference. 

### Requirements 
* You should have `GPUImage` framework linked to the project.
* `GPUImageVideoCamera` object should be created and initialized before using `HyperEyeReader`.
* HyperEyeFramework is not compatible with `Bitcode`, so it should be disabled for the project.

### Files
To use HyperEyeReader, add `HyperEyeFramework` to the project manually or via CocoaPods. 
The CocoaPods way is shown in the reference project `HyperEyeReaderExample`.
Add a dependency in the project target in your Podfile. Since HyperEyeFramework is not a public CocoaPod, you have to manually set git source and version to be downloaded.

```
use_frameworks!
pod 'HyperEyeFramework', :git => 'https://github.com/winkk/HyperEyeFramework.git', :tag => '1.0.0'
```

After framework is added, include import directive in the module which will use `HyperEyeReader`.

```
#import <HyperEyeFramework/HyperEyeLib.h>
```

### SQNHyperEyeReader
The object which is used to recognize HyperEye codes is named `SQNHyperEyeReader`.

#### Methods

```
- (SQNHyperEyeReader *)initWithGPUImageVideoCamera:(GPUImageVideoCamera *)camera;
```

Creates an instance of `SQNHyperEyeReader` object. 

```
- (void) beginFrameProcessing;
```

This method starts actual processing of frames. 

```
- (void) stopFrameProcessing;
```

This method stops processing of frames.

```
- (void) requestSavingImageToCameraRoll;
```

When this method is called the next available frame will be saved to the camera roll in PNG format. Only the area which is clipped to cameraTrackerFrame  will be saved. It may be used for debug purposes.

#### Properties

```
@property (weak, nonatomic) id<SQNHyperEyeReaderDelegate> delegate;
```

Sets a delegate object which will receive callbacks when HyperEye code is recognized or state changes.

```
@property (assign, nonatomic) CGRect cameraTrackerFrame;
```

Sets an area of image where HyperEye pictures are searched in when a frame is arrived. The default value is (0,0,0,0) which is useless.

```
@property (assign, nonatomic) CGFloat zoom;
```

Sets an enlarging factor which will be used to increase the scale of input image.
	    The default value is `1.0`, which means that no scaling is performed. This is minimal value for the property.
	When the zoom property value is set to anything more than 1.0, the input image is stretched up by given zoom factor, and cameraTrackerFrame property value is stretched down internally by the same value. The area to detect remains the same pixel size. This results in ability to detect HyperEye codes of less size while decreasing the search area. 
	Maximal value of zoom property is limited to `10`.
	The zoom property value can be modified “on-the-fly” without restarting frame processing.


### How does it work

#### Initialization
To recognize HyperEye pictures you should initialize an instance of `SQNHyperEyeReader` object. An instance of active `GPUImageVideoCamera` object should be passed.

```
_hyperEyeReader = [[SQNHyperEyeReader alloc] initWithGPUImageVideoCamera:_session];
```

#### Set an area to search in

Assign a value to the property `cameraTrackerFrame`. This is a CGRect with values in a coordinate base of camera frame. If this is not set, none part of image will be analyzed.

```
[_hyperEyeReader setCameraTrackerFrame:_cameraTrackerFrame];
```

#### Set image scale factor

HyperEyeReader can enlarge input image to detect HyperEye codes of smaller size or placed too far from the camera. Assign a value to the property `zoom` to set scale factor. 

```
[_hyperEyeReader setZoom:3.0f];
```

#### Set delegate to receive and handle notifications

Assign a reference to object which conforms to `SQNHyperEyeReaderDelegate` protocol to the property `delegate`. The protocol `SQNHyperEyeReaderDelegate` has optional method:
    
```	
- (void)hyperEyeReader:(SQNHyperEyeReader *)reader hasRecognizedHyperEyeCode:(UInt64)code;
```		
	
Called once when a new HyperEye code is recognized with recognized value passed in code parameter. Called once when previously recognized code disappears with zero value passed in code parameter. 
* `reader` parameter stays for reference to the source `SQNHyperEyeReader` object.
* Method is dispatched at the main thread.

#### Start processing
When all of the previous stuff is set up, start processing frames from camera using `beginFrameProcessing`. This method takes no parameters.

```
[_hyperEyeReader beginFrameProcessing];
```

#### Finish processing 
When processing should be stopped, use `stopFrameProcessing` method.

```	
[_hyperEyeReader stopFrameProcessing];
```

#### Deallocate
    
`HyperEyeReader` is deallocated as regular Objective-C instance when it has no strong references left.

```
 _hyperEyeReader = nil;
```
