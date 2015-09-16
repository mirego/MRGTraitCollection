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

@implementation UIView (MRGTraitEnvironment)

- (instancetype)MRGTraitEnvironment_UIView_initWithFrame:(CGRect)frame {
    if (![self MRGTraitEnvironment_UIView_initWithFrame:frame]) {
        return self;
    }
    
    [self MRGTraitEnvironment_UIView_setTraitCollection:(id)[MRGTraitCollection new]];
    return self;
}

- (instancetype)MRGTraitEnvironment_UIView_initWithCoder:(NSCoder *)aDecoder {
    if (![self MRGTraitEnvironment_UIView_initWithCoder:aDecoder]) {
        return self;
    }
    
    [self MRGTraitEnvironment_UIView_setTraitCollection:(id)[MRGTraitCollection new]];
    return self;
}

- (UITraitCollection *)MRGTraitEnvironment_UIView_getTraitCollection {
    return objc_getAssociatedObject(self, @selector(MRGTraitEnvironment_UIView_getTraitCollection));
}

- (void)MRGTraitEnvironment_UIView_setTraitCollection:(UITraitCollection *)traitCollection {
    UITraitCollection *previousTraitCollection = [self MRGTraitEnvironment_UIView_getTraitCollection];
    if (![previousTraitCollection isEqual:traitCollection]) {
        return;
    }
    
    // Store traitCollection
    objc_setAssociatedObject(self, @selector(MRGTraitEnvironment_UIView_getTraitCollection), traitCollection, OBJC_ASSOCIATION_RETAIN_NONATOMIC);
    
    // Notify subviews
    for (UIView *subview in self.subviews) {
        [subview MRGTraitEnvironment_UIView_setTraitCollection:traitCollection];
    }
    
    [self traitCollectionDidChange:previousTraitCollection];
}

static UITraitCollection* MRGTraitEnvironment_UIView_getTraitCollection(UIView *self, SEL _cmd) {
    return [self MRGTraitEnvironment_UIView_getTraitCollection];
}

static void MRGTraitEnvironment_UIView_traitCollectionDidChange(UIView *self, SEL _cmd, UITraitCollection *previousTraitCollection) {
    // NOP
}

+ (void)load {
    if (MRG_TRAITCOLLECTION_SYSTEM_VERSION_GREATER_THAN_OR_EQUAL_TO(@"8.0")) {
        return;
    }
    
    [UIView rt_addMethod:[RTMethod methodWithSelector:@selector(traitCollection)
                                       implementation:(IMP)MRGTraitEnvironment_UIView_getTraitCollection
                                            signature:[NSString stringWithFormat:@"%s%s%s", @encode(id), @encode(id), @encode(SEL)]]];
    [UIView rt_addMethod:[RTMethod methodWithSelector:@selector(traitCollectionDidChange:)
                                       implementation:(IMP)MRGTraitEnvironment_UIView_traitCollectionDidChange
                                            signature:[NSString stringWithFormat:@"%s%s%s%s", @encode(void), @encode(id), @encode(SEL), @encode(id)]]];
    
    [self jr_swizzleMethod:@selector(initWithFrame:) withMethod:@selector(MRGTraitEnvironment_UIView_initWithFrame:) error:NULL];
    [self jr_swizzleMethod:@selector(initWithCoder:) withMethod:@selector(MRGTraitEnvironment_UIView_initWithCoder:) error:NULL];
}

@end
