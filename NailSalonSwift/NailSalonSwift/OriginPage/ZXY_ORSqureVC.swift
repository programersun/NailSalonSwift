//
//  ZXY_ORSqureVC.swift
//  NailSalonSwift
//
//  Created by 宇周 on 15/3/29.
//  Copyright (c) 2015年 宇周. All rights reserved.
//

import UIKit

enum SqureType : Int
{
    case SqureTypeHot = 0
    case SqureTypeNew = 1
}

class ZXY_ORSqureVC: UIViewController {

    @IBOutlet weak var tagSepLbl: UILabel!                       ///  最新、最火的按钮
    @IBOutlet weak var mainCollectionV: UICollectionView!        ///  当前collectionView
    
    
    private var currentPage : Int = 1                           ///  当前加载数据的页数
    var squreType : SqureType = SqureType.SqureTypeHot          ///  当前的类型 最火、最热
    var headerView : ZXY_ORSqureTitleView?
    var dataForTable : [ZXYOriginAlbumData]? = []               ///  collectionView 数据
    var dataForRec   : [ZXYOfferRecommendAlbum]? = []           ///  推荐数据
    var isRegist = false
    var isWaitingView = true
    var layout = CHTCollectionViewWaterfallLayout()
    var squreRecommendData: ZXYOfferOfferList?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        tagSepLbl.backgroundColor = UIColor.NailBlueColor()
        mainCollectionV.backgroundColor = UIColor.NailBackGrayColor()
        
        /// 一下两句代码用啦注册重用cell
        var nib = UINib(nibName: "ZXY_IndicatorCell", bundle: nil)
        mainCollectionV.registerNib(nib, forCellWithReuseIdentifier: ZXY_IndicatorCell.cellID())
        self.changeLayoutType(1)
        /**
        一下两句代码用来将最火最热标签变为圆形
        */
        tagSepLbl.layer.cornerRadius = 20
        tagSepLbl.layer.masksToBounds = true
        
        //上拉加载，下拉刷新
        self.addHeaderAndFooterforCollection()
        self.startInitLoadData()
        self.startLoadRecommandData() ///下载数据
        // Do any additional setup after loading the view.
    }

    private func changeLayoutType(columnNum : Int)
    {
        layout.headerHeight = 264
        layout.sectionInset = UIEdgeInsetsMake(10, 10, 10, 10);
        layout.minimumColumnSpacing = 10;
        layout.minimumInteritemSpacing = 10;
        layout.columnCount = columnNum
        mainCollectionV.setCollectionViewLayout(layout, animated: false)
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    /**
    为collectionView 增加上拉加载下拉刷新
    */
    private func addHeaderAndFooterforCollection()
    {
        mainCollectionV.addFooterWithCallback { [weak self]() -> Void in
            self?.currentPage++
            self?.startInitLoadData()
        }
        
        mainCollectionV.addHeaderWithCallback { [weak self] () -> Void in
            self?.currentPage = 1
            self?.startInitLoadData()
            self?.startLoadRecommandData()
        }
    }
    
    private func endFreshing()
    {
        mainCollectionV.footerEndRefreshing()
        mainCollectionV.headerEndRefreshing()
    }
    
    /**
    数据下载开始
    */
    func startInitLoadData() -> Void
    {
        var urlString = ZXY_NailNetAPI.GiveMeOriginAPI(ZXY_OriginAPI.Origin_MostHot)
        if(squreType == SqureType.SqureTypeNew)
        {
            urlString = ZXY_NailNetAPI.GiveMeOriginAPI(ZXY_OriginAPI.Origin_MostNew)
        }
        var parameter = ["p" : currentPage]
        // 开始下载
        ZXY_NetHelperOperate().startGetDataPost(urlString, parameter: parameter, successBlock: { [weak self](returnDic) -> Void in
            var baseData = ZXYOriginAlbumList(dictionary: returnDic)
            var resultID = baseData.result
            if(resultID == Double(1000))
            {
                if(self?.currentPage == 1)
                {
                    self?.dataForTable = []
                }
                var resultData = baseData.data
                /**
                *  此处一定要这样写，否则打包成ipa 会崩溃
                */
                for value in resultData
                {
                    var dataValue: ZXYOriginAlbumData = value as ZXYOriginAlbumData
                    self?.dataForTable?.append(dataValue)
                }
                self?.isWaitingView = false
                self?.changeLayoutType(2)
                self?.mainCollectionV.reloadData()
                self?.endFreshing()
            }
            else
            {
                var errorString = ZXY_ErrorMessageHandle.messageForErrorCode(resultID)
                self?.showAlertEasy("提示", messageContent: errorString)
                self?.endFreshing()
            }
        }) {[weak self] (error) -> Void in
            println(error)
            self?.showAlertEasy("提示", messageContent: "网络状况不好，请稍后重试")
            ""
        }
    }
    
    func startLoadRecommandData()
    {
        var urlString = ZXY_NailNetAPI.GiveMeOriginAPI(ZXY_OriginAPI.Origin_Offer)
        ZXY_NetHelperOperate().startGetDataPost(urlString, parameter: nil, successBlock: {[weak self] (returnDic) -> Void in
            
            self?.squreRecommendData = ZXYOfferOfferList(dictionary: returnDic)
            var baseData             = ZXYOfferOfferList(dictionary: returnDic)
            self?.mainCollectionV.reloadData()
            ""
            var resultID = baseData.result
            if(resultID == Double(1000))
            {
                self?.dataForRec = []
                var recData = baseData.data.recommendAlbum
                for value in recData
                {
                    var dataValue: ZXYOfferRecommendAlbum = value as ZXYOfferRecommendAlbum
                    self?.dataForRec?.append(dataValue)
                }
                self?.mainCollectionV.reloadData()
            }
            else
            {
                var errorString = ZXY_ErrorMessageHandle.messageForErrorCode(resultID)
                self?.showAlertEasy("提示", messageContent: errorString)
            }

            
        }) { [weak self](error) -> Void in
            self?.showAlertEasy("提示", messageContent: "网络状况不好，请稍后重试")
            ""
        }
    }

    /**
    最新与最热之间的切换 事件
    
    :param: sender tap
    */
    @IBAction func tapTagToChange(sender: AnyObject)
    {
        currentPage = 1
        if(squreType == SqureType.SqureTypeNew)
        {
            squreType = SqureType.SqureTypeHot
            tagSepLbl.text = "最新"
            tagSepLbl.backgroundColor = UIColor.NailBlueColor()
        }
        else
        {
            squreType = SqureType.SqureTypeNew
            tagSepLbl.text = "最热"
            tagSepLbl.backgroundColor = UIColor.NailRedColor()
        }
        self.changeLayoutType(1)
        isWaitingView = true
        mainCollectionV.reloadData()
        self.startInitLoadData()
    }
    
    
    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}

extension ZXY_ORSqureVC : UICollectionViewDataSource , UICollectionViewDelegate, CHTCollectionViewDelegateWaterfallLayout
{
    func collectionView(collectionView: UICollectionView, cellForItemAtIndexPath indexPath: NSIndexPath) -> UICollectionViewCell {
        if(isWaitingView)
        {
            var cell = collectionView.dequeueReusableCellWithReuseIdentifier(ZXY_IndicatorCell.cellID(), forIndexPath: indexPath) as ZXY_IndicatorCell
            cell.startAnimation()
            return cell
            
        }
        var cell = collectionView.dequeueReusableCellWithReuseIdentifier(ZXY_ORSqureMainCCell.cellID(), forIndexPath: indexPath) as ZXY_ORSqureMainCCell
        var currentData = dataForTable?[indexPath.row]
        var currentImg  = currentData?.image?.cutPath?
        var currentUser = currentData?.user
        cell.artistAva.layer.cornerRadius = 20
        cell.artistAva.layer.masksToBounds = true
        if(currentImg != nil )
        {
            var imgURL = ZXY_NailNetAPI.ZXY_MainAPIImage + currentImg!
            cell.artImg.setImageWithURL(NSURL(string: imgURL), placeholderImage: UIImage(named: "imgHolder"))
        }
        
        cell.artDoLike.text      = currentData?.agreeCount
        cell.artDoLike.textColor = UIColor.NailRedColor()
        cell.artTitle.textColor  = UIColor.NailGrayColor()
        cell.artTitle.text       = currentData?.dataDescription
        
        if(currentUser?.role == "1")
        {
            cell.isArtImg.hidden  = true
            cell.isArtName.hidden = true
        }
        else
        {
            cell.isArtImg.hidden  = false
            cell.isArtName.hidden = false
            cell.isArtName.textColor = UIColor.NailGrayColor()
            cell.isArtImg.backgroundColor = UIColor.NailRedColor()
        }
        
        cell.artName.text = currentUser?.nickName
        cell.artName.textColor = UIColor.NailGrayColor()
        var avataURL      = currentUser?.headImage?
        if let aVA = avataURL
        {
            var headURL = ZXY_NailNetAPI.ZXY_MainAPIImage + aVA
            if(aVA.hasPrefix("http"))
            {
                headURL = aVA
            }
            //cell.artistAva.setImageWithURL(NSURL(string: headURL))
            cell.artistAva.setImageWithURL(NSURL(string: headURL), placeholderImage: UIImage(named: "headerHolder"))
        }
        cell.layer.cornerRadius  = 5
        //cell.layer.borderWidth   = 1
        var path = UIBezierPath(rect: cell.bounds)
        cell.layer.shadowOpacity = 0.7
        cell.layer.masksToBounds = false
        cell.layer.shadowOffset  = CGSizeMake(1, 1)
        cell.layer.shadowColor   = UIColor.darkGrayColor().CGColor
        cell.layer.shadowPath    = path.CGPath
        cell.layer.shadowRadius  = 3
        cell.layerView.layer.cornerRadius = 5
        cell.layerView.layer.masksToBounds = true
        return cell
    }
    
    func collectionView(collectionView: UICollectionView, viewForSupplementaryElementOfKind kind: String, atIndexPath indexPath: NSIndexPath) -> UICollectionReusableView {
        var screenSize = UIScreen.mainScreen().bounds
        var nib = UINib(nibName: "ZXY_ORSqureTitleView", bundle: nil)
        collectionView.registerNib(nib, forSupplementaryViewOfKind: kind, withReuseIdentifier: ZXY_ORSqureTitleView.cellID())
        var reView = collectionView.dequeueReusableSupplementaryViewOfKind(kind, withReuseIdentifier: ZXY_ORSqureTitleView.cellID(), forIndexPath: indexPath) as? ZXY_ORSqureTitleView
        headerView = reView
        reView?.offerDataList = dataForRec
        reView?.subCollectionV.reloadData()
        return reView!
    }
    
    func collectionView(collectionView: UICollectionView, didSelectItemAtIndexPath indexPath: NSIndexPath) {
        
    }
    
    func numberOfSectionsInCollectionView(collectionView: UICollectionView) -> Int {
        
        return 1
    }
    
    func collectionView(collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        if(isWaitingView)
        {
            return 1
        }
        if let datas = dataForTable
        {
            return datas.count
        }
        else
        {
            return 1
        }
    }
    
    func collectionView(collectionView: UICollectionView!, layout collectionViewLayout: UICollectionViewLayout!, sizeForItemAtIndexPath indexPath: NSIndexPath!) -> CGSize {
        
        if(isWaitingView)
        {
            return CGSizeMake(UIScreen.mainScreen().bounds.width - 20, 100)
        }
        var currentData = dataForTable?[indexPath.row]
        var width       = (currentData!.image.cutWidth as NSString).floatValue
        var height      = (currentData!.image.cutHeight as NSString).floatValue
        var radio       = height / width
        var screenWidths = self.view.frame.size.width / 2 - 15
        var imgRealHeight = CGFloat(radio) * screenWidths
        return CGSizeMake(screenWidths, imgRealHeight + 83)

        
    }
}


