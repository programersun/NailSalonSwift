//
//  SR_FansBaseClass.m
//
//  Created by sun  on 15/4/27
//  Copyright (c) 2015 __MyCompanyName__. All rights reserved.
//

#import "SR_FansBaseClass.h"
#import "SR_FansData.h"


NSString *const kSR_FansBaseClassResult = @"result";
NSString *const kSR_FansBaseClassData = @"data";


@interface SR_FansBaseClass ()

- (id)objectOrNilForKey:(id)aKey fromDictionary:(NSDictionary *)dict;

@end

@implementation SR_FansBaseClass

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
            self.result = [[self objectOrNilForKey:kSR_FansBaseClassResult fromDictionary:dict] doubleValue];
    NSObject *receivedSR_FansData = [dict objectForKey:kSR_FansBaseClassData];
    NSMutableArray *parsedSR_FansData = [NSMutableArray array];
    if ([receivedSR_FansData isKindOfClass:[NSArray class]]) {
        for (NSDictionary *item in (NSArray *)receivedSR_FansData) {
            if ([item isKindOfClass:[NSDictionary class]]) {
                [parsedSR_FansData addObject:[SR_FansData modelObjectWithDictionary:item]];
            }
       }
    } else if ([receivedSR_FansData isKindOfClass:[NSDictionary class]]) {
       [parsedSR_FansData addObject:[SR_FansData modelObjectWithDictionary:(NSDictionary *)receivedSR_FansData]];
    }

    self.data = [NSArray arrayWithArray:parsedSR_FansData];

    }
    
    return self;
    
}

- (NSDictionary *)dictionaryRepresentation
{
    NSMutableDictionary *mutableDict = [NSMutableDictionary dictionary];
    [mutableDict setValue:[NSNumber numberWithDouble:self.result] forKey:kSR_FansBaseClassResult];
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
    [mutableDict setValue:[NSArray arrayWithArray:tempArrayForData] forKey:kSR_FansBaseClassData];

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

    self.result = [aDecoder decodeDoubleForKey:kSR_FansBaseClassResult];
    self.data = [aDecoder decodeObjectForKey:kSR_FansBaseClassData];
    return self;
}

- (void)encodeWithCoder:(NSCoder *)aCoder
{

    [aCoder encodeDouble:_result forKey:kSR_FansBaseClassResult];
    [aCoder encodeObject:_data forKey:kSR_FansBaseClassData];
}

- (id)copyWithZone:(NSZone *)zone
{
    SR_FansBaseClass *copy = [[SR_FansBaseClass alloc] init];
    
    if (copy) {

        copy.result = self.result;
        copy.data = [self.data copyWithZone:zone];
    }
    
    return copy;
}


@end
