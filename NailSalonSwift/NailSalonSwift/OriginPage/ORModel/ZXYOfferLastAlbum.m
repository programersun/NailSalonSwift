//
//  ZXYOfferLastAlbum.m
//
//  Created by   on 15/3/31
//  Copyright (c) 2015 __MyCompanyName__. All rights reserved.
//

#import "ZXYOfferLastAlbum.h"
#import "ZXYOfferImage.h"


NSString *const kZXYOfferLastAlbumNickName = @"nick_name";
NSString *const kZXYOfferLastAlbumAlbumId = @"album_id";
NSString *const kZXYOfferLastAlbumHeadImage = @"head_image";
NSString *const kZXYOfferLastAlbumCollectCount = @"collect_count";
NSString *const kZXYOfferLastAlbumRole = @"role";
NSString *const kZXYOfferLastAlbumImage = @"image";
NSString *const kZXYOfferLastAlbumUserId = @"user_id";
NSString *const kZXYOfferLastAlbumDescription = @"description";
NSString *const kZXYOfferLastAlbumAgreeCount = @"agree_count";
NSString *const kZXYOfferLastAlbumAddTime = @"add_time";


@interface ZXYOfferLastAlbum ()

- (id)objectOrNilForKey:(id)aKey fromDictionary:(NSDictionary *)dict;

@end

@implementation ZXYOfferLastAlbum

@synthesize nickName = _nickName;
@synthesize albumId = _albumId;
@synthesize headImage = _headImage;
@synthesize collectCount = _collectCount;
@synthesize role = _role;
@synthesize image = _image;
@synthesize userId = _userId;
@synthesize lastAlbumDescription = _lastAlbumDescription;
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
            self.nickName = [self objectOrNilForKey:kZXYOfferLastAlbumNickName fromDictionary:dict];
            self.albumId = [self objectOrNilForKey:kZXYOfferLastAlbumAlbumId fromDictionary:dict];
            self.headImage = [self objectOrNilForKey:kZXYOfferLastAlbumHeadImage fromDictionary:dict];
            self.collectCount = [self objectOrNilForKey:kZXYOfferLastAlbumCollectCount fromDictionary:dict];
            self.role = [self objectOrNilForKey:kZXYOfferLastAlbumRole fromDictionary:dict];
            self.image = [ZXYOfferImage modelObjectWithDictionary:[dict objectForKey:kZXYOfferLastAlbumImage]];
            self.userId = [self objectOrNilForKey:kZXYOfferLastAlbumUserId fromDictionary:dict];
            self.lastAlbumDescription = [self objectOrNilForKey:kZXYOfferLastAlbumDescription fromDictionary:dict];
            self.agreeCount = [self objectOrNilForKey:kZXYOfferLastAlbumAgreeCount fromDictionary:dict];
            self.addTime = [self objectOrNilForKey:kZXYOfferLastAlbumAddTime fromDictionary:dict];

    }
    
    return self;
    
}

- (NSDictionary *)dictionaryRepresentation
{
    NSMutableDictionary *mutableDict = [NSMutableDictionary dictionary];
    [mutableDict setValue:self.nickName forKey:kZXYOfferLastAlbumNickName];
    [mutableDict setValue:self.albumId forKey:kZXYOfferLastAlbumAlbumId];
    [mutableDict setValue:self.headImage forKey:kZXYOfferLastAlbumHeadImage];
    [mutableDict setValue:self.collectCount forKey:kZXYOfferLastAlbumCollectCount];
    [mutableDict setValue:self.role forKey:kZXYOfferLastAlbumRole];
    [mutableDict setValue:[self.image dictionaryRepresentation] forKey:kZXYOfferLastAlbumImage];
    [mutableDict setValue:self.userId forKey:kZXYOfferLastAlbumUserId];
    [mutableDict setValue:self.lastAlbumDescription forKey:kZXYOfferLastAlbumDescription];
    [mutableDict setValue:self.agreeCount forKey:kZXYOfferLastAlbumAgreeCount];
    [mutableDict setValue:self.addTime forKey:kZXYOfferLastAlbumAddTime];

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

    self.nickName = [aDecoder decodeObjectForKey:kZXYOfferLastAlbumNickName];
    self.albumId = [aDecoder decodeObjectForKey:kZXYOfferLastAlbumAlbumId];
    self.headImage = [aDecoder decodeObjectForKey:kZXYOfferLastAlbumHeadImage];
    self.collectCount = [aDecoder decodeObjectForKey:kZXYOfferLastAlbumCollectCount];
    self.role = [aDecoder decodeObjectForKey:kZXYOfferLastAlbumRole];
    self.image = [aDecoder decodeObjectForKey:kZXYOfferLastAlbumImage];
    self.userId = [aDecoder decodeObjectForKey:kZXYOfferLastAlbumUserId];
    self.lastAlbumDescription = [aDecoder decodeObjectForKey:kZXYOfferLastAlbumDescription];
    self.agreeCount = [aDecoder decodeObjectForKey:kZXYOfferLastAlbumAgreeCount];
    self.addTime = [aDecoder decodeObjectForKey:kZXYOfferLastAlbumAddTime];
    return self;
}

- (void)encodeWithCoder:(NSCoder *)aCoder
{

    [aCoder encodeObject:_nickName forKey:kZXYOfferLastAlbumNickName];
    [aCoder encodeObject:_albumId forKey:kZXYOfferLastAlbumAlbumId];
    [aCoder encodeObject:_headImage forKey:kZXYOfferLastAlbumHeadImage];
    [aCoder encodeObject:_collectCount forKey:kZXYOfferLastAlbumCollectCount];
    [aCoder encodeObject:_role forKey:kZXYOfferLastAlbumRole];
    [aCoder encodeObject:_image forKey:kZXYOfferLastAlbumImage];
    [aCoder encodeObject:_userId forKey:kZXYOfferLastAlbumUserId];
    [aCoder encodeObject:_lastAlbumDescription forKey:kZXYOfferLastAlbumDescription];
    [aCoder encodeObject:_agreeCount forKey:kZXYOfferLastAlbumAgreeCount];
    [aCoder encodeObject:_addTime forKey:kZXYOfferLastAlbumAddTime];
}

- (id)copyWithZone:(NSZone *)zone
{
    ZXYOfferLastAlbum *copy = [[ZXYOfferLastAlbum alloc] init];
    
    if (copy) {

        copy.nickName = [self.nickName copyWithZone:zone];
        copy.albumId = [self.albumId copyWithZone:zone];
        copy.headImage = [self.headImage copyWithZone:zone];
        copy.collectCount = [self.collectCount copyWithZone:zone];
        copy.role = [self.role copyWithZone:zone];
        copy.image = [self.image copyWithZone:zone];
        copy.userId = [self.userId copyWithZone:zone];
        copy.lastAlbumDescription = [self.lastAlbumDescription copyWithZone:zone];
        copy.agreeCount = [self.agreeCount copyWithZone:zone];
        copy.addTime = [self.addTime copyWithZone:zone];
    }
    
    return copy;
}


@end
