//
//  ZXYOfferImage.m
//
//  Created by   on 15/3/31
//  Copyright (c) 2015 __MyCompanyName__. All rights reserved.
//

#import "ZXYOfferImage.h"


NSString *const kZXYOfferImageCutWidth = @"cut_width";
NSString *const kZXYOfferImageCutPath = @"cut_path";
NSString *const kZXYOfferImageCutHeight = @"cut_height";


@interface ZXYOfferImage ()

- (id)objectOrNilForKey:(id)aKey fromDictionary:(NSDictionary *)dict;

@end

@implementation ZXYOfferImage

@synthesize cutWidth = _cutWidth;
@synthesize cutPath = _cutPath;
@synthesize cutHeight = _cutHeight;


+ (instancetype)modelObjectWithDictionary:(NSDictionary *)dict
{
    return [[self alloc] initWithDictionary:dict];
}

- (instancetype)initWithDictionary:(NSDictionary *)dict
{
    self = [super init];
    
    // This check serves to make sure that a non-NSDictionary object
    // passed into the model class doesn't break the parsing.
    if(self && [dict isKindOfClass:[NSDictionary class]]) {
            self.cutWidth = [self objectOrNilForKey:kZXYOfferImageCutWidth fromDictionary:dict];
            self.cutPath = [self objectOrNilForKey:kZXYOfferImageCutPath fromDictionary:dict];
            self.cutHeight = [self objectOrNilForKey:kZXYOfferImageCutHeight fromDictionary:dict];

    }
    
    return self;
    
}

- (NSDictionary *)dictionaryRepresentation
{
    NSMutableDictionary *mutableDict = [NSMutableDictionary dictionary];
    [mutableDict setValue:self.cutWidth forKey:kZXYOfferImageCutWidth];
    [mutableDict setValue:self.cutPath forKey:kZXYOfferImageCutPath];
    [mutableDict setValue:self.cutHeight forKey:kZXYOfferImageCutHeight];

    return [NSDictionary dictionaryWithDictionary:mutableDict];
}

- (NSString *)description 
{
    return [NSString stringWithFormat:@"%@", [self dictionaryRepresentation]];
}

#pragma mark - Helper Method
- (id)objectOrNilForKey:(id)aKey fromDictionary:(NSDictionary *)dict
{
    id object = [dict objectForKey:aKey];
    return [object isEqual:[NSNull null]] ? nil : object;
}


#pragma mark - NSCoding Methods

- (id)initWithCoder:(NSCoder *)aDecoder
{
    self = [super init];

    self.cutWidth = [aDecoder decodeObjectForKey:kZXYOfferImageCutWidth];
    self.cutPath = [aDecoder decodeObjectForKey:kZXYOfferImageCutPath];
    self.cutHeight = [aDecoder decodeObjectForKey:kZXYOfferImageCutHeight];
    return self;
}

- (void)encodeWithCoder:(NSCoder *)aCoder
{

    [aCoder encodeObject:_cutWidth forKey:kZXYOfferImageCutWidth];
    [aCoder encodeObject:_cutPath forKey:kZXYOfferImageCutPath];
    [aCoder encodeObject:_cutHeight forKey:kZXYOfferImageCutHeight];
}

- (id)copyWithZone:(NSZone *)zone
{
    ZXYOfferImage *copy = [[ZXYOfferImage alloc] init];
    
    if (copy) {

        copy.cutWidth = [self.cutWidth copyWithZone:zone];
        copy.cutPath = [self.cutPath copyWithZone:zone];
        copy.cutHeight = [self.cutHeight copyWithZone:zone];
    }
    
    return copy;
}


@end
