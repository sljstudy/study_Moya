//
//  DSApi.swift
//  study_Moya 逗视API
//
//  Created by 宋立君 on 15/12/29.
//  Copyright © 2015年 宋立君. All rights reserved.
//

/**
*  DS 逗视API
*/

import Foundation
import Moya

// MARK: - Provider setup
let DSProvider = MoyaProvider<DS>()


/**
 
  MARK: 创建DS 请求
 - GetVideosByType  根据类型获取视频列表 
 */
public enum DS {
    case GetVideosByType(Int,Int,Int,Int) //根据类型获取视频列表
}


extension DS: TargetType {
    // 逗视API地址
    public var baseURL: NSURL { return NSURL(string: "https://api.doushi.me/v1/rest/video/")! }
    
    /// 拼接请求字符串
    public var path: String {
        switch self {
        case .GetVideosByType(let vid, let count, let type,let userId):
            return ("getVideosByType/\(vid)/\(count)/\(type)/\(userId)")
        }
    }
    /// 请求方法
    public var method: Moya.Method {
        return .GET
    }
    
    /// 配置参数
    public var parameters: [String: AnyObject]? {
        switch self {
            
        default:
            return nil
        }
    }
    
    /// 数据
    public var sampleData: NSData {
        switch self {
        case .GetVideosByType:
            return "Half measures are as bad as nothing at all.".dataUsingEncoding(NSUTF8StringEncoding)!
        }
    }

    
}

//public func url(route: TargetType) -> String {
//    return route.baseURL.URLByAppendingPathComponent(route.path).absoluteString
//}





