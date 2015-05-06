//
//  SR_OrderListData.m
//
//  Created by sun  on 15/5/6
//  Copyright (c) 2015 __MyCompanyName__. All rights reserved.
//

#import "SR_OrderListData.h"


NSString *const kSR_OrderListDataNickName = @"nick_name";
NSString *const kSR_OrderListDataOrderId = @"order_id";
NSString *const kSR_OrderListDataUid = @"uid";
NSString *const kSR_OrderListDataHeadImage = @"head_image";
NSString *const kSR_OrderListDataDetailAddr = @"detail_addr";
NSString *const kSR_OrderListDataPreStatus = @"pre_status";
NSString *const kSR_OrderListDataRealName = @"real_name";
NSString *const kSR_OrderListDataOrderStatus = @"order_status";
NSString *const kSR_OrderListDataAlbumDesc = @"album_desc";
NSString *const kSR_OrderListDataAddTime = @"add_time";


@interface SR_OrderListData ()

- (id)objectOrNilForKey:(id)aKey fromDictionary:(NSDictionary *)dict;

@end

@implementation SR_OrderListData

@synthesize nickName = _nickName;
@synthesize orderId = _orderId;
@synthesize uid = _uid;
@synthesize headImage = _headImage;
@synthesize detailAddr = _detailAddr;
@synthesize preStatus = _preStatus;
@synthesize realName = _realName;
@synthesize orderStatus = _orderStatus;
@synthesize albumDesc = _albumDesc;
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
            self.nickName = [self objectOrNilForKey:kSR_OrderListDataNickName fromDictionary:dict];
            self.orderId = [self objectOrNilForKey:kSR_OrderListDataOrderId fromDictionary:dict];
            self.uid = [self objectOrNilForKey:kSR_OrderListDataUid fromDictionary:dict];
            self.headImage = [self objectOrNilForKey:kSR_OrderListDataHeadImage fromDictionary:dict];
            self.detailAddr = [self objectOrNilForKey:kSR_OrderListDataDetailAddr fromDictionary:dict];
            self.preStatus = [self objectOrNilForKey:kSR_OrderListDataPreStatus fromDictionary:dict];
            self.realName = [self objectOrNilForKey:kSR_OrderListDataRealName fromDictionary:dict];
            self.orderStatus = [self objectOrNilForKey:kSR_OrderListDataOrderStatus fromDictionary:dict];
            self.albumDesc = [self objectOrNilForKey:kSR_OrderListDataAlbumDesc fromDictionary:dict];
            self.addTime = [self objectOrNilForKey:kSR_OrderListDataAddTime fromDictionary:dict];

    }
    
    return self;
    
}

- (NSDictionary *)dictionaryRepresentation
{
    NSMutableDictionary *mutableDict = [NSMutableDictionary dictionary];
    [mutableDict setValue:self.nickName forKey:kSR_OrderListDataNickName];
    [mutableDict setValue:self.orderId forKey:kSR_OrderListDataOrderId];
    [mutableDict setValue:self.uid forKey:kSR_OrderListDataUid];
    [mutableDict setValue:self.headImage forKey:kSR_OrderListDataHeadImage];
    [mutableDict setValue:self.detailAddr forKey:kSR_OrderListDataDetailAddr];
    [mutableDict setValue:self.preStatus forKey:kSR_OrderListDataPreStatus];
    [mutableDict setValue:self.realName forKey:kSR_OrderListDataRealName];
    [mutableDict setValue:self.orderStatus forKey:kSR_OrderListDataOrderStatus];
    [mutableDict setValue:self.albumDesc forKey:kSR_OrderListDataAlbumDesc];
    [mutableDict setValue:self.addTime forKey:kSR_OrderListDataAddTime];

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

    self.nickName = [aDecoder decodeObjectForKey:kSR_OrderListDataNickName];
    self.orderId = [aDecoder decodeObjectForKey:kSR_OrderListDataOrderId];
    self.uid = [aDecoder decodeObjectForKey:kSR_OrderListDataUid];
    self.headImage = [aDecoder decodeObjectForKey:kSR_OrderListDataHeadImage];
    self.detailAddr = [aDecoder decodeObjectForKey:kSR_OrderListDataDetailAddr];
    self.preStatus = [aDecoder decodeObjectForKey:kSR_OrderListDataPreStatus];
    self.realName = [aDecoder decodeObjectForKey:kSR_OrderListDataRealName];
    self.orderStatus = [aDecoder decodeObjectForKey:kSR_OrderListDataOrderStatus];
    self.albumDesc = [aDecoder decodeObjectForKey:kSR_OrderListDataAlbumDesc];
    self.addTime = [aDecoder decodeObjectForKey:kSR_OrderListDataAddTime];
    return self;
}

- (void)encodeWithCoder:(NSCoder *)aCoder
{

    [aCoder encodeObject:_nickName forKey:kSR_OrderListDataNickName];
    [aCoder encodeObject:_orderId forKey:kSR_OrderListDataOrderId];
    [aCoder encodeObject:_uid forKey:kSR_OrderListDataUid];
    [aCoder encodeObject:_headImage forKey:kSR_OrderListDataHeadImage];
    [aCoder encodeObject:_detailAddr forKey:kSR_OrderListDataDetailAddr];
    [aCoder encodeObject:_preStatus forKey:kSR_OrderListDataPreStatus];
    [aCoder encodeObject:_realName forKey:kSR_OrderListDataRealName];
    [aCoder encodeObject:_orderStatus forKey:kSR_OrderListDataOrderStatus];
    [aCoder encodeObject:_albumDesc forKey:kSR_OrderListDataAlbumDesc];
    [aCoder encodeObject:_addTime forKey:kSR_OrderListDataAddTime];
}

- (id)copyWithZone:(NSZone *)zone
{
    SR_OrderListData *copy = [[SR_OrderListData alloc] init];
    
    if (copy) {

        copy.nickName = [self.nickName copyWithZone:zone];
        copy.orderId = [self.orderId copyWithZone:zone];
        copy.uid = [self.uid copyWithZone:zone];
        copy.headImage = [self.headImage copyWithZone:zone];
        copy.detailAddr = [self.detailAddr copyWithZone:zone];
        copy.preStatus = [self.preStatus copyWithZone:zone];
        copy.realName = [self.realName copyWithZone:zone];
        copy.orderStatus = [self.orderStatus copyWithZone:zone];
        copy.albumDesc = [self.albumDesc copyWithZone:zone];
        copy.addTime = [self.addTime copyWithZone:zone];
    }
    
    return copy;
}


@end
