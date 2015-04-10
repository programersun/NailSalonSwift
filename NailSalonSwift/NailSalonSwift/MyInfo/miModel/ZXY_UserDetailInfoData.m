//
//  ZXY_UserDetailInfoData.m
//
//  Created by   on 15/4/10
//  Copyright (c) 2015 __MyCompanyName__. All rights reserved.
//

#import "ZXY_UserDetailInfoData.h"


NSString *const kZXY_UserDetailInfoDataRealName = @"real_name";
NSString *const kZXY_UserDetailInfoDataHeadImage = @"head_image";
NSString *const kZXY_UserDetailInfoDataSex = @"sex";
NSString *const kZXY_UserDetailInfoDataLongitude = @"longitude";
NSString *const kZXY_UserDetailInfoDataNickName = @"nick_name";
NSString *const kZXY_UserDetailInfoDataLatitude = @"latitude";
NSString *const kZXY_UserDetailInfoDataByAttention = @"by_attention";
NSString *const kZXY_UserDetailInfoDataAddress = @"address";
NSString *const kZXY_UserDetailInfoDataUserName = @"user_name";
NSString *const kZXY_UserDetailInfoDataRole = @"role";
NSString *const kZXY_UserDetailInfoDataTel = @"tel";
NSString *const kZXY_UserDetailInfoDataAttention = @"attention";
NSString *const kZXY_UserDetailInfoDataScore = @"score";


@interface ZXY_UserDetailInfoData ()

- (id)objectOrNilForKey:(id)aKey fromDictionary:(NSDictionary *)dict;

@end

@implementation ZXY_UserDetailInfoData

@synthesize realName = _realName;
@synthesize headImage = _headImage;
@synthesize sex = _sex;
@synthesize longitude = _longitude;
@synthesize nickName = _nickName;
@synthesize latitude = _latitude;
@synthesize byAttention = _byAttention;
@synthesize address = _address;
@synthesize userName = _userName;
@synthesize role = _role;
@synthesize tel = _tel;
@synthesize attention = _attention;
@synthesize score = _score;


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
            self.realName = [self objectOrNilForKey:kZXY_UserDetailInfoDataRealName fromDictionary:dict];
            self.headImage = [self objectOrNilForKey:kZXY_UserDetailInfoDataHeadImage fromDictionary:dict];
            self.sex = [self objectOrNilForKey:kZXY_UserDetailInfoDataSex fromDictionary:dict];
            self.longitude = [self objectOrNilForKey:kZXY_UserDetailInfoDataLongitude fromDictionary:dict];
            self.nickName = [self objectOrNilForKey:kZXY_UserDetailInfoDataNickName fromDictionary:dict];
            self.latitude = [self objectOrNilForKey:kZXY_UserDetailInfoDataLatitude fromDictionary:dict];
            self.byAttention = [self objectOrNilForKey:kZXY_UserDetailInfoDataByAttention fromDictionary:dict];
            self.address = [self objectOrNilForKey:kZXY_UserDetailInfoDataAddress fromDictionary:dict];
            self.userName = [self objectOrNilForKey:kZXY_UserDetailInfoDataUserName fromDictionary:dict];
            self.role = [self objectOrNilForKey:kZXY_UserDetailInfoDataRole fromDictionary:dict];
            self.tel = [self objectOrNilForKey:kZXY_UserDetailInfoDataTel fromDictionary:dict];
            self.attention = [self objectOrNilForKey:kZXY_UserDetailInfoDataAttention fromDictionary:dict];
            self.score = [self objectOrNilForKey:kZXY_UserDetailInfoDataScore fromDictionary:dict];

    }
    
    return self;
    
}

- (NSDictionary *)dictionaryRepresentation
{
    NSMutableDictionary *mutableDict = [NSMutableDictionary dictionary];
    [mutableDict setValue:self.realName forKey:kZXY_UserDetailInfoDataRealName];
    [mutableDict setValue:self.headImage forKey:kZXY_UserDetailInfoDataHeadImage];
    [mutableDict setValue:self.sex forKey:kZXY_UserDetailInfoDataSex];
    [mutableDict setValue:self.longitude forKey:kZXY_UserDetailInfoDataLongitude];
    [mutableDict setValue:self.nickName forKey:kZXY_UserDetailInfoDataNickName];
    [mutableDict setValue:self.latitude forKey:kZXY_UserDetailInfoDataLatitude];
    [mutableDict setValue:self.byAttention forKey:kZXY_UserDetailInfoDataByAttention];
    [mutableDict setValue:self.address forKey:kZXY_UserDetailInfoDataAddress];
    [mutableDict setValue:self.userName forKey:kZXY_UserDetailInfoDataUserName];
    [mutableDict setValue:self.role forKey:kZXY_UserDetailInfoDataRole];
    [mutableDict setValue:self.tel forKey:kZXY_UserDetailInfoDataTel];
    [mutableDict setValue:self.attention forKey:kZXY_UserDetailInfoDataAttention];
    [mutableDict setValue:self.score forKey:kZXY_UserDetailInfoDataScore];

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

    self.realName = [aDecoder decodeObjectForKey:kZXY_UserDetailInfoDataRealName];
    self.headImage = [aDecoder decodeObjectForKey:kZXY_UserDetailInfoDataHeadImage];
    self.sex = [aDecoder decodeObjectForKey:kZXY_UserDetailInfoDataSex];
    self.longitude = [aDecoder decodeObjectForKey:kZXY_UserDetailInfoDataLongitude];
    self.nickName = [aDecoder decodeObjectForKey:kZXY_UserDetailInfoDataNickName];
    self.latitude = [aDecoder decodeObjectForKey:kZXY_UserDetailInfoDataLatitude];
    self.byAttention = [aDecoder decodeObjectForKey:kZXY_UserDetailInfoDataByAttention];
    self.address = [aDecoder decodeObjectForKey:kZXY_UserDetailInfoDataAddress];
    self.userName = [aDecoder decodeObjectForKey:kZXY_UserDetailInfoDataUserName];
    self.role = [aDecoder decodeObjectForKey:kZXY_UserDetailInfoDataRole];
    self.tel = [aDecoder decodeObjectForKey:kZXY_UserDetailInfoDataTel];
    self.attention = [aDecoder decodeObjectForKey:kZXY_UserDetailInfoDataAttention];
    self.score = [aDecoder decodeObjectForKey:kZXY_UserDetailInfoDataScore];
    return self;
}

- (void)encodeWithCoder:(NSCoder *)aCoder
{

    [aCoder encodeObject:_realName forKey:kZXY_UserDetailInfoDataRealName];
    [aCoder encodeObject:_headImage forKey:kZXY_UserDetailInfoDataHeadImage];
    [aCoder encodeObject:_sex forKey:kZXY_UserDetailInfoDataSex];
    [aCoder encodeObject:_longitude forKey:kZXY_UserDetailInfoDataLongitude];
    [aCoder encodeObject:_nickName forKey:kZXY_UserDetailInfoDataNickName];
    [aCoder encodeObject:_latitude forKey:kZXY_UserDetailInfoDataLatitude];
    [aCoder encodeObject:_byAttention forKey:kZXY_UserDetailInfoDataByAttention];
    [aCoder encodeObject:_address forKey:kZXY_UserDetailInfoDataAddress];
    [aCoder encodeObject:_userName forKey:kZXY_UserDetailInfoDataUserName];
    [aCoder encodeObject:_role forKey:kZXY_UserDetailInfoDataRole];
    [aCoder encodeObject:_tel forKey:kZXY_UserDetailInfoDataTel];
    [aCoder encodeObject:_attention forKey:kZXY_UserDetailInfoDataAttention];
    [aCoder encodeObject:_score forKey:kZXY_UserDetailInfoDataScore];
}

- (id)copyWithZone:(NSZone *)zone
{
    ZXY_UserDetailInfoData *copy = [[ZXY_UserDetailInfoData alloc] init];
    
    if (copy) {

        copy.realName = [self.realName copyWithZone:zone];
        copy.headImage = [self.headImage copyWithZone:zone];
        copy.sex = [self.sex copyWithZone:zone];
        copy.longitude = [self.longitude copyWithZone:zone];
        copy.nickName = [self.nickName copyWithZone:zone];
        copy.latitude = [self.latitude copyWithZone:zone];
        copy.byAttention = [self.byAttention copyWithZone:zone];
        copy.address = [self.address copyWithZone:zone];
        copy.userName = [self.userName copyWithZone:zone];
        copy.role = [self.role copyWithZone:zone];
        copy.tel = [self.tel copyWithZone:zone];
        copy.attention = [self.attention copyWithZone:zone];
        copy.score = [self.score copyWithZone:zone];
    }
    
    return copy;
}


@end
