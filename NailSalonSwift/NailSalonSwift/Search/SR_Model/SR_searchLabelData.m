//
//  SR_searchLabelData.m
//
//  Created by sun  on 15/4/28
//  Copyright (c) 2015 __MyCompanyName__. All rights reserved.
//

#import "SR_searchLabelData.h"
#import "SR_searchLabelUser.h"
#import "SR_searchLabelImage.h"


NSString *const kSR_searchLabelDataAlbumId = @"album_id";
NSString *const kSR_searchLabelDataUser = @"user";
NSString *const kSR_searchLabelDataImage = @"image";
NSString *const kSR_searchLabelDataTag = @"tag";
NSString *const kSR_searchLabelDataUserId = @"user_id";
NSString *const kSR_searchLabelDataDescription = @"description";
NSString *const kSR_searchLabelDataAddTime = @"add_time";


@interface SR_searchLabelData ()

- (id)objectOrNilForKey:(id)aKey fromDictionary:(NSDictionary *)dict;

@end

@implementation SR_searchLabelData

@synthesize albumId = _albumId;
@synthesize user = _user;
@synthesize image = _image;
@synthesize tag = _tag;
@synthesize userId = _userId;
@synthesize dataDescription = _dataDescription;
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
            self.albumId = [self objectOrNilForKey:kSR_searchLabelDataAlbumId fromDictionary:dict];
            self.user = [SR_searchLabelUser modelObjectWithDictionary:[dict objectForKey:kSR_searchLabelDataUser]];
            self.image = [SR_searchLabelImage modelObjectWithDictionary:[dict objectForKey:kSR_searchLabelDataImage]];
            self.tag = [self objectOrNilForKey:kSR_searchLabelDataTag fromDictionary:dict];
            self.userId = [self objectOrNilForKey:kSR_searchLabelDataUserId fromDictionary:dict];
            self.dataDescription = [self objectOrNilForKey:kSR_searchLabelDataDescription fromDictionary:dict];
            self.addTime = [self objectOrNilForKey:kSR_searchLabelDataAddTime fromDictionary:dict];

    }
    
    return self;
    
}

- (NSDictionary *)dictionaryRepresentation
{
    NSMutableDictionary *mutableDict = [NSMutableDictionary dictionary];
    [mutableDict setValue:self.albumId forKey:kSR_searchLabelDataAlbumId];
    [mutableDict setValue:[self.user dictionaryRepresentation] forKey:kSR_searchLabelDataUser];
    [mutableDict setValue:[self.image dictionaryRepresentation] forKey:kSR_searchLabelDataImage];
    [mutableDict setValue:self.tag forKey:kSR_searchLabelDataTag];
    [mutableDict setValue:self.userId forKey:kSR_searchLabelDataUserId];
    [mutableDict setValue:self.dataDescription forKey:kSR_searchLabelDataDescription];
    [mutableDict setValue:self.addTime forKey:kSR_searchLabelDataAddTime];

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

    self.albumId = [aDecoder decodeObjectForKey:kSR_searchLabelDataAlbumId];
    self.user = [aDecoder decodeObjectForKey:kSR_searchLabelDataUser];
    self.image = [aDecoder decodeObjectForKey:kSR_searchLabelDataImage];
    self.tag = [aDecoder decodeObjectForKey:kSR_searchLabelDataTag];
    self.userId = [aDecoder decodeObjectForKey:kSR_searchLabelDataUserId];
    self.dataDescription = [aDecoder decodeObjectForKey:kSR_searchLabelDataDescription];
    self.addTime = [aDecoder decodeObjectForKey:kSR_searchLabelDataAddTime];
    return self;
}

- (void)encodeWithCoder:(NSCoder *)aCoder
{

    [aCoder encodeObject:_albumId forKey:kSR_searchLabelDataAlbumId];
    [aCoder encodeObject:_user forKey:kSR_searchLabelDataUser];
    [aCoder encodeObject:_image forKey:kSR_searchLabelDataImage];
    [aCoder encodeObject:_tag forKey:kSR_searchLabelDataTag];
    [aCoder encodeObject:_userId forKey:kSR_searchLabelDataUserId];
    [aCoder encodeObject:_dataDescription forKey:kSR_searchLabelDataDescription];
    [aCoder encodeObject:_addTime forKey:kSR_searchLabelDataAddTime];
}

- (id)copyWithZone:(NSZone *)zone
{
    SR_searchLabelData *copy = [[SR_searchLabelData alloc] init];
    
    if (copy) {

        copy.albumId = [self.albumId copyWithZone:zone];
        copy.user = [self.user copyWithZone:zone];
        copy.image = [self.image copyWithZone:zone];
        copy.tag = [self.tag copyWithZone:zone];
        copy.userId = [self.userId copyWithZone:zone];
        copy.dataDescription = [self.dataDescription copyWithZone:zone];
        copy.addTime = [self.addTime copyWithZone:zone];
    }
    
    return copy;
}


@end
