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

#import "MRGTraitCollection_Private.h"
#import "MRGTraitEnvironment_Private.h"

#import <UIKit/UITraitCollection.h>

#import <MAObjCRuntime/MARTNSObject.h>
#import <MAObjCRuntime/RTMethod.h>
#import <JRSwizzle/JRSwizzle.h>

@implementation UIScreen (MRGTraitEnvironment)

- (UITraitCollection *)MRGTraitEnvironment_UIScreen_traitCollectionForInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation {
    MRGTraitCollection *traitCollection = [MRGTraitCollection new];
    traitCollection.userInterfaceIdiom = [[UIDevice currentDevice] userInterfaceIdiom];
    traitCollection.displayScale = [self scale];
    
    switch (traitCollection.userInterfaceIdiom) {
        default:
            break;
            
        case UIUserInterfaceIdiomPhone:
            traitCollection.horizontalSizeClass = UIInterfaceOrientationIsPortrait(interfaceOrientation) ? UIUserInterfaceSizeClassCompact : UIUserInterfaceSizeClassCompact;
            traitCollection.verticalSizeClass = UIInterfaceOrientationIsPortrait(interfaceOrientation) ? UIUserInterfaceSizeClassRegular : UIUserInterfaceSizeClassCompact;
            break;
            
        case UIUserInterfaceIdiomPad:
            traitCollection.horizontalSizeClass = UIUserInterfaceSizeClassRegular;
            traitCollection.verticalSizeClass = UIUserInterfaceSizeClassRegular;
            break;
    }
    
    return (id)traitCollection;
}

static UITraitCollection* MRGTraitEnvironment_UIScreen_getTraitCollection(UIScreen *self, SEL _cmd) {
    return [self MRGTraitEnvironment_UIScreen_traitCollectionForInterfaceOrientation:[[UIApplication sharedApplication] statusBarOrientation]];
}

static void MRGTraitEnvironment_UIScreen_traitCollectionDidChange(UIScreen *self, SEL _cmd, UITraitCollection *previousTraitCollection) {
    // NOP
}

+ (void)load {
    if (MRG_TRAITCOLLECTION_SYSTEM_VERSION_GREATER_THAN_OR_EQUAL_TO(@"8.0")) {
        return;
    }
    
    [UIScreen rt_addMethod:[RTMethod methodWithSelector:@selector(traitCollection)
                                         implementation:(IMP)MRGTraitEnvironment_UIScreen_getTraitCollection
                                              signature:[NSString stringWithFormat:@"%s%s%s", @encode(id), @encode(id), @encode(SEL)]]];
    [UIScreen rt_addMethod:[RTMethod methodWithSelector:@selector(traitCollectionDidChange:)
                                         implementation:(IMP)MRGTraitEnvironment_UIScreen_traitCollectionDidChange
                                              signature:[NSString stringWithFormat:@"%s%s%s%s", @encode(void), @encode(id), @encode(SEL), @encode(id)]]];
}

@end
