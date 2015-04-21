//
//  ZXY_ALLApi.swift
//  KickYourAss
//
//  Created by 宇周 on 15/1/21.
//  Copyright (c) 2015年 宇周. All rights reserved.
//

import Foundation
/**
*  周效宇的API接口 书写格式请按照ZXY_NailNetAPI.swift书写
*/

//enum ZXY_MainCourseAPIType : Int
//{
//    case CourseCategoryList = 0
//    case CourseDetailList
//    case CourseDetail
//    case CourseUserStatus
//    case CourseStart
//    case CourseCollect
//    case CourseMyCollect
//}
struct ZXY_ALLApi
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
    *  搜索页面 ： 用户列表相关API
    */
    static let ZXY_SearchListAPI = "UserList/user_list"
    
    /**
    *  获取首页部分最热的API
    */
    static let ZXY_AlbumHotAPI              = "Album/album_hot"
    
    /**
    *  获取广场数据 API
    */
    static let ZXY_AlbumSquAPI              = "Album/album_square"
    
    /**
    *  美甲师列表接口API
    */
    static let ZXY_UserListAPI              = "UserList/tech_list"
    
    /**
    *  获取用户详细信息
    */
    static let ZXY_UserInfoAPI = "User/another_user_Info"
    
    /**
    *  获取用户的图集API
    */
    static let ZXY_UserAlbumAPI = "UserList/my_album"
    
    /**
    *  获取用户的评价
    */
    static let ZXY_UserCommentAPI = "UserList/order_evalue"
    
    /**
    *  获取图片详情
    */
    static let ZXY_AlbumDetailAPI = "Album/album_detail"
    
    /**
    *  更改用户的关注状态
    */
    static let ZXY_ChangeStatusAtten = "User/attention"
    
    /**
    *  更改用户的点赞状态
    */
    static let ZXY_ChangeStatusFavor = "Album/album_agree"
    
    /**
    *  更改用户的收藏状态
    */
    static let ZXY_ChangeStatusCollec = "Album/album_collect"
    
    /**
    *  添加图集
    */
    static let ZXY_SubmitAlbumAPI     = "Album/add_album"
    
    /**
    *  删除图集
    */
    static let ZXY_DeleteAlbumAPI     = "Album/album_delete"
    
    /**
    *  修改图集描述信息
    */
    static let ZXY_ModifyAlbumAPI     = "Album/modify_content"
    
    /**
    *  增加订单
    */
    static let ZXY_AddOrderAPI        = "Order/order_add"
    
    /**
    *  修改用户头像
    */
    static let ZXY_ChangeProfileAPI   = "User/modifyHeadImage"
    
    /**
    *  修改用户基本信息
    */
    static let ZXY_ChangeInfoAPI      = "User/modifyUserInfo"
    
    /**
    *  修改密码
    */
    static let ZXY_ChangePassWordAPI  = "User/rePass"
    

//    /**
//    教程的Api
//    
//    :param: currentType 接口类型
//    
//    :returns: 接口
//    */
//    static func ZXY_MainCourseAPI(currentType : ZXY_MainCourseAPIType) -> String
//    {
//        switch currentType
//        {
//        case .CourseCategoryList:
//            return "Course/index"
//        case .CourseDetailList:
//            return "Course/getListByCategory"
//        case .CourseDetail:
//            return "Course/getCourse"
//        case .CourseUserStatus:
//            return "Course/userStatus"
//        case .CourseStart:
//            return "Course/course_star"
//        case .CourseCollect:
//            return "Course/course_collect"
//        case .CourseMyCollect:
//            return "Course/my_collect_course"
//        default :
//            return "Course/index"
//        }
//    }
}