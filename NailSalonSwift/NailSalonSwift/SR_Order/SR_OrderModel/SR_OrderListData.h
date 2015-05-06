//
//  SR_OrderListData.h
//
//  Created by sun  on 15/5/6
//  Copyright (c) 2015 __MyCompanyName__. All rights reserved.
//

#import <Foundation/Foundation.h>



@interface SR_OrderListData : NSObject <NSCoding, NSCopying>

@property (nonatomic, strong) NSString *nickName;
@property (nonatomic, strong) NSString *orderId;
@property (nonatomic, strong) NSString *uid;
@property (nonatomic, strong) NSString *headImage;
@property (nonatomic, strong) NSString *detailAddr;
@property (nonatomic, strong) NSString *preStatus;
@property (nonatomic, strong) NSString *realName;
@property (nonatomic, strong) NSString *orderStatus;
@property (nonatomic, strong) NSString *albumDesc;
@property (nonatomic, strong) NSString *addTime;

+ (instancetype)modelObjectWithDictionary:(NSDictionary *)dict;
- (instancetype)initWithDictionary:(NSDictionary *)dict;
- (NSDictionary *)dictionaryRepresentation;

@end
