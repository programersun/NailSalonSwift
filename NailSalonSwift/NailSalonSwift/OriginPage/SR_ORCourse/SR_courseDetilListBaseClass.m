//
//  SR_courseDetilListBaseClass.m
//
//  Created by sun  on 15/4/23
//  Copyright (c) 2015 __MyCompanyName__. All rights reserved.
//

#import "SR_courseDetilListBaseClass.h"
#import "SR_courseDetilListData.h"


NSString *const kSR_courseDetilListBaseClassResult = @"result";
NSString *const kSR_courseDetilListBaseClassData = @"data";


@interface SR_courseDetilListBaseClass ()

- (id)objectOrNilForKey:(id)aKey fromDictionary:(NSDictionary *)dict;

@end

@implementation SR_courseDetilListBaseClass

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
            self.result = [[self objectOrNilForKey:kSR_courseDetilListBaseClassResult fromDictionary:dict] doubleValue];
    NSObject *receivedSR_courseDetilListData = [dict objectForKey:kSR_courseDetilListBaseClassData];
    NSMutableArray *parsedSR_courseDetilListData = [NSMutableArray array];
    if ([receivedSR_courseDetilListData isKindOfClass:[NSArray class]]) {
        for (NSDictionary *item in (NSArray *)receivedSR_courseDetilListData) {
            if ([item isKindOfClass:[NSDictionary class]]) {
                [parsedSR_courseDetilListData addObject:[SR_courseDetilListData modelObjectWithDictionary:item]];
            }
       }
    } else if ([receivedSR_courseDetilListData isKindOfClass:[NSDictionary class]]) {
       [parsedSR_courseDetilListData addObject:[SR_courseDetilListData modelObjectWithDictionary:(NSDictionary *)receivedSR_courseDetilListData]];
    }

    self.data = [NSArray arrayWithArray:parsedSR_courseDetilListData];

    }
    
    return self;
    
}

- (NSDictionary *)dictionaryRepresentation
{
    NSMutableDictionary *mutableDict = [NSMutableDictionary dictionary];
    [mutableDict setValue:[NSNumber numberWithDouble:self.result] forKey:kSR_courseDetilListBaseClassResult];
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
    [mutableDict setValue:[NSArray arrayWithArray:tempArrayForData] forKey:kSR_courseDetilListBaseClassData];

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

    self.result = [aDecoder decodeDoubleForKey:kSR_courseDetilListBaseClassResult];
    self.data = [aDecoder decodeObjectForKey:kSR_courseDetilListBaseClassData];
    return self;
}

- (void)encodeWithCoder:(NSCoder *)aCoder
{

    [aCoder encodeDouble:_result forKey:kSR_courseDetilListBaseClassResult];
    [aCoder encodeObject:_data forKey:kSR_courseDetilListBaseClassData];
}

- (id)copyWithZone:(NSZone *)zone
{
    SR_courseDetilListBaseClass *copy = [[SR_courseDetilListBaseClass alloc] init];
    
    if (copy) {

        copy.result = self.result;
        copy.data = [self.data copyWithZone:zone];
    }
    
    return copy;
}


@end
