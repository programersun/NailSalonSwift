//
//  ZXYCourseData.m
//
//  Created by   on 15/4/1
//  Copyright (c) 2015 __MyCompanyName__. All rights reserved.
//

#import "ZXYCourseData.h"
#import "ZXYCourseCourse.h"


NSString *const kZXYCourseDataCateId = @"cate_id";
NSString *const kZXYCourseDataCateOrder = @"cate_order";
NSString *const kZXYCourseDataCateName = @"cate_name";
NSString *const kZXYCourseDataAddTime = @"add_time";
NSString *const kZXYCourseDataCourse = @"course";
NSString *const kZXYCourseDataImgPath = @"img_path";


@interface ZXYCourseData ()

- (id)objectOrNilForKey:(id)aKey fromDictionary:(NSDictionary *)dict;

@end

@implementation ZXYCourseData

@synthesize cateId = _cateId;
@synthesize cateOrder = _cateOrder;
@synthesize cateName = _cateName;
@synthesize addTime = _addTime;
@synthesize course = _course;
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
            self.cateId = [self objectOrNilForKey:kZXYCourseDataCateId fromDictionary:dict];
            self.cateOrder = [self objectOrNilForKey:kZXYCourseDataCateOrder fromDictionary:dict];
            self.cateName = [self objectOrNilForKey:kZXYCourseDataCateName fromDictionary:dict];
            self.addTime = [self objectOrNilForKey:kZXYCourseDataAddTime fromDictionary:dict];
    NSObject *receivedZXYCourseCourse = [dict objectForKey:kZXYCourseDataCourse];
    NSMutableArray *parsedZXYCourseCourse = [NSMutableArray array];
    if ([receivedZXYCourseCourse isKindOfClass:[NSArray class]]) {
        for (NSDictionary *item in (NSArray *)receivedZXYCourseCourse) {
            if ([item isKindOfClass:[NSDictionary class]]) {
                [parsedZXYCourseCourse addObject:[ZXYCourseCourse modelObjectWithDictionary:item]];
            }
       }
    } else if ([receivedZXYCourseCourse isKindOfClass:[NSDictionary class]]) {
       [parsedZXYCourseCourse addObject:[ZXYCourseCourse modelObjectWithDictionary:(NSDictionary *)receivedZXYCourseCourse]];
    }

    self.course = [NSArray arrayWithArray:parsedZXYCourseCourse];
            self.imgPath = [self objectOrNilForKey:kZXYCourseDataImgPath fromDictionary:dict];

    }
    
    return self;
    
}

- (NSDictionary *)dictionaryRepresentation
{
    NSMutableDictionary *mutableDict = [NSMutableDictionary dictionary];
    [mutableDict setValue:self.cateId forKey:kZXYCourseDataCateId];
    [mutableDict setValue:self.cateOrder forKey:kZXYCourseDataCateOrder];
    [mutableDict setValue:self.cateName forKey:kZXYCourseDataCateName];
    [mutableDict setValue:self.addTime forKey:kZXYCourseDataAddTime];
    NSMutableArray *tempArrayForCourse = [NSMutableArray array];
    for (NSObject *subArrayObject in self.course) {
        if([subArrayObject respondsToSelector:@selector(dictionaryRepresentation)]) {
            // This class is a model object
            [tempArrayForCourse addObject:[subArrayObject performSelector:@selector(dictionaryRepresentation)]];
        } else {
            // Generic object
            [tempArrayForCourse addObject:subArrayObject];
        }
    }
    [mutableDict setValue:[NSArray arrayWithArray:tempArrayForCourse] forKey:kZXYCourseDataCourse];
    [mutableDict setValue:self.imgPath forKey:kZXYCourseDataImgPath];

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

    self.cateId = [aDecoder decodeObjectForKey:kZXYCourseDataCateId];
    self.cateOrder = [aDecoder decodeObjectForKey:kZXYCourseDataCateOrder];
    self.cateName = [aDecoder decodeObjectForKey:kZXYCourseDataCateName];
    self.addTime = [aDecoder decodeObjectForKey:kZXYCourseDataAddTime];
    self.course = [aDecoder decodeObjectForKey:kZXYCourseDataCourse];
    self.imgPath = [aDecoder decodeObjectForKey:kZXYCourseDataImgPath];
    return self;
}

- (void)encodeWithCoder:(NSCoder *)aCoder
{

    [aCoder encodeObject:_cateId forKey:kZXYCourseDataCateId];
    [aCoder encodeObject:_cateOrder forKey:kZXYCourseDataCateOrder];
    [aCoder encodeObject:_cateName forKey:kZXYCourseDataCateName];
    [aCoder encodeObject:_addTime forKey:kZXYCourseDataAddTime];
    [aCoder encodeObject:_course forKey:kZXYCourseDataCourse];
    [aCoder encodeObject:_imgPath forKey:kZXYCourseDataImgPath];
}

- (id)copyWithZone:(NSZone *)zone
{
    ZXYCourseData *copy = [[ZXYCourseData alloc] init];
    
    if (copy) {

        copy.cateId = [self.cateId copyWithZone:zone];
        copy.cateOrder = [self.cateOrder copyWithZone:zone];
        copy.cateName = [self.cateName copyWithZone:zone];
        copy.addTime = [self.addTime copyWithZone:zone];
        copy.course = [self.course copyWithZone:zone];
        copy.imgPath = [self.imgPath copyWithZone:zone];
    }
    
    return copy;
}


@end
