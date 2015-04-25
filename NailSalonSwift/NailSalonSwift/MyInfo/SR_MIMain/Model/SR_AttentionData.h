//
//  SR_AttentionData.h
//
//  Created by sun  on 15/4/25
//  Copyright (c) 2015 __MyCompanyName__. All rights reserved.
//

#import <Foundation/Foundation.h>



@interface SR_AttentionData : NSObject <NSCoding, NSCopying>

@property (nonatomic, strong) NSString *orderCount2;
@property (nonatomic, strong) NSString *headImage;
@property (nonatomic, strong) NSString *longitude;
@property (nonatomic, strong) NSString *nickName;
@property (nonatomic, strong) NSString *latitude;
@property (nonatomic, strong) NSString *userId;
@property (nonatomic, strong) NSString *albumCount;
@property (nonatomic, strong) NSString *byAttention;
@property (nonatomic, strong) NSString *orderCount;
@property (nonatomic, strong) NSString *role;
@property (nonatomic, strong) NSString *score;
@property (nonatomic, strong) NSString *isPass;

+ (instancetype)modelObjectWithDictionary:(NSDictionary *)dict;
- (instancetype)initWithDictionary:(NSDictionary *)dict;
- (NSDictionary *)dictionaryRepresentation;

@end
