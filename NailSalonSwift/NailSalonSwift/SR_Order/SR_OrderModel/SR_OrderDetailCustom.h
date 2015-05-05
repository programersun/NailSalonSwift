//
//  SR_OrderDetailCustom.h
//
//  Created by sun  on 15/5/5
//  Copyright (c) 2015 __MyCompanyName__. All rights reserved.
//

#import <Foundation/Foundation.h>



@interface SR_OrderDetailCustom : NSObject <NSCoding, NSCopying>

@property (nonatomic, strong) NSString *nickName;
@property (nonatomic, strong) NSString *score;
@property (nonatomic, strong) NSString *userId;
@property (nonatomic, strong) NSString *headImage;
@property (nonatomic, strong) NSString *role;
@property (nonatomic, strong) NSString *score2;

+ (instancetype)modelObjectWithDictionary:(NSDictionary *)dict;
- (instancetype)initWithDictionary:(NSDictionary *)dict;
- (NSDictionary *)dictionaryRepresentation;

@end
