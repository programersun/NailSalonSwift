//
//  ZXY_NotiForAttensionData.m
//
//  Created by   on 15/5/9
//  Copyright (c) 2015 __MyCompanyName__. All rights reserved.
//

#import "ZXY_NotiForAttensionData.h"


NSString *const kZXY_NotiForAttensionDataId = @"id";
NSString *const kZXY_NotiForAttensionDataNick = @"nick";
NSString *const kZXY_NotiForAttensionDataSendTime = @"send_time";
NSString *const kZXY_NotiForAttensionDataRole = @"role";
NSString *const kZXY_NotiForAttensionDataHead = @"head";


@interface ZXY_NotiForAttensionData ()

- (id)objectOrNilForKey:(id)aKey fromDictionary:(NSDictionary *)dict;

@end

@implementation ZXY_NotiForAttensionData

@synthesize dataIdentifier = _dataIdentifier;
@synthesize nick = _nick;
@synthesize sendTime = _sendTime;
@synthesize role = _role;
@synthesize head = _head;


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
            self.dataIdentifier = [self objectOrNilForKey:kZXY_NotiForAttensionDataId fromDictionary:dict];
            self.nick = [self objectOrNilForKey:kZXY_NotiForAttensionDataNick fromDictionary:dict];
            self.sendTime = [[self objectOrNilForKey:kZXY_NotiForAttensionDataSendTime fromDictionary:dict] doubleValue];
            self.role = [self objectOrNilForKey:kZXY_NotiForAttensionDataRole fromDictionary:dict];
            self.head = [self objectOrNilForKey:kZXY_NotiForAttensionDataHead fromDictionary:dict];

    }
    
    return self;
    
}

- (NSDictionary *)dictionaryRepresentation
{
    NSMutableDictionary *mutableDict = [NSMutableDictionary dictionary];
    [mutableDict setValue:self.dataIdentifier forKey:kZXY_NotiForAttensionDataId];
    [mutableDict setValue:self.nick forKey:kZXY_NotiForAttensionDataNick];
    [mutableDict setValue:[NSNumber numberWithDouble:self.sendTime] forKey:kZXY_NotiForAttensionDataSendTime];
    [mutableDict setValue:self.role forKey:kZXY_NotiForAttensionDataRole];
    [mutableDict setValue:self.head forKey:kZXY_NotiForAttensionDataHead];

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

    self.dataIdentifier = [aDecoder decodeObjectForKey:kZXY_NotiForAttensionDataId];
    self.nick = [aDecoder decodeObjectForKey:kZXY_NotiForAttensionDataNick];
    self.sendTime = [aDecoder decodeDoubleForKey:kZXY_NotiForAttensionDataSendTime];
    self.role = [aDecoder decodeObjectForKey:kZXY_NotiForAttensionDataRole];
    self.head = [aDecoder decodeObjectForKey:kZXY_NotiForAttensionDataHead];
    return self;
}

- (void)encodeWithCoder:(NSCoder *)aCoder
{

    [aCoder encodeObject:_dataIdentifier forKey:kZXY_NotiForAttensionDataId];
    [aCoder encodeObject:_nick forKey:kZXY_NotiForAttensionDataNick];
    [aCoder encodeDouble:_sendTime forKey:kZXY_NotiForAttensionDataSendTime];
    [aCoder encodeObject:_role forKey:kZXY_NotiForAttensionDataRole];
    [aCoder encodeObject:_head forKey:kZXY_NotiForAttensionDataHead];
}

- (id)copyWithZone:(NSZone *)zone
{
    ZXY_NotiForAttensionData *copy = [[ZXY_NotiForAttensionData alloc] init];
    
    if (copy) {

        copy.dataIdentifier = [self.dataIdentifier copyWithZone:zone];
        copy.nick = [self.nick copyWithZone:zone];
        copy.sendTime = self.sendTime;
        copy.role = [self.role copyWithZone:zone];
        copy.head = [self.head copyWithZone:zone];
    }
    
    return copy;
}


@end
