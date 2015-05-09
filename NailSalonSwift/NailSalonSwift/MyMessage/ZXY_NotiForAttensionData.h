//
//  ZXY_NotiForAttensionData.h
//
//  Created by   on 15/5/9
//  Copyright (c) 2015 __MyCompanyName__. All rights reserved.
//

#import <Foundation/Foundation.h>



@interface ZXY_NotiForAttensionData : NSObject <NSCoding, NSCopying>

@property (nonatomic, strong) NSString *dataIdentifier;
@property (nonatomic, strong) NSString *nick;
@property (nonatomic, assign) double sendTime;
@property (nonatomic, strong) NSString *role;
@property (nonatomic, strong) NSString *head;

+ (instancetype)modelObjectWithDictionary:(NSDictionary *)dict;
- (instancetype)initWithDictionary:(NSDictionary *)dict;
- (NSDictionary *)dictionaryRepresentation;

@end
