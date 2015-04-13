//
//  ZXY_AlbumDetailUser.h
//
//  Created by   on 15/4/12
//  Copyright (c) 2015 __MyCompanyName__. All rights reserved.
//

#import <Foundation/Foundation.h>



@interface ZXY_AlbumDetailUser : NSObject <NSCoding, NSCopying>

@property (nonatomic, strong) NSString *nickName;
@property (nonatomic, strong) NSString *attention;
@property (nonatomic, strong) NSString *score;
@property (nonatomic, strong) NSString *headImage;
@property (nonatomic, strong) NSString *role;
@property (nonatomic, strong) NSString *userId;
@property (nonatomic, strong) NSString *byAttention;
@property (nonatomic, strong) NSString *albumCount;
@property (nonatomic, strong) NSString *addTime;

+ (instancetype)modelObjectWithDictionary:(NSDictionary *)dict;
- (instancetype)initWithDictionary:(NSDictionary *)dict;
- (NSDictionary *)dictionaryRepresentation;

@end
