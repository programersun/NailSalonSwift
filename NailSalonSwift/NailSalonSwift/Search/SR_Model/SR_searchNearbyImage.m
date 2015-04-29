//
//  SR_searchNearbyImage.m
//
//  Created by sun  on 15/4/29
//  Copyright (c) 2015 __MyCompanyName__. All rights reserved.
//

#import "SR_searchNearbyImage.h"


NSString *const kSR_searchNearbyImageHeight = @"height";
NSString *const kSR_searchNearbyImageImagePath = @"image_path";
NSString *const kSR_searchNearbyImageAlbumId = @"album_id";
NSString *const kSR_searchNearbyImageCutHeight = @"cut_height";
NSString *const kSR_searchNearbyImageImageId = @"image_id";
NSString *const kSR_searchNearbyImageCutPath = @"cut_path";
NSString *const kSR_searchNearbyImageWidth = @"width";
NSString *const kSR_searchNearbyImageIsFirst = @"is_first";
NSString *const kSR_searchNearbyImageCutWidth = @"cut_width";
NSString *const kSR_searchNearbyImageAddTime = @"add_time";


@interface SR_searchNearbyImage ()

- (id)objectOrNilForKey:(id)aKey fromDictionary:(NSDictionary *)dict;

@end

@implementation SR_searchNearbyImage

@synthesize height = _height;
@synthesize imagePath = _imagePath;
@synthesize albumId = _albumId;
@synthesize cutHeight = _cutHeight;
@synthesize imageId = _imageId;
@synthesize cutPath = _cutPath;
@synthesize width = _width;
@synthesize isFirst = _isFirst;
@synthesize cutWidth = _cutWidth;
@synthesize addTime = _addTime;


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
            self.height = [self objectOrNilForKey:kSR_searchNearbyImageHeight fromDictionary:dict];
            self.imagePath = [self objectOrNilForKey:kSR_searchNearbyImageImagePath fromDictionary:dict];
            self.albumId = [self objectOrNilForKey:kSR_searchNearbyImageAlbumId fromDictionary:dict];
            self.cutHeight = [self objectOrNilForKey:kSR_searchNearbyImageCutHeight fromDictionary:dict];
            self.imageId = [self objectOrNilForKey:kSR_searchNearbyImageImageId fromDictionary:dict];
            self.cutPath = [self objectOrNilForKey:kSR_searchNearbyImageCutPath fromDictionary:dict];
            self.width = [self objectOrNilForKey:kSR_searchNearbyImageWidth fromDictionary:dict];
            self.isFirst = [self objectOrNilForKey:kSR_searchNearbyImageIsFirst fromDictionary:dict];
            self.cutWidth = [self objectOrNilForKey:kSR_searchNearbyImageCutWidth fromDictionary:dict];
            self.addTime = [self objectOrNilForKey:kSR_searchNearbyImageAddTime fromDictionary:dict];

    }
    
    return self;
    
}

- (NSDictionary *)dictionaryRepresentation
{
    NSMutableDictionary *mutableDict = [NSMutableDictionary dictionary];
    [mutableDict setValue:self.height forKey:kSR_searchNearbyImageHeight];
    [mutableDict setValue:self.imagePath forKey:kSR_searchNearbyImageImagePath];
    [mutableDict setValue:self.albumId forKey:kSR_searchNearbyImageAlbumId];
    [mutableDict setValue:self.cutHeight forKey:kSR_searchNearbyImageCutHeight];
    [mutableDict setValue:self.imageId forKey:kSR_searchNearbyImageImageId];
    [mutableDict setValue:self.cutPath forKey:kSR_searchNearbyImageCutPath];
    [mutableDict setValue:self.width forKey:kSR_searchNearbyImageWidth];
    [mutableDict setValue:self.isFirst forKey:kSR_searchNearbyImageIsFirst];
    [mutableDict setValue:self.cutWidth forKey:kSR_searchNearbyImageCutWidth];
    [mutableDict setValue:self.addTime forKey:kSR_searchNearbyImageAddTime];

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

    self.height = [aDecoder decodeObjectForKey:kSR_searchNearbyImageHeight];
    self.imagePath = [aDecoder decodeObjectForKey:kSR_searchNearbyImageImagePath];
    self.albumId = [aDecoder decodeObjectForKey:kSR_searchNearbyImageAlbumId];
    self.cutHeight = [aDecoder decodeObjectForKey:kSR_searchNearbyImageCutHeight];
    self.imageId = [aDecoder decodeObjectForKey:kSR_searchNearbyImageImageId];
    self.cutPath = [aDecoder decodeObjectForKey:kSR_searchNearbyImageCutPath];
    self.width = [aDecoder decodeObjectForKey:kSR_searchNearbyImageWidth];
    self.isFirst = [aDecoder decodeObjectForKey:kSR_searchNearbyImageIsFirst];
    self.cutWidth = [aDecoder decodeObjectForKey:kSR_searchNearbyImageCutWidth];
    self.addTime = [aDecoder decodeObjectForKey:kSR_searchNearbyImageAddTime];
    return self;
}

- (void)encodeWithCoder:(NSCoder *)aCoder
{

    [aCoder encodeObject:_height forKey:kSR_searchNearbyImageHeight];
    [aCoder encodeObject:_imagePath forKey:kSR_searchNearbyImageImagePath];
    [aCoder encodeObject:_albumId forKey:kSR_searchNearbyImageAlbumId];
    [aCoder encodeObject:_cutHeight forKey:kSR_searchNearbyImageCutHeight];
    [aCoder encodeObject:_imageId forKey:kSR_searchNearbyImageImageId];
    [aCoder encodeObject:_cutPath forKey:kSR_searchNearbyImageCutPath];
    [aCoder encodeObject:_width forKey:kSR_searchNearbyImageWidth];
    [aCoder encodeObject:_isFirst forKey:kSR_searchNearbyImageIsFirst];
    [aCoder encodeObject:_cutWidth forKey:kSR_searchNearbyImageCutWidth];
    [aCoder encodeObject:_addTime forKey:kSR_searchNearbyImageAddTime];
}

- (id)copyWithZone:(NSZone *)zone
{
    SR_searchNearbyImage *copy = [[SR_searchNearbyImage alloc] init];
    
    if (copy) {

        copy.height = [self.height copyWithZone:zone];
        copy.imagePath = [self.imagePath copyWithZone:zone];
        copy.albumId = [self.albumId copyWithZone:zone];
        copy.cutHeight = [self.cutHeight copyWithZone:zone];
        copy.imageId = [self.imageId copyWithZone:zone];
        copy.cutPath = [self.cutPath copyWithZone:zone];
        copy.width = [self.width copyWithZone:zone];
        copy.isFirst = [self.isFirst copyWithZone:zone];
        copy.cutWidth = [self.cutWidth copyWithZone:zone];
        copy.addTime = [self.addTime copyWithZone:zone];
    }
    
    return copy;
}


@end
