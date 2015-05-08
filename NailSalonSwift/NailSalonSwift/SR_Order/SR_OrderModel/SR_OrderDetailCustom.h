//
//  SR_OrderDetailCustom.h
//
//  Created by sun  on 15/5/8
//  Copyright (c) 2015 __MyCompanyName__. All rights reserved.
//

#import <Foundation/Foundation.h>

@class SR_OrderDetailComment;

@interface SR_OrderDetailCustom : NSObject <NSCoding, NSCopying>

@property (nonatomic, strong) NSString *nickName;
@property (nonatomic, strong) NSString *score;
@property (nonatomic, strong) NSString *headImage;
@property (nonatomic, strong) NSString *score2;
@property (nonatomic, strong) NSString *role;
@property (nonatomic, strong) NSString *userId;
@property (nonatomic, strong) SR_OrderDetailComment *comment;

+ (instancetype)modelObjectWithDictionary:(NSDictionary *)dict;
- (instancetype)initWithDictionary:(NSDictionary *)dict;
- (NSDictionary *)dictionaryRepresentation;

@end
