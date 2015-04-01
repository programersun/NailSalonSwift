//
//  ZXYOriginAlbumImage.m
//
//  Created by   on 15/3/29
//  Copyright (c) 2015 __MyCompanyName__. All rights reserved.
//

#import "ZXYOriginAlbumImage.h"


NSString *const kZXYOriginAlbumImageCutWidth = @"cut_width";
NSString *const kZXYOriginAlbumImageCutPath = @"cut_path";
NSString *const kZXYOriginAlbumImageCutHeight = @"cut_height";


@interface ZXYOriginAlbumImage ()

- (id)objectOrNilForKey:(id)aKey fromDictionary:(NSDictionary *)dict;

@end

@implementation ZXYOriginAlbumImage

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
            self.cutWidth = [self objectOrNilForKey:kZXYOriginAlbumImageCutWidth fromDictionary:dict];
            self.cutPath = [self objectOrNilForKey:kZXYOriginAlbumImageCutPath fromDictionary:dict];
            self.cutHeight = [self objectOrNilForKey:kZXYOriginAlbumImageCutHeight fromDictionary:dict];

    }
    
    return self;
    
}

- (NSDictionary *)dictionaryRepresentation
{
    NSMutableDictionary *mutableDict = [NSMutableDictionary dictionary];
    [mutableDict setValue:self.cutWidth forKey:kZXYOriginAlbumImageCutWidth];
    [mutableDict setValue:self.cutPath forKey:kZXYOriginAlbumImageCutPath];
    [mutableDict setValue:self.cutHeight forKey:kZXYOriginAlbumImageCutHeight];

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

    self.cutWidth = [aDecoder decodeObjectForKey:kZXYOriginAlbumImageCutWidth];
    self.cutPath = [aDecoder decodeObjectForKey:kZXYOriginAlbumImageCutPath];
    self.cutHeight = [aDecoder decodeObjectForKey:kZXYOriginAlbumImageCutHeight];
    return self;
}

- (void)encodeWithCoder:(NSCoder *)aCoder
{

    [aCoder encodeObject:_cutWidth forKey:kZXYOriginAlbumImageCutWidth];
    [aCoder encodeObject:_cutPath forKey:kZXYOriginAlbumImageCutPath];
    [aCoder encodeObject:_cutHeight forKey:kZXYOriginAlbumImageCutHeight];
}

- (id)copyWithZone:(NSZone *)zone
{
    ZXYOriginAlbumImage *copy = [[ZXYOriginAlbumImage alloc] init];
    
    if (copy) {

        copy.cutWidth = [self.cutWidth copyWithZone:zone];
        copy.cutPath = [self.cutPath copyWithZone:zone];
        copy.cutHeight = [self.cutHeight copyWithZone:zone];
    }
    
    return copy;
}


@end
