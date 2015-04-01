//
//  ZXYCourseData.h
//
//  Created by   on 15/4/1
//  Copyright (c) 2015 __MyCompanyName__. All rights reserved.
//

#import <Foundation/Foundation.h>



@interface ZXYCourseData : NSObject <NSCoding, NSCopying>

@property (nonatomic, strong) NSString *cateId;
@property (nonatomic, strong) NSString *cateOrder;
@property (nonatomic, strong) NSString *cateName;
@property (nonatomic, strong) NSString *addTime;
@property (nonatomic, strong) NSArray *course;
@property (nonatomic, strong) NSString *imgPath;

+ (instancetype)modelObjectWithDictionary:(NSDictionary *)dict;
- (instancetype)initWithDictionary:(NSDictionary *)dict;
- (NSDictionary *)dictionaryRepresentation;

@end
