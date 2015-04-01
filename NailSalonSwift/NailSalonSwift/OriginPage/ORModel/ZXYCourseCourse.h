//
//  ZXYCourseCourse.h
//
//  Created by   on 15/4/1
//  Copyright (c) 2015 __MyCompanyName__. All rights reserved.
//

#import <Foundation/Foundation.h>



@interface ZXYCourseCourse : NSObject <NSCoding, NSCopying>

@property (nonatomic, strong) NSString *courseIdentifier;
@property (nonatomic, strong) NSString *imgPath;

+ (instancetype)modelObjectWithDictionary:(NSDictionary *)dict;
- (instancetype)initWithDictionary:(NSDictionary *)dict;
- (NSDictionary *)dictionaryRepresentation;

@end
