//
//  KATURIParser.swift
//  SwiftRouter
//
//  Created by 吕陈强 on 2018/4/3.
//  Copyright © 2018年 吕陈强. All rights reserved.
//

import UIKit

//URI例: https://kat@kantice.com:80/path?id=1&name=k#frag
// scheme://user@host:80/path?query#fragment


class KATURIParser: NSObject {
    class func  parseURI(uri:String) -> NSDictionary{
        var uri_info = "";
        var dic = NSDictionary();
        
        if(uri.length > 0){ /// 处理拿到的uri
            uri_info = uri.replacingOccurrences(of: " ", with: ""); // 去掉空格
            
            
            
        }
        
        
        
        
        
        return dic;
    }
}
