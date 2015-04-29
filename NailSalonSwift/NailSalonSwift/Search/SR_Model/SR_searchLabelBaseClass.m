//
//  SR_searchLabelBaseClass.m
//
//  Created by sun  on 15/4/28
//  Copyright (c) 2015 __MyCompanyName__. All rights reserved.
//

#import "SR_searchLabelBaseClass.h"
#import "SR_searchLabelData.h"


NSString *const kSR_searchLabelBaseClassResult = @"result";
NSString *const kSR_searchLabelBaseClassData = @"data";


@interface SR_searchLabelBaseClass ()

- (id)objectOrNilForKey:(id)aKey fromDictionary:(NSDictionary *)dict;

@end

@implementation SR_searchLabelBaseClass

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
            self.result = [[self objectOrNilForKey:kSR_searchLabelBaseClassResult fromDictionary:dict] doubleValue];
    NSObject *receivedSR_searchLabelData = [dict objectForKey:kSR_searchLabelBaseClassData];
    NSMutableArray *parsedSR_searchLabelData = [NSMutableArray array];
    if ([receivedSR_searchLabelData isKindOfClass:[NSArray class]]) {
        for (NSDictionary *item in (NSArray *)receivedSR_searchLabelData) {
            if ([item isKindOfClass:[NSDictionary class]]) {
                [parsedSR_searchLabelData addObject:[SR_searchLabelData modelObjectWithDictionary:item]];
            }
       }
    } else if ([receivedSR_searchLabelData isKindOfClass:[NSDictionary class]]) {
       [parsedSR_searchLabelData addObject:[SR_searchLabelData modelObjectWithDictionary:(NSDictionary *)receivedSR_searchLabelData]];
    }

    self.data = [NSArray arrayWithArray:parsedSR_searchLabelData];

    }
    
    return self;
    
}

- (NSDictionary *)dictionaryRepresentation
{
    NSMutableDictionary *mutableDict = [NSMutableDictionary dictionary];
    [mutableDict setValue:[NSNumber numberWithDouble:self.result] forKey:kSR_searchLabelBaseClassResult];
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
    [mutableDict setValue:[NSArray arrayWithArray:tempArrayForData] forKey:kSR_searchLabelBaseClassData];

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

    self.result = [aDecoder decodeDoubleForKey:kSR_searchLabelBaseClassResult];
    self.data = [aDecoder decodeObjectForKey:kSR_searchLabelBaseClassData];
    return self;
}

- (void)encodeWithCoder:(NSCoder *)aCoder
{

    [aCoder encodeDouble:_result forKey:kSR_searchLabelBaseClassResult];
    [aCoder encodeObject:_data forKey:kSR_searchLabelBaseClassData];
}

- (id)copyWithZone:(NSZone *)zone
{
    SR_searchLabelBaseClass *copy = [[SR_searchLabelBaseClass alloc] init];
    
    if (copy) {

        copy.result = self.result;
        copy.data = [self.data copyWithZone:zone];
    }
    
    return copy;
}


@end
