//
//  SR_searchUserBaseClass.m
//
//  Created by sun  on 15/4/28
//  Copyright (c) 2015 __MyCompanyName__. All rights reserved.
//

#import "SR_searchUserBaseClass.h"
#import "SR_searchUserData.h"


NSString *const kSR_searchUserBaseClassResult = @"result";
NSString *const kSR_searchUserBaseClassData = @"data";


@interface SR_searchUserBaseClass ()

- (id)objectOrNilForKey:(id)aKey fromDictionary:(NSDictionary *)dict;

@end

@implementation SR_searchUserBaseClass

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
            self.result = [[self objectOrNilForKey:kSR_searchUserBaseClassResult fromDictionary:dict] doubleValue];
    NSObject *receivedSR_searchUserData = [dict objectForKey:kSR_searchUserBaseClassData];
    NSMutableArray *parsedSR_searchUserData = [NSMutableArray array];
    if ([receivedSR_searchUserData isKindOfClass:[NSArray class]]) {
        for (NSDictionary *item in (NSArray *)receivedSR_searchUserData) {
            if ([item isKindOfClass:[NSDictionary class]]) {
                [parsedSR_searchUserData addObject:[SR_searchUserData modelObjectWithDictionary:item]];
            }
       }
    } else if ([receivedSR_searchUserData isKindOfClass:[NSDictionary class]]) {
       [parsedSR_searchUserData addObject:[SR_searchUserData modelObjectWithDictionary:(NSDictionary *)receivedSR_searchUserData]];
    }

    self.data = [NSArray arrayWithArray:parsedSR_searchUserData];

    }
    
    return self;
    
}

- (NSDictionary *)dictionaryRepresentation
{
    NSMutableDictionary *mutableDict = [NSMutableDictionary dictionary];
    [mutableDict setValue:[NSNumber numberWithDouble:self.result] forKey:kSR_searchUserBaseClassResult];
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
    [mutableDict setValue:[NSArray arrayWithArray:tempArrayForData] forKey:kSR_searchUserBaseClassData];

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

    self.result = [aDecoder decodeDoubleForKey:kSR_searchUserBaseClassResult];
    self.data = [aDecoder decodeObjectForKey:kSR_searchUserBaseClassData];
    return self;
}

- (void)encodeWithCoder:(NSCoder *)aCoder
{

    [aCoder encodeDouble:_result forKey:kSR_searchUserBaseClassResult];
    [aCoder encodeObject:_data forKey:kSR_searchUserBaseClassData];
}

- (id)copyWithZone:(NSZone *)zone
{
    SR_searchUserBaseClass *copy = [[SR_searchUserBaseClass alloc] init];
    
    if (copy) {

        copy.result = self.result;
        copy.data = [self.data copyWithZone:zone];
    }
    
    return copy;
}


@end
