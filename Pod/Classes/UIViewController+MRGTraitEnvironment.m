//
// Copyright (c) 2015, Mirego
// All rights reserved.
//
// Redistribution and use in source and binary forms, with or without
// modification, are permitted provided that the following conditions are met:
//
// - Redistributions of source code must retain the above copyright notice,
//   this list of conditions and the following disclaimer.
// - Redistributions in binary form must reproduce the above copyright notice,
//   this list of conditions and the following disclaimer in the documentation
//   and/or other materials provided with the distribution.
// - Neither the name of the Mirego nor the names of its contributors may
//   be used to endorse or promote products derived from this software without
//   specific prior written permission.
//
// THIS SOFTWARE IS PROVIDED BY THE COPYRIGHT HOLDERS AND CONTRIBUTORS "AS IS"
// AND ANY EXPRESS OR IMPLIED WARRANTIES, INCLUDING, BUT NOT LIMITED TO, THE
// IMPLIED WARRANTIES OF MERCHANTABILITY AND FITNESS FOR A PARTICULAR PURPOSE
// ARE DISCLAIMED. IN NO EVENT SHALL THE COPYRIGHT HOLDER OR CONTRIBUTORS BE
// LIABLE FOR ANY DIRECT, INDIRECT, INCIDENTAL, SPECIAL, EXEMPLARY, OR
// CONSEQUENTIAL DAMAGES (INCLUDING, BUT NOT LIMITED TO, PROCUREMENT OF
// SUBSTITUTE GOODS OR SERVICES; LOSS OF USE, DATA, OR PROFITS; OR BUSINESS
// INTERRUPTION) HOWEVER CAUSED AND ON ANY THEORY OF LIABILITY, WHETHER IN
// CONTRACT, STRICT LIABILITY, OR TORT (INCLUDING NEGLIGENCE OR OTHERWISE)
// ARISING IN ANY WAY OUT OF THE USE OF THIS SOFTWARE, EVEN IF ADVISED OF THE
// POSSIBILITY OF SUCH DAMAGE.

#import "MRGTraitCollection_private.h"
#import "MRGTraitEnvironment_Private.h"

#import <UIKit/UITraitCollection.h>

#import <MAObjCRuntime/MARTNSObject.h>
#import <MAObjCRuntime/RTMethod.h>
#import <JRSwizzle/JRSwizzle.h>

@implementation UIViewController (MRGTraitEnvironment)

- (instancetype)MRGTraitEnvironment_UIViewController_initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil {
    if (![self MRGTraitEnvironment_UIViewController_initWithNibName:nibNameOrNil bundle:nibBundleOrNil]) {
        return self;
    }
    
    [self MRGTraitEnvironment_UIViewController_setTraitCollection:(id)[MRGTraitCollection new]];
    return self;
}

- (instancetype)MRGTraitEnvironment_UIViewController_initWithCoder:(NSCoder *)aDecoder {
    if (![self MRGTraitEnvironment_UIViewController_initWithCoder:aDecoder]) {
        return self;
    }
    
    [self MRGTraitEnvironment_UIViewController_setTraitCollection:(id)[MRGTraitCollection new]];
    return self;
}

- (UITraitCollection *)MRGTraitEnvironment_UIViewController_getTraitCollection {
    return objc_getAssociatedObject(self, @selector(MRGTraitEnvironment_UIViewController_getTraitCollection));
}

- (void)MRGTraitEnvironment_UIViewController_setTraitCollection:(UITraitCollection *)traitCollection {
    UITraitCollection *previousTraitCollection = [self MRGTraitEnvironment_UIViewController_getTraitCollection];
    if (![previousTraitCollection isEqual:traitCollection]) {
        return;
    }
    
    // Store traitCollection
    objc_setAssociatedObject(self, @selector(MRGTraitEnvironment_UIViewController_getTraitCollection), traitCollection, OBJC_ASSOCIATION_RETAIN_NONATOMIC);
    
    // Notify child controllers
    for (UIViewController *childController in self.childViewControllers) {
        [childController MRGTraitEnvironment_UIViewController_setTraitCollection:[self overrideTraitCollectionForChildViewController:childController]];
    }
    
    if ((self.presentedViewController && self.presentedViewController.presentingViewController == self)) {
        [self.presentedViewController MRGTraitEnvironment_UIViewController_setTraitCollection:[self overrideTraitCollectionForChildViewController:self.presentedViewController]];
    }
    
    // Notify view
    if ([self isViewLoaded]) {
        [self.view MRGTraitEnvironment_UIView_setTraitCollection:traitCollection];
    }
    
    [self traitCollectionDidChange:previousTraitCollection];
}

- (void)MRGTraitEnvironment_UIViewController_addChildViewController:(UIViewController *)childController {
    // Notify child controller
    [self MRGTraitEnvironment_UIViewController_addChildViewController:childController];
    [childController MRGTraitEnvironment_UIViewController_setTraitCollection:[self overrideTraitCollectionForChildViewController:childController]];
}

- (void)MRGTraitEnvironment_UIViewController_loadView {
    // Notify view
    [self MRGTraitEnvironment_UIViewController_loadView];
    [self.view MRGTraitEnvironment_UIView_setTraitCollection:[self MRGTraitEnvironment_UIViewController_getTraitCollection]];
}

static UITraitCollection* MRGTraitEnvironment_UIViewController_getTraitCollection(UIViewController *self, SEL _cmd) {
    return [self MRGTraitEnvironment_UIViewController_getTraitCollection];
}

static void MRGTraitEnvironment_UIViewController_willTransitionToTraitCollectionWithTransitionCoordinator(UIViewController *self, SEL _cmd, UITraitCollection *newCollection, id<UIViewControllerTransitionCoordinator> coordinator) {
    // NOP
}

static void MRGTraitEnvironment_UIViewController_traitCollectionDidChange(UIViewController *self, SEL _cmd, UITraitCollection *previousTraitCollection) {
    // NOP
}

static void MRGTraitEnvironment_UIViewController_setOverrideTraitCollectionForChildViewController(UIViewController *self, SEL _cmd, UITraitCollection *collection, UIViewController *childViewController) {
    // FIXME Store override for child ViewController
}

static UITraitCollection* MRGTraitEnvironment_UIViewController_overrideTraitCollectionForChildViewController(UIViewController *self, SEL _cmd, UIViewController *childViewController) {
    // FIXME Retrieve override for child ViewController and merge it with stored
    return [self MRGTraitEnvironment_UIViewController_getTraitCollection];
}

+ (void)load {
    if (MRG_TRAITCOLLECTION_SYSTEM_VERSION_GREATER_THAN_OR_EQUAL_TO(@"8.0")) {
        return;
    }
    
    [UIViewController rt_addMethod:[RTMethod methodWithSelector:@selector(traitCollection)
                                                 implementation:(IMP)MRGTraitEnvironment_UIViewController_getTraitCollection
                                                      signature:[NSString stringWithFormat:@"%s%s%s", @encode(id), @encode(id), @encode(SEL)]]];
    [UIViewController rt_addMethod:[RTMethod methodWithSelector:@selector(willTransitionToTraitCollection:withTransitionCoordinator:)
                                                 implementation:(IMP)MRGTraitEnvironment_UIViewController_willTransitionToTraitCollectionWithTransitionCoordinator
                                                      signature:[NSString stringWithFormat:@"%s%s%s%s%s", @encode(void), @encode(id), @encode(SEL), @encode(id), @encode(id)]]];
    [UIViewController rt_addMethod:[RTMethod methodWithSelector:@selector(traitCollectionDidChange:)
                                                 implementation:(IMP)MRGTraitEnvironment_UIViewController_traitCollectionDidChange
                                                      signature:[NSString stringWithFormat:@"%s%s%s%s", @encode(void), @encode(id), @encode(SEL), @encode(id)]]];
    
    [UIViewController rt_addMethod:[RTMethod methodWithSelector:@selector(setOverrideTraitCollection:forChildViewController:)
                                                 implementation:(IMP)MRGTraitEnvironment_UIViewController_setOverrideTraitCollectionForChildViewController
                                                      signature:[NSString stringWithFormat:@"%s%s%s%s%s", @encode(void), @encode(id), @encode(SEL), @encode(id), @encode(id)]]];
    [UIViewController rt_addMethod:[RTMethod methodWithSelector:@selector(overrideTraitCollectionForChildViewController:)
                                                 implementation:(IMP)MRGTraitEnvironment_UIViewController_overrideTraitCollectionForChildViewController
                                                      signature:[NSString stringWithFormat:@"%s%s%s%s", @encode(id), @encode(id), @encode(SEL), @encode(id)]]];
    
    [self jr_swizzleMethod:@selector(initWithNibName:bundle:) withMethod:@selector(MRGTraitEnvironment_UIViewController_initWithNibName:bundle:) error:NULL];
    [self jr_swizzleMethod:@selector(initWithCoder:) withMethod:@selector(MRGTraitEnvironment_UIViewController_initWithCoder:) error:NULL];
    [self jr_swizzleMethod:@selector(addChildViewController:) withMethod:@selector(MRGTraitEnvironment_UIViewController_addChildViewController:) error:NULL];
    [self jr_swizzleMethod:@selector(loadView) withMethod:@selector(MRGTraitEnvironment_UIViewController_loadView) error:NULL];
}

@end
