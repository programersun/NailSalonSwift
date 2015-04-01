//
//  ZXYOfferRecommendAlbum.m
//
//  Created by   on 15/3/31
//  Copyright (c) 2015 __MyCompanyName__. All rights reserved.
//

#import "ZXYOfferRecommendAlbum.h"
#import "ZXYOfferImage.h"


NSString *const kZXYOfferRecommendAlbumNickName = @"nick_name";
NSString *const kZXYOfferRecommendAlbumAlbumId = @"album_id";
NSString *const kZXYOfferRecommendAlbumHeadImage = @"head_image";
NSString *const kZXYOfferRecommendAlbumCollectCount = @"collect_count";
NSString *const kZXYOfferRecommendAlbumRole = @"role";
NSString *const kZXYOfferRecommendAlbumImage = @"image";
NSString *const kZXYOfferRecommendAlbumUserId = @"user_id";
NSString *const kZXYOfferRecommendAlbumDescription = @"description";
NSString *const kZXYOfferRecommendAlbumAgreeCount = @"agree_count";
NSString *const kZXYOfferRecommendAlbumAddTime = @"add_time";


@interface ZXYOfferRecommendAlbum ()

- (id)objectOrNilForKey:(id)aKey fromDictionary:(NSDictionary *)dict;

@end

@implementation ZXYOfferRecommendAlbum

@synthesize nickName = _nickName;
@synthesize albumId = _albumId;
@synthesize headImage = _headImage;
@synthesize collectCount = _collectCount;
@synthesize role = _role;
@synthesize image = _image;
@synthesize userId = _userId;
@synthesize recommendAlbumDescription = _recommendAlbumDescription;
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
            self.nickName = [self objectOrNilForKey:kZXYOfferRecommendAlbumNickName fromDictionary:dict];
            self.albumId = [self objectOrNilForKey:kZXYOfferRecommendAlbumAlbumId fromDictionary:dict];
            self.headImage = [self objectOrNilForKey:kZXYOfferRecommendAlbumHeadImage fromDictionary:dict];
            self.collectCount = [self objectOrNilForKey:kZXYOfferRecommendAlbumCollectCount fromDictionary:dict];
            self.role = [self objectOrNilForKey:kZXYOfferRecommendAlbumRole fromDictionary:dict];
            self.image = [ZXYOfferImage modelObjectWithDictionary:[dict objectForKey:kZXYOfferRecommendAlbumImage]];
            self.userId = [self objectOrNilForKey:kZXYOfferRecommendAlbumUserId fromDictionary:dict];
            self.recommendAlbumDescription = [self objectOrNilForKey:kZXYOfferRecommendAlbumDescription fromDictionary:dict];
            self.agreeCount = [self objectOrNilForKey:kZXYOfferRecommendAlbumAgreeCount fromDictionary:dict];
            self.addTime = [self objectOrNilForKey:kZXYOfferRecommendAlbumAddTime fromDictionary:dict];

    }
    
    return self;
    
}

- (NSDictionary *)dictionaryRepresentation
{
    NSMutableDictionary *mutableDict = [NSMutableDictionary dictionary];
    [mutableDict setValue:self.nickName forKey:kZXYOfferRecommendAlbumNickName];
    [mutableDict setValue:self.albumId forKey:kZXYOfferRecommendAlbumAlbumId];
    [mutableDict setValue:self.headImage forKey:kZXYOfferRecommendAlbumHeadImage];
    [mutableDict setValue:self.collectCount forKey:kZXYOfferRecommendAlbumCollectCount];
    [mutableDict setValue:self.role forKey:kZXYOfferRecommendAlbumRole];
    [mutableDict setValue:[self.image dictionaryRepresentation] forKey:kZXYOfferRecommendAlbumImage];
    [mutableDict setValue:self.userId forKey:kZXYOfferRecommendAlbumUserId];
    [mutableDict setValue:self.recommendAlbumDescription forKey:kZXYOfferRecommendAlbumDescription];
    [mutableDict setValue:self.agreeCount forKey:kZXYOfferRecommendAlbumAgreeCount];
    [mutableDict setValue:self.addTime forKey:kZXYOfferRecommendAlbumAddTime];

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

    self.nickName = [aDecoder decodeObjectForKey:kZXYOfferRecommendAlbumNickName];
    self.albumId = [aDecoder decodeObjectForKey:kZXYOfferRecommendAlbumAlbumId];
    self.headImage = [aDecoder decodeObjectForKey:kZXYOfferRecommendAlbumHeadImage];
    self.collectCount = [aDecoder decodeObjectForKey:kZXYOfferRecommendAlbumCollectCount];
    self.role = [aDecoder decodeObjectForKey:kZXYOfferRecommendAlbumRole];
    self.image = [aDecoder decodeObjectForKey:kZXYOfferRecommendAlbumImage];
    self.userId = [aDecoder decodeObjectForKey:kZXYOfferRecommendAlbumUserId];
    self.recommendAlbumDescription = [aDecoder decodeObjectForKey:kZXYOfferRecommendAlbumDescription];
    self.agreeCount = [aDecoder decodeObjectForKey:kZXYOfferRecommendAlbumAgreeCount];
    self.addTime = [aDecoder decodeObjectForKey:kZXYOfferRecommendAlbumAddTime];
    return self;
}

- (void)encodeWithCoder:(NSCoder *)aCoder
{

    [aCoder encodeObject:_nickName forKey:kZXYOfferRecommendAlbumNickName];
    [aCoder encodeObject:_albumId forKey:kZXYOfferRecommendAlbumAlbumId];
    [aCoder encodeObject:_headImage forKey:kZXYOfferRecommendAlbumHeadImage];
    [aCoder encodeObject:_collectCount forKey:kZXYOfferRecommendAlbumCollectCount];
    [aCoder encodeObject:_role forKey:kZXYOfferRecommendAlbumRole];
    [aCoder encodeObject:_image forKey:kZXYOfferRecommendAlbumImage];
    [aCoder encodeObject:_userId forKey:kZXYOfferRecommendAlbumUserId];
    [aCoder encodeObject:_recommendAlbumDescription forKey:kZXYOfferRecommendAlbumDescription];
    [aCoder encodeObject:_agreeCount forKey:kZXYOfferRecommendAlbumAgreeCount];
    [aCoder encodeObject:_addTime forKey:kZXYOfferRecommendAlbumAddTime];
}

- (id)copyWithZone:(NSZone *)zone
{
    ZXYOfferRecommendAlbum *copy = [[ZXYOfferRecommendAlbum alloc] init];
    
    if (copy) {

        copy.nickName = [self.nickName copyWithZone:zone];
        copy.albumId = [self.albumId copyWithZone:zone];
        copy.headImage = [self.headImage copyWithZone:zone];
        copy.collectCount = [self.collectCount copyWithZone:zone];
        copy.role = [self.role copyWithZone:zone];
        copy.image = [self.image copyWithZone:zone];
        copy.userId = [self.userId copyWithZone:zone];
        copy.recommendAlbumDescription = [self.recommendAlbumDescription copyWithZone:zone];
        copy.agreeCount = [self.agreeCount copyWithZone:zone];
        copy.addTime = [self.addTime copyWithZone:zone];
    }
    
    return copy;
}


@end
