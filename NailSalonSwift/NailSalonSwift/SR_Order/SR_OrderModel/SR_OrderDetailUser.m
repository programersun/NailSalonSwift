//
//  SR_OrderDetailUser.m
//
//  Created by sun  on 15/5/5
//  Copyright (c) 2015 __MyCompanyName__. All rights reserved.
//

#import "SR_OrderDetailUser.h"


NSString *const kSR_OrderDetailUserNickName = @"nick_name";
NSString *const kSR_OrderDetailUserUserName = @"user_name";
NSString *const kSR_OrderDetailUserScore = @"score";
NSString *const kSR_OrderDetailUserUserId = @"user_id";
NSString *const kSR_OrderDetailUserHeadImage = @"head_image";
NSString *const kSR_OrderDetailUserTel = @"tel";


@interface SR_OrderDetailUser ()

- (id)objectOrNilForKey:(id)aKey fromDictionary:(NSDictionary *)dict;

@end

@implementation SR_OrderDetailUser

@synthesize nickName = _nickName;
@synthesize userName = _userName;
@synthesize score = _score;
@synthesize userId = _userId;
@synthesize headImage = _headImage;
@synthesize tel = _tel;


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
            self.nickName = [self objectOrNilForKey:kSR_OrderDetailUserNickName fromDictionary:dict];
            self.userName = [self objectOrNilForKey:kSR_OrderDetailUserUserName fromDictionary:dict];
            self.score = [self objectOrNilForKey:kSR_OrderDetailUserScore fromDictionary:dict];
            self.userId = [self objectOrNilForKey:kSR_OrderDetailUserUserId fromDictionary:dict];
            self.headImage = [self objectOrNilForKey:kSR_OrderDetailUserHeadImage fromDictionary:dict];
            self.tel = [self objectOrNilForKey:kSR_OrderDetailUserTel fromDictionary:dict];

    }
    
    return self;
    
}

- (NSDictionary *)dictionaryRepresentation
{
    NSMutableDictionary *mutableDict = [NSMutableDictionary dictionary];
    [mutableDict setValue:self.nickName forKey:kSR_OrderDetailUserNickName];
    [mutableDict setValue:self.userName forKey:kSR_OrderDetailUserUserName];
    [mutableDict setValue:self.score forKey:kSR_OrderDetailUserScore];
    [mutableDict setValue:self.userId forKey:kSR_OrderDetailUserUserId];
    [mutableDict setValue:self.headImage forKey:kSR_OrderDetailUserHeadImage];
    [mutableDict setValue:self.tel forKey:kSR_OrderDetailUserTel];

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

    self.nickName = [aDecoder decodeObjectForKey:kSR_OrderDetailUserNickName];
    self.userName = [aDecoder decodeObjectForKey:kSR_OrderDetailUserUserName];
    self.score = [aDecoder decodeObjectForKey:kSR_OrderDetailUserScore];
    self.userId = [aDecoder decodeObjectForKey:kSR_OrderDetailUserUserId];
    self.headImage = [aDecoder decodeObjectForKey:kSR_OrderDetailUserHeadImage];
    self.tel = [aDecoder decodeObjectForKey:kSR_OrderDetailUserTel];
    return self;
}

- (void)encodeWithCoder:(NSCoder *)aCoder
{

    [aCoder encodeObject:_nickName forKey:kSR_OrderDetailUserNickName];
    [aCoder encodeObject:_userName forKey:kSR_OrderDetailUserUserName];
    [aCoder encodeObject:_score forKey:kSR_OrderDetailUserScore];
    [aCoder encodeObject:_userId forKey:kSR_OrderDetailUserUserId];
    [aCoder encodeObject:_headImage forKey:kSR_OrderDetailUserHeadImage];
    [aCoder encodeObject:_tel forKey:kSR_OrderDetailUserTel];
}

- (id)copyWithZone:(NSZone *)zone
{
    SR_OrderDetailUser *copy = [[SR_OrderDetailUser alloc] init];
    
    if (copy) {

        copy.nickName = [self.nickName copyWithZone:zone];
        copy.userName = [self.userName copyWithZone:zone];
        copy.score = [self.score copyWithZone:zone];
        copy.userId = [self.userId copyWithZone:zone];
        copy.headImage = [self.headImage copyWithZone:zone];
        copy.tel = [self.tel copyWithZone:zone];
    }
    
    return copy;
}


@end
