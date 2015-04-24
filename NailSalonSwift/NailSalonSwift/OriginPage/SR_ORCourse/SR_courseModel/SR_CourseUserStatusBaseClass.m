//
//  SR_CourseUserStatusBaseClass.m
//
//  Created by sun  on 15/4/24
//  Copyright (c) 2015 __MyCompanyName__. All rights reserved.
//

#import "SR_CourseUserStatusBaseClass.h"
#import "SR_CourseUserStatusData.h"


NSString *const kSR_CourseUserStatusBaseClassResult = @"result";
NSString *const kSR_CourseUserStatusBaseClassData = @"data";


@interface SR_CourseUserStatusBaseClass ()

- (id)objectOrNilForKey:(id)aKey fromDictionary:(NSDictionary *)dict;

@end

@implementation SR_CourseUserStatusBaseClass

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
            self.result = [[self objectOrNilForKey:kSR_CourseUserStatusBaseClassResult fromDictionary:dict] doubleValue];
            self.data = [SR_CourseUserStatusData modelObjectWithDictionary:[dict objectForKey:kSR_CourseUserStatusBaseClassData]];

    }
    
    return self;
    
}

- (NSDictionary *)dictionaryRepresentation
{
    NSMutableDictionary *mutableDict = [NSMutableDictionary dictionary];
    [mutableDict setValue:[NSNumber numberWithDouble:self.result] forKey:kSR_CourseUserStatusBaseClassResult];
    [mutableDict setValue:[self.data dictionaryRepresentation] forKey:kSR_CourseUserStatusBaseClassData];

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

    self.result = [aDecoder decodeDoubleForKey:kSR_CourseUserStatusBaseClassResult];
    self.data = [aDecoder decodeObjectForKey:kSR_CourseUserStatusBaseClassData];
    return self;
}

- (void)encodeWithCoder:(NSCoder *)aCoder
{

    [aCoder encodeDouble:_result forKey:kSR_CourseUserStatusBaseClassResult];
    [aCoder encodeObject:_data forKey:kSR_CourseUserStatusBaseClassData];
}

- (id)copyWithZone:(NSZone *)zone
{
    SR_CourseUserStatusBaseClass *copy = [[SR_CourseUserStatusBaseClass alloc] init];
    
    if (copy) {

        copy.result = self.result;
        copy.data = [self.data copyWithZone:zone];
    }
    
    return copy;
}


@end
