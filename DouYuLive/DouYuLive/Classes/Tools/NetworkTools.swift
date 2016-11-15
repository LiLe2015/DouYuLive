//
//  NetworkTools.swift
//  DouYuLive
//
//  Created by LiLe on 2016/11/15.
//  Copyright © 2016年 LiLe. All rights reserved.
//

import UIKit

class NetworkTools {

    /**
     GET请求
     */
    class func GETACtion(urlString: String) {
        // 获取Url --- 这个是我获取的天气预报接口，时间久了可能就会失效
        let url:NSURL = NSURL(string: urlString)!
        // 转换为requset
        let requets:NSURLRequest = NSURLRequest(URL: url)
        //NSURLSession 对象都由一个 NSURLSessionConfiguration 对象来进行初始化，后者指定了刚才提到的那些策略以及一些用来增强移动设备上性能的新选项
        let configuration:NSURLSessionConfiguration = NSURLSessionConfiguration.defaultSessionConfiguration()
        let session:NSURLSession = NSURLSession(configuration: configuration)
        
        //NSURLSessionTask负责处理数据的加载以及文件和数据在客户端与服务端之间的上传和下载，NSURLSessionTask 与 NSURLConnection 最大的相似之处在于它也负责数据的加载，最大的不同之处在于所有的 task 共享其创造者 NSURLSession 这一公共委托者（common delegate）
        let task:NSURLSessionDataTask = session.dataTaskWithRequest(requets, completionHandler: {
            (data:NSData?,response:NSURLResponse?,error:NSError?)->Void in
            if error == nil{
                do{
                    let responseData:NSDictionary = try NSJSONSerialization.JSONObjectWithData(data!, options: NSJSONReadingOptions.AllowFragments) as! NSDictionary
                    print("responseData： \(responseData)")
                }catch{
                    
                }
            }
        })
        // 启动任务
        task.resume()
    }
    
    class func GetWithPara() {
        let url:NSURL = NSURL(string: "http://httpbin.org/get")!
        let request:NSMutableURLRequest = NSMutableURLRequest(URL:url)
        request.HTTPMethod = "GET"
        // 请求的Header
        //request.addValue("a566eb03378211f7dc9ff15ca78c2d93", forHTTPHeaderField: "apikey")
        let configuration:NSURLSessionConfiguration = NSURLSessionConfiguration.defaultSessionConfiguration()
        let session:NSURLSession = NSURLSession(configuration: configuration)
        
        let task:NSURLSessionDataTask = session.dataTaskWithRequest(request, completionHandler: {
            (data:NSData?,response:NSURLResponse?,error:NSError?)->Void in
            if error == nil{
                do{
                    let responseData:NSDictionary = try NSJSONSerialization.JSONObjectWithData(data!, options: NSJSONReadingOptions.AllowFragments) as! NSDictionary
                    print("普通带头与参数的GET请求 --- > \(responseData)")
                    
                }catch{
                    
                }
            }
        })
        task.resume()
    }
    
    
    /**
     POST请求
     */
    class func POSTACtion(urlString: String, parameters: String, finishedCallBack:(result: AnyObject) -> ()) {
        // 注意内容以HTTPBody的方式传递过去 http://capi.douyucdn.cn/api/v1/getHotCate
        let request = NSMutableURLRequest(URL: NSURL(string: urlString)!)
        // 这块就是区别啦，其实也差不多
        request.HTTPMethod = "POST"
        request.HTTPBody = parameters.dataUsingEncoding(NSUTF8StringEncoding)
        let task = NSURLSession.sharedSession().dataTaskWithRequest(request, completionHandler: {
            (data:NSData?,response:NSURLResponse?,error:NSError?)->Void in
            if error == nil{
                do{
                    //let result = NSString(data: data!, encoding: NSUTF8StringEncoding)
                    let result:NSDictionary = try NSJSONSerialization.JSONObjectWithData(data!, options: NSJSONReadingOptions.AllowFragments) as! NSDictionary
                    finishedCallBack(result: result)
                    
                }catch{
                    print("have catch")
                }
            }
            
        })
        task.resume()
    }

    
    class func startRequest(){
        
        var strURL=String(format:"http://blog.csdn.net/sps900608")
        strURL=strURL.stringByAddingPercentEncodingWithAllowedCharacters(NSCharacterSet(charactersInString:"`#%^{}\"[]|\\<> ").invertedSet)!
        
        let url=NSURL(string: strURL)!
        let request=NSURLRequest(URL: url)
        
        let session=NSURLSession.sharedSession()
        let dataTask=session.dataTaskWithRequest(request) { (data, reponse, error) -> Void in
            if (error != nil){
                NSLog("Error:\(error?.localizedDescription)")
            }
            else{
                print(data)            }
        }
        dataTask.resume()
    }

}
