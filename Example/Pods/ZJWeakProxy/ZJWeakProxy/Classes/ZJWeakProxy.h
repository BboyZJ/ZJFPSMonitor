//
//  ZJWeakProxy.h
//  ZJWeakProxy
//
//  Created by Mac on 2023/2/27.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

/**
 功能：利用NSProxy的消息转发机制来避免循环引用
 用在NSTimer或者CADisplayLink中
 */
@interface ZJWeakProxy : NSProxy
+ (instancetype)proxyWithTarget:(id)target;
@end

NS_ASSUME_NONNULL_END
