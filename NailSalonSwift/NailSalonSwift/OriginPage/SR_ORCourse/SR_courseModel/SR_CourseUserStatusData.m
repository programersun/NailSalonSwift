//
//  SR_CourseUserStatusData.m
//
//  Created by sun  on 15/4/24
//  Copyright (c) 2015 __MyCompanyName__. All rights reserved.
//

#import "SR_CourseUserStatusData.h"


NSString *const kSR_CourseUserStatusDataIsStar = @"isStar";
NSString *const kSR_CourseUserStatusDataIsCollect = @"isCollect";


@interface SR_CourseUserStatusData ()

- (id)objectOrNilForKey:(id)aKey fromDictionary:(NSDictionary *)dict;

@end

@implementation SR_CourseUserStatusData

@synthesize isStar = _isStar;
@synthesize isCollect = _isCollect;


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
            self.isStar = [self objectOrNilForKey:kSR_CourseUserStatusDataIsStar fromDictionary:dict];
            self.isCollect = [self objectOrNilForKey:kSR_CourseUserStatusDataIsCollect fromDictionary:dict];

    }
    
    return self;
    
}

- (NSDictionary *)dictionaryRepresentation
{
    NSMutableDictionary *mutableDict = [NSMutableDictionary dictionary];
    [mutableDict setValue:self.isStar forKey:kSR_CourseUserStatusDataIsStar];
    [mutableDict setValue:self.isCollect forKey:kSR_CourseUserStatusDataIsCollect];

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

    self.isStar = [aDecoder decodeObjectForKey:kSR_CourseUserStatusDataIsStar];
    self.isCollect = [aDecoder decodeObjectForKey:kSR_CourseUserStatusDataIsCollect];
    return self;
}

- (void)encodeWithCoder:(NSCoder *)aCoder
{

    [aCoder encodeObject:_isStar forKey:kSR_CourseUserStatusDataIsStar];
    [aCoder encodeObject:_isCollect forKey:kSR_CourseUserStatusDataIsCollect];
}

- (id)copyWithZone:(NSZone *)zone
{
    SR_CourseUserStatusData *copy = [[SR_CourseUserStatusData alloc] init];
    
    if (copy) {

        copy.isStar = [self.isStar copyWithZone:zone];
        copy.isCollect = [self.isCollect copyWithZone:zone];
    }
    
    return copy;
}


@end
