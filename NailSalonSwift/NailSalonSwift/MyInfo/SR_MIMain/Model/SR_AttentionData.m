//
//  SR_AttentionData.m
//
//  Created by sun  on 15/4/25
//  Copyright (c) 2015 __MyCompanyName__. All rights reserved.
//

#import "SR_AttentionData.h"


NSString *const kSR_AttentionDataOrderCount2 = @"order_count2";
NSString *const kSR_AttentionDataHeadImage = @"head_image";
NSString *const kSR_AttentionDataLongitude = @"longitude";
NSString *const kSR_AttentionDataNickName = @"nick_name";
NSString *const kSR_AttentionDataLatitude = @"latitude";
NSString *const kSR_AttentionDataUserId = @"user_id";
NSString *const kSR_AttentionDataAlbumCount = @"album_count";
NSString *const kSR_AttentionDataByAttention = @"by_attention";
NSString *const kSR_AttentionDataOrderCount = @"order_count";
NSString *const kSR_AttentionDataRole = @"role";
NSString *const kSR_AttentionDataScore = @"score";
NSString *const kSR_AttentionDataIsPass = @"is_pass";


@interface SR_AttentionData ()

- (id)objectOrNilForKey:(id)aKey fromDictionary:(NSDictionary *)dict;

@end

@implementation SR_AttentionData

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
            self.orderCount2 = [self objectOrNilForKey:kSR_AttentionDataOrderCount2 fromDictionary:dict];
            self.headImage = [self objectOrNilForKey:kSR_AttentionDataHeadImage fromDictionary:dict];
            self.longitude = [self objectOrNilForKey:kSR_AttentionDataLongitude fromDictionary:dict];
            self.nickName = [self objectOrNilForKey:kSR_AttentionDataNickName fromDictionary:dict];
            self.latitude = [self objectOrNilForKey:kSR_AttentionDataLatitude fromDictionary:dict];
            self.userId = [self objectOrNilForKey:kSR_AttentionDataUserId fromDictionary:dict];
            self.albumCount = [self objectOrNilForKey:kSR_AttentionDataAlbumCount fromDictionary:dict];
            self.byAttention = [self objectOrNilForKey:kSR_AttentionDataByAttention fromDictionary:dict];
            self.orderCount = [self objectOrNilForKey:kSR_AttentionDataOrderCount fromDictionary:dict];
            self.role = [self objectOrNilForKey:kSR_AttentionDataRole fromDictionary:dict];
            self.score = [self objectOrNilForKey:kSR_AttentionDataScore fromDictionary:dict];
            self.isPass = [self objectOrNilForKey:kSR_AttentionDataIsPass fromDictionary:dict];

    }
    
    return self;
    
}

- (NSDictionary *)dictionaryRepresentation
{
    NSMutableDictionary *mutableDict = [NSMutableDictionary dictionary];
    [mutableDict setValue:self.orderCount2 forKey:kSR_AttentionDataOrderCount2];
    [mutableDict setValue:self.headImage forKey:kSR_AttentionDataHeadImage];
    [mutableDict setValue:self.longitude forKey:kSR_AttentionDataLongitude];
    [mutableDict setValue:self.nickName forKey:kSR_AttentionDataNickName];
    [mutableDict setValue:self.latitude forKey:kSR_AttentionDataLatitude];
    [mutableDict setValue:self.userId forKey:kSR_AttentionDataUserId];
    [mutableDict setValue:self.albumCount forKey:kSR_AttentionDataAlbumCount];
    [mutableDict setValue:self.byAttention forKey:kSR_AttentionDataByAttention];
    [mutableDict setValue:self.orderCount forKey:kSR_AttentionDataOrderCount];
    [mutableDict setValue:self.role forKey:kSR_AttentionDataRole];
    [mutableDict setValue:self.score forKey:kSR_AttentionDataScore];
    [mutableDict setValue:self.isPass forKey:kSR_AttentionDataIsPass];

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

    self.orderCount2 = [aDecoder decodeObjectForKey:kSR_AttentionDataOrderCount2];
    self.headImage = [aDecoder decodeObjectForKey:kSR_AttentionDataHeadImage];
    self.longitude = [aDecoder decodeObjectForKey:kSR_AttentionDataLongitude];
    self.nickName = [aDecoder decodeObjectForKey:kSR_AttentionDataNickName];
    self.latitude = [aDecoder decodeObjectForKey:kSR_AttentionDataLatitude];
    self.userId = [aDecoder decodeObjectForKey:kSR_AttentionDataUserId];
    self.albumCount = [aDecoder decodeObjectForKey:kSR_AttentionDataAlbumCount];
    self.byAttention = [aDecoder decodeObjectForKey:kSR_AttentionDataByAttention];
    self.orderCount = [aDecoder decodeObjectForKey:kSR_AttentionDataOrderCount];
    self.role = [aDecoder decodeObjectForKey:kSR_AttentionDataRole];
    self.score = [aDecoder decodeObjectForKey:kSR_AttentionDataScore];
    self.isPass = [aDecoder decodeObjectForKey:kSR_AttentionDataIsPass];
    return self;
}

- (void)encodeWithCoder:(NSCoder *)aCoder
{

    [aCoder encodeObject:_orderCount2 forKey:kSR_AttentionDataOrderCount2];
    [aCoder encodeObject:_headImage forKey:kSR_AttentionDataHeadImage];
    [aCoder encodeObject:_longitude forKey:kSR_AttentionDataLongitude];
    [aCoder encodeObject:_nickName forKey:kSR_AttentionDataNickName];
    [aCoder encodeObject:_latitude forKey:kSR_AttentionDataLatitude];
    [aCoder encodeObject:_userId forKey:kSR_AttentionDataUserId];
    [aCoder encodeObject:_albumCount forKey:kSR_AttentionDataAlbumCount];
    [aCoder encodeObject:_byAttention forKey:kSR_AttentionDataByAttention];
    [aCoder encodeObject:_orderCount forKey:kSR_AttentionDataOrderCount];
    [aCoder encodeObject:_role forKey:kSR_AttentionDataRole];
    [aCoder encodeObject:_score forKey:kSR_AttentionDataScore];
    [aCoder encodeObject:_isPass forKey:kSR_AttentionDataIsPass];
}

- (id)copyWithZone:(NSZone *)zone
{
    SR_AttentionData *copy = [[SR_AttentionData alloc] init];
    
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
