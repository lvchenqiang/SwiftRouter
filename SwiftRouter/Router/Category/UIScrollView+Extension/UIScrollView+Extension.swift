//
//  UIScrollView+Extension.swift
//  SwiftRouter
//
//  Created by 吕陈强 on 2018/3/27.
//  Copyright © 2018年 吕陈强. All rights reserved.
//

import Foundation
import UIKit

public enum RefreshBlockingType {
    case none
    case loadNewData
    case loadMoreData
}

/*
 刷新结果回调
 */
typealias RefreshBlocking = (_ refreshType:RefreshBlockingType) -> ()


extension UIScrollView{
    private struct AssociatedKeys {
        static var lv_header_refresh = "lv_header_refresh"
        static var lv_footer_refresh = "lv_footer_refresh"
        static var lv_refresh_block  = "lv_refresh_block"
    }
    
    
    fileprivate var refreshBlocking:RefreshBlocking?{
        
        get {
            return (objc_getAssociatedObject(self, &AssociatedKeys.lv_refresh_block) as? RefreshBlocking) ?? nil
            
        }
        
        set{
            objc_setAssociatedObject(self, &AssociatedKeys.lv_refresh_block, newValue, objc_AssociationPolicy.OBJC_ASSOCIATION_COPY)
        }
        
    }
    
    
    fileprivate  var isRefreshHeader:Bool{
        
        get {
            return (objc_getAssociatedObject(self, &AssociatedKeys.lv_header_refresh) as? Bool) ?? false
        }
        
        set{
            objc_setAssociatedObject(self, &AssociatedKeys.lv_header_refresh, newValue, objc_AssociationPolicy.OBJC_ASSOCIATION_ASSIGN)
            setupRefreshHeader()
            
        }
        
    }
    
    
    fileprivate  var isRefreshFooter:Bool{
        
        get {
            return (objc_getAssociatedObject(self, &AssociatedKeys.lv_footer_refresh) as? Bool) ?? false
        }
        set{
            objc_setAssociatedObject(self, &AssociatedKeys.lv_footer_refresh, newValue, objc_AssociationPolicy.OBJC_ASSOCIATION_ASSIGN)
            setupRefreshFooter()
        }
        
    }
    
    //MARK:-设置刷新头部
    fileprivate func setupRefreshHeader(){
        
        if(self.isRefreshHeader){//头部刷新
//            self.mj_header = MJRefreshNormalHeader(refreshingBlock: {[unowned self] in
//                if(self.refreshBlocking != nil){
//                    self.refreshBlocking!(RefreshBlockingType.loadNewData);
//                }
//
//            });
        }else{
//            self.mj_header = nil;
        }
    }
    
    //设置刷新尾部
    fileprivate func setupRefreshFooter(){
        if(self.isRefreshFooter){
//            self.mj_footer = MJRefreshBackNormalFooter(refreshingBlock: { [unowned self] in
//
//                if(self.refreshBlocking != nil){
//                    self.refreshBlocking!(RefreshBlockingType.loadMoreData);
//                }
//
//            })
        }else{
//            self.mj_footer = nil;
        }
    }
    
    
    //MARK:-结束刷新
    func endAllRefresh(){
        if(self.isRefreshFooter){
//            self.mj_footer.endRefreshing();
        }
        if(self.isRefreshHeader){
//            self.mj_header.endRefreshing()
        }
    }
    
    func setupRefreshBlocking(refreshHeader:Bool=true,refreshFooter:Bool=true, _ _refreshBlockiing:@escaping RefreshBlocking){

        self.isRefreshHeader = refreshHeader;
        self.isRefreshFooter = refreshFooter;
        self.refreshBlocking = _refreshBlockiing;
        
    }
    
    
    
}
