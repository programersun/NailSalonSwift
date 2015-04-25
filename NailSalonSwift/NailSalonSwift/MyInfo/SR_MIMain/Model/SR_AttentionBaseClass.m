//
//  SR_AttentionBaseClass.m
//
//  Created by sun  on 15/4/25
//  Copyright (c) 2015 __MyCompanyName__. All rights reserved.
//

#import "SR_AttentionBaseClass.h"
#import "SR_AttentionData.h"


NSString *const kSR_AttentionBaseClassResult = @"result";
NSString *const kSR_AttentionBaseClassData = @"data";


@interface SR_AttentionBaseClass ()

- (id)objectOrNilForKey:(id)aKey fromDictionary:(NSDictionary *)dict;

@end

@implementation SR_AttentionBaseClass

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
            self.result = [[self objectOrNilForKey:kSR_AttentionBaseClassResult fromDictionary:dict] doubleValue];
    NSObject *receivedSR_AttentionData = [dict objectForKey:kSR_AttentionBaseClassData];
    NSMutableArray *parsedSR_AttentionData = [NSMutableArray array];
    if ([receivedSR_AttentionData isKindOfClass:[NSArray class]]) {
        for (NSDictionary *item in (NSArray *)receivedSR_AttentionData) {
            if ([item isKindOfClass:[NSDictionary class]]) {
                [parsedSR_AttentionData addObject:[SR_AttentionData modelObjectWithDictionary:item]];
            }
       }
    } else if ([receivedSR_AttentionData isKindOfClass:[NSDictionary class]]) {
       [parsedSR_AttentionData addObject:[SR_AttentionData modelObjectWithDictionary:(NSDictionary *)receivedSR_AttentionData]];
    }

    self.data = [NSArray arrayWithArray:parsedSR_AttentionData];

    }
    
    return self;
    
}

- (NSDictionary *)dictionaryRepresentation
{
    NSMutableDictionary *mutableDict = [NSMutableDictionary dictionary];
    [mutableDict setValue:[NSNumber numberWithDouble:self.result] forKey:kSR_AttentionBaseClassResult];
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
    [mutableDict setValue:[NSArray arrayWithArray:tempArrayForData] forKey:kSR_AttentionBaseClassData];

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

    self.result = [aDecoder decodeDoubleForKey:kSR_AttentionBaseClassResult];
    self.data = [aDecoder decodeObjectForKey:kSR_AttentionBaseClassData];
    return self;
}

- (void)encodeWithCoder:(NSCoder *)aCoder
{

    [aCoder encodeDouble:_result forKey:kSR_AttentionBaseClassResult];
    [aCoder encodeObject:_data forKey:kSR_AttentionBaseClassData];
}

- (id)copyWithZone:(NSZone *)zone
{
    SR_AttentionBaseClass *copy = [[SR_AttentionBaseClass alloc] init];
    
    if (copy) {

        copy.result = self.result;
        copy.data = [self.data copyWithZone:zone];
    }
    
    return copy;
}


@end
