//
//  UIView+SJResponseChain.m
//  SJResponseChainExample
//
//  Created by SoulJa on 2018/3/30.
//  Copyright © 2018年 SoulJa. All rights reserved.
//

#import "UIView+SJResponseChain.h"
#import <objc/message.h>

@implementation UIView (SJResponseChain)

+ (void)load {
//    static dispatch_once_t onceToken;
//    dispatch_once(&onceToken, ^{
//        Class class = [self class];
//
//        SEL oriSel = @selector(hitTest:withEvent:);
//        SEL swiSel = @selector(sj_hitTest:withEvent:);
//
//        Method oriMethod = class_getInstanceMethod(class, oriSel);
//        Method swiMethod = class_getInstanceMethod(class, swiSel);
//
//        BOOL didAddMethod = class_addMethod(class, oriSel, class_getMethodImplementation(class, swiSel), method_getTypeEncoding(swiMethod));
//
//        if (didAddMethod) {
//            class_replaceMethod(class, swiSel, method_getImplementation(oriMethod), method_getTypeEncoding(oriMethod));
//        } else {
//            method_exchangeImplementations(oriMethod, swiMethod);
//        }
//    });
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        Class class = [self class];
        
        SEL oriSel = @selector(touchesBegan:withEvent:);
        SEL swiSel = @selector(sj_touchesBegan:withEvent:);
        
        Method oriMethod = class_getInstanceMethod(class, oriSel);
        Method swiMethod = class_getInstanceMethod(class, swiSel);
        
        BOOL didAddMethod = class_addMethod(class, oriSel, method_getImplementation(swiMethod), method_getTypeEncoding(swiMethod));
        
        if (didAddMethod) {
            class_replaceMethod(class, swiSel, method_getImplementation(oriMethod), method_getTypeEncoding(oriMethod));
        } else {
            method_exchangeImplementations(oriMethod, swiMethod);
        }
    });
}

- (UIView *)sj_hitTest:(CGPoint)point withEvent:(UIEvent *)event {
    NSLog(@"%@-%s",[self class],__PRETTY_FUNCTION__);
    return [self sj_hitTest:point withEvent:event];
}

- (void)sj_touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event {
    NSLog(@"%@-%s",[self class],__PRETTY_FUNCTION__);
    [super touchesBegan:touches withEvent:event];
}

@end
