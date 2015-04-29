//
//  SR_searchLabelImage.m
//
//  Created by sun  on 15/4/28
//  Copyright (c) 2015 __MyCompanyName__. All rights reserved.
//

#import "SR_searchLabelImage.h"


NSString *const kSR_searchLabelImageCutWidth = @"cut_width";
NSString *const kSR_searchLabelImageCutPath = @"cut_path";
NSString *const kSR_searchLabelImageCutHeight = @"cut_height";


@interface SR_searchLabelImage ()

- (id)objectOrNilForKey:(id)aKey fromDictionary:(NSDictionary *)dict;

@end

@implementation SR_searchLabelImage

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
            self.cutWidth = [self objectOrNilForKey:kSR_searchLabelImageCutWidth fromDictionary:dict];
            self.cutPath = [self objectOrNilForKey:kSR_searchLabelImageCutPath fromDictionary:dict];
            self.cutHeight = [self objectOrNilForKey:kSR_searchLabelImageCutHeight fromDictionary:dict];

    }
    
    return self;
    
}

- (NSDictionary *)dictionaryRepresentation
{
    NSMutableDictionary *mutableDict = [NSMutableDictionary dictionary];
    [mutableDict setValue:self.cutWidth forKey:kSR_searchLabelImageCutWidth];
    [mutableDict setValue:self.cutPath forKey:kSR_searchLabelImageCutPath];
    [mutableDict setValue:self.cutHeight forKey:kSR_searchLabelImageCutHeight];

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

    self.cutWidth = [aDecoder decodeObjectForKey:kSR_searchLabelImageCutWidth];
    self.cutPath = [aDecoder decodeObjectForKey:kSR_searchLabelImageCutPath];
    self.cutHeight = [aDecoder decodeObjectForKey:kSR_searchLabelImageCutHeight];
    return self;
}

- (void)encodeWithCoder:(NSCoder *)aCoder
{

    [aCoder encodeObject:_cutWidth forKey:kSR_searchLabelImageCutWidth];
    [aCoder encodeObject:_cutPath forKey:kSR_searchLabelImageCutPath];
    [aCoder encodeObject:_cutHeight forKey:kSR_searchLabelImageCutHeight];
}

- (id)copyWithZone:(NSZone *)zone
{
    SR_searchLabelImage *copy = [[SR_searchLabelImage alloc] init];
    
    if (copy) {

        copy.cutWidth = [self.cutWidth copyWithZone:zone];
        copy.cutPath = [self.cutPath copyWithZone:zone];
        copy.cutHeight = [self.cutHeight copyWithZone:zone];
    }
    
    return copy;
}


@end
