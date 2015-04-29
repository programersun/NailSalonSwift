//
//  SR_searchNearbyBaseClass.m
//
//  Created by sun  on 15/4/29
//  Copyright (c) 2015 __MyCompanyName__. All rights reserved.
//

#import "SR_searchNearbyBaseClass.h"
#import "SR_searchNearbyData.h"


NSString *const kSR_searchNearbyBaseClassResult = @"result";
NSString *const kSR_searchNearbyBaseClassData = @"data";


@interface SR_searchNearbyBaseClass ()

- (id)objectOrNilForKey:(id)aKey fromDictionary:(NSDictionary *)dict;

@end

@implementation SR_searchNearbyBaseClass

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
            self.result = [[self objectOrNilForKey:kSR_searchNearbyBaseClassResult fromDictionary:dict] doubleValue];
    NSObject *receivedSR_searchNearbyData = [dict objectForKey:kSR_searchNearbyBaseClassData];
    NSMutableArray *parsedSR_searchNearbyData = [NSMutableArray array];
    if ([receivedSR_searchNearbyData isKindOfClass:[NSArray class]]) {
        for (NSDictionary *item in (NSArray *)receivedSR_searchNearbyData) {
            if ([item isKindOfClass:[NSDictionary class]]) {
                [parsedSR_searchNearbyData addObject:[SR_searchNearbyData modelObjectWithDictionary:item]];
            }
       }
    } else if ([receivedSR_searchNearbyData isKindOfClass:[NSDictionary class]]) {
       [parsedSR_searchNearbyData addObject:[SR_searchNearbyData modelObjectWithDictionary:(NSDictionary *)receivedSR_searchNearbyData]];
    }

    self.data = [NSArray arrayWithArray:parsedSR_searchNearbyData];

    }
    
    return self;
    
}

- (NSDictionary *)dictionaryRepresentation
{
    NSMutableDictionary *mutableDict = [NSMutableDictionary dictionary];
    [mutableDict setValue:[NSNumber numberWithDouble:self.result] forKey:kSR_searchNearbyBaseClassResult];
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
    [mutableDict setValue:[NSArray arrayWithArray:tempArrayForData] forKey:kSR_searchNearbyBaseClassData];

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

    self.result = [aDecoder decodeDoubleForKey:kSR_searchNearbyBaseClassResult];
    self.data = [aDecoder decodeObjectForKey:kSR_searchNearbyBaseClassData];
    return self;
}

- (void)encodeWithCoder:(NSCoder *)aCoder
{

    [aCoder encodeDouble:_result forKey:kSR_searchNearbyBaseClassResult];
    [aCoder encodeObject:_data forKey:kSR_searchNearbyBaseClassData];
}

- (id)copyWithZone:(NSZone *)zone
{
    SR_searchNearbyBaseClass *copy = [[SR_searchNearbyBaseClass alloc] init];
    
    if (copy) {

        copy.result = self.result;
        copy.data = [self.data copyWithZone:zone];
    }
    
    return copy;
}


@end
