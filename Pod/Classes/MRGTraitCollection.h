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

#import <Foundation/Foundation.h>

/*! A trait collection encapsulates the system traits of an interface's environment. */
NS_ASSUME_NONNULL_BEGIN

@interface MRGTraitCollection : NSObject <NSCopying, NSSecureCoding>

- (instancetype)init NS_DESIGNATED_INITIALIZER;
- (nullable instancetype)initWithCoder:(NSCoder *)aDecoder NS_DESIGNATED_INITIALIZER;

- (BOOL)containsTraitsInCollection:(nullable MRGTraitCollection *)trait;

/*! Returns a trait collection by merging the traits in `traitCollections`. The last trait along any given
 axis (e.g. interface usage) will supercede any others. */
+ (MRGTraitCollection *)traitCollectionWithTraitsFromCollections:(NSArray<MRGTraitCollection *> *)traitCollections;


+ (MRGTraitCollection *)traitCollectionWithUserInterfaceIdiom:(UIUserInterfaceIdiom)idiom;
@property (nonatomic, readonly) UIUserInterfaceIdiom userInterfaceIdiom; // unspecified: UIUserInterfaceIdiomUnspecified

+ (MRGTraitCollection *)traitCollectionWithDisplayScale:(CGFloat)scale;
@property (nonatomic, readonly) CGFloat displayScale; // unspecified: 0.0

+ (MRGTraitCollection *)traitCollectionWithHorizontalSizeClass:(UIUserInterfaceSizeClass)horizontalSizeClass;
@property (nonatomic, readonly) UIUserInterfaceSizeClass horizontalSizeClass; // unspecified: UIUserInterfaceSizeClassUnspecified

+ (MRGTraitCollection *)traitCollectionWithVerticalSizeClass:(UIUserInterfaceSizeClass)verticalSizeClass;
@property (nonatomic, readonly) UIUserInterfaceSizeClass verticalSizeClass; // unspecified: UIUserInterfaceSizeClassUnspecified

@end

NS_ASSUME_NONNULL_END
