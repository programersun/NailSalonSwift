//
//  ZXY_UserInfoBase.m
//
//  Created by   on 15/4/8
//  Copyright (c) 2015 __MyCompanyName__. All rights reserved.
//

#import "ZXY_UserInfoBase.h"
#import "ZXY_UserData.h"


NSString *const kZXY_UserInfoBaseResult = @"result";
NSString *const kZXY_UserInfoBaseData = @"data";


@interface ZXY_UserInfoBase ()

- (id)objectOrNilForKey:(id)aKey fromDictionary:(NSDictionary *)dict;

@end

@implementation ZXY_UserInfoBase

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
            self.result = [[self objectOrNilForKey:kZXY_UserInfoBaseResult fromDictionary:dict] doubleValue];
            self.data = [ZXY_UserData modelObjectWithDictionary:[dict objectForKey:kZXY_UserInfoBaseData]];

    }
    
    return self;
    
}

- (NSDictionary *)dictionaryRepresentation
{
    NSMutableDictionary *mutableDict = [NSMutableDictionary dictionary];
    [mutableDict setValue:[NSNumber numberWithDouble:self.result] forKey:kZXY_UserInfoBaseResult];
    [mutableDict setValue:[self.data dictionaryRepresentation] forKey:kZXY_UserInfoBaseData];

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

    self.result = [aDecoder decodeDoubleForKey:kZXY_UserInfoBaseResult];
    self.data = [aDecoder decodeObjectForKey:kZXY_UserInfoBaseData];
    return self;
}

- (void)encodeWithCoder:(NSCoder *)aCoder
{

    [aCoder encodeDouble:_result forKey:kZXY_UserInfoBaseResult];
    [aCoder encodeObject:_data forKey:kZXY_UserInfoBaseData];
}

- (id)copyWithZone:(NSZone *)zone
{
    ZXY_UserInfoBase *copy = [[ZXY_UserInfoBase alloc] init];
    
    if (copy) {

        copy.result = self.result;
        copy.data = [self.data copyWithZone:zone];
    }
    
    return copy;
}


@end
