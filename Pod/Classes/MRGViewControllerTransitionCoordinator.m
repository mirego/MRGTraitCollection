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

#import "MRGViewControllerTransitionCoordinator.h"

@implementation MRGViewControllerTransitionCoordinator

- (instancetype)init {
    self = [super init];
    if (self) {
    }
    
    return self;
}

#pragma mark - UIViewControllerTransitionCoordinator

- (BOOL)animateAlongsideTransition:(void (^)(id<UIViewControllerTransitionCoordinatorContext> _Nonnull))animation completion:(void (^)(id<UIViewControllerTransitionCoordinatorContext> _Nonnull))completion {
    return YES;
}

- (BOOL)animateAlongsideTransitionInView:(UIView *)view animation:(void (^)(id<UIViewControllerTransitionCoordinatorContext> _Nonnull))animation completion:(void (^)(id<UIViewControllerTransitionCoordinatorContext> _Nonnull))completion {
    return YES;
}

- (void)notifyWhenInteractionEndsUsingBlock:(void (^)(id<UIViewControllerTransitionCoordinatorContext> _Nonnull))handler {
}

#pragma mark - UIViewControllerTransitionCoordinatorContext

- (BOOL)isAnimated {
    return YES;
}

- (UIModalPresentationStyle)presentationStyle {
    return UIModalPresentationFullScreen;
}

- (BOOL)initiallyInteractive {
    return NO;
}

- (BOOL)isInteractive {
    return NO;
}

- (BOOL)isCancelled {
    return NO;
}

- (NSTimeInterval)transitionDuration {
    return 0.25;
}

- (CGFloat)percentComplete {
    return 0.0;
}

- (CGFloat)completionVelocity {
    return 0.0;
}

- (UIViewAnimationCurve)completionCurve {
    return UIViewAnimationCurveEaseInOut;
}

- (UIViewController *)viewControllerForKey:(NSString *)key {
    return nil;
}

- (UIView *)viewForKey:(NSString *)key {
    return nil;
}

- (UIView *)containerView {
    return nil;
}

- (CGAffineTransform)targetTransform {
    return CGAffineTransformIdentity;
}

@end
