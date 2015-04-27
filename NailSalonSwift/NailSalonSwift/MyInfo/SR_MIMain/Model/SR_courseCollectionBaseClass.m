//
//  SR_courseCollectionBaseClass.m
//
//  Created by sun  on 15/4/27
//  Copyright (c) 2015 __MyCompanyName__. All rights reserved.
//

#import "SR_courseCollectionBaseClass.h"
#import "SR_courseCollectionData.h"


NSString *const kSR_courseCollectionBaseClassResult = @"result";
NSString *const kSR_courseCollectionBaseClassData = @"data";


@interface SR_courseCollectionBaseClass ()

- (id)objectOrNilForKey:(id)aKey fromDictionary:(NSDictionary *)dict;

@end

@implementation SR_courseCollectionBaseClass

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
            self.result = [self objectOrNilForKey:kSR_courseCollectionBaseClassResult fromDictionary:dict];
    NSObject *receivedSR_courseCollectionData = [dict objectForKey:kSR_courseCollectionBaseClassData];
    NSMutableArray *parsedSR_courseCollectionData = [NSMutableArray array];
    if ([receivedSR_courseCollectionData isKindOfClass:[NSArray class]]) {
        for (NSDictionary *item in (NSArray *)receivedSR_courseCollectionData) {
            if ([item isKindOfClass:[NSDictionary class]]) {
                [parsedSR_courseCollectionData addObject:[SR_courseCollectionData modelObjectWithDictionary:item]];
            }
       }
    } else if ([receivedSR_courseCollectionData isKindOfClass:[NSDictionary class]]) {
       [parsedSR_courseCollectionData addObject:[SR_courseCollectionData modelObjectWithDictionary:(NSDictionary *)receivedSR_courseCollectionData]];
    }

    self.data = [NSArray arrayWithArray:parsedSR_courseCollectionData];

    }
    
    return self;
    
}

- (NSDictionary *)dictionaryRepresentation
{
    NSMutableDictionary *mutableDict = [NSMutableDictionary dictionary];
    [mutableDict setValue:self.result forKey:kSR_courseCollectionBaseClassResult];
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
    [mutableDict setValue:[NSArray arrayWithArray:tempArrayForData] forKey:kSR_courseCollectionBaseClassData];

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

    self.result = [aDecoder decodeObjectForKey:kSR_courseCollectionBaseClassResult];
    self.data = [aDecoder decodeObjectForKey:kSR_courseCollectionBaseClassData];
    return self;
}

- (void)encodeWithCoder:(NSCoder *)aCoder
{

    [aCoder encodeObject:_result forKey:kSR_courseCollectionBaseClassResult];
    [aCoder encodeObject:_data forKey:kSR_courseCollectionBaseClassData];
}

- (id)copyWithZone:(NSZone *)zone
{
    SR_courseCollectionBaseClass *copy = [[SR_courseCollectionBaseClass alloc] init];
    
    if (copy) {

        copy.result = [self.result copyWithZone:zone];
        copy.data = [self.data copyWithZone:zone];
    }
    
    return copy;
}


@end
