//
//  SR_albumCollectionData.h
//
//  Created by sun  on 15/4/27
//  Copyright (c) 2015 __MyCompanyName__. All rights reserved.
//

#import <Foundation/Foundation.h>



@interface SR_albumCollectionData : NSObject <NSCoding, NSCopying>

@property (nonatomic, strong) NSString *nickName;
@property (nonatomic, strong) NSString *albumId;
@property (nonatomic, strong) NSString *headImage;
@property (nonatomic, strong) NSString *addTime;
@property (nonatomic, strong) NSString *cutPath;
@property (nonatomic, strong) NSString *userId;
@property (nonatomic, strong) NSString *dataDescription;
@property (nonatomic, strong) NSString *cutWidth;
@property (nonatomic, strong) NSString *agreeCount;
@property (nonatomic, strong) NSString *cutHeight;

+ (instancetype)modelObjectWithDictionary:(NSDictionary *)dict;
- (instancetype)initWithDictionary:(NSDictionary *)dict;
- (NSDictionary *)dictionaryRepresentation;

@end
