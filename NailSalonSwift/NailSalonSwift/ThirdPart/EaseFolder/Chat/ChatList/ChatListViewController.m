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

#import "ChatListViewController.h"
#import "SRRefreshView.h"
#import "ChatListCell.h"
#import "EMSearchBar.h"
#import "NSDate+Category.h"
#import "RealtimeSearchUtil.h"
#import "ChatViewController.h"
#import "EMSearchDisplayController.h"
#import "ConvertToCommonEmoticonsHelper.h"
#import "ArtistList.h"
#import "NailSalonSwift-swift.h"
@interface ChatListViewController ()<UITableViewDelegate,UITableViewDataSource, UISearchDisplayDelegate,SRRefreshDelegate, UISearchBarDelegate, IChatManagerDelegate>

@property (strong, nonatomic) NSMutableArray        *dataSource;

@property (strong, nonatomic) UITableView           *tableView;
@property (nonatomic, strong) SRRefreshView         *slimeView;
@property (nonatomic, strong) UIView                *networkStateView;
@property (nonatomic , strong) NSString             *mainImgURL;
@property (assign) CGRect originalFrame;
//@property (strong, nonatomic) EMSearchDisplayController *searchController;

@end

@implementation ChatListViewController

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        _dataSource = [NSMutableArray array];
        self.mainImgURL = @"http://www.meijiab.cn/admin/";
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    //[self.view addSubview:self.searchBar];
    [self.view addSubview:self.tableView];
    [self.tableView addSubview:self.slimeView];
    [self networkStateView];
    [self setNaviBarLeftImage:@"backArrow"];
    self.view.backgroundColor = [UIColor blueColor];
    [self userAutoLayout];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
}

-(void)viewWillAppear:(BOOL)animated
{
    self.navigationController.navigationBar.hidden = NO;
    [super viewWillAppear:animated];
//    [self setHidesBottomBarWhenPushed:YES];
    self.originalFrame = self.tabBarController.tabBar.frame;
    self.tabBarController.tabBar.hidden = YES;
    //self.tabBarController.tabBar.frame  = CGRectMake(0, self.view.window.bounds.size.height, self.view.window.bounds.size.width, self.tabBarController.tabBar.frame.size.height);
    [self refreshDataSource];
    [self registerNotifications];
    
}

-(void)viewWillDisappear:(BOOL)animated
{
    //self.navigationController.navigationBar.hidden = YES;
    //self.tabBarController.tabBar.hidden = NO;
    
    [super viewWillDisappear:animated];
    [self unregisterNotifications];
}

- (void)leftNaviButtonAction
{
    self.tabBarController.tabBar.hidden = false;
    //self.tabBarController.tabBar.frame  = self.originalFrame;
    [self.navigationController popViewControllerAnimated:YES];
}

- (void)userAutoLayout
{
    self.tableView.translatesAutoresizingMaskIntoConstraints = NO;
    self.view.autoresizesSubviews = YES;
    self.view.clipsToBounds = NO;
    self.tableView.autoresizesSubviews = YES;
    [self.view addConstraint:[NSLayoutConstraint constraintWithItem:self.view attribute:NSLayoutAttributeBottom relatedBy:NSLayoutRelationEqual toItem:self.tableView attribute:NSLayoutAttributeBottom multiplier:1 constant:-45]];
    
    [self.view addConstraint:[NSLayoutConstraint constraintWithItem:self.view attribute:NSLayoutAttributeLeading relatedBy:NSLayoutRelationEqual toItem:self.tableView attribute:NSLayoutAttributeLeading multiplier:1 constant:0]];
    
    [self.view addConstraint:[NSLayoutConstraint constraintWithItem:self.view attribute:NSLayoutAttributeTop relatedBy:NSLayoutRelationEqual toItem:self.tableView attribute:NSLayoutAttributeTop multiplier:1 constant:0]];
    
    
    [self.view addConstraint:[NSLayoutConstraint constraintWithItem:self.view attribute:NSLayoutAttributeTrailing relatedBy:NSLayoutRelationEqual toItem:self.tableView attribute:NSLayoutAttributeTrailing multiplier:1 constant:0]];
    
}

#pragma mark - getter

- (SRRefreshView *)slimeView
{
    if (!_slimeView) {
        _slimeView = [[SRRefreshView alloc] init];
        _slimeView.delegate = self;
        _slimeView.upInset = 0;
        _slimeView.slimeMissWhenGoingBack = YES;
        _slimeView.slime.bodyColor = [UIColor grayColor];
        _slimeView.slime.skinColor = [UIColor grayColor];
        _slimeView.slime.lineWith = 1;
        _slimeView.slime.shadowBlur = 4;
        _slimeView.slime.shadowColor = [UIColor grayColor];
        _slimeView.backgroundColor = [UIColor whiteColor];
    }
    
    return _slimeView;
}


- (UITableView *)tableView
{
    if (_tableView == nil) {
        _tableView = [[UITableView alloc] initWithFrame:CGRectMake(0, 0, self.view.frame.size.width, self.view.frame.size.height ) style:UITableViewStylePlain];
        
        _tableView.backgroundColor = [UIColor whiteColor];
        //_tableView.autoresizingMask = UIViewAutoresizingFlexibleHeight;
        _tableView.delegate = self;
        _tableView.dataSource = self;
        _tableView.tableFooterView = [[UIView alloc] init];
        _tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
        [_tableView registerClass:[ChatListCell class] forCellReuseIdentifier:@"chatListCell"];
    }
    
    return _tableView;
}


- (UIView *)networkStateView
{
    if (_networkStateView == nil) {
        _networkStateView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, self.tableView.frame.size.width, 44)];
        _networkStateView.backgroundColor = [UIColor colorWithRed:255 / 255.0 green:199 / 255.0 blue:199 / 255.0 alpha:0.5];
        
        UIImageView *imageView = [[UIImageView alloc] initWithFrame:CGRectMake(10, (_networkStateView.frame.size.height - 20) / 2, 20, 20)];
        imageView.image = [UIImage imageNamed:@"messageSendFail"];
        [_networkStateView addSubview:imageView];
        
        UILabel *label = [[UILabel alloc] initWithFrame:CGRectMake(CGRectGetMaxX(imageView.frame) + 5, 0, _networkStateView.frame.size.width - (CGRectGetMaxX(imageView.frame) + 15), _networkStateView.frame.size.height)];
        label.font = [UIFont systemFontOfSize:15.0];
        label.textColor = [UIColor grayColor];
        label.backgroundColor = [UIColor clearColor];
        label.text = NSLocalizedString(@"network.disconnection", @"Network disconnection");
        [_networkStateView addSubview:label];
    }
    
    return _networkStateView;
}

#pragma mark - private

- (NSMutableArray *)loadDataSource
{
    NSMutableArray *ret = nil;
    NSArray *conversations = [[EaseMob sharedInstance].chatManager conversations];
    NSArray* sorte = [conversations sortedArrayUsingComparator:
           ^(EMConversation *obj1, EMConversation* obj2){
               EMMessage *message1 = [obj1 latestMessage];
               EMMessage *message2 = [obj2 latestMessage];
               if(message1.timestamp > message2.timestamp) {
                   return(NSComparisonResult)NSOrderedAscending;
               }else {
                   return(NSComparisonResult)NSOrderedDescending;
               }
           }];
    ret = [[NSMutableArray alloc] initWithArray:sorte];
    return ret;
}

// 得到最后消息时间
-(NSString *)lastMessageTimeByConversation:(EMConversation *)conversation
{
    NSString *ret = @"";
    EMMessage *lastMessage = [conversation latestMessage];;
    if (lastMessage) {
        ret = [NSDate formattedTimeFromTimeInterval:lastMessage.timestamp];
    }
    
    return ret;
}

// 得到未读消息条数
- (NSInteger)unreadMessageCountByConversation:(EMConversation *)conversation
{
    NSInteger ret = 0;
    ret = conversation.unreadMessagesCount;
    
    return  ret;
}

// 得到最后消息文字或者类型
-(NSString *)subTitleMessageByConversation:(EMConversation *)conversation
{
    NSString *ret = @"";
    EMMessage *lastMessage = [conversation latestMessage];
    if (lastMessage) {
        id<IEMMessageBody> messageBody = lastMessage.messageBodies.lastObject;
        switch (messageBody.messageBodyType) {
            case eMessageBodyType_Image:{
                ret = NSLocalizedString(@"message.image1", @"[image]");
            } break;
            case eMessageBodyType_Text:{
                // 表情映射。
                NSString *didReceiveText = [ConvertToCommonEmoticonsHelper
                                            convertToSystemEmoticons:((EMTextMessageBody *)messageBody).text];
                ret = didReceiveText;
            } break;
            case eMessageBodyType_Voice:{
                ret = NSLocalizedString(@"message.voice1", @"[voice]");
            } break;
            case eMessageBodyType_Location: {
                ret = NSLocalizedString(@"message.location1", @"[location]");
            } break;
            case eMessageBodyType_Video: {
                ret = NSLocalizedString(@"message.vidio1", @"[vidio]");
            } break;
            default: {
            } break;
        }
    }
    
    return ret;
}

#pragma mark - TableViewDelegate & TableViewDatasource

-(UITableViewCell *)tableView:(UITableView *)tableView
        cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    static NSString *identify = @"chatListCell";
    ChatListCell *cell = [tableView dequeueReusableCellWithIdentifier:identify];
    
    if (!cell) {
        cell = [[ChatListCell alloc] initWithStyle:UITableViewCellStyleValue1 reuseIdentifier:identify];
    }
    EMConversation *conversation = [self.dataSource objectAtIndex:indexPath.row];

    ZXY_DataProvider *provider   = [[ZXY_DataProvider alloc] init];
    ArtistList *currentArt = [provider fetchArt:conversation.chatter];
    if(currentArt != nil)
    {
        
        cell.name = currentArt.artistName;
        NSString *stringURL = [NSString stringWithFormat:@"%@%@",self.mainImgURL,currentArt.artistImg];
        if([currentArt.artistImg hasPrefix:@"http"])
        {
            stringURL = currentArt.artistImg;
        }
        cell.imageURL = [NSURL URLWithString:stringURL];
    }
    else
    {
        cell.name = conversation.chatter;
        cell.placeholderImage = [UIImage imageNamed:@"chatListCellHead.png"];
    }
    
    
    
    cell.detailMsg = [self subTitleMessageByConversation:conversation];
    cell.time = [self lastMessageTimeByConversation:conversation];
    cell.unreadCount = [self unreadMessageCountByConversation:conversation];
    if (indexPath.row % 2 == 1) {
        cell.contentView.backgroundColor = RGBACOLOR(246, 246, 246, 1);
    }else{
        cell.contentView.backgroundColor = [UIColor whiteColor];
    }
    return cell;
}

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return  self.dataSource.count;
}

-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    return [ChatListCell tableView:tableView heightForRowAtIndexPath:indexPath];
}

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    
    EMConversation *conversation = [self.dataSource objectAtIndex:indexPath.row];
    
    ChatViewController *chatController;
    NSString *title = conversation.chatter;
    if (conversation.isGroup) {
        NSArray *groupArray = [[EaseMob sharedInstance].chatManager groupList];
        for (EMGroup *group in groupArray) {
            if ([group.groupId isEqualToString:conversation.chatter]) {
                title = group.groupSubject;
                break;
            }
        }
    }
    
    NSString *chatter = conversation.chatter;
    ZXY_DataProvider *provider   = [[ZXY_DataProvider alloc] init];
    ArtistList *currentArt = [provider fetchArt:conversation.chatter];
    chatController = [[ChatViewController alloc] initWithChatter:chatter isGroup:conversation.isGroup];
    chatController.title = title;
    chatController.shouleEx = YES;
    if(currentArt != nil)
    {
        chatController.title = currentArt.artistName;
        NSString *stringURL = [NSString stringWithFormat:@"%@%@",self.mainImgURL,currentArt.artistImg];
        if([currentArt.artistImg hasPrefix:@"http"])
        {
            stringURL = currentArt.artistImg;
        }
        chatController.imgURLTo = stringURL;
//        [[LCYCommon sharedInstance] getUserDetailInfo:^(CYMJUserInfoData *hello) {
//            NSString *stringURLMe = [NSString stringWithFormat:@"%@%@",self.mainImgURL,hello.headImage];
//            chatController.imgURLMy = stringURLMe;
//        } failBlock:^{
//            
//        }];
        
        
    }
    
    [self.navigationController pushViewController:chatController animated:YES];
}

-(BOOL)tableView:(UITableView *)tableView canEditRowAtIndexPath:(NSIndexPath *)indexPath{
    return YES;
}

- (void)tableView:(UITableView *)tableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(NSIndexPath *)indexPath {
    
    if (editingStyle == UITableViewCellEditingStyleDelete) {
        EMConversation *converation = [self.dataSource objectAtIndex:indexPath.row];
        [[EaseMob sharedInstance].chatManager removeConversationByChatter:converation.chatter deleteMessages:YES];
        [self.dataSource removeObjectAtIndex:indexPath.row];
        [self.tableView deleteRowsAtIndexPaths:[NSArray arrayWithObject:indexPath] withRowAnimation:UITableViewRowAnimationFade];
    }
}


#pragma mark - UISearchBarDelegate

- (BOOL)searchBarShouldBeginEditing:(UISearchBar *)searchBar
{
    [searchBar setShowsCancelButton:YES animated:YES];
    
    return YES;
}


- (BOOL)searchBarShouldEndEditing:(UISearchBar *)searchBar
{
    return YES;
}

- (void)searchBarSearchButtonClicked:(UISearchBar *)searchBar
{
    [searchBar resignFirstResponder];
}

- (void)searchBarCancelButtonClicked:(UISearchBar *)searchBar
{
    searchBar.text = @"";
    [[RealtimeSearchUtil currentUtil] realtimeSearchStop];
    [searchBar resignFirstResponder];
    [searchBar setShowsCancelButton:NO animated:YES];
}

#pragma mark - scrollView delegate
- (void)scrollViewDidScroll:(UIScrollView *)scrollView
{
    [_slimeView scrollViewDidScroll];
}

- (void)scrollViewDidEndDragging:(UIScrollView *)scrollView willDecelerate:(BOOL)decelerate
{
    [_slimeView scrollViewDidEndDraging];
}

#pragma mark - slimeRefresh delegate
//刷新消息列表
- (void)slimeRefreshStartRefresh:(SRRefreshView *)refreshView
{
    [self refreshDataSource];
    [_slimeView endRefresh];
}

#pragma mark - IChatMangerDelegate

-(void)didUnreadMessagesCountChanged
{
    [self refreshDataSource];
}

- (void)didUpdateGroupList:(NSArray *)allGroups error:(EMError *)error
{
    [self refreshDataSource];
}

#pragma mark - registerNotifications
-(void)registerNotifications{
    [self unregisterNotifications];
    [[EaseMob sharedInstance].chatManager addDelegate:self delegateQueue:nil];
}

-(void)unregisterNotifications{
    [[EaseMob sharedInstance].chatManager removeDelegate:self];
}

- (void)dealloc{
    [self unregisterNotifications];
}

#pragma mark - public

-(void)refreshDataSource
{
    self.dataSource = [self loadDataSource];
    [_tableView reloadData];
    [self hideHud];
}

- (void)isConnect:(BOOL)isConnect{
    if (!isConnect) {
        _tableView.tableHeaderView = _networkStateView;
    }
    else{
        _tableView.tableHeaderView = nil;
    }

}

//- (void)networkChanged:(EMConnectionState)connectionState
//{
//    if (connectionState == eEMConnectionDisconnected) {
//        _tableView.tableHeaderView = _networkStateView;
//    }
//    else{
//        _tableView.tableHeaderView = nil;
//    }
//}

- (void)willReceiveOfflineMessages{
    NSLog(NSLocalizedString(@"message.beginReceiveOffine", @"Begin to receive offline messages"));
}

- (void)didFinishedReceiveOfflineMessages:(NSArray *)offlineMessages{
    NSLog(NSLocalizedString(@"message.endReceiveOffine", @"End to receive offline messages"));
    [self refreshDataSource];
}

@end
