//
//  SR_CourseUserStatusData.h
//
//  Created by sun  on 15/4/24
//  Copyright (c) 2015 __MyCompanyName__. All rights reserved.
//

#import <Foundation/Foundation.h>



@interface SR_CourseUserStatusData : NSObject <NSCoding, NSCopying>

@property (nonatomic, strong) NSString *isStar;
@property (nonatomic, strong) NSString *isCollect;

+ (instancetype)modelObjectWithDictionary:(NSDictionary *)dict;
- (instancetype)initWithDictionary:(NSDictionary *)dict;
- (NSDictionary *)dictionaryRepresentation;

@end
