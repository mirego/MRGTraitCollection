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

#import "MRGTraitCollection.h"
#import "MRGTraitCollection_Private.h"

@implementation MRGTraitCollection

- (instancetype)init {
    self = [super init];
    if (self) {
        _userInterfaceIdiom = UIUserInterfaceIdiomUnspecified;
        _displayScale = 0.0;
        _horizontalSizeClass = UIUserInterfaceSizeClassUnspecified;
        _verticalSizeClass = UIUserInterfaceSizeClassUnspecified;
    }
    
    return self;
}

- (instancetype)initWithCoder:(NSCoder *)aDecoder {
    self = [super init];
    if (self) {
        _userInterfaceIdiom = [aDecoder decodeIntegerForKey:NSStringFromSelector(@selector(userInterfaceIdiom))];
        _displayScale = [aDecoder decodeFloatForKey:NSStringFromSelector(@selector(displayScale))];
        _horizontalSizeClass = [aDecoder decodeIntegerForKey:NSStringFromSelector(@selector(horizontalSizeClass))];
        _verticalSizeClass = [aDecoder decodeIntegerForKey:NSStringFromSelector(@selector(verticalSizeClass))];
    }
    
    return self;
}

- (id)copyWithZone:(NSZone *)zone {
    MRGTraitCollection *copy = [[[self class] allocWithZone:zone] init];
    if (copy) {
        copy.userInterfaceIdiom = self.userInterfaceIdiom;
        copy.displayScale = self.displayScale;
        copy.horizontalSizeClass = self.horizontalSizeClass;
        copy.verticalSizeClass = self.verticalSizeClass;
    }
    
    return copy;
}

- (void)encodeWithCoder:(NSCoder *)aCoder {
    [aCoder encodeInteger:[self userInterfaceIdiom] forKey:NSStringFromSelector(@selector(userInterfaceIdiom))];
    [aCoder encodeFloat:[self displayScale] forKey:NSStringFromSelector(@selector(displayScale))];
    [aCoder encodeInteger:[self horizontalSizeClass] forKey:NSStringFromSelector(@selector(horizontalSizeClass))];
    [aCoder encodeInteger:[self verticalSizeClass] forKey:NSStringFromSelector(@selector(verticalSizeClass))];
}

+ (BOOL)supportsSecureCoding {
    return YES;
}

+ (NSString *)stringForUserInterfaceIdiom:(UIUserInterfaceIdiom)userInterfaceIdiom {
    switch (userInterfaceIdiom) {
        case UIUserInterfaceIdiomUnspecified:
            return @"Unspecified";
        case UIUserInterfaceIdiomPhone:
            return @"Phone";
        case UIUserInterfaceIdiomPad:
            return @"Pad";
#ifdef __IPHONE_9_1
        case UIUserInterfaceIdiomTV:
            return @"TV";
#endif
    }
}

+ (NSString *)stringForUserInterfaceSizeClass:(UIUserInterfaceSizeClass)userInterfaceSizeClass {
    switch (userInterfaceSizeClass) {
        case UIUserInterfaceSizeClassUnspecified:
            return @"Unspecified";
        case UIUserInterfaceSizeClassCompact:
            return @"Compact";
        case UIUserInterfaceSizeClassRegular:
            return @"Regular";
    }
}

- (NSString *)description {
    NSMutableArray *description = [[NSMutableArray alloc] init];
    if (self.userInterfaceIdiom != UIUserInterfaceIdiomUnspecified) {
        [description addObject:[NSString stringWithFormat:@"_UITraitNameUserInterfaceIdiom: %@", [MRGTraitCollection stringForUserInterfaceIdiom:self.userInterfaceIdiom]]];
    }
    if (self.displayScale != 0.0) {
        [description addObject:[NSString stringWithFormat:@"_UITraitNameDisplayScale: %f", self.displayScale]];
    }
    if (self.horizontalSizeClass != UIUserInterfaceSizeClassUnspecified) {
        [description addObject:[NSString stringWithFormat:@"_UITraitNameHorizontalSizeClass: %@", [MRGTraitCollection stringForUserInterfaceSizeClass:self.horizontalSizeClass]]];
    }
    if (self.verticalSizeClass != UIUserInterfaceSizeClassUnspecified) {
        [description addObject:[NSString stringWithFormat:@"_UITraitNameVerticalSizeClass: %@", [MRGTraitCollection stringForUserInterfaceSizeClass:self.verticalSizeClass]]];
    }
    
    return [NSString stringWithFormat:@"<%@: %p; %@>", NSStringFromClass([self class]), self, [description componentsJoinedByString:@", "]];
}

- (BOOL)isEqual:(id)object {
    if (self == object) {
        return YES;
    }
    
    if (![object isKindOfClass:[MRGTraitCollection class]]) {
        return NO;
    }
    
    MRGTraitCollection *other = (MRGTraitCollection *)object;
    if (self.userInterfaceIdiom != other.userInterfaceIdiom) {
        return NO;
    }
    
    if (self.displayScale != other.displayScale) {
        return NO;
    }
    
    if (self.horizontalSizeClass != other.horizontalSizeClass) {
        return NO;
    }
    
    if (self.verticalSizeClass != other.verticalSizeClass) {
        return NO;
    }
    
    return YES;
}

- (NSUInteger)hash {
    return
    [@(self.userInterfaceIdiom) hash] ^
    [@(self.displayScale) hash] ^
    [@(self.horizontalSizeClass) hash] ^
    [@(self.verticalSizeClass) hash];
}

- (BOOL)containsTraitsInCollection:(MRGTraitCollection *)trait {
    if (trait.userInterfaceIdiom != UIUserInterfaceIdiomUnspecified &&
        trait.userInterfaceIdiom != self.userInterfaceIdiom) {
        return NO;
    }
    
    if (trait.displayScale != 0.0 &&
        trait.displayScale != self.displayScale) {
        return NO;
    }
    
    if (trait.horizontalSizeClass != UIUserInterfaceSizeClassUnspecified &&
        trait.horizontalSizeClass != self.horizontalSizeClass) {
        return NO;
    }
    
    if (trait.verticalSizeClass != UIUserInterfaceSizeClassUnspecified &&
        trait.verticalSizeClass != self.verticalSizeClass) {
        return NO;
    }
    
    return YES;
}

+ (MRGTraitCollection *)traitCollectionWithTraitsFromCollections:(NSArray<MRGTraitCollection *> *)traitCollections {
    MRGTraitCollection *newTraitCollection = [MRGTraitCollection new];
    
    for (MRGTraitCollection *traitCollection in traitCollections) {
        if (traitCollection.userInterfaceIdiom != UIUserInterfaceIdiomUnspecified) {
            newTraitCollection.userInterfaceIdiom = traitCollection.userInterfaceIdiom;
        }
        if (traitCollection.displayScale != 0.0) {
            newTraitCollection.displayScale = traitCollection.displayScale;
        }
        if (traitCollection.horizontalSizeClass != UIUserInterfaceSizeClassUnspecified) {
            newTraitCollection.horizontalSizeClass = traitCollection.horizontalSizeClass;
        }
        if (traitCollection.verticalSizeClass != UIUserInterfaceSizeClassUnspecified) {
            newTraitCollection.verticalSizeClass = traitCollection.verticalSizeClass;
        }
    }
    
    return newTraitCollection;
}

+ (MRGTraitCollection *)traitCollectionWithUserInterfaceIdiom:(UIUserInterfaceIdiom)idiom {
    MRGTraitCollection *newTraitCollection = [MRGTraitCollection new];
    newTraitCollection.userInterfaceIdiom = idiom;
    return newTraitCollection;
}

+ (MRGTraitCollection *)traitCollectionWithDisplayScale:(CGFloat)scale {
    MRGTraitCollection *newTraitCollection = [MRGTraitCollection new];
    newTraitCollection.displayScale = scale;
    return newTraitCollection;
}

+ (MRGTraitCollection *)traitCollectionWithHorizontalSizeClass:(UIUserInterfaceSizeClass)horizontalSizeClass {
    MRGTraitCollection *newTraitCollection = [MRGTraitCollection new];
    newTraitCollection.horizontalSizeClass = horizontalSizeClass;
    return newTraitCollection;
}

+ (MRGTraitCollection *)traitCollectionWithVerticalSizeClass:(UIUserInterfaceSizeClass)verticalSizeClass {
    MRGTraitCollection *newTraitCollection = [MRGTraitCollection new];
    newTraitCollection.verticalSizeClass = verticalSizeClass;
    return newTraitCollection;
}

@end
