//
//  ZXY_ArtistDetailData.m
//
//  Created by   on 15/4/21
//  Copyright (c) 2015 __MyCompanyName__. All rights reserved.
//

#import "ZXY_ArtistDetailData.h"


NSString *const kZXY_ArtistDetailDataAttention = @"attention";
NSString *const kZXY_ArtistDetailDataOrderCount2 = @"order_count2";
NSString *const kZXY_ArtistDetailDataRealName = @"real_name";
NSString *const kZXY_ArtistDetailDataHeadImage = @"head_image";
NSString *const kZXY_ArtistDetailDataSex = @"sex";
NSString *const kZXY_ArtistDetailDataLongitude = @"longitude";
NSString *const kZXY_ArtistDetailDataNickName = @"nick_name";
NSString *const kZXY_ArtistDetailDataLatitude = @"latitude";
NSString *const kZXY_ArtistDetailDataAlbumCount = @"album_count";
NSString *const kZXY_ArtistDetailDataByAttention = @"by_attention";
NSString *const kZXY_ArtistDetailDataAddress = @"address";
NSString *const kZXY_ArtistDetailDataOrderCount = @"order_count";
NSString *const kZXY_ArtistDetailDataRole = @"role";
NSString *const kZXY_ArtistDetailDataTel = @"tel";
NSString *const kZXY_ArtistDetailDataScore = @"score";
NSString *const kZXY_ArtistDetailDataIsAttention = @"is_attention";
NSString *const kZXY_ArtistDetailDataIsPass = @"is_pass";


@interface ZXY_ArtistDetailData ()

- (id)objectOrNilForKey:(id)aKey fromDictionary:(NSDictionary *)dict;

@end

@implementation ZXY_ArtistDetailData

@synthesize attention = _attention;
@synthesize orderCount2 = _orderCount2;
@synthesize realName = _realName;
@synthesize headImage = _headImage;
@synthesize sex = _sex;
@synthesize longitude = _longitude;
@synthesize nickName = _nickName;
@synthesize latitude = _latitude;
@synthesize albumCount = _albumCount;
@synthesize byAttention = _byAttention;
@synthesize address = _address;
@synthesize orderCount = _orderCount;
@synthesize role = _role;
@synthesize tel = _tel;
@synthesize score = _score;
@synthesize isAttention = _isAttention;
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
            self.attention = [self objectOrNilForKey:kZXY_ArtistDetailDataAttention fromDictionary:dict];
            self.orderCount2 = [self objectOrNilForKey:kZXY_ArtistDetailDataOrderCount2 fromDictionary:dict];
            self.realName = [self objectOrNilForKey:kZXY_ArtistDetailDataRealName fromDictionary:dict];
            self.headImage = [self objectOrNilForKey:kZXY_ArtistDetailDataHeadImage fromDictionary:dict];
            self.sex = [self objectOrNilForKey:kZXY_ArtistDetailDataSex fromDictionary:dict];
            self.longitude = [self objectOrNilForKey:kZXY_ArtistDetailDataLongitude fromDictionary:dict];
            self.nickName = [self objectOrNilForKey:kZXY_ArtistDetailDataNickName fromDictionary:dict];
            self.latitude = [self objectOrNilForKey:kZXY_ArtistDetailDataLatitude fromDictionary:dict];
            self.albumCount = [self objectOrNilForKey:kZXY_ArtistDetailDataAlbumCount fromDictionary:dict];
            self.byAttention = [self objectOrNilForKey:kZXY_ArtistDetailDataByAttention fromDictionary:dict];
            self.address = [self objectOrNilForKey:kZXY_ArtistDetailDataAddress fromDictionary:dict];
            self.orderCount = [self objectOrNilForKey:kZXY_ArtistDetailDataOrderCount fromDictionary:dict];
            self.role = [self objectOrNilForKey:kZXY_ArtistDetailDataRole fromDictionary:dict];
            self.tel = [self objectOrNilForKey:kZXY_ArtistDetailDataTel fromDictionary:dict];
            self.score = [self objectOrNilForKey:kZXY_ArtistDetailDataScore fromDictionary:dict];
            self.isAttention = [[self objectOrNilForKey:kZXY_ArtistDetailDataIsAttention fromDictionary:dict] doubleValue];
            self.isPass = [self objectOrNilForKey:kZXY_ArtistDetailDataIsPass fromDictionary:dict];

    }
    
    return self;
    
}

- (NSDictionary *)dictionaryRepresentation
{
    NSMutableDictionary *mutableDict = [NSMutableDictionary dictionary];
    [mutableDict setValue:self.attention forKey:kZXY_ArtistDetailDataAttention];
    [mutableDict setValue:self.orderCount2 forKey:kZXY_ArtistDetailDataOrderCount2];
    [mutableDict setValue:self.realName forKey:kZXY_ArtistDetailDataRealName];
    [mutableDict setValue:self.headImage forKey:kZXY_ArtistDetailDataHeadImage];
    [mutableDict setValue:self.sex forKey:kZXY_ArtistDetailDataSex];
    [mutableDict setValue:self.longitude forKey:kZXY_ArtistDetailDataLongitude];
    [mutableDict setValue:self.nickName forKey:kZXY_ArtistDetailDataNickName];
    [mutableDict setValue:self.latitude forKey:kZXY_ArtistDetailDataLatitude];
    [mutableDict setValue:self.albumCount forKey:kZXY_ArtistDetailDataAlbumCount];
    [mutableDict setValue:self.byAttention forKey:kZXY_ArtistDetailDataByAttention];
    [mutableDict setValue:self.address forKey:kZXY_ArtistDetailDataAddress];
    [mutableDict setValue:self.orderCount forKey:kZXY_ArtistDetailDataOrderCount];
    [mutableDict setValue:self.role forKey:kZXY_ArtistDetailDataRole];
    [mutableDict setValue:self.tel forKey:kZXY_ArtistDetailDataTel];
    [mutableDict setValue:self.score forKey:kZXY_ArtistDetailDataScore];
    [mutableDict setValue:[NSNumber numberWithDouble:self.isAttention] forKey:kZXY_ArtistDetailDataIsAttention];
    [mutableDict setValue:self.isPass forKey:kZXY_ArtistDetailDataIsPass];

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

    self.attention = [aDecoder decodeObjectForKey:kZXY_ArtistDetailDataAttention];
    self.orderCount2 = [aDecoder decodeObjectForKey:kZXY_ArtistDetailDataOrderCount2];
    self.realName = [aDecoder decodeObjectForKey:kZXY_ArtistDetailDataRealName];
    self.headImage = [aDecoder decodeObjectForKey:kZXY_ArtistDetailDataHeadImage];
    self.sex = [aDecoder decodeObjectForKey:kZXY_ArtistDetailDataSex];
    self.longitude = [aDecoder decodeObjectForKey:kZXY_ArtistDetailDataLongitude];
    self.nickName = [aDecoder decodeObjectForKey:kZXY_ArtistDetailDataNickName];
    self.latitude = [aDecoder decodeObjectForKey:kZXY_ArtistDetailDataLatitude];
    self.albumCount = [aDecoder decodeObjectForKey:kZXY_ArtistDetailDataAlbumCount];
    self.byAttention = [aDecoder decodeObjectForKey:kZXY_ArtistDetailDataByAttention];
    self.address = [aDecoder decodeObjectForKey:kZXY_ArtistDetailDataAddress];
    self.orderCount = [aDecoder decodeObjectForKey:kZXY_ArtistDetailDataOrderCount];
    self.role = [aDecoder decodeObjectForKey:kZXY_ArtistDetailDataRole];
    self.tel = [aDecoder decodeObjectForKey:kZXY_ArtistDetailDataTel];
    self.score = [aDecoder decodeObjectForKey:kZXY_ArtistDetailDataScore];
    self.isAttention = [aDecoder decodeDoubleForKey:kZXY_ArtistDetailDataIsAttention];
    self.isPass = [aDecoder decodeObjectForKey:kZXY_ArtistDetailDataIsPass];
    return self;
}

- (void)encodeWithCoder:(NSCoder *)aCoder
{

    [aCoder encodeObject:_attention forKey:kZXY_ArtistDetailDataAttention];
    [aCoder encodeObject:_orderCount2 forKey:kZXY_ArtistDetailDataOrderCount2];
    [aCoder encodeObject:_realName forKey:kZXY_ArtistDetailDataRealName];
    [aCoder encodeObject:_headImage forKey:kZXY_ArtistDetailDataHeadImage];
    [aCoder encodeObject:_sex forKey:kZXY_ArtistDetailDataSex];
    [aCoder encodeObject:_longitude forKey:kZXY_ArtistDetailDataLongitude];
    [aCoder encodeObject:_nickName forKey:kZXY_ArtistDetailDataNickName];
    [aCoder encodeObject:_latitude forKey:kZXY_ArtistDetailDataLatitude];
    [aCoder encodeObject:_albumCount forKey:kZXY_ArtistDetailDataAlbumCount];
    [aCoder encodeObject:_byAttention forKey:kZXY_ArtistDetailDataByAttention];
    [aCoder encodeObject:_address forKey:kZXY_ArtistDetailDataAddress];
    [aCoder encodeObject:_orderCount forKey:kZXY_ArtistDetailDataOrderCount];
    [aCoder encodeObject:_role forKey:kZXY_ArtistDetailDataRole];
    [aCoder encodeObject:_tel forKey:kZXY_ArtistDetailDataTel];
    [aCoder encodeObject:_score forKey:kZXY_ArtistDetailDataScore];
    [aCoder encodeDouble:_isAttention forKey:kZXY_ArtistDetailDataIsAttention];
    [aCoder encodeObject:_isPass forKey:kZXY_ArtistDetailDataIsPass];
}

- (id)copyWithZone:(NSZone *)zone
{
    ZXY_ArtistDetailData *copy = [[ZXY_ArtistDetailData alloc] init];
    
    if (copy) {

        copy.attention = [self.attention copyWithZone:zone];
        copy.orderCount2 = [self.orderCount2 copyWithZone:zone];
        copy.realName = [self.realName copyWithZone:zone];
        copy.headImage = [self.headImage copyWithZone:zone];
        copy.sex = [self.sex copyWithZone:zone];
        copy.longitude = [self.longitude copyWithZone:zone];
        copy.nickName = [self.nickName copyWithZone:zone];
        copy.latitude = [self.latitude copyWithZone:zone];
        copy.albumCount = [self.albumCount copyWithZone:zone];
        copy.byAttention = [self.byAttention copyWithZone:zone];
        copy.address = [self.address copyWithZone:zone];
        copy.orderCount = [self.orderCount copyWithZone:zone];
        copy.role = [self.role copyWithZone:zone];
        copy.tel = [self.tel copyWithZone:zone];
        copy.score = [self.score copyWithZone:zone];
        copy.isAttention = self.isAttention;
        copy.isPass = [self.isPass copyWithZone:zone];
    }
    
    return copy;
}


@end
