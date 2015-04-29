//
//  SR_searchLabelUser.m
//
//  Created by sun  on 15/4/28
//  Copyright (c) 2015 __MyCompanyName__. All rights reserved.
//

#import "SR_searchLabelUser.h"


NSString *const kSR_searchLabelUserNickName = @"nick_name";
NSString *const kSR_searchLabelUserRole = @"role";
NSString *const kSR_searchLabelUserHeadImage = @"head_image";


@interface SR_searchLabelUser ()

- (id)objectOrNilForKey:(id)aKey fromDictionary:(NSDictionary *)dict;

@end

@implementation SR_searchLabelUser

@synthesize nickName = _nickName;
@synthesize role = _role;
@synthesize headImage = _headImage;


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
            self.nickName = [self objectOrNilForKey:kSR_searchLabelUserNickName fromDictionary:dict];
            self.role = [self objectOrNilForKey:kSR_searchLabelUserRole fromDictionary:dict];
            self.headImage = [self objectOrNilForKey:kSR_searchLabelUserHeadImage fromDictionary:dict];

    }
    
    return self;
    
}

- (NSDictionary *)dictionaryRepresentation
{
    NSMutableDictionary *mutableDict = [NSMutableDictionary dictionary];
    [mutableDict setValue:self.nickName forKey:kSR_searchLabelUserNickName];
    [mutableDict setValue:self.role forKey:kSR_searchLabelUserRole];
    [mutableDict setValue:self.headImage forKey:kSR_searchLabelUserHeadImage];

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

    self.nickName = [aDecoder decodeObjectForKey:kSR_searchLabelUserNickName];
    self.role = [aDecoder decodeObjectForKey:kSR_searchLabelUserRole];
    self.headImage = [aDecoder decodeObjectForKey:kSR_searchLabelUserHeadImage];
    return self;
}

- (void)encodeWithCoder:(NSCoder *)aCoder
{

    [aCoder encodeObject:_nickName forKey:kSR_searchLabelUserNickName];
    [aCoder encodeObject:_role forKey:kSR_searchLabelUserRole];
    [aCoder encodeObject:_headImage forKey:kSR_searchLabelUserHeadImage];
}

- (id)copyWithZone:(NSZone *)zone
{
    SR_searchLabelUser *copy = [[SR_searchLabelUser alloc] init];
    
    if (copy) {

        copy.nickName = [self.nickName copyWithZone:zone];
        copy.role = [self.role copyWithZone:zone];
        copy.headImage = [self.headImage copyWithZone:zone];
    }
    
    return copy;
}


@end
