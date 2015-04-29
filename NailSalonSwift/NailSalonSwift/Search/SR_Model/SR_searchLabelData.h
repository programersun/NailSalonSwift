//
//  SR_searchLabelData.h
//
//  Created by sun  on 15/4/28
//  Copyright (c) 2015 __MyCompanyName__. All rights reserved.
//

#import <Foundation/Foundation.h>

@class SR_searchLabelUser, SR_searchLabelImage;

@interface SR_searchLabelData : NSObject <NSCoding, NSCopying>

@property (nonatomic, strong) SR_searchLabelUser *user;
@property (nonatomic, strong) NSString *albumId;
@property (nonatomic, strong) SR_searchLabelImage *image;
@property (nonatomic, strong) NSString *tag;
@property (nonatomic, strong) NSString *userId;
@property (nonatomic, strong) NSString *dataDescription;
@property (nonatomic, strong) NSString *addTime;

+ (instancetype)modelObjectWithDictionary:(NSDictionary *)dict;
- (instancetype)initWithDictionary:(NSDictionary *)dict;
- (NSDictionary *)dictionaryRepresentation;

@end
