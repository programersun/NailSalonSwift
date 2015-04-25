//
//  SR_FansData.m
//
//  Created by sun  on 15/4/25
//  Copyright (c) 2015 __MyCompanyName__. All rights reserved.
//

#import "SR_FansData.h"


NSString *const kSR_FansDataOrderCount2 = @"order_count2";
NSString *const kSR_FansDataHeadImage = @"head_image";
NSString *const kSR_FansDataLongitude = @"longitude";
NSString *const kSR_FansDataNickName = @"nick_name";
NSString *const kSR_FansDataLatitude = @"latitude";
NSString *const kSR_FansDataUserId = @"user_id";
NSString *const kSR_FansDataAlbumCount = @"album_count";
NSString *const kSR_FansDataByAttention = @"by_attention";
NSString *const kSR_FansDataOrderCount = @"order_count";
NSString *const kSR_FansDataRole = @"role";
NSString *const kSR_FansDataScore = @"score";
NSString *const kSR_FansDataIsPass = @"is_pass";


@interface SR_FansData ()

- (id)objectOrNilForKey:(id)aKey fromDictionary:(NSDictionary *)dict;

@end

@implementation SR_FansData

@synthesize orderCount2 = _orderCount2;
@synthesize headImage = _headImage;
@synthesize longitude = _longitude;
@synthesize nickName = _nickName;
@synthesize latitude = _latitude;
@synthesize userId = _userId;
@synthesize albumCount = _albumCount;
@synthesize byAttention = _byAttention;
@synthesize orderCount = _orderCount;
@synthesize role = _role;
@synthesize score = _score;
@synthesize isPass = _isPass;


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
            self.orderCount2 = [self objectOrNilForKey:kSR_FansDataOrderCount2 fromDictionary:dict];
            self.headImage = [self objectOrNilForKey:kSR_FansDataHeadImage fromDictionary:dict];
            self.longitude = [self objectOrNilForKey:kSR_FansDataLongitude fromDictionary:dict];
            self.nickName = [self objectOrNilForKey:kSR_FansDataNickName fromDictionary:dict];
            self.latitude = [self objectOrNilForKey:kSR_FansDataLatitude fromDictionary:dict];
            self.userId = [self objectOrNilForKey:kSR_FansDataUserId fromDictionary:dict];
            self.albumCount = [self objectOrNilForKey:kSR_FansDataAlbumCount fromDictionary:dict];
            self.byAttention = [self objectOrNilForKey:kSR_FansDataByAttention fromDictionary:dict];
            self.orderCount = [self objectOrNilForKey:kSR_FansDataOrderCount fromDictionary:dict];
            self.role = [self objectOrNilForKey:kSR_FansDataRole fromDictionary:dict];
            self.score = [self objectOrNilForKey:kSR_FansDataScore fromDictionary:dict];
            self.isPass = [self objectOrNilForKey:kSR_FansDataIsPass fromDictionary:dict];

    }
    
    return self;
    
}

- (NSDictionary *)dictionaryRepresentation
{
    NSMutableDictionary *mutableDict = [NSMutableDictionary dictionary];
    [mutableDict setValue:self.orderCount2 forKey:kSR_FansDataOrderCount2];
    [mutableDict setValue:self.headImage forKey:kSR_FansDataHeadImage];
    [mutableDict setValue:self.longitude forKey:kSR_FansDataLongitude];
    [mutableDict setValue:self.nickName forKey:kSR_FansDataNickName];
    [mutableDict setValue:self.latitude forKey:kSR_FansDataLatitude];
    [mutableDict setValue:self.userId forKey:kSR_FansDataUserId];
    [mutableDict setValue:self.albumCount forKey:kSR_FansDataAlbumCount];
    [mutableDict setValue:self.byAttention forKey:kSR_FansDataByAttention];
    [mutableDict setValue:self.orderCount forKey:kSR_FansDataOrderCount];
    [mutableDict setValue:self.role forKey:kSR_FansDataRole];
    [mutableDict setValue:self.score forKey:kSR_FansDataScore];
    [mutableDict setValue:self.isPass forKey:kSR_FansDataIsPass];

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

    self.orderCount2 = [aDecoder decodeObjectForKey:kSR_FansDataOrderCount2];
    self.headImage = [aDecoder decodeObjectForKey:kSR_FansDataHeadImage];
    self.longitude = [aDecoder decodeObjectForKey:kSR_FansDataLongitude];
    self.nickName = [aDecoder decodeObjectForKey:kSR_FansDataNickName];
    self.latitude = [aDecoder decodeObjectForKey:kSR_FansDataLatitude];
    self.userId = [aDecoder decodeObjectForKey:kSR_FansDataUserId];
    self.albumCount = [aDecoder decodeObjectForKey:kSR_FansDataAlbumCount];
    self.byAttention = [aDecoder decodeObjectForKey:kSR_FansDataByAttention];
    self.orderCount = [aDecoder decodeObjectForKey:kSR_FansDataOrderCount];
    self.role = [aDecoder decodeObjectForKey:kSR_FansDataRole];
    self.score = [aDecoder decodeObjectForKey:kSR_FansDataScore];
    self.isPass = [aDecoder decodeObjectForKey:kSR_FansDataIsPass];
    return self;
}

- (void)encodeWithCoder:(NSCoder *)aCoder
{

    [aCoder encodeObject:_orderCount2 forKey:kSR_FansDataOrderCount2];
    [aCoder encodeObject:_headImage forKey:kSR_FansDataHeadImage];
    [aCoder encodeObject:_longitude forKey:kSR_FansDataLongitude];
    [aCoder encodeObject:_nickName forKey:kSR_FansDataNickName];
    [aCoder encodeObject:_latitude forKey:kSR_FansDataLatitude];
    [aCoder encodeObject:_userId forKey:kSR_FansDataUserId];
    [aCoder encodeObject:_albumCount forKey:kSR_FansDataAlbumCount];
    [aCoder encodeObject:_byAttention forKey:kSR_FansDataByAttention];
    [aCoder encodeObject:_orderCount forKey:kSR_FansDataOrderCount];
    [aCoder encodeObject:_role forKey:kSR_FansDataRole];
    [aCoder encodeObject:_score forKey:kSR_FansDataScore];
    [aCoder encodeObject:_isPass forKey:kSR_FansDataIsPass];
}

- (id)copyWithZone:(NSZone *)zone
{
    SR_FansData *copy = [[SR_FansData alloc] init];
    
    if (copy) {

        copy.orderCount2 = [self.orderCount2 copyWithZone:zone];
        copy.headImage = [self.headImage copyWithZone:zone];
        copy.longitude = [self.longitude copyWithZone:zone];
        copy.nickName = [self.nickName copyWithZone:zone];
        copy.latitude = [self.latitude copyWithZone:zone];
        copy.userId = [self.userId copyWithZone:zone];
        copy.albumCount = [self.albumCount copyWithZone:zone];
        copy.byAttention = [self.byAttention copyWithZone:zone];
        copy.orderCount = [self.orderCount copyWithZone:zone];
        copy.role = [self.role copyWithZone:zone];
        copy.score = [self.score copyWithZone:zone];
        copy.isPass = [self.isPass copyWithZone:zone];
    }
    
    return copy;
}


@end
