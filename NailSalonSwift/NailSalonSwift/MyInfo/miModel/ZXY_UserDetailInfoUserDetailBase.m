//
//  ZXY_UserDetailInfoUserDetailBase.m
//
//  Created by   on 15/4/10
//  Copyright (c) 2015 __MyCompanyName__. All rights reserved.
//

#import "ZXY_UserDetailInfoUserDetailBase.h"
#import "ZXY_UserDetailInfoData.h"


NSString *const kZXY_UserDetailInfoUserDetailBaseResult = @"result";
NSString *const kZXY_UserDetailInfoUserDetailBaseData = @"data";


@interface ZXY_UserDetailInfoUserDetailBase ()

- (id)objectOrNilForKey:(id)aKey fromDictionary:(NSDictionary *)dict;

@end

@implementation ZXY_UserDetailInfoUserDetailBase

@synthesize result = _result;
@synthesize data = _data;


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
            self.result = [[self objectOrNilForKey:kZXY_UserDetailInfoUserDetailBaseResult fromDictionary:dict] doubleValue];
            self.data = [ZXY_UserDetailInfoData modelObjectWithDictionary:[dict objectForKey:kZXY_UserDetailInfoUserDetailBaseData]];

    }
    
    return self;
    
}

- (NSDictionary *)dictionaryRepresentation
{
    NSMutableDictionary *mutableDict = [NSMutableDictionary dictionary];
    [mutableDict setValue:[NSNumber numberWithDouble:self.result] forKey:kZXY_UserDetailInfoUserDetailBaseResult];
    [mutableDict setValue:[self.data dictionaryRepresentation] forKey:kZXY_UserDetailInfoUserDetailBaseData];

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

    self.result = [aDecoder decodeDoubleForKey:kZXY_UserDetailInfoUserDetailBaseResult];
    self.data = [aDecoder decodeObjectForKey:kZXY_UserDetailInfoUserDetailBaseData];
    return self;
}

- (void)encodeWithCoder:(NSCoder *)aCoder
{

    [aCoder encodeDouble:_result forKey:kZXY_UserDetailInfoUserDetailBaseResult];
    [aCoder encodeObject:_data forKey:kZXY_UserDetailInfoUserDetailBaseData];
}

- (id)copyWithZone:(NSZone *)zone
{
    ZXY_UserDetailInfoUserDetailBase *copy = [[ZXY_UserDetailInfoUserDetailBase alloc] init];
    
    if (copy) {

        copy.result = self.result;
        copy.data = [self.data copyWithZone:zone];
    }
    
    return copy;
}


@end
