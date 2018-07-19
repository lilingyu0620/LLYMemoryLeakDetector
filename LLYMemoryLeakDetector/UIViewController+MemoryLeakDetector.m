//
//  UIViewController+MemoryLeakDetector.m
//  LLYMemoryLeakDetector
//
//  Created by lly on 2018/7/19.
//  Copyright © 2018年 lly. All rights reserved.
//

#import "UIViewController+MemoryLeakDetector.h"
#import <objc/runtime.h>

const void *const kHasBeenPoppedKey = &kHasBeenPoppedKey;

@implementation UIViewController (MemoryLeakDetector)

+ (void)load{
    
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        
        [self swizzledViewWillAppear];
        [self swizzledViewDidDisappear];
        [self swizzledDismissViewController];
        
    });

}

+ (void)swizzledViewWillAppear{
    
    Class class = [self class];
    
    SEL originalSelector = @selector(viewWillAppear:);
    SEL swizzledSelector = @selector(ocn_viewWillAppear:);
    
    Method originalMethod = class_getInstanceMethod(class, originalSelector);
    Method swizzledMethod = class_getInstanceMethod(class, swizzledSelector);
    
    BOOL success = class_addMethod(class, originalSelector, method_getImplementation(swizzledMethod), method_getTypeEncoding(swizzledMethod));
    if (success) {
        class_replaceMethod(class, swizzledSelector, method_getImplementation(originalMethod), method_getTypeEncoding(originalMethod));
    }
    else{
        method_exchangeImplementations(originalMethod, swizzledMethod);
    }
}

+ (void)swizzledViewDidDisappear{
    
    Class class = [self class];
    
    SEL originalSelector = @selector(viewDidDisappear:);
    SEL swizzledSelector = @selector(ocn_viewDidDisappear:);
    
    Method originalMethod = class_getInstanceMethod(class, originalSelector);
    Method swizzledMethod = class_getInstanceMethod(class, swizzledSelector);
    
    BOOL success = class_addMethod(class, originalSelector, method_getImplementation(swizzledMethod), method_getTypeEncoding(swizzledMethod));
    if (success) {
        class_replaceMethod(class, swizzledSelector, method_getImplementation(originalMethod), method_getTypeEncoding(originalMethod));
    }
    else{
        method_exchangeImplementations(originalMethod, swizzledMethod);
    }
}

+ (void)swizzledDismissViewController{
    
    Class class = [self class];
    
    SEL originalSelector = @selector(dismissViewControllerAnimated:completion:);
    SEL swizzledSelector = @selector(ocn_dismissViewControllerAnimated:completion:);
    
    Method originalMethod = class_getInstanceMethod(class, originalSelector);
    Method swizzledMethod = class_getInstanceMethod(class, swizzledSelector);
    
    BOOL success = class_addMethod(class, originalSelector, method_getImplementation(swizzledMethod), method_getTypeEncoding(swizzledMethod));
    if (success) {
        class_replaceMethod(class, swizzledSelector, method_getImplementation(originalMethod), method_getTypeEncoding(originalMethod));
    }
    else{
        method_exchangeImplementations(originalMethod, swizzledMethod);
    }
}



- (void)ocn_viewWillAppear:(BOOL)animated{
    
    [self ocn_viewWillAppear:animated];
    
//    NSLog(@"%@--%@",NSStringFromClass([self class]),NSStringFromSelector(_cmd));
    
    [self setOcn_hasBeenPopped:NO];
    
}

- (void)ocn_viewDidDisappear:(BOOL)animated{
    
    [self ocn_viewDidDisappear:animated];

    __weak __typeof(self)weakSelf = self;
    
    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(1 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
        if ([weakSelf ocn_hasBeenPopped]) {
            [weakSelf alertWithClassName:NSStringFromClass([weakSelf class])];
        }
    });
    
}

- (void)ocn_dismissViewControllerAnimated:(BOOL)flag completion:(void (^)(void))completion {
    
    [self ocn_dismissViewControllerAnimated:flag completion:completion];
    [self setOcn_hasBeenPopped:YES];
    
}

- (BOOL)ocn_hasBeenPopped{
    return [objc_getAssociatedObject(self, kHasBeenPoppedKey) boolValue];
}

- (void)setOcn_hasBeenPopped:(BOOL)hasBeenPopped{
    objc_setAssociatedObject(self, kHasBeenPoppedKey, @(hasBeenPopped), OBJC_ASSOCIATION_RETAIN_NONATOMIC);
}

- (void)alertWithClassName:(NSString *)className{
    
    UIAlertController *alertController = [UIAlertController alertControllerWithTitle:@"内存泄露!!!" message:[NSString stringWithFormat:@"%@类发生内存泄露，请及时修改",className] preferredStyle:UIAlertControllerStyleAlert];
    UIAlertAction *ok = [UIAlertAction actionWithTitle:@"知道了" style:UIAlertActionStyleDefault handler:nil];
    [alertController addAction:ok];
    [[UIViewController oc_topViewController] presentViewController:alertController animated:YES completion:nil];
}

/**
 当前屏幕中正在显示的viewcontroller
 
 @return UIViewController
 */
+ (UIViewController *)oc_topViewController {
    UIViewController *resultVC;
    UIViewController *rootController = [[UIApplication sharedApplication].keyWindow rootViewController];
    resultVC = [rootController oc_topViewController];
    while (resultVC.presentedViewController) {
        resultVC = [resultVC.presentedViewController oc_topViewController];
    }
    return resultVC;
}

- (UIViewController *)oc_topViewController{
    UIViewController *vc = self;
    if ([vc isKindOfClass:[UINavigationController class]]) {
        return [[(UINavigationController *)vc topViewController] oc_topViewController];
    } else if ([vc isKindOfClass:[UITabBarController class]]) {
        return [[(UITabBarController *)vc selectedViewController] oc_topViewController];
    } else {
        return vc;
    }
    return nil;
}

@end

@implementation UINavigationController (MemoryLeakDetector)

+ (void)load{
    
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        [self swizzledPopViewControllerAnimated];
    });
    
}

+ (void)swizzledPopViewControllerAnimated{
    
    Class class = [self class];
    
    SEL originalSelector = @selector(popViewControllerAnimated:);
    SEL swizzledSelector = @selector(ocn_popViewControllerAnimated:);
    
    Method originalMethod = class_getInstanceMethod(class, originalSelector);
    Method swizzledMethod = class_getInstanceMethod(class, swizzledSelector);
    
    BOOL success = class_addMethod(class, originalSelector, method_getImplementation(swizzledMethod), method_getTypeEncoding(swizzledMethod));
    if (success) {
        class_replaceMethod(class, swizzledSelector, method_getImplementation(originalMethod), method_getTypeEncoding(originalMethod));
    }
    else{
        method_exchangeImplementations(originalMethod, swizzledMethod);
    }
}

- (UIViewController *)ocn_popViewControllerAnimated:(BOOL)animated {
    UIViewController *poppedViewController = [self ocn_popViewControllerAnimated:animated];
    
    if (!poppedViewController) {
        return nil;
    }
    
    objc_setAssociatedObject(poppedViewController, kHasBeenPoppedKey, @(YES), OBJC_ASSOCIATION_RETAIN);
    
    return poppedViewController;
}

@end

