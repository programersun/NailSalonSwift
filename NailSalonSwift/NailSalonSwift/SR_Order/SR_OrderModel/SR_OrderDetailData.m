//
//  SR_OrderDetailData.m
//
//  Created by sun  on 15/5/8
//  Copyright (c) 2015 __MyCompanyName__. All rights reserved.
//

#import "SR_OrderDetailData.h"
#import "SR_OrderDetailCustom.h"
#import "SR_OrderDetailUser.h"


NSString *const kSR_OrderDetailDataAlbumId = @"album_id";
NSString *const kSR_OrderDetailDataRealName = @"real_name";
NSString *const kSR_OrderDetailDataCommId = @"comm_id";
NSString *const kSR_OrderDetailDataOrderAddr = @"order_addr";
NSString *const kSR_OrderDetailDataSex = @"sex";
NSString *const kSR_OrderDetailDataAlbumDesc = @"album_desc";
NSString *const kSR_OrderDetailDataCustomId = @"custom_id";
NSString *const kSR_OrderDetailDataIsDel = @"isDel";
NSString *const kSR_OrderDetailDataOrderId = @"order_id";
NSString *const kSR_OrderDetailDataUserId = @"user_id";
NSString *const kSR_OrderDetailDataDetailAddr = @"detail_addr";
NSString *const kSR_OrderDetailDataOrderTime = @"order_time";
NSString *const kSR_OrderDetailDataOrderStatus = @"order_status";
NSString *const kSR_OrderDetailDataPreStatus = @"pre_status";
NSString *const kSR_OrderDetailDataTel = @"tel";
NSString *const kSR_OrderDetailDataCustom = @"custom";
NSString *const kSR_OrderDetailDataAddTime = @"add_time";
NSString *const kSR_OrderDetailDataCommTouserId = @"comm_touser_id";
NSString *const kSR_OrderDetailDataUser = @"user";


@interface SR_OrderDetailData ()

- (id)objectOrNilForKey:(id)aKey fromDictionary:(NSDictionary *)dict;

@end

@implementation SR_OrderDetailData

@synthesize albumId = _albumId;
@synthesize realName = _realName;
@synthesize commId = _commId;
@synthesize orderAddr = _orderAddr;
@synthesize sex = _sex;
@synthesize albumDesc = _albumDesc;
@synthesize customId = _customId;
@synthesize isDel = _isDel;
@synthesize orderId = _orderId;
@synthesize userId = _userId;
@synthesize detailAddr = _detailAddr;
@synthesize orderTime = _orderTime;
@synthesize orderStatus = _orderStatus;
@synthesize preStatus = _preStatus;
@synthesize tel = _tel;
@synthesize custom = _custom;
@synthesize addTime = _addTime;
@synthesize commTouserId = _commTouserId;
@synthesize user = _user;


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
            self.albumId = [self objectOrNilForKey:kSR_OrderDetailDataAlbumId fromDictionary:dict];
            self.realName = [self objectOrNilForKey:kSR_OrderDetailDataRealName fromDictionary:dict];
            self.commId = [self objectOrNilForKey:kSR_OrderDetailDataCommId fromDictionary:dict];
            self.orderAddr = [self objectOrNilForKey:kSR_OrderDetailDataOrderAddr fromDictionary:dict];
            self.sex = [self objectOrNilForKey:kSR_OrderDetailDataSex fromDictionary:dict];
            self.albumDesc = [self objectOrNilForKey:kSR_OrderDetailDataAlbumDesc fromDictionary:dict];
            self.customId = [self objectOrNilForKey:kSR_OrderDetailDataCustomId fromDictionary:dict];
            self.isDel = [self objectOrNilForKey:kSR_OrderDetailDataIsDel fromDictionary:dict];
            self.orderId = [self objectOrNilForKey:kSR_OrderDetailDataOrderId fromDictionary:dict];
            self.userId = [self objectOrNilForKey:kSR_OrderDetailDataUserId fromDictionary:dict];
            self.detailAddr = [self objectOrNilForKey:kSR_OrderDetailDataDetailAddr fromDictionary:dict];
            self.orderTime = [self objectOrNilForKey:kSR_OrderDetailDataOrderTime fromDictionary:dict];
            self.orderStatus = [self objectOrNilForKey:kSR_OrderDetailDataOrderStatus fromDictionary:dict];
            self.preStatus = [self objectOrNilForKey:kSR_OrderDetailDataPreStatus fromDictionary:dict];
            self.tel = [self objectOrNilForKey:kSR_OrderDetailDataTel fromDictionary:dict];
            self.custom = [SR_OrderDetailCustom modelObjectWithDictionary:[dict objectForKey:kSR_OrderDetailDataCustom]];
            self.addTime = [self objectOrNilForKey:kSR_OrderDetailDataAddTime fromDictionary:dict];
            self.commTouserId = [self objectOrNilForKey:kSR_OrderDetailDataCommTouserId fromDictionary:dict];
            self.user = [SR_OrderDetailUser modelObjectWithDictionary:[dict objectForKey:kSR_OrderDetailDataUser]];

    }
    
    return self;
    
}

- (NSDictionary *)dictionaryRepresentation
{
    NSMutableDictionary *mutableDict = [NSMutableDictionary dictionary];
    [mutableDict setValue:self.albumId forKey:kSR_OrderDetailDataAlbumId];
    [mutableDict setValue:self.realName forKey:kSR_OrderDetailDataRealName];
    [mutableDict setValue:self.commId forKey:kSR_OrderDetailDataCommId];
    [mutableDict setValue:self.orderAddr forKey:kSR_OrderDetailDataOrderAddr];
    [mutableDict setValue:self.sex forKey:kSR_OrderDetailDataSex];
    [mutableDict setValue:self.albumDesc forKey:kSR_OrderDetailDataAlbumDesc];
    [mutableDict setValue:self.customId forKey:kSR_OrderDetailDataCustomId];
    [mutableDict setValue:self.isDel forKey:kSR_OrderDetailDataIsDel];
    [mutableDict setValue:self.orderId forKey:kSR_OrderDetailDataOrderId];
    [mutableDict setValue:self.userId forKey:kSR_OrderDetailDataUserId];
    [mutableDict setValue:self.detailAddr forKey:kSR_OrderDetailDataDetailAddr];
    [mutableDict setValue:self.orderTime forKey:kSR_OrderDetailDataOrderTime];
    [mutableDict setValue:self.orderStatus forKey:kSR_OrderDetailDataOrderStatus];
    [mutableDict setValue:self.preStatus forKey:kSR_OrderDetailDataPreStatus];
    [mutableDict setValue:self.tel forKey:kSR_OrderDetailDataTel];
    [mutableDict setValue:[self.custom dictionaryRepresentation] forKey:kSR_OrderDetailDataCustom];
    [mutableDict setValue:self.addTime forKey:kSR_OrderDetailDataAddTime];
    [mutableDict setValue:self.commTouserId forKey:kSR_OrderDetailDataCommTouserId];
    [mutableDict setValue:[self.user dictionaryRepresentation] forKey:kSR_OrderDetailDataUser];

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

    self.albumId = [aDecoder decodeObjectForKey:kSR_OrderDetailDataAlbumId];
    self.realName = [aDecoder decodeObjectForKey:kSR_OrderDetailDataRealName];
    self.commId = [aDecoder decodeObjectForKey:kSR_OrderDetailDataCommId];
    self.orderAddr = [aDecoder decodeObjectForKey:kSR_OrderDetailDataOrderAddr];
    self.sex = [aDecoder decodeObjectForKey:kSR_OrderDetailDataSex];
    self.albumDesc = [aDecoder decodeObjectForKey:kSR_OrderDetailDataAlbumDesc];
    self.customId = [aDecoder decodeObjectForKey:kSR_OrderDetailDataCustomId];
    self.isDel = [aDecoder decodeObjectForKey:kSR_OrderDetailDataIsDel];
    self.orderId = [aDecoder decodeObjectForKey:kSR_OrderDetailDataOrderId];
    self.userId = [aDecoder decodeObjectForKey:kSR_OrderDetailDataUserId];
    self.detailAddr = [aDecoder decodeObjectForKey:kSR_OrderDetailDataDetailAddr];
    self.orderTime = [aDecoder decodeObjectForKey:kSR_OrderDetailDataOrderTime];
    self.orderStatus = [aDecoder decodeObjectForKey:kSR_OrderDetailDataOrderStatus];
    self.preStatus = [aDecoder decodeObjectForKey:kSR_OrderDetailDataPreStatus];
    self.tel = [aDecoder decodeObjectForKey:kSR_OrderDetailDataTel];
    self.custom = [aDecoder decodeObjectForKey:kSR_OrderDetailDataCustom];
    self.addTime = [aDecoder decodeObjectForKey:kSR_OrderDetailDataAddTime];
    self.commTouserId = [aDecoder decodeObjectForKey:kSR_OrderDetailDataCommTouserId];
    self.user = [aDecoder decodeObjectForKey:kSR_OrderDetailDataUser];
    return self;
}

- (void)encodeWithCoder:(NSCoder *)aCoder
{

    [aCoder encodeObject:_albumId forKey:kSR_OrderDetailDataAlbumId];
    [aCoder encodeObject:_realName forKey:kSR_OrderDetailDataRealName];
    [aCoder encodeObject:_commId forKey:kSR_OrderDetailDataCommId];
    [aCoder encodeObject:_orderAddr forKey:kSR_OrderDetailDataOrderAddr];
    [aCoder encodeObject:_sex forKey:kSR_OrderDetailDataSex];
    [aCoder encodeObject:_albumDesc forKey:kSR_OrderDetailDataAlbumDesc];
    [aCoder encodeObject:_customId forKey:kSR_OrderDetailDataCustomId];
    [aCoder encodeObject:_isDel forKey:kSR_OrderDetailDataIsDel];
    [aCoder encodeObject:_orderId forKey:kSR_OrderDetailDataOrderId];
    [aCoder encodeObject:_userId forKey:kSR_OrderDetailDataUserId];
    [aCoder encodeObject:_detailAddr forKey:kSR_OrderDetailDataDetailAddr];
    [aCoder encodeObject:_orderTime forKey:kSR_OrderDetailDataOrderTime];
    [aCoder encodeObject:_orderStatus forKey:kSR_OrderDetailDataOrderStatus];
    [aCoder encodeObject:_preStatus forKey:kSR_OrderDetailDataPreStatus];
    [aCoder encodeObject:_tel forKey:kSR_OrderDetailDataTel];
    [aCoder encodeObject:_custom forKey:kSR_OrderDetailDataCustom];
    [aCoder encodeObject:_addTime forKey:kSR_OrderDetailDataAddTime];
    [aCoder encodeObject:_commTouserId forKey:kSR_OrderDetailDataCommTouserId];
    [aCoder encodeObject:_user forKey:kSR_OrderDetailDataUser];
}

- (id)copyWithZone:(NSZone *)zone
{
    SR_OrderDetailData *copy = [[SR_OrderDetailData alloc] init];
    
    if (copy) {

        copy.albumId = [self.albumId copyWithZone:zone];
        copy.realName = [self.realName copyWithZone:zone];
        copy.commId = [self.commId copyWithZone:zone];
        copy.orderAddr = [self.orderAddr copyWithZone:zone];
        copy.sex = [self.sex copyWithZone:zone];
        copy.albumDesc = [self.albumDesc copyWithZone:zone];
        copy.customId = [self.customId copyWithZone:zone];
        copy.isDel = [self.isDel copyWithZone:zone];
        copy.orderId = [self.orderId copyWithZone:zone];
        copy.userId = [self.userId copyWithZone:zone];
        copy.detailAddr = [self.detailAddr copyWithZone:zone];
        copy.orderTime = [self.orderTime copyWithZone:zone];
        copy.orderStatus = [self.orderStatus copyWithZone:zone];
        copy.preStatus = [self.preStatus copyWithZone:zone];
        copy.tel = [self.tel copyWithZone:zone];
        copy.custom = [self.custom copyWithZone:zone];
        copy.addTime = [self.addTime copyWithZone:zone];
        copy.commTouserId = [self.commTouserId copyWithZone:zone];
        copy.user = [self.user copyWithZone:zone];
    }
    
    return copy;
}


@end
