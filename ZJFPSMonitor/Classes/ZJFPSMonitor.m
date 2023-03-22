//
//  ZJFPSMonitor.m
//  FPS
//
//  Created by Mac on 2023/3/23.
//

#import "ZJFPSMonitor.h"
#import <UIKit/UIKit.h>
#import <ZJWeakProxy/ZJWeakProxy.h>

@interface ZJFPSMonitor ()
@property (nonatomic,strong)CADisplayLink * displayLink;
@property (nonatomic,assign)NSTimeInterval lastUpdateTime; // 上一次更新时间
@property (nonatomic,assign)NSInteger count; // 刷新次数
@property (nonatomic,assign)NSInteger fps; // FPS
@end
@implementation ZJFPSMonitor
// 单例
+ (instancetype)shareInstance{
    static ZJFPSMonitor * instance = nil;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        instance = [[ZJFPSMonitor alloc] init];
    });
    return instance;
}

#pragma mark -开始监测
- (void)startMonitor{
    if (_displayLink != nil) {
        return;
    }
    // 线程保活
    [self.displayLink addToRunLoop:[NSRunLoop currentRunLoop] forMode:NSRunLoopCommonModes];
}

#pragma mark -计算FPS
- (void)fpsInfoAction:(CADisplayLink *)displayLink{
    if (self.lastUpdateTime == 0) {
        self.lastUpdateTime = displayLink.timestamp;
    }
    // 刷新次数
    self.count ++;
    // 时间间隔
    NSTimeInterval interval = displayLink.timestamp - self.lastUpdateTime;
    // 如果满足更新FPS时间间隔
    if (interval >= 1) {
        // 赋值fps
        self.fps = self.count / interval;
        // 赋值上次更新时间
        self.lastUpdateTime = displayLink.timestamp;
        // 重置数量
        self.count = 0;
        // 返回FPS
        if (self.FPSMonitorBlock) {
            self.FPSMonitorBlock(self.fps);
        }
    }
}

#pragma mark -lazy
- (CADisplayLink *)displayLink{
    if (!_displayLink) {
        _displayLink = [CADisplayLink displayLinkWithTarget:[ZJWeakProxy proxyWithTarget:self] selector:@selector(fpsInfoAction:)];
        // 屏幕刷新率
        _displayLink.preferredFramesPerSecond = 60;
    }
    return _displayLink;
}

@end
