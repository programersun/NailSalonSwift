//
//  ZXY_AlbumDetailImages.m
//
//  Created by   on 15/4/12
//  Copyright (c) 2015 __MyCompanyName__. All rights reserved.
//

#import "ZXY_AlbumDetailImages.h"


NSString *const kZXY_AlbumDetailImagesHeight = @"height";
NSString *const kZXY_AlbumDetailImagesImagePath = @"image_path";
NSString *const kZXY_AlbumDetailImagesAlbumId = @"album_id";
NSString *const kZXY_AlbumDetailImagesAddTime = @"add_time";
NSString *const kZXY_AlbumDetailImagesImageId = @"image_id";
NSString *const kZXY_AlbumDetailImagesCutPath = @"cut_path";
NSString *const kZXY_AlbumDetailImagesWidth = @"width";
NSString *const kZXY_AlbumDetailImagesIsFirst = @"is_first";
NSString *const kZXY_AlbumDetailImagesCutWidth = @"cut_width";
NSString *const kZXY_AlbumDetailImagesCutHeight = @"cut_height";


@interface ZXY_AlbumDetailImages ()

- (id)objectOrNilForKey:(id)aKey fromDictionary:(NSDictionary *)dict;

@end

@implementation ZXY_AlbumDetailImages

@synthesize height = _height;
@synthesize imagePath = _imagePath;
@synthesize albumId = _albumId;
@synthesize addTime = _addTime;
@synthesize imageId = _imageId;
@synthesize cutPath = _cutPath;
@synthesize width = _width;
@synthesize isFirst = _isFirst;
@synthesize cutWidth = _cutWidth;
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
            self.height = [self objectOrNilForKey:kZXY_AlbumDetailImagesHeight fromDictionary:dict];
            self.imagePath = [self objectOrNilForKey:kZXY_AlbumDetailImagesImagePath fromDictionary:dict];
            self.albumId = [self objectOrNilForKey:kZXY_AlbumDetailImagesAlbumId fromDictionary:dict];
            self.addTime = [self objectOrNilForKey:kZXY_AlbumDetailImagesAddTime fromDictionary:dict];
            self.imageId = [self objectOrNilForKey:kZXY_AlbumDetailImagesImageId fromDictionary:dict];
            self.cutPath = [self objectOrNilForKey:kZXY_AlbumDetailImagesCutPath fromDictionary:dict];
            self.width = [self objectOrNilForKey:kZXY_AlbumDetailImagesWidth fromDictionary:dict];
            self.isFirst = [self objectOrNilForKey:kZXY_AlbumDetailImagesIsFirst fromDictionary:dict];
            self.cutWidth = [self objectOrNilForKey:kZXY_AlbumDetailImagesCutWidth fromDictionary:dict];
            self.cutHeight = [self objectOrNilForKey:kZXY_AlbumDetailImagesCutHeight fromDictionary:dict];

    }
    
    return self;
    
}

- (NSDictionary *)dictionaryRepresentation
{
    NSMutableDictionary *mutableDict = [NSMutableDictionary dictionary];
    [mutableDict setValue:self.height forKey:kZXY_AlbumDetailImagesHeight];
    [mutableDict setValue:self.imagePath forKey:kZXY_AlbumDetailImagesImagePath];
    [mutableDict setValue:self.albumId forKey:kZXY_AlbumDetailImagesAlbumId];
    [mutableDict setValue:self.addTime forKey:kZXY_AlbumDetailImagesAddTime];
    [mutableDict setValue:self.imageId forKey:kZXY_AlbumDetailImagesImageId];
    [mutableDict setValue:self.cutPath forKey:kZXY_AlbumDetailImagesCutPath];
    [mutableDict setValue:self.width forKey:kZXY_AlbumDetailImagesWidth];
    [mutableDict setValue:self.isFirst forKey:kZXY_AlbumDetailImagesIsFirst];
    [mutableDict setValue:self.cutWidth forKey:kZXY_AlbumDetailImagesCutWidth];
    [mutableDict setValue:self.cutHeight forKey:kZXY_AlbumDetailImagesCutHeight];

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

    self.height = [aDecoder decodeObjectForKey:kZXY_AlbumDetailImagesHeight];
    self.imagePath = [aDecoder decodeObjectForKey:kZXY_AlbumDetailImagesImagePath];
    self.albumId = [aDecoder decodeObjectForKey:kZXY_AlbumDetailImagesAlbumId];
    self.addTime = [aDecoder decodeObjectForKey:kZXY_AlbumDetailImagesAddTime];
    self.imageId = [aDecoder decodeObjectForKey:kZXY_AlbumDetailImagesImageId];
    self.cutPath = [aDecoder decodeObjectForKey:kZXY_AlbumDetailImagesCutPath];
    self.width = [aDecoder decodeObjectForKey:kZXY_AlbumDetailImagesWidth];
    self.isFirst = [aDecoder decodeObjectForKey:kZXY_AlbumDetailImagesIsFirst];
    self.cutWidth = [aDecoder decodeObjectForKey:kZXY_AlbumDetailImagesCutWidth];
    self.cutHeight = [aDecoder decodeObjectForKey:kZXY_AlbumDetailImagesCutHeight];
    return self;
}

- (void)encodeWithCoder:(NSCoder *)aCoder
{

    [aCoder encodeObject:_height forKey:kZXY_AlbumDetailImagesHeight];
    [aCoder encodeObject:_imagePath forKey:kZXY_AlbumDetailImagesImagePath];
    [aCoder encodeObject:_albumId forKey:kZXY_AlbumDetailImagesAlbumId];
    [aCoder encodeObject:_addTime forKey:kZXY_AlbumDetailImagesAddTime];
    [aCoder encodeObject:_imageId forKey:kZXY_AlbumDetailImagesImageId];
    [aCoder encodeObject:_cutPath forKey:kZXY_AlbumDetailImagesCutPath];
    [aCoder encodeObject:_width forKey:kZXY_AlbumDetailImagesWidth];
    [aCoder encodeObject:_isFirst forKey:kZXY_AlbumDetailImagesIsFirst];
    [aCoder encodeObject:_cutWidth forKey:kZXY_AlbumDetailImagesCutWidth];
    [aCoder encodeObject:_cutHeight forKey:kZXY_AlbumDetailImagesCutHeight];
}

- (id)copyWithZone:(NSZone *)zone
{
    ZXY_AlbumDetailImages *copy = [[ZXY_AlbumDetailImages alloc] init];
    
    if (copy) {

        copy.height = [self.height copyWithZone:zone];
        copy.imagePath = [self.imagePath copyWithZone:zone];
        copy.albumId = [self.albumId copyWithZone:zone];
        copy.addTime = [self.addTime copyWithZone:zone];
        copy.imageId = [self.imageId copyWithZone:zone];
        copy.cutPath = [self.cutPath copyWithZone:zone];
        copy.width = [self.width copyWithZone:zone];
        copy.isFirst = [self.isFirst copyWithZone:zone];
        copy.cutWidth = [self.cutWidth copyWithZone:zone];
        copy.cutHeight = [self.cutHeight copyWithZone:zone];
    }
    
    return copy;
}


@end
