//
//  ZXYOriginAlbumData.m
//
//  Created by   on 15/3/29
//  Copyright (c) 2015 __MyCompanyName__. All rights reserved.
//

#import "ZXYOriginAlbumData.h"
#import "ZXYOriginAlbumUser.h"
#import "ZXYOriginAlbumImage.h"


NSString *const kZXYOriginAlbumDataUser = @"user";
NSString *const kZXYOriginAlbumDataAlbumId = @"album_id";
NSString *const kZXYOriginAlbumDataImage = @"image";
NSString *const kZXYOriginAlbumDataUserId = @"user_id";
NSString *const kZXYOriginAlbumDataDescription = @"description";
NSString *const kZXYOriginAlbumDataAgreeCount = @"agree_count";
NSString *const kZXYOriginAlbumDataAddTime = @"add_time";


@interface ZXYOriginAlbumData ()

- (id)objectOrNilForKey:(id)aKey fromDictionary:(NSDictionary *)dict;

@end

@implementation ZXYOriginAlbumData

@synthesize user = _user;
@synthesize albumId = _albumId;
@synthesize image = _image;
@synthesize userId = _userId;
@synthesize dataDescription = _dataDescription;
@synthesize agreeCount = _agreeCount;
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
            self.user = [ZXYOriginAlbumUser modelObjectWithDictionary:[dict objectForKey:kZXYOriginAlbumDataUser]];
            self.albumId = [self objectOrNilForKey:kZXYOriginAlbumDataAlbumId fromDictionary:dict];
            self.image = [ZXYOriginAlbumImage modelObjectWithDictionary:[dict objectForKey:kZXYOriginAlbumDataImage]];
            self.userId = [self objectOrNilForKey:kZXYOriginAlbumDataUserId fromDictionary:dict];
            self.dataDescription = [self objectOrNilForKey:kZXYOriginAlbumDataDescription fromDictionary:dict];
            self.agreeCount = [self objectOrNilForKey:kZXYOriginAlbumDataAgreeCount fromDictionary:dict];
            self.addTime = [self objectOrNilForKey:kZXYOriginAlbumDataAddTime fromDictionary:dict];

    }
    
    return self;
    
}

- (NSDictionary *)dictionaryRepresentation
{
    NSMutableDictionary *mutableDict = [NSMutableDictionary dictionary];
    [mutableDict setValue:[self.user dictionaryRepresentation] forKey:kZXYOriginAlbumDataUser];
    [mutableDict setValue:self.albumId forKey:kZXYOriginAlbumDataAlbumId];
    [mutableDict setValue:[self.image dictionaryRepresentation] forKey:kZXYOriginAlbumDataImage];
    [mutableDict setValue:self.userId forKey:kZXYOriginAlbumDataUserId];
    [mutableDict setValue:self.dataDescription forKey:kZXYOriginAlbumDataDescription];
    [mutableDict setValue:self.agreeCount forKey:kZXYOriginAlbumDataAgreeCount];
    [mutableDict setValue:self.addTime forKey:kZXYOriginAlbumDataAddTime];

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

    self.user = [aDecoder decodeObjectForKey:kZXYOriginAlbumDataUser];
    self.albumId = [aDecoder decodeObjectForKey:kZXYOriginAlbumDataAlbumId];
    self.image = [aDecoder decodeObjectForKey:kZXYOriginAlbumDataImage];
    self.userId = [aDecoder decodeObjectForKey:kZXYOriginAlbumDataUserId];
    self.dataDescription = [aDecoder decodeObjectForKey:kZXYOriginAlbumDataDescription];
    self.agreeCount = [aDecoder decodeObjectForKey:kZXYOriginAlbumDataAgreeCount];
    self.addTime = [aDecoder decodeObjectForKey:kZXYOriginAlbumDataAddTime];
    return self;
}

- (void)encodeWithCoder:(NSCoder *)aCoder
{

    [aCoder encodeObject:_user forKey:kZXYOriginAlbumDataUser];
    [aCoder encodeObject:_albumId forKey:kZXYOriginAlbumDataAlbumId];
    [aCoder encodeObject:_image forKey:kZXYOriginAlbumDataImage];
    [aCoder encodeObject:_userId forKey:kZXYOriginAlbumDataUserId];
    [aCoder encodeObject:_dataDescription forKey:kZXYOriginAlbumDataDescription];
    [aCoder encodeObject:_agreeCount forKey:kZXYOriginAlbumDataAgreeCount];
    [aCoder encodeObject:_addTime forKey:kZXYOriginAlbumDataAddTime];
}

- (id)copyWithZone:(NSZone *)zone
{
    ZXYOriginAlbumData *copy = [[ZXYOriginAlbumData alloc] init];
    
    if (copy) {

        copy.user = [self.user copyWithZone:zone];
        copy.albumId = [self.albumId copyWithZone:zone];
        copy.image = [self.image copyWithZone:zone];
        copy.userId = [self.userId copyWithZone:zone];
        copy.dataDescription = [self.dataDescription copyWithZone:zone];
        copy.agreeCount = [self.agreeCount copyWithZone:zone];
        copy.addTime = [self.addTime copyWithZone:zone];
    }
    
    return copy;
}


@end
