//
//  SR_OrderListBaseClass.m
//
//  Created by sun  on 15/5/4
//  Copyright (c) 2015 __MyCompanyName__. All rights reserved.
//

#import "SR_OrderListBaseClass.h"
#import "SR_OrderListData.h"


NSString *const kSR_OrderListBaseClassResult = @"result";
NSString *const kSR_OrderListBaseClassData = @"data";


@interface SR_OrderListBaseClass ()

- (id)objectOrNilForKey:(id)aKey fromDictionary:(NSDictionary *)dict;

@end

@implementation SR_OrderListBaseClass

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
            self.result = [[self objectOrNilForKey:kSR_OrderListBaseClassResult fromDictionary:dict] doubleValue];
    NSObject *receivedSR_OrderListData = [dict objectForKey:kSR_OrderListBaseClassData];
    NSMutableArray *parsedSR_OrderListData = [NSMutableArray array];
    if ([receivedSR_OrderListData isKindOfClass:[NSArray class]]) {
        for (NSDictionary *item in (NSArray *)receivedSR_OrderListData) {
            if ([item isKindOfClass:[NSDictionary class]]) {
                [parsedSR_OrderListData addObject:[SR_OrderListData modelObjectWithDictionary:item]];
            }
       }
    } else if ([receivedSR_OrderListData isKindOfClass:[NSDictionary class]]) {
       [parsedSR_OrderListData addObject:[SR_OrderListData modelObjectWithDictionary:(NSDictionary *)receivedSR_OrderListData]];
    }

    self.data = [NSArray arrayWithArray:parsedSR_OrderListData];

    }
    
    return self;
    
}

- (NSDictionary *)dictionaryRepresentation
{
    NSMutableDictionary *mutableDict = [NSMutableDictionary dictionary];
    [mutableDict setValue:[NSNumber numberWithDouble:self.result] forKey:kSR_OrderListBaseClassResult];
    NSMutableArray *tempArrayForData = [NSMutableArray array];
    for (NSObject *subArrayObject in self.data) {
        if([subArrayObject respondsToSelector:@selector(dictionaryRepresentation)]) {
            // This class is a model object
            [tempArrayForData addObject:[subArrayObject performSelector:@selector(dictionaryRepresentation)]];
        } else {
            // Generic object
            [tempArrayForData addObject:subArrayObject];
        }
    }
    [mutableDict setValue:[NSArray arrayWithArray:tempArrayForData] forKey:kSR_OrderListBaseClassData];

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

    self.result = [aDecoder decodeDoubleForKey:kSR_OrderListBaseClassResult];
    self.data = [aDecoder decodeObjectForKey:kSR_OrderListBaseClassData];
    return self;
}

- (void)encodeWithCoder:(NSCoder *)aCoder
{

    [aCoder encodeDouble:_result forKey:kSR_OrderListBaseClassResult];
    [aCoder encodeObject:_data forKey:kSR_OrderListBaseClassData];
}

- (id)copyWithZone:(NSZone *)zone
{
    SR_OrderListBaseClass *copy = [[SR_OrderListBaseClass alloc] init];
    
    if (copy) {

        copy.result = self.result;
        copy.data = [self.data copyWithZone:zone];
    }
    
    return copy;
}


@end
