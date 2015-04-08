//
//  ZXY_LocationRelative.swift
//  KickYourAss
//
//  Created by 宇周 on 15/1/26.
//  Copyright (c) 2015年 宇周. All rights reserved.
//

import UIKit
import MapKit


typealias ZXY_LocationRelativeFailureBlock = (errorMessage : String) -> Void
typealias ZXY_LocationRelativeSuccessBlock = (location : BMKUserLocation) -> Void
private let _locationR = ZXY_LocationRelative()



class ZXY_LocationRelative: NSObject {
    
    var failureBlock : ZXY_LocationRelativeFailureBlock?
    var successBlock : ZXY_LocationRelativeSuccessBlock?
    
    private var previousTimeStamp : NSTimeInterval = 0
    
    private let locationService : BMKLocationService = BMKLocationService()
    private let locationGeo     : BMKGeoCodeSearch   = BMKGeoCodeSearch()
    
    
    private var currentUserLocation : BMKUserLocation?
    private var currentLocationInfo : BMKReverseGeoCodeResult?
    
    class var  sharedInstance: ZXY_LocationRelative
    {
        return _locationR
    }
    
    func startLocateUserPosition()
    {
        locationService.delegate = self
        locationService.startUserLocationService()
        locationGeo.delegate = self
        
    }
    
    func sendLocationToEveryBody() -> CLLocation?
    {
        return currentUserLocation?.location
    }
    
    func sendCityNameToEveryBody() -> BMKReverseGeoCodeResult?
    {
        return currentLocationInfo
    }
    
}

extension ZXY_LocationRelative : BMKLocationServiceDelegate , BMKGeoCodeSearchDelegate
{
    func didUpdateBMKUserLocation(userLocation: BMKUserLocation!) {
        currentUserLocation = userLocation
        var currentTimeStamp = NSTimeIntervalSince1970
        if(currentTimeStamp - previousTimeStamp > 5)
        {
            if successBlock != nil
            {
                successBlock!(location: currentUserLocation!)
            }
            var geoOption  = BMKReverseGeoCodeOption()
            geoOption.reverseGeoPoint = userLocation.location.coordinate
            var flag : Bool = locationGeo.reverseGeoCode(geoOption)
            if(flag)
            {
                previousTimeStamp = currentTimeStamp
            }
            else
            {
                previousTimeStamp = 0
            }
        }
    }
    
    func didFailToLocateUserWithError(error: NSError!) {
        var failMessage = ""
        switch error.code
        {
        case CLError.Denied.rawValue :
            self.failureBlock?(errorMessage: "请在权限设置中开启定位功能")
        case CLError.Network.rawValue:
            self.failureBlock?(errorMessage: "请连接网络")
        default:
            return
        }
    }
    
    func onGetReverseGeoCodeResult(searcher: BMKGeoCodeSearch!, result: BMKReverseGeoCodeResult!, errorCode error: BMKSearchErrorCode) {
        if(error.value == BMK_SEARCH_NO_ERROR.value)
        {
            var cityName = result.addressDetail.city
            ZXY_UserInfoDetail.sharedInstance.setUserCityName(cityName)
        }
        currentLocationInfo = result
        previousTimeStamp = NSTimeIntervalSince1970
        
    }
}

extension ZXY_LocationRelative
{
    func gpsToBD(gpsCoor: CLLocationCoordinate2D) -> CLLocationCoordinate2D
    {
        var BDCoorBase = BMKConvertBaiduCoorFrom(gpsCoor, BMK_COORDTYPE_GPS)
        var BDCoorDe   = BMKCoorDictionaryDecode(BDCoorBase)
        return BDCoorDe
    }
    

}
