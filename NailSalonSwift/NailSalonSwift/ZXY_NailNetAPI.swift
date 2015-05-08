//
//  ZXY_NailNetAPI.swift
//  NailSalonSwift
//
//  Created by 宇周 on 15/3/29.
//  Copyright (c) 2015年 宇周. All rights reserved.
//

import Foundation

/**
首页API

- Origin_MostNew: 最新图集
- Origin_MostHot: 最热图集
- Origin_Offer:   推荐（首页中间的一条CollectionView）
*/
enum ZXY_OriginAPI : String
{
    
    case Origin_MostNew = "Album2/album_last"
    
    case Origin_MostHot = "Album/album_hot"
    
    case Origin_Offer   = "Album/album_square"
    
}

/**
教程API

- CourseCategoryList: 教程分类
- CourseDetailList:   教程分类 -> 列表
- CourseDetail:       教程分类 -> 列表 -> 详细教程
- CourseUserStatus:   详细教程 -> 用户点赞状态
- CourseStart:        详细教程 -> 星星
- CourseCollect:      详细教程 -> 收藏
- CourseMyCollect:    我的收藏
*/
enum ZXY_MainCourseAPIType : Int
{
    case CourseCategoryList = 0
    case CourseDetailList
    case CourseDetail
    case CourseUserStatus
    case CourseStart
    case CourseCollect
    case CourseMyCollect
}

/**
用户页面API

- MI_Login:  用户登录接口
- MI_Regist: 用户注册接口
- MI_ThirdLogin: 第三方登陆
- MI_MyInfo: 获取用户信息接口
*/
enum ZXY_MyInfoAPIType : String
{
    case MI_Login   = "User/login"
    case MI_ThirdLogin = "User/third_login"
    case MI_Regist  = "User/register"
    case MI_MyInfo  = "User/userInfo"
}

enum ZXY_ADFPAPIType : String
{
    case ADFP_ArtDetail     = "Album2/album_detail"
    case ADFP_ArtComment    = "Album2/comment_list"
    case ADFP_ArtCommentAdd = "Album2/comment_add"
    case ADFP_ArtCollection = "Album/album_collect"
    case ADFP_ArtAgree      = "Album/album_agree"
    case ADFP_ArtAttension  = "User/attention"
    case ADPF_ArtistArts    = "UserList/my_album"
    case ADPF_ArtistComment = "UserList/order_evalue"
    case ADPF_ArtistDetailInfo = "User/another_user_Info"
    case SR_albumCollection    = "Album/album_my_collect"
}


enum SR_SearchAPIType : String
{
    case SR_SearchLabel  = "Album2/search_album"
    case SR_SearchUser = "UserList/user_list"
}

enum SR_AttentionAPIType : String
{
    case SR_Attention = "UserList2/attention_list"
    case SR_Fans      = "UserList2/attention_list2"
}

enum SR_OrderAPIType : String
{
    case SR_OrderList = "Order2/order_list"
    case SR_OrderAdd  = "Order/order_add"
    case SR_OrderDetail  = "Order/order_detail"
    case SR_ChangeOrderStatus = "Order2/change_order_status"
    case SR_CommentAdd = "Order/order_comment_add"
}

struct ZXY_NailNetAPI
{
    /**
    *  用于获取非图片数据的主要API
    */
    static let ZXY_MainAPI      = "http://www.meijiab.cn/admin/index.php/Api/"
    
    /**
    *  用于获取图片的主要HOST_Image_API
    */
    static let ZXY_MainAPIImage = "http://www.meijiab.cn/admin/"
    
    /**
    *  分享主要的URL 后跟 albumID值
    */
    static let ZXY_ShareMainAPI = "http://www.meijiab.cn/admin/index.php/Home/Home/index/album_id/"
    static let ZXY_ShareMainCourseAPI = "http://www.meijiab.cn/admin/index.php/Home/Home/course/course_id/"
    
    /**
    该方法用于返回首页的api
    
    :param: type 传入类型
    
    :returns: 根据类型给出相应的API
    */
    static func GiveMeOriginAPI(type : ZXY_OriginAPI) -> String
    {
        return ZXY_MainAPI + type.rawValue
    }
    
    /**
    教程的Api
    
    :param: currentType 接口类型
    
    :returns: 接口
    */
    static func ZXY_MainCourseAPI(currentType : ZXY_MainCourseAPIType) -> String
    {
        switch currentType
        {
        case .CourseCategoryList:
            return ZXY_MainAPI + "Course/index"
        case .CourseDetailList:
            return ZXY_MainAPI + "Course/getListByCategory"
        case .CourseDetail:
            return ZXY_MainAPI + "Course/getCourse"
        case .CourseUserStatus:
            return ZXY_MainAPI + "Course/userStatus"
        case .CourseStart:
            return ZXY_MainAPI + "Course/course_star"
        case .CourseCollect:
            return ZXY_MainAPI + "Course/course_collect"
        case .CourseMyCollect:
            return ZXY_MainAPI + "Course/my_collect_course"
        default :
            return ZXY_MainAPI + "Course/index"
        }
    }

    static func ZXY_MyInfoAPI(currentType: ZXY_MyInfoAPIType) -> String
    {
        return ZXY_MainAPI + currentType.rawValue
    }

    static func ZXY_ADFPAPI(currentType : ZXY_ADFPAPIType) -> String
    {
        return ZXY_MainAPI + currentType.rawValue
    }
    static func SR_AttentionAPI(currentType: SR_AttentionAPIType) -> String
    {
        return ZXY_MainAPI + currentType.rawValue
    }
    
    static func SR_SearchAPI(currentType: SR_SearchAPIType) -> String
    {
        return ZXY_MainAPI + currentType.rawValue
    }
    
    static func SR_OrderAPITpye(currentType : SR_OrderAPIType) -> String
    {
        return ZXY_MainAPI + currentType.rawValue
    }
}