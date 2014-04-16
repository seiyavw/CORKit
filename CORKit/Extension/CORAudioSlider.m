//
//  CORAudioSlider.m
//  CORKit
//
//  Created by Seiya Sasaki on 2014/01/30.
//  Copyright (c) 2014年 Seiya Sasaki. All rights reserved.
//

#import "CORAudioSlider.h"
#import <AVFoundation/AVFoundation.h>

@implementation CORAudioSlider
{
    AVPlayer *_player;
    id _sliderObserver;

}

NSString *const kCORAudioPlayerStatus;
NSString *const kCORAudioPlayerLoadedTimeRange;

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        // Initialization code
    }
    return self;
}

- (id)initWithAVPlayer:(AVPlayer *)player
{
    self = [super init];
    
    if (self)
    {
        _player = player;
        [self setup];
    }
    return self;
}

- (void)setImages:(UIImage *)thumbImage maxTrackImage:(UIImage *)maxTrackImage minTrackImage:(UIImage *)minTrackImage
{
    [self setThumbImage:thumbImage forState:UIControlStateNormal];
    [self setMaximumTrackImage:maxTrackImage forState:UIControlStateNormal];
    [self setMinimumTrackImage:minTrackImage forState:UIControlStateNormal];
}

- (void)setup
{
    // player item observer
    [_player.currentItem addObserver:self forKeyPath:kCORAudioPlayerStatus options:0 context:nil];
    [_player.currentItem addObserver:self forKeyPath:kCORAudioPlayerLoadedTimeRange options:NSKeyValueObservingOptionNew context:nil];
    self.minimumValue = 0.0;
    
    // monitor slider value change
    [self addTarget:self action:@selector(sliderViewValueChanged) forControlEvents:UIControlEventValueChanged];
}

- (void)sliderViewValueChanged
{
    [_player seekToTime:CMTimeMakeWithSeconds(self.value, NSEC_PER_SEC)];
}

- (void)syncWithPlayer
{
    // change slider value depending on player's current time
    const double duration = CMTimeGetSeconds([_player.currentItem duration]);
    const double time = CMTimeGetSeconds(_player.currentTime);
    const float value = (self.maximumValue - self.minimumValue) * time / duration + self.minimumValue;
    
    [self setValue:value];
    
    
    // use for  time display
//    NSInteger timeMinutes = ceil(time)/60;
//    NSInteger timeSeconds = (NSInteger)ceil(time) % 60;
    
}

- (void)updateSlider
{
    // clean time observer
    if (_sliderObserver != nil) {
        
        [_player removeTimeObserver:_sliderObserver];
        _sliderObserver = nil;
    }
    
    // update miximum and timer setting
    self.value = 0.0;
    self.maximumValue = CMTimeGetSeconds(_player.currentItem.duration);
    
    const double interval = (0.5f * self.maximumValue) / self.bounds.size.width;
    const CMTime time = CMTimeMakeWithSeconds( interval,  NSEC_PER_SEC);
    
    __weak typeof(self)weakSelf = self;
    // add time observer
    _sliderObserver = [_player addPeriodicTimeObserverForInterval:time queue:nil usingBlock:^(CMTime time){
        
        [weakSelf syncWithPlayer];
        
    }];
    
}

#pragma mark - Observer

// check if player is ready to play
- (void)observeValueForKeyPath:(NSString *)keyPath ofObject:(id)object
                        change:(NSDictionary *)change context:(void *)context
{
    if ([keyPath isEqualToString:kCORAudioPlayerStatus]) {
        
        AVPlayerItem *playerItem = (AVPlayerItem *)object;
        
        if (playerItem.status == AVPlayerItemStatusReadyToPlay) {
            
            [self updateSlider];
            
        } else if (playerItem.status == AVPlayerStatusFailed) {
            // failed
        }
        
    } else if ([keyPath isEqualToString:kCORAudioPlayerLoadedTimeRange]) {
        /* handleloaded time rages */
        //        AVPlayerItem *playerItem = (AVPlayerItem *)object;
        //        CMTimeRange timeRange = [[playerItem.loadedTimeRanges firstObject] CMTimeRangeValue];
        //        CGFloat startSeconds = CMTimeGetSeconds(timeRange.start);
        //        CGFloat durationSeconds = CMTimeGetSeconds(timeRange.duration);
        //        CGFloat result = startSeconds + durationSeconds;
        //        CGFloat maxSeconds = CMTimeGetSeconds(_playerItem.duration);
        
        //        NSLog(@"-----------------------------------------");
        //        NSLog(@"start is %f", startSeconds);
        //        NSLog(@"duration is %f", durationSeconds);
        //        NSLog(@"result is %f", result);
        //        NSLog(@"max is %f", maxSeconds);
    }
}

@end
