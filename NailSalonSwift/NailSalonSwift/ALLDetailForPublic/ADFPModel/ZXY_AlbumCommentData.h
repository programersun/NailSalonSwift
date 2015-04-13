//
//  ZXY_AlbumCommentData.h
//
//  Created by   on 15/4/13
//  Copyright (c) 2015 __MyCompanyName__. All rights reserved.
//

#import <Foundation/Foundation.h>



@interface ZXY_AlbumCommentData : NSObject <NSCoding, NSCopying>

@property (nonatomic, strong) NSString *nickName;
@property (nonatomic, strong) NSString *addTime;
@property (nonatomic, strong) NSString *content;
@property (nonatomic, strong) NSString *userId;
@property (nonatomic, strong) NSString *headImage;

+ (instancetype)modelObjectWithDictionary:(NSDictionary *)dict;
- (instancetype)initWithDictionary:(NSDictionary *)dict;
- (NSDictionary *)dictionaryRepresentation;

@end
