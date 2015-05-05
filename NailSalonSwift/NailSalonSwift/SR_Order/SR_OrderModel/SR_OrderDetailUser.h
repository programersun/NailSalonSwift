//
//  SR_OrderDetailUser.h
//
//  Created by sun  on 15/5/5
//  Copyright (c) 2015 __MyCompanyName__. All rights reserved.
//

#import <Foundation/Foundation.h>



@interface SR_OrderDetailUser : NSObject <NSCoding, NSCopying>

@property (nonatomic, strong) NSString *nickName;
@property (nonatomic, strong) NSString *userName;
@property (nonatomic, strong) NSString *score;
@property (nonatomic, strong) NSString *userId;
@property (nonatomic, strong) NSString *headImage;
@property (nonatomic, strong) NSString *tel;

+ (instancetype)modelObjectWithDictionary:(NSDictionary *)dict;
- (instancetype)initWithDictionary:(NSDictionary *)dict;
- (NSDictionary *)dictionaryRepresentation;

@end
