//
//  ZXY_UserData.m
//
//  Created by   on 15/4/8
//  Copyright (c) 2015 __MyCompanyName__. All rights reserved.
//

#import "ZXY_UserData.h"


NSString *const kZXY_UserDataUserId = @"user_id";
NSString *const kZXY_UserDataNickName = @"nick_name";
NSString *const kZXY_UserDataRole = @"role";


@interface ZXY_UserData ()

- (id)objectOrNilForKey:(id)aKey fromDictionary:(NSDictionary *)dict;

@end

@implementation ZXY_UserData

@synthesize userId = _userId;
@synthesize nickName = _nickName;
@synthesize role = _role;


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
            self.userId = [self objectOrNilForKey:kZXY_UserDataUserId fromDictionary:dict];
            self.nickName = [self objectOrNilForKey:kZXY_UserDataNickName fromDictionary:dict];
            self.role = [self objectOrNilForKey:kZXY_UserDataRole fromDictionary:dict];

    }
    
    return self;
    
}

- (NSDictionary *)dictionaryRepresentation
{
    NSMutableDictionary *mutableDict = [NSMutableDictionary dictionary];
    [mutableDict setValue:self.userId forKey:kZXY_UserDataUserId];
    [mutableDict setValue:self.nickName forKey:kZXY_UserDataNickName];
    [mutableDict setValue:self.role forKey:kZXY_UserDataRole];

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

    self.userId = [aDecoder decodeObjectForKey:kZXY_UserDataUserId];
    self.nickName = [aDecoder decodeObjectForKey:kZXY_UserDataNickName];
    self.role = [aDecoder decodeObjectForKey:kZXY_UserDataRole];
    return self;
}

- (void)encodeWithCoder:(NSCoder *)aCoder
{

    [aCoder encodeObject:_userId forKey:kZXY_UserDataUserId];
    [aCoder encodeObject:_nickName forKey:kZXY_UserDataNickName];
    [aCoder encodeObject:_role forKey:kZXY_UserDataRole];
}

- (id)copyWithZone:(NSZone *)zone
{
    ZXY_UserData *copy = [[ZXY_UserData alloc] init];
    
    if (copy) {

        copy.userId = [self.userId copyWithZone:zone];
        copy.nickName = [self.nickName copyWithZone:zone];
        copy.role = [self.role copyWithZone:zone];
    }
    
    return copy;
}


@end
