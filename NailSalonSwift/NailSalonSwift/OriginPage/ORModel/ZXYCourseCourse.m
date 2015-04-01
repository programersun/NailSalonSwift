//
//  ZXYCourseCourse.m
//
//  Created by   on 15/4/1
//  Copyright (c) 2015 __MyCompanyName__. All rights reserved.
//

#import "ZXYCourseCourse.h"


NSString *const kZXYCourseCourseId = @"id";
NSString *const kZXYCourseCourseImgPath = @"img_path";


@interface ZXYCourseCourse ()

- (id)objectOrNilForKey:(id)aKey fromDictionary:(NSDictionary *)dict;

@end

@implementation ZXYCourseCourse

@synthesize courseIdentifier = _courseIdentifier;
@synthesize imgPath = _imgPath;


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
            self.courseIdentifier = [self objectOrNilForKey:kZXYCourseCourseId fromDictionary:dict];
            self.imgPath = [self objectOrNilForKey:kZXYCourseCourseImgPath fromDictionary:dict];

    }
    
    return self;
    
}

- (NSDictionary *)dictionaryRepresentation
{
    NSMutableDictionary *mutableDict = [NSMutableDictionary dictionary];
    [mutableDict setValue:self.courseIdentifier forKey:kZXYCourseCourseId];
    [mutableDict setValue:self.imgPath forKey:kZXYCourseCourseImgPath];

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

    self.courseIdentifier = [aDecoder decodeObjectForKey:kZXYCourseCourseId];
    self.imgPath = [aDecoder decodeObjectForKey:kZXYCourseCourseImgPath];
    return self;
}

- (void)encodeWithCoder:(NSCoder *)aCoder
{

    [aCoder encodeObject:_courseIdentifier forKey:kZXYCourseCourseId];
    [aCoder encodeObject:_imgPath forKey:kZXYCourseCourseImgPath];
}

- (id)copyWithZone:(NSZone *)zone
{
    ZXYCourseCourse *copy = [[ZXYCourseCourse alloc] init];
    
    if (copy) {

        copy.courseIdentifier = [self.courseIdentifier copyWithZone:zone];
        copy.imgPath = [self.imgPath copyWithZone:zone];
    }
    
    return copy;
}


@end
