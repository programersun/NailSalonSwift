//
//  SR_OrderDetailCustom.m
//
//  Created by sun  on 15/5/5
//  Copyright (c) 2015 __MyCompanyName__. All rights reserved.
//

#import "SR_OrderDetailCustom.h"


NSString *const kSR_OrderDetailCustomNickName = @"nick_name";
NSString *const kSR_OrderDetailCustomScore = @"score";
NSString *const kSR_OrderDetailCustomUserId = @"user_id";
NSString *const kSR_OrderDetailCustomHeadImage = @"head_image";
NSString *const kSR_OrderDetailCustomRole = @"role";
NSString *const kSR_OrderDetailCustomScore2 = @"score2";


@interface SR_OrderDetailCustom ()

- (id)objectOrNilForKey:(id)aKey fromDictionary:(NSDictionary *)dict;

@end

@implementation SR_OrderDetailCustom

@synthesize nickName = _nickName;
@synthesize score = _score;
@synthesize userId = _userId;
@synthesize headImage = _headImage;
@synthesize role = _role;
@synthesize score2 = _score2;


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
            self.nickName = [self objectOrNilForKey:kSR_OrderDetailCustomNickName fromDictionary:dict];
            self.score = [self objectOrNilForKey:kSR_OrderDetailCustomScore fromDictionary:dict];
            self.userId = [self objectOrNilForKey:kSR_OrderDetailCustomUserId fromDictionary:dict];
            self.headImage = [self objectOrNilForKey:kSR_OrderDetailCustomHeadImage fromDictionary:dict];
            self.role = [self objectOrNilForKey:kSR_OrderDetailCustomRole fromDictionary:dict];
            self.score2 = [self objectOrNilForKey:kSR_OrderDetailCustomScore2 fromDictionary:dict];

    }
    
    return self;
    
}

- (NSDictionary *)dictionaryRepresentation
{
    NSMutableDictionary *mutableDict = [NSMutableDictionary dictionary];
    [mutableDict setValue:self.nickName forKey:kSR_OrderDetailCustomNickName];
    [mutableDict setValue:self.score forKey:kSR_OrderDetailCustomScore];
    [mutableDict setValue:self.userId forKey:kSR_OrderDetailCustomUserId];
    [mutableDict setValue:self.headImage forKey:kSR_OrderDetailCustomHeadImage];
    [mutableDict setValue:self.role forKey:kSR_OrderDetailCustomRole];
    [mutableDict setValue:self.score2 forKey:kSR_OrderDetailCustomScore2];

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

    self.nickName = [aDecoder decodeObjectForKey:kSR_OrderDetailCustomNickName];
    self.score = [aDecoder decodeObjectForKey:kSR_OrderDetailCustomScore];
    self.userId = [aDecoder decodeObjectForKey:kSR_OrderDetailCustomUserId];
    self.headImage = [aDecoder decodeObjectForKey:kSR_OrderDetailCustomHeadImage];
    self.role = [aDecoder decodeObjectForKey:kSR_OrderDetailCustomRole];
    self.score2 = [aDecoder decodeObjectForKey:kSR_OrderDetailCustomScore2];
    return self;
}

- (void)encodeWithCoder:(NSCoder *)aCoder
{

    [aCoder encodeObject:_nickName forKey:kSR_OrderDetailCustomNickName];
    [aCoder encodeObject:_score forKey:kSR_OrderDetailCustomScore];
    [aCoder encodeObject:_userId forKey:kSR_OrderDetailCustomUserId];
    [aCoder encodeObject:_headImage forKey:kSR_OrderDetailCustomHeadImage];
    [aCoder encodeObject:_role forKey:kSR_OrderDetailCustomRole];
    [aCoder encodeObject:_score2 forKey:kSR_OrderDetailCustomScore2];
}

- (id)copyWithZone:(NSZone *)zone
{
    SR_OrderDetailCustom *copy = [[SR_OrderDetailCustom alloc] init];
    
    if (copy) {

        copy.nickName = [self.nickName copyWithZone:zone];
        copy.score = [self.score copyWithZone:zone];
        copy.userId = [self.userId copyWithZone:zone];
        copy.headImage = [self.headImage copyWithZone:zone];
        copy.role = [self.role copyWithZone:zone];
        copy.score2 = [self.score2 copyWithZone:zone];
    }
    
    return copy;
}


@end
