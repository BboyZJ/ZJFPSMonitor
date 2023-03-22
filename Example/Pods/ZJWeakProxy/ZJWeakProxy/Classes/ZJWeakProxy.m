//
//  ZJWeakProxy.m
//  ZJWeakProxy
//
//  Created by Mac on 2023/2/27.
//

#import "ZJWeakProxy.h"

/**
 实现的原理：使用 NSProxy 持有 target
 不再利用 NSTimer 直接持有 self，就不会导致 timer 对 self 的循环引用了
 */
@interface ZJWeakProxy ()
@property (nonatomic,weak)id target;
@end
@implementation ZJWeakProxy
+ (instancetype)proxyWithTarget:(id)target{
    // NSProxy对象不需要调用init，因为它本来就没有init方法
    ZJWeakProxy * proxy = [ZJWeakProxy alloc];
    proxy.target = target;
    return proxy;
}

#pragma mark -private
// 重写NSProxy两个方法：在处理消息转发时，将消息转发给真正的target处理
// 返回方法签名
- (NSMethodSignature *)methodSignatureForSelector:(SEL)sel{
    if ([self.target respondsToSelector:sel]) {
        return [self.target methodSignatureForSelector:sel];
    }
    return nil;
}
- (void)forwardInvocation:(NSInvocation *)invocation{
    SEL selector = invocation.selector;
    if ([self.target respondsToSelector:selector]) {
        [invocation invokeWithTarget:self.target];
    }
}
- (BOOL)respondsToSelector:(SEL)aSelector{
    return [self.target respondsToSelector:aSelector];
}

#pragma mark -dealloc
- (void)dealloc{
    NSLog(@"%s",__FUNCTION__);
}

@end

