//
//  SR_OrderDetailBaseClass.m
//
//  Created by sun  on 15/5/8
//  Copyright (c) 2015 __MyCompanyName__. All rights reserved.
//

#import "SR_OrderDetailBaseClass.h"
#import "SR_OrderDetailData.h"


NSString *const kSR_OrderDetailBaseClassResult = @"result";
NSString *const kSR_OrderDetailBaseClassData = @"data";


@interface SR_OrderDetailBaseClass ()

- (id)objectOrNilForKey:(id)aKey fromDictionary:(NSDictionary *)dict;

@end

@implementation SR_OrderDetailBaseClass

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
            self.result = [[self objectOrNilForKey:kSR_OrderDetailBaseClassResult fromDictionary:dict] doubleValue];
            self.data = [SR_OrderDetailData modelObjectWithDictionary:[dict objectForKey:kSR_OrderDetailBaseClassData]];

    }
    
    return self;
    
}

- (NSDictionary *)dictionaryRepresentation
{
    NSMutableDictionary *mutableDict = [NSMutableDictionary dictionary];
    [mutableDict setValue:[NSNumber numberWithDouble:self.result] forKey:kSR_OrderDetailBaseClassResult];
    [mutableDict setValue:[self.data dictionaryRepresentation] forKey:kSR_OrderDetailBaseClassData];

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

    self.result = [aDecoder decodeDoubleForKey:kSR_OrderDetailBaseClassResult];
    self.data = [aDecoder decodeObjectForKey:kSR_OrderDetailBaseClassData];
    return self;
}

- (void)encodeWithCoder:(NSCoder *)aCoder
{

    [aCoder encodeDouble:_result forKey:kSR_OrderDetailBaseClassResult];
    [aCoder encodeObject:_data forKey:kSR_OrderDetailBaseClassData];
}

- (id)copyWithZone:(NSZone *)zone
{
    SR_OrderDetailBaseClass *copy = [[SR_OrderDetailBaseClass alloc] init];
    
    if (copy) {

        copy.result = self.result;
        copy.data = [self.data copyWithZone:zone];
    }
    
    return copy;
}


@end
