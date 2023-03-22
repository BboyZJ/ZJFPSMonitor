//
//  ZJFPSMonitor.h
//  FPS
//
//  Created by Mac on 2023/3/23.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface ZJFPSMonitor : NSObject
// 返回屏幕刷新率FPS
@property (nonatomic,copy)void(^FPSMonitorBlock)(NSInteger fps);
// 单例
+ (instancetype)shareInstance;
// 开始监测
- (void)startMonitor;
@end

NS_ASSUME_NONNULL_END
