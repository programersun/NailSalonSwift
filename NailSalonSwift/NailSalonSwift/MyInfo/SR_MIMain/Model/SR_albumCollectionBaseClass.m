//
//  SR_albumCollectionBaseClass.m
//
//  Created by sun  on 15/4/27
//  Copyright (c) 2015 __MyCompanyName__. All rights reserved.
//

#import "SR_albumCollectionBaseClass.h"
#import "SR_albumCollectionData.h"


NSString *const kSR_albumCollectionBaseClassResult = @"result";
NSString *const kSR_albumCollectionBaseClassData = @"data";


@interface SR_albumCollectionBaseClass ()

- (id)objectOrNilForKey:(id)aKey fromDictionary:(NSDictionary *)dict;

@end

@implementation SR_albumCollectionBaseClass

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
            self.result = [[self objectOrNilForKey:kSR_albumCollectionBaseClassResult fromDictionary:dict] doubleValue];
    NSObject *receivedSR_albumCollectionData = [dict objectForKey:kSR_albumCollectionBaseClassData];
    NSMutableArray *parsedSR_albumCollectionData = [NSMutableArray array];
    if ([receivedSR_albumCollectionData isKindOfClass:[NSArray class]]) {
        for (NSDictionary *item in (NSArray *)receivedSR_albumCollectionData) {
            if ([item isKindOfClass:[NSDictionary class]]) {
                [parsedSR_albumCollectionData addObject:[SR_albumCollectionData modelObjectWithDictionary:item]];
            }
       }
    } else if ([receivedSR_albumCollectionData isKindOfClass:[NSDictionary class]]) {
       [parsedSR_albumCollectionData addObject:[SR_albumCollectionData modelObjectWithDictionary:(NSDictionary *)receivedSR_albumCollectionData]];
    }

    self.data = [NSArray arrayWithArray:parsedSR_albumCollectionData];

    }
    
    return self;
    
}

- (NSDictionary *)dictionaryRepresentation
{
    NSMutableDictionary *mutableDict = [NSMutableDictionary dictionary];
    [mutableDict setValue:[NSNumber numberWithDouble:self.result] forKey:kSR_albumCollectionBaseClassResult];
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
    [mutableDict setValue:[NSArray arrayWithArray:tempArrayForData] forKey:kSR_albumCollectionBaseClassData];

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

    self.result = [aDecoder decodeDoubleForKey:kSR_albumCollectionBaseClassResult];
    self.data = [aDecoder decodeObjectForKey:kSR_albumCollectionBaseClassData];
    return self;
}

- (void)encodeWithCoder:(NSCoder *)aCoder
{

    [aCoder encodeDouble:_result forKey:kSR_albumCollectionBaseClassResult];
    [aCoder encodeObject:_data forKey:kSR_albumCollectionBaseClassData];
}

- (id)copyWithZone:(NSZone *)zone
{
    SR_albumCollectionBaseClass *copy = [[SR_albumCollectionBaseClass alloc] init];
    
    if (copy) {

        copy.result = self.result;
        copy.data = [self.data copyWithZone:zone];
    }
    
    return copy;
}


@end
