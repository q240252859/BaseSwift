//
//  HedgehogProvider.swift
//  Hedgehog
//
//  Created by  on 2018/7/24.
//  Copyright © 2018年 mingLuo. All rights reserved.
//

import Foundation


//初始化请求的provider
let HedgehogProvider = MoyaProvider<Hedgehog>()

/** 下面定义请求的endpoints（供provider使用）**/

//请求分类
public enum Hedgehog {
    case channels
    case playlist([String: Any],Moya.Method,String,ParameterEncoding)
    case playBaseUrl([String: Any],Moya.Method,String,ParameterEncoding,String)
}
//默认下载保存地址（用户文档目录）
let DefaultDownloadDir: URL = {
    let file = FileManager.default
    
    
    let directoryURLs = FileManager.default.urls(for: .documentDirectory,
                                                 in: .userDomainMask)

    return directoryURLs.first ?? URL(fileURLWithPath: NSTemporaryDirectory())
}()




//初始化请求的provider
let MyServiceProvider = MoyaProvider<MyService>()

//请求分类
public enum MyService {
    case downloadAsset(assetName:String,FileName:String) //下载文件
    case playlist([String: Any],Moya.Method,String,ParameterEncoding,String)
}

//请求配置
extension MyService: TargetType {
    //服务器地址
    public var baseURL: URL {
        switch self {
        case  .downloadAsset:
            return URL(string: qiniuyunUrl)!
        case  .playlist:
            return URL(string: BaseUrl)!
        }
        
    }
    
    //各个请求的具体路径
    public var path: String {
        switch self {
        case let .downloadAsset(assetName,_):
            return assetName
        case let .playlist(_,_, Url,_,_):
            return Url
        }
    }
    
    //请求类型
    public var method: Moya.Method {
        switch self {
        case .downloadAsset(_):
            return .post
        case let .playlist(_,Method,_,_,_):
           
        return Method
        }
        
    }
    
    //请求任务事件（这里附带上参数）
    public var task: Task {
        switch self {
        case let .downloadAsset(_, FileName):
            //定义下载的DownloadDestination（不改变文件名，自动覆盖同名）
            let localLocation: URL = DefaultDownloadDir.appendingPathComponent(FileName)
            let downloadDestination:DownloadDestination = {temporaryURL, response in
                return (localLocation, .removePreviousFile) }
            return .downloadDestination(downloadDestination)
        
        case let .playlist(parame,_,_,encod,FileName):
            //定义下载的DownloadDestination（不改变文件名，自动覆盖同名）
//            let localLocation: URL = DefaultDownloadDir.appendingPathComponent(FileName)
            let downloadDestination:DownloadDestination = { temporaryURL, response in
                
                return (DefaultDownloadDir.appendingPathComponent(response.suggestedFilename ?? FileName), .removePreviousFile) }
            
            return .downloadParameters(parameters: parame, encoding: encod, destination: downloadDestination)
        }
    }
    
    //是否执行Alamofire验证
    public var validate: Bool {
        return false
    }
    
    //这个就是做单元测试模拟的数据，只会在单元测试文件中有作用
    public var sampleData: Data {
        return "{}".data(using: String.Encoding.utf8)!
    }
    
    //请求头
    public var headers: [String: String]? {
        return nil
    }
}






//请求配置
extension Hedgehog: TargetType {
    
   

    //服务器地址
    public var baseURL: URL {
      
        
        
       
        
        switch self {
        case .channels:
            return URL(string: BaseUrl)!
        case .playlist(_,_,_,let encoding):
            if encoding is JSONEncoding {
                return URL(string: BaseUrl)!
            }
            return URL(string: BaseUrl)!
        case .playBaseUrl(_, _, _, let encoding,let FileName):
//            if encoding is JSONEncoding{
//                return URL(string: BaseUrl+access_token+FileName)!
//            }
          
            return URL(string: BaseUrl+FileName)!
      
        }
    }
    
    //各个请求的具体路径
    public var path: String {
        switch self {
        case .channels:
            return "/api/appLogin"
        case .playlist(_,_,let Url,_):
            return Url
        case .playBaseUrl(_, _,let Url, _,_):
            return Url
        }
    }
    
    //请求类型
    public var method: Moya.Method {
        switch self {
        case .channels:
            return .post
        case .playlist(_,let channel,_,_):
            return channel
        case .playBaseUrl(_,let channel,_,_,_):
            return channel
        }

    }
   
    //请求任务事件（这里附带上参数）
    public var task: Task {
        var params: [String: Any] = [:]
        
        
        
        
        
        params["deviceType"] = "2"
        
        
        params["grant_type"] = "password"
        params["scope"] = "select"
        params["client_id"] = "client_2"
        params["client_secret"] = "123456"
        params["username"] = "123456"
        params["password"] = "123456"
        
        
        if let decoded = UserDefaults.standard.value(forKey: UserNameKey){
            let person = NSKeyedUnarchiver.unarchiveObject(with: decoded as! Data) as! SignInModel
            params["access_token"] = person.access_token
        }
        switch self {
        case .playlist(let channel,_,_,let str):
          
            
            for (key, value) in (channel as [String : Any]){
                params[key] = value as Any?
            }
   
            return .requestParameters(parameters: params,
                                      encoding: str)
        case .playBaseUrl(let channel,_,_,let str,_):
            
            
            
            for (key, value) in (channel as [String : Any]){
                params[key] = value as Any?
            }
            
            return .requestParameters(parameters: params,
                                      encoding: str)
        default:
            return .requestPlain
        }
    }
    
    //是否执行Alamofire验证
    public var validate: Bool {
        return false
    }
    
    //这个就是做单元测试模拟的数据，只会在单元测试文件中有作用
    public var sampleData: Data {
        return "{}".data(using: String.Encoding.utf8)!
    }
    
    //请求头
    public var headers: [String: String]? {
        
        
        var params: [String: String] = [:]
        
        params["deviceType"] = "2"
      

        params["grant_type"] = "password"
        params["scope"] = "select"
        params["client_id"] = "client_2"
        params["client_secret"] = "123456"
        params["username"] = "123456"
        params["password"] = "123456"

 
        if let decoded = UserDefaults.standard.value(forKey: UserNameKey){
            let person = NSKeyedUnarchiver.unarchiveObject(with: decoded as! Data) as! SignInModel
            params["access_token"] = person.access_token
        }
        
        return params
    }
}
