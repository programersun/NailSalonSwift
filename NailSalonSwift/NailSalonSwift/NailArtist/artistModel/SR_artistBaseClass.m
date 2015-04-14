//
//  SR_artistBaseClass.m
//
//  Created by sun  on 15/4/9
//  Copyright (c) 2015 __MyCompanyName__. All rights reserved.
//

#import "SR_artistBaseClass.h"
#import "SR_artistData.h"


NSString *const kSR_artistBaseClassResult = @"result";
NSString *const kSR_artistBaseClassData = @"data";


@interface SR_artistBaseClass ()

- (id)objectOrNilForKey:(id)aKey fromDictionary:(NSDictionary *)dict;

@end

@implementation SR_artistBaseClass

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
            self.result = [[self objectOrNilForKey:kSR_artistBaseClassResult fromDictionary:dict] doubleValue];
    NSObject *receivedSR_artistData = [dict objectForKey:kSR_artistBaseClassData];
    NSMutableArray *parsedSR_artistData = [NSMutableArray array];
    if ([receivedSR_artistData isKindOfClass:[NSArray class]]) {
        for (NSDictionary *item in (NSArray *)receivedSR_artistData) {
            if ([item isKindOfClass:[NSDictionary class]]) {
                [parsedSR_artistData addObject:[SR_artistData modelObjectWithDictionary:item]];
            }
       }
    } else if ([receivedSR_artistData isKindOfClass:[NSDictionary class]]) {
       [parsedSR_artistData addObject:[SR_artistData modelObjectWithDictionary:(NSDictionary *)receivedSR_artistData]];
    }

    self.data = [NSArray arrayWithArray:parsedSR_artistData];

    }
    
    return self;
    
}

- (NSDictionary *)dictionaryRepresentation
{
    NSMutableDictionary *mutableDict = [NSMutableDictionary dictionary];
    [mutableDict setValue:[NSNumber numberWithDouble:self.result] forKey:kSR_artistBaseClassResult];
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
    [mutableDict setValue:[NSArray arrayWithArray:tempArrayForData] forKey:kSR_artistBaseClassData];

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

    self.result = [aDecoder decodeDoubleForKey:kSR_artistBaseClassResult];
    self.data = [aDecoder decodeObjectForKey:kSR_artistBaseClassData];
    return self;
}

- (void)encodeWithCoder:(NSCoder *)aCoder
{

    [aCoder encodeDouble:_result forKey:kSR_artistBaseClassResult];
    [aCoder encodeObject:_data forKey:kSR_artistBaseClassData];
}

- (id)copyWithZone:(NSZone *)zone
{
    SR_artistBaseClass *copy = [[SR_artistBaseClass alloc] init];
    
    if (copy) {

        copy.result = self.result;
        copy.data = [self.data copyWithZone:zone];
    }
    
    return copy;
}


@end
