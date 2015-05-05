//
//  SR_OrderDetailData.h
//
//  Created by sun  on 15/5/5
//  Copyright (c) 2015 __MyCompanyName__. All rights reserved.
//

#import <Foundation/Foundation.h>

@class SR_OrderDetailCustom, SR_OrderDetailUser;

@interface SR_OrderDetailData : NSObject <NSCoding, NSCopying>

@property (nonatomic, strong) NSString *commTouserId;
@property (nonatomic, strong) NSString *realName;
@property (nonatomic, strong) NSString *commId;
@property (nonatomic, assign) id orderAddr;
@property (nonatomic, strong) NSString *sex;
@property (nonatomic, strong) NSString *albumDesc;
@property (nonatomic, strong) NSString *addTime;
@property (nonatomic, strong) NSString *isDel;
@property (nonatomic, strong) NSString *orderId;
@property (nonatomic, strong) NSString *detailAddr;
@property (nonatomic, strong) NSString *userId;
@property (nonatomic, strong) NSString *orderTime;
@property (nonatomic, strong) NSString *orderStatus;
@property (nonatomic, strong) NSString *preStatus;
@property (nonatomic, strong) NSString *tel;
@property (nonatomic, strong) SR_OrderDetailCustom *custom;
@property (nonatomic, strong) SR_OrderDetailUser *user;
@property (nonatomic, strong) NSString *albumId;
@property (nonatomic, strong) NSString *customId;

+ (instancetype)modelObjectWithDictionary:(NSDictionary *)dict;
- (instancetype)initWithDictionary:(NSDictionary *)dict;
- (NSDictionary *)dictionaryRepresentation;

@end
