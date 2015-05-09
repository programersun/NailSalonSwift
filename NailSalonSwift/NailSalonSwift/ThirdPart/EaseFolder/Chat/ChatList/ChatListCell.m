/************************************************************
  *  * EaseMob CONFIDENTIAL 
  * __________________ 
  * Copyright (C) 2013-2014 EaseMob Technologies. All rights reserved. 
  *  
  * NOTICE: All information contained herein is, and remains 
  * the property of EaseMob Technologies.
  * Dissemination of this information or reproduction of this material 
  * is strictly forbidden unless prior written permission is obtained
  * from EaseMob Technologies.
  */


#import "ChatListCell.h"
#import "UIImageView+EMWebCache.h"
#import "NailSalonSwift-swift.h"
#import "ZXY_ArtistDetailModelBase.h"
#import "ZXY_ArtistDetailData.h"
@interface ChatListCell (){
    UILabel *_timeLabel;
    UILabel *_unreadLabel;
    UILabel *_detailLabel;
    UIView *_lineView;
    
    
}

@end

@implementation ChatListCell

- (id)initWithStyle:(UITableViewCellStyle)style
    reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        // Initialization code
        _timeLabel = [[UILabel alloc] initWithFrame:CGRectMake(self.frame.size.width - 80, 7, 80, 16)];
        _timeLabel.font = [UIFont systemFontOfSize:13];
        _timeLabel.backgroundColor = [UIColor clearColor];
        [self.contentView addSubview:_timeLabel];
        
        _unreadLabel = [[UILabel alloc] initWithFrame:CGRectMake(45, 0, 20, 20)];
        _unreadLabel.backgroundColor = [UIColor redColor];
        _unreadLabel.textColor = [UIColor whiteColor];
        
        _unreadLabel.textAlignment = NSTextAlignmentCenter;
        _unreadLabel.font = [UIFont systemFontOfSize:11];
        _unreadLabel.layer.cornerRadius = 10;
        _unreadLabel.clipsToBounds = YES;
        [self.contentView addSubview:_unreadLabel];
        
        _detailLabel = [[UILabel alloc] initWithFrame:CGRectMake(65, 30, 175, 20)];
        _detailLabel.backgroundColor = [UIColor clearColor];
        _detailLabel.font = [UIFont systemFontOfSize:15];
        _detailLabel.textColor = [UIColor lightGrayColor];
        [self.contentView addSubview:_detailLabel];
        
        self.textLabel.backgroundColor = [UIColor clearColor];
        
        _lineView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, self.contentView.frame.size.width, 1)];
        _lineView.backgroundColor = RGBACOLOR(207, 210, 213, 0.7);
        [self.contentView addSubview:_lineView];
    }
    return self;
}

- (void)awakeFromNib
{
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated
{
    [super setSelected:selected animated:animated];
    if (![_unreadLabel isHidden]) {
        _unreadLabel.backgroundColor = [UIColor redColor];
    }
}

-(void)setHighlighted:(BOOL)highlighted animated:(BOOL)animated{
    [super setHighlighted:highlighted animated:animated];
    if (![_unreadLabel isHidden]) {
        _unreadLabel.backgroundColor = [UIColor redColor];
    }
}

- (void)startDownLoadInfo
{
    NSString *stringURL = @"http://www.meijiab.cn/admin/index.php/Api/User/another_user_Info";

    NSDictionary *parameter = [NSDictionary dictionaryWithObjectsAndKeys:self.name,@"user_id", @"",@"my_user_id",  nil];
    __weak __typeof(self) weakSelf = self;
    [[ZXY_NetHelperOperate alloc] startGetDataPost:stringURL parameter:parameter successBlock:^(NSDictionary * returnDic) {
        self.baseData = [ZXY_ArtistDetailModelBase modelObjectWithDictionary:returnDic];
        self.dataUser = self.baseData.data;
        [weakSelf reLoadViewData];
    } failBlock:^(NSError * error) {
        
    }];
    
}

- (void)reLoadViewData
{
    NSString *imgURL = self.dataUser.headImage;
    imgURL = [NSString stringWithFormat:@"http://www.meijiab.cn/admin/%@",imgURL];
    if ([self.dataUser.headImage hasPrefix:@"http"])
    {
        imgURL = self.dataUser.headImage;
    }
    [self.imageView sd_setImageWithURL:[NSURL URLWithString:imgURL] placeholderImage:_placeholderImage];
    self.textLabel.text = self.dataUser.nickName;
}

-(void)layoutSubviews{
    [super layoutSubviews];
    CGRect frame = self.imageView.frame;
    
//    NSString *imgURL = dataUser.headImage;
//    imgURL = [NSString stringWithFormat:@"http://www.meijiab.cn/admin/%@",imgURL];
//    if ([dataUser.headImage hasPrefix:@"http"])
//    {
//        imgURL = dataUser.headImage;
//    }
//    [self.imageView sd_setImageWithURL:[NSURL URLWithString:@"imgURL"] placeholderImage:_placeholderImage];
//    self.textLabel.text = dataUser.nickName;
    self.imageView.frame = CGRectMake(10, 7, 45, 45);
    
    
    self.textLabel.frame = CGRectMake(65, 7, 175, 20);
    
    _detailLabel.text = _detailMsg;
    _timeLabel.text = _time;
    if (_unreadCount > 0) {
        if (_unreadCount < 9) {
            _unreadLabel.font = [UIFont systemFontOfSize:13];
        }else if(_unreadCount > 9 && _unreadCount < 99){
            _unreadLabel.font = [UIFont systemFontOfSize:12];
        }else{
            _unreadLabel.font = [UIFont systemFontOfSize:10];
        }
        [_unreadLabel setHidden:NO];
        [self.contentView bringSubviewToFront:_unreadLabel];
        _unreadLabel.text = [NSString stringWithFormat:@"%d",_unreadCount];
    }else{
        [_unreadLabel setHidden:YES];
    }
    
    frame = _lineView.frame;
    frame.origin.y = self.contentView.frame.size.height - 1;
    _lineView.frame = frame;
}

-(void)setName:(NSString *)name{
    _name = name;
    self.textLabel.text = name;
}

+(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 60;
}
@end
