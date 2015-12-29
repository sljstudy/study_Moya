# 学习 Alamofire封装库Moya

##Moya
moya 对Alamofire网络请求库进行了封装，开发不需要写网络模型，管理等。使代码更加简洁。详情访问 [Moya](https://github.com/Moya/Moya "moya") 项目主页

##1. 创建一个iOS Swift项目 (废话)
这里使用cocoapods 创建Podfile文件放在项目根目录下
```bash
source 'https://github.com/CocoaPods/Specs.git'
use_frameworks!
pod 'Moya'
```
在项目根目录运行
```bash
pod install --verbose --no-repo-update // 不更新repo, 速度会快点
```
安装成功
点击`.xcworkspace`文件。启动项目

## 2. 创建API管理文件 DSAPI.Swift
这里我们使用逗视的api
1.引入Moya头文件
```swift
import Foundation
import Moya
```
2.创建DS的请求方法列表 enum

```swift
/**
  MARK: 创建DS 请求方法列表
 - GetVideosByType  根据类型获取视频列表 
 */
public enum DS {
    case GetVideosByType(Int,Int,Int,Int) //根据类型获取视频列表
}
```
3.创建 MoyaProvider
```swift
// MARK: - Provider setup
let DSProvider = MoyaProvider<DS>()
```
4.通过Moya 定义的`baseUrl`、 请求路径(`path`)、 Http方法、 参数和目标的示例数据的协议。
扩展DS : TargetType
```swift
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
```
OK 这样创建好了DSAPI管理类，下面在tableView中实验一把

## 5.创建VideosTableViewController
- 定义数据集合
```swift
var repos = NSArray()
```
- 创建loadData()方法请求网络数据
```swift
/**
  请求数据
   */
  func loadData() {
    DSProvider.request(DS.GetVideosByType(0, 12, 0, 1)) {(result) -> () in
        switch result {
        case let .Success(response):
              do {
                      let json: Dictionary? = try response.mapJSON() as? Dictionary<String, AnyObject>
                      if let json = json {
                      print(json["content"] as! Array<AnyObject>)
                      if let contents: Array<AnyObject> = json["content"] as? Array<AnyObject> {
                          self.repos = contents
                      }
                    }
                  self.tableView.reloadData()
                } catch {
                }
            case let .Failure(error):
              print(error)
              break
            }
       }
    }
```
- 扩展VideosTableViewController Cell增添数据
```swift
extension VideosTableViewController {
  override func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
      let cell = tableView.dequeueReusableCellWithIdentifier("reuseIdentifier", forIndexPath: indexPath)
      // Configure the cell...
      let contentDic = repos[indexPath.row] as? Dictionary<String, AnyObject>
      cell.textLabel?.text = contentDic!["title"] as? String
      return cell
   }
    override func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return repos.count
    }
}
```
OK，点击`Run`看一下效果吧

[![](http://img.itjh.com.cn/moyas11.png)](http://img.itjh.com.cn/moyas11.png)

正确获取到 [逗视](https://itunes.apple.com/us/app/dou-shi-gao-xiao-shi-pin-ju-ji-de/id1044917946?l=zh&ls=1&mt=8 "逗视")app的视频列表了

------------
有没有发现这样写网络请求很爽，我们只维护`DSAPI`就可以了,添加请求方法，处理数据等。
本文例子已经上传到github，有问题可以发送邮件iosdev#itjh.com.cn
