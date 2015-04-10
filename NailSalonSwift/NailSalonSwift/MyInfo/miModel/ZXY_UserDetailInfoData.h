//
//  ZXY_UserDetailInfoData.h
//
//  Created by   on 15/4/10
//  Copyright (c) 2015 __MyCompanyName__. All rights reserved.
//

#import <Foundation/Foundation.h>



@interface ZXY_UserDetailInfoData : NSObject <NSCoding, NSCopying>

@property (nonatomic, strong) NSString *realName;
@property (nonatomic, strong) NSString *headImage;
@property (nonatomic, strong) NSString *sex;
@property (nonatomic, strong) NSString *longitude;
@property (nonatomic, strong) NSString *nickName;
@property (nonatomic, strong) NSString *latitude;
@property (nonatomic, strong) NSString *byAttention;
@property (nonatomic, strong) NSString *address;
@property (nonatomic, strong) NSString *userName;
@property (nonatomic, strong) NSString *role;
@property (nonatomic, strong) NSString *tel;
@property (nonatomic, strong) NSString *attention;
@property (nonatomic, strong) NSString *score;

+ (instancetype)modelObjectWithDictionary:(NSDictionary *)dict;
- (instancetype)initWithDictionary:(NSDictionary *)dict;
- (NSDictionary *)dictionaryRepresentation;

@end
