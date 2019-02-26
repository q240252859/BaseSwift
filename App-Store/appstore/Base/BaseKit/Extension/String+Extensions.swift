
//
import UIKit
import Foundation
import CommonCrypto

public func showAlert(_ title:String,message:String,VC:UIViewController){
    let alert:UIAlertController = UIAlertController(title: title, message: message, preferredStyle: .alert)
    VC.present(alert, animated: true, completion: nil)
    let action:UIAlertAction = UIAlertAction(title: "确定", style: .default, handler: nil)
    alert.addAction(action)
}

//字典转换成JSONString
func getJSONStringFromDictionary(dictionary:NSDictionary) -> String {
    
    if (!JSONSerialization.isValidJSONObject(dictionary)) {
        print("无法解析出JSONString")
        return ""
    }
    let data : NSData! = try? JSONSerialization.data(withJSONObject: dictionary, options: []) as NSData!
    let JSONString = NSString(data:data as Data,encoding: String.Encoding.utf8.rawValue)
    return JSONString! as String
    
}

func getNSDictionaryFromJSONString(JSONString:String) ->NSDictionary{
    if JSONString.isEmpty{
        return ["":""]
    }
    let data = JSONString.data(using: String.Encoding.utf8)! as NSData
    let dictionary_temp_temp = try? JSONSerialization.jsonObject(with: data as Data, options: JSONSerialization.ReadingOptions.mutableContainers)
    if dictionary_temp_temp != nil{
        let chatData:Dictionary<String,Any> = dictionary_temp_temp as! Dictionary
    return chatData as NSDictionary
    }
    return ["":""]

}
extension UIAlertController {
    //在指定视图控制器上弹出普通消息提示框
    static func showAlert(message: String, in viewController: UIViewController) {
        let alert = UIAlertController(title: nil, message: message, preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: "确定", style: .cancel))
        viewController.present(alert, animated: true)
    }
    
    //在根视图控制器上弹出普通消息提示框
    static func showAlert(message: String) {
        if let vc = UIApplication.shared.keyWindow?.rootViewController {
            showAlert(message: message, in: vc)
        }
    }
    
    //在指定视图控制器上弹出确认框
    static func showAlertYes(title:String,message: String, in viewController: UIViewController,
                            confirm: ((UIAlertAction)->Void)?) {
        let alert = UIAlertController(title: title, message: message, preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: "取消", style: .cancel))
        alert.addAction(UIAlertAction(title: "确定", style: .default, handler: confirm))
        viewController.present(alert, animated: true)
    }
    
    //在根视图控制器上弹出确认框
    static func showAlertYes(title:String,message: String, confirm: ((UIAlertAction)->Void)?) {
        if let vc = UIApplication.shared.keyWindow?.rootViewController {
            showAlertYes(title:title, message: message, in: vc, confirm: confirm)
        }
    }
}

//extension UITextView {
//    //添加链接文本（链接为空时则表示普通文本）
//    func appendLinkString(string:String, withURLString:String = "") {
//        //原来的文本内容
//        let attrString:NSMutableAttributedString = NSMutableAttributedString()
//        attrString.append(self.attributedText)
//
//        //新增的文本内容（使用默认设置的字体样式）
//        let attrs = [NSAttributedStringKey.font : self.font!]
//        let appendString = NSMutableAttributedString(string: string, attributes:attrs)
//        //判断是否是链接文字
//        if withURLString != "" {
//            let range:NSRange = NSMakeRange(0, appendString.length)
//            appendString.beginEditing()
//            appendString.addAttribute(NSAttributedStringKey.link, value:withURLString, range:range)
//            appendString.endEditing()
//        }
//        //合并新的文本
//        attrString.append(appendString)
//
//        //设置合并后的文本
//        self.attributedText = attrString
//    }
//
//
//
//
//}
extension UIView {
    
    //纯色图
    func imageWithColor(color:UIColor) -> UIImage
    {
        let rect = CGRect(x: 0.0, y: 0.0, width: 1.0, height: 1.0)
        UIGraphicsBeginImageContext(rect.size)
        let context:CGContext = UIGraphicsGetCurrentContext()!
        context.setFillColor(color.cgColor);
        context.fill(rect);
        
        let image = UIGraphicsGetImageFromCurrentImageContext()
        UIGraphicsEndImageContext()
        
        return image ?? UIImage.init()
    }
    /// 部分圆角
    ///
    /// - Parameters:
    ///   - corners: 需要实现为圆角的角，可传入多个
    ///   - radii: 圆角半径
    func corner(byRoundingCorners corners: UIRectCorner, radii: CGFloat) {
        let maskPath = UIBezierPath(roundedRect: self.bounds, byRoundingCorners: corners, cornerRadii: CGSize(width: radii, height: radii))
        let maskLayer = CAShapeLayer()
        maskLayer.frame = self.bounds
        maskLayer.path = maskPath.cgPath
        self.layer.mask = maskLayer
    }
    //画虚线
    func drawDashLine(strokeColor: UIColor, lineWidth: CGFloat = 1, lineLength: Int = 10, lineSpacing: Int = 5, isBottom: Bool = true, isWorH:Bool = true) {
        let shapeLayer = CAShapeLayer()
        shapeLayer.bounds = self.bounds
        shapeLayer.anchorPoint = CGPoint(x: 0, y: 0)
        shapeLayer.fillColor = UIColor.blue.cgColor
        shapeLayer.strokeColor = strokeColor.cgColor
        
        shapeLayer.lineWidth = lineWidth
        shapeLayer.lineJoin = kCALineJoinRound
        
        //每一段虚线长度 和 每两段虚线之间的间隔
        shapeLayer.lineDashPattern = [NSNumber(value: lineLength), NSNumber(value: lineSpacing)]
        
        let path = CGMutablePath()
        
        let x = isBottom == true ? self.layer.bounds.width - lineWidth : 0
        
        let y = isBottom == true ? self.layer.bounds.height - lineWidth : 0
        if isWorH{
            path.move(to: CGPoint(x: 0, y: y))
            
            path.addLine(to: CGPoint(x: self.layer.bounds.width, y: y))
        }else{
        
        path.move(to: CGPoint(x: x, y: 0))
        
        path.addLine(to: CGPoint(x: x, y: self.layer.bounds.height))
        }
        
        
        
        shapeLayer.path = path
        self.layer.addSublayer(shapeLayer)
    }
    

}


extension String {
//    md5加密
    func md5() ->String!{
        
        let str = self.cString(using: String.Encoding.utf8)
        
        let strLen = CUnsignedInt(self.lengthOfBytes(using: String.Encoding.utf8))
        
        let digestLen = Int(CC_MD5_DIGEST_LENGTH)
        
        let result = UnsafeMutablePointer<CUnsignedChar>.allocate(capacity: digestLen)
        
        CC_MD5(str!, strLen, result)
        
        var hash = NSMutableString()
        
        for i in 0 ..< digestLen {
            
            hash.appendFormat("%02x", result[i])
            
        }
        
        result.deinitialize()
        
        return String(format: hash as String)
        
    }
    func isTrueIDNumber(text:String) -> Bool{
        var value = text
        value = value.trimmingCharacters(in: CharacterSet.whitespacesAndNewlines)
        var length : Int = 0
        length = value.count
        if length != 15 && length != 18{
            //不满足15位和18位，即身份证错误
            return false
        }
        // 省份代码
        let areasArray = ["11","12", "13","14", "15","21", "22","23", "31","32", "33","34", "35","36", "37","41", "42","43", "44","45", "46","50", "51","52", "53","54", "61","62", "63","64", "65","71", "81","82", "91"]
        // 检测省份身份行政区代码
        let index = value.index(value.startIndex, offsetBy: 2)
        let valueStart2 = value.substring(to: index)
        //标识省份代码是否正确
        var areaFlag = false
        for areaCode in areasArray {
            if areaCode == valueStart2 {
                areaFlag = true
                break
                
            }
            
        }
        if !areaFlag {
            return false
            
        }
        var regularExpression : NSRegularExpression?
        var numberofMatch : Int?
        var year = 0
        switch length {
        case 15:
            //获取年份对应的数字
            let valueNSStr = value as NSString
            let yearStr = valueNSStr.substring(with: NSRange.init(location: 6, length: 2)) as NSString
            year = yearStr.integerValue + 1900
            if year % 4 == 0 || (year % 100 == 0 && year % 4 == 0) {
                //创建正则表达式 NSRegularExpressionCaseInsensitive：不区分字母大小写的模式
                //测试出生日期的合法性
                regularExpression = try! NSRegularExpression.init(pattern: "^[1-9][0-9]{5}[0-9]{2}((01|03|05|07|08|10|12)(0[1-9]|[1-2][0-9]|3[0-1])|(04|06|09|11)(0[1-9]|[1-2][0-9]|30)|02(0[1-9]|[1-2][0-9]))[0-9]{3}$", options: NSRegularExpression.Options.caseInsensitive)
                
            }else{
                //测试出生日期的合法性
                regularExpression = try! NSRegularExpression.init(pattern: "^[1-9][0-9]{5}[0-9]{2}((01|03|05|07|08|10|12)(0[1-9]|[1-2][0-9]|3[0-1])|(04|06|09|11)(0[1-9]|[1-2][0-9]|30)|02(0[1-9]|1[0-9]|2[0-8]))[0-9]{3}$", options: NSRegularExpression.Options.caseInsensitive)
                
            }
            numberofMatch = regularExpression?.numberOfMatches(in: value, options: NSRegularExpression.MatchingOptions.reportProgress, range: NSRange.init(location: 0, length: value.count))
            if numberofMatch! > 0 {
                return true
                
            }else{
                return false
                
            }
        case 18:
            let valueNSStr = value as NSString
            let yearStr = valueNSStr.substring(with: NSRange.init(location: 6, length: 4)) as NSString
            year = yearStr.integerValue
            if year % 4 == 0 || (year % 100 == 0 && year % 4 == 0) {
                //测试出生日期的合法性
                regularExpression = try! NSRegularExpression.init(pattern: "^((1[1-5])|(2[1-3])|(3[1-7])|(4[1-6])|(5[0-4])|(6[1-5])|71|(8[12])|91)\\d{4}(((19|20)\\d{2}(0[13-9]|1[012])(0[1-9]|[12]\\d|30))|((19|20)\\d{2}(0[13578]|1[02])31)|((19|20)\\d{2}02(0[1-9]|1\\d|2[0-8]))|((19|20)([13579][26]|[2468][048]|0[048])0229))\\d{3}(\\d|X|x)?$", options: NSRegularExpression.Options.caseInsensitive)
                
            }else{
                //测试出生日期的合法性
                regularExpression = try! NSRegularExpression.init(pattern: "^((1[1-5])|(2[1-3])|(3[1-7])|(4[1-6])|(5[0-4])|(6[1-5])|71|(8[12])|91)\\d{4}(((19|20)\\d{2}(0[13-9]|1[012])(0[1-9]|[12]\\d|30))|((19|20)\\d{2}(0[13578]|1[02])31)|((19|20)\\d{2}02(0[1-9]|1\\d|2[0-8]))|((19|20)([13579][26]|[2468][048]|0[048])0229))\\d{3}(\\d|X|x)?$", options: NSRegularExpression.Options.caseInsensitive)
                
            }
            numberofMatch = regularExpression?.numberOfMatches(in: value, options: NSRegularExpression.MatchingOptions.reportProgress, range: NSRange.init(location: 0, length: value.count))
            if numberofMatch! > 0 {
                let a = getStringByRangeIntValue(Str: valueNSStr, location: 0, length: 1) * 7
                let b = getStringByRangeIntValue(Str: valueNSStr, location: 10, length: 1) * 7
                let c = getStringByRangeIntValue(Str: valueNSStr, location: 1, length: 1) * 9
                let d = getStringByRangeIntValue(Str: valueNSStr, location: 11, length: 1) * 9
                let e = getStringByRangeIntValue(Str: valueNSStr, location: 2, length: 1) * 10
                let f = getStringByRangeIntValue(Str: valueNSStr, location: 12, length: 1) * 10
                let g = getStringByRangeIntValue(Str: valueNSStr, location: 3, length: 1) * 5
                let h = getStringByRangeIntValue(Str: valueNSStr, location: 13, length: 1) * 5
                let i = getStringByRangeIntValue(Str: valueNSStr, location: 4, length: 1) * 8
                let j = getStringByRangeIntValue(Str: valueNSStr, location: 14, length: 1) * 8
                let k = getStringByRangeIntValue(Str: valueNSStr, location: 5, length: 1) * 4
                let l = getStringByRangeIntValue(Str: valueNSStr, location: 15, length: 1) * 4
                let m = getStringByRangeIntValue(Str: valueNSStr, location: 6, length: 1) * 2
                let n = getStringByRangeIntValue(Str: valueNSStr, location: 16, length: 1) * 2
                let o = getStringByRangeIntValue(Str: valueNSStr, location: 7, length: 1) * 1
                let p = getStringByRangeIntValue(Str: valueNSStr, location: 8, length: 1) * 6
                let q = getStringByRangeIntValue(Str: valueNSStr, location: 9, length: 1) * 3
                let S = a + b + c + d + e + f + g + h + i + j + k + l + m + n + o + p + q
                
                let Y = S % 11
                var M = "F"
                let JYM = "10X98765432"
                M = (JYM as NSString).substring(with: NSRange.init(location: Y, length: 1))
                let lastStr = valueNSStr.substring(with: NSRange.init(location: 17, length: 1))
                
                return true
                /*
                if lastStr == "x" {
                    if M == "X" {
                        return true
                        
                    }else{
                        return false
                        
                    }
                    
                }else{
                    if M == lastStr {
                        return true
                        
                    }else{
                        return false
                        
                    }
                    
                }
 */
                
            }else{
                return false
                
            }
        default:
            return false
            
        }
    }
    
    func getStringByRangeIntValue(Str : NSString,location : Int, length : Int) -> Int{
        let a = Str.substring(with: NSRange(location: location, length: length))
        let intValue = (a as NSString).integerValue
        return intValue
    }
      
    //根据身份证获取出生日期
    func birthdayStrFromIdentityCard(numberStr: String) -> (String) {
        var year:String = ""
        var month:String
        var day:String
        //截取前14位
        //        let fontNumber = (numberStr as NSString).substringWithRange(NSMakeRange(0, 14))
        //判断是18位身份证还是15位身份证
        if (numberStr as NSString).length == 18 {
            year = (numberStr as NSString).substring(with: NSMakeRange(6, 4))
            month = (numberStr as NSString).substring(with: NSMakeRange(10, 2))
            day = (numberStr as NSString).substring(with: NSMakeRange(12, 2))
            let result = "\(year)-\(month)-\(day)"
            print(result)
            return result
        }else{
            year = (numberStr as NSString).substring(with: NSMakeRange(6, 2))
            month = (numberStr as NSString).substring(with: NSMakeRange(8, 2))
            day = (numberStr as NSString).substring(with: NSMakeRange(10, 2))
            let result = "19\(year)-\(month)-\(day)"
            print(result)
            return result
        }
        
    }
    //根据出生日期计算年龄的方法
    func caculateAge(birthday: String) -> (CGFloat){
        //        var resultTag = ""
        //格式化日期
        let d_formatter = DateFormatter()
        d_formatter.dateFormat = "yyyy-MM-dd"
        let birthDay_date = d_formatter.date(from: birthday)
        // 出生日期转换 年月日
        if let tempBirthDay_date = birthDay_date {
            
            let birthdayDate = NSCalendar.current.dateComponents([.year,.month,.day], from: tempBirthDay_date)
            let brithDateYear :CGFloat = CGFloat(birthdayDate.year!)
            let brithDateDay  :CGFloat = CGFloat(birthdayDate.day!)
            let brithDateMonth :CGFloat = CGFloat(birthdayDate.month!)
            // 获取系统当前 年月日
            let currentDate = NSCalendar.current.dateComponents([.year,.month,.day], from: NSDate() as Date)
            let currentDateYear :CGFloat = CGFloat(currentDate.year!)
            let currentDateDay  :CGFloat = CGFloat(currentDate.day!)
            let currentDateMonth :CGFloat = CGFloat(currentDate.month!)
            // 计算年龄
            var iAge = currentDateYear - brithDateYear - 1;
            if ((currentDateMonth > brithDateMonth) || (currentDateMonth == brithDateMonth && currentDateDay >= brithDateDay)) {
                iAge += 1
            }
            return iAge
        }
        //计算错误
        return 9999
    }
    

    
    func urlEncoded() -> String {
        let encodeUrlString = self.addingPercentEncoding(withAllowedCharacters:
            .urlQueryAllowed)
        return encodeUrlString ?? ""
    }
    
    //将编码后的url转换回原始的url
    func urlDecoded() -> String {
        return self.removingPercentEncoding ?? ""
    }
     func validateEmail(email: String) -> Bool {
        let emailString = "[A-Z0-9a-z._%+-]+@[A-Za-z0-9.-]+\\.[A-Za-z]{2,4}"
        let emailPredicate = NSPredicate(format: "SELF MATCHES %@", emailString)
        return emailPredicate.evaluate(with: email)
    }
    //URL
    func validateURL(urlStr: String) -> Bool {
        let predicateStr = "^(https?:\\/\\/)?([\\da-z\\.-]+)\\.([a-z\\.]{2,6})([\\/\\w \\.-]*)*\\/?$"
        let emailPredicate = NSPredicate(format: "SELF MATCHES %@", predicateStr)
        return emailPredicate.evaluate(with: urlStr)
    }
    
    
    
    /// 从当前字符串中，提取链接和文本
    /// Swift 提供了`元组`，同时返回多个值
    /// 如果是 OC，可以返回字典／自定义对象／指针的指针
    func cz_href() -> (link: String, text: String)? {
        
        // 0. 匹配方案
        let pattern = "<a href=\"(.*?)\".*?>(.*?)</a>"
        
        // 1. 创建正则表达式，并且匹配第一项
        guard let regx = try? NSRegularExpression(pattern: pattern, options: []),
            let result = regx.firstMatch(in: self, options: [], range: NSRange(location: 0, length: characters.count))
            else {
                return nil
        }
        
        // 2. 获取结果
        let link = (self as NSString).substring(with: result.range(at: 1))
        let text = (self as NSString).substring(with: result.range(at: 2))
        
        
        
        return (link, text)
    }
    func validateyouzhen(phono: String) -> Bool {
        //邮政编码
        let phoneString = "^[1-9]\\d{5}(?!\\d)$"
        let phonePredicate = NSPredicate(format: "SELF MATCHES %@", phoneString)
        return phonePredicate.evaluate(with: phono)
    }
    
    func validatePhonoNum(phono: String) -> Bool {
        //手机号以13,15,17,18开头，八个 \d 数字字符
        let phoneString = "^((13[0-9])|(15[^4])|(166)|(17[0-8])|(18[0-9])|(19[8-9])|(147,145))\\d{8}$"
        let phonePredicate = NSPredicate(format: "SELF MATCHES %@", phoneString)
        return phonePredicate.evaluate(with: phono)
    }
   
    func patternPasswor(phono: String) -> Bool {
        //密码
        let phoneString = "^[a-zA-Z0-9]{6,16}$"
        let phonePredicate = NSPredicate(format: "SELF MATCHES %@", phoneString)
        return phonePredicate.evaluate(with: phono)
    }
    
    func validateCodeNum(phono: String) -> Bool {
        //验证码
        let phoneString = "^\\d{4}$"
        let phonePredicate = NSPredicate(format: "SELF MATCHES %@", phoneString)
        return phonePredicate.evaluate(with: phono)
    }
    
    var length: Int {
        return self.characters.count
    }
    //字符串除去小数点
    func RemoDecimalRetainTwo()-> String{
        if let index = self.index(of: ".") {
            let result = self.substring(to: index)//从起始截取到索引的所有字符串,即abc,注意不包含d
            
            let firstStr = self.suffix(from: index)
        
            if firstStr.count == 1{
                return self.replacingOccurrences(of: ".", with: "")+"00"
            }
            if firstStr.count == 2{
                return self.replacingOccurrences(of: ".", with: "")+"0"
            }
            if firstStr.count > 2{
                let endIndex = self.index(index, offsetBy:3)//从d的索引开始往后两个,即获取f的索引
                let resultstr = self.substring(with: index..<endIndex)//输出d的索引到f索引的范围,注意..<符号表示输出不包含f
                return  (result+resultstr).replacingOccurrences(of: ".", with: "")
            }
        }
        return self
    }
    //字符串后两位加小数点
    func RetainRemoDecimalTwo()-> String{
        if self.count > 2{
            var sr = self
            sr.insert(".", at: sr.index(sr.endIndex, offsetBy: -2) )
            return sr
        }else if self.count == 1{
            return "0.0"+self
        }else if self.count == 2{
            return "0."+self
        }
        
        return self
    }
    
    func RemoDecimalRetainTwoCGFloat()-> CGFloat{
        return CGFloat(Double(self.RemoDecimalRetainAddTwo()) ?? 0)
    }
    
    func RemoDecimalRetainAddTwo()-> String{
        if let index = self.index(of: ".") {
            let result = self.substring(to: index)//从起始截取到索引的所有字符串,即abc,注意不包含d
            
            let firstStr = self.suffix(from: index)
            
            if firstStr.count == 1{
                return self.replacingOccurrences(of: ".", with: "")+"00"
            }
            if firstStr.count == 2{
                return self.replacingOccurrences(of: ".", with: "")+"0"
            }
            if firstStr.count > 2{
                let endIndex = self.index(index, offsetBy:3)//从d的索引开始往后两个,即获取f的索引
                let resultstr = self.substring(with: index..<endIndex)//输出d的索引到f索引的范围,注意..<符号表示输出不包含f
                return  (result+resultstr).replacingOccurrences(of: ".", with: "")
            }
        }
        return self+"00"
    }
    
    
    
    //字符串转时间
    func getDateByFormatString(_ str: String) -> Date? {
        
        
        let dateFormat = DateFormatter()
        
        dateFormat.dateFormat = str
        dateFormat.locale = Locale.current
        
        return dateFormat.date(from: self)
    }
    
    
    func getIntByA_ZString(_ str: String) -> String{
        
        
        switch str {
        case "1":
            return "A."
        case "2":
            return "B."
        case "3":
            return "C."
        case "4":
            return "D."
        case "5":
            return "E."
        case "6":
            return "F."
        case "7":
            return "G."
        default:
            return ""
        }
        
       
    }
    
    
    
    //截取字符串
    func substrfromBegin(length:Int)->String{
        
        let index = self.index(self.startIndex, offsetBy: length)
        
        return self.substring(to: index)
        
    }
    
    
    func getCommonDateByFormatString() -> Date? {
        return getDateByFormatString("yyyy-MM-dd HH:mm:ss")
    }
    
    
    
}
extension String{
    
    
    
//    func boundingRect(with constrainedSize: CGSize, font: UIFont, lineSpacing: CGFloat? = nil) -> CGSize {
//        let attritube = NSMutableAttributedString(string: self)
//        let range = NSRange(location: 0, length: attritube.length)
//        attritube.addAttributes([NSAttributedStringKey.font: font], range: range)
//        if lineSpacing != nil {
//            let paragraphStyle = NSMutableParagraphStyle()
//            paragraphStyle.lineSpacing = lineSpacing!
//            attritube.addAttribute(NSAttributedStringKey.paragraphStyle, value: paragraphStyle, range: range)
//        }
//
//        let rect = attritube.boundingRect(with: constrainedSize, options: [.usesLineFragmentOrigin, .usesFontLeading], context: nil)
//        var size = rect.size
//
//        if let currentLineSpacing = lineSpacing {
//            // 文本的高度减去字体高度小于等于行间距，判断为当前只有1行
//            let spacing = size.height - font.lineHeight
//            if spacing <= currentLineSpacing && spacing > 0 {
//                size = CGSize(width: size.width, height: font.lineHeight)
//            }
//        }
//
//        return size
//    }
    
//    func boundingRect(with constrainedSize: CGSize, font: UIFont, lineSpacing: CGFloat? = nil, lines: Int) -> CGSize {
//        if lines < 0 {
//            return .zero
//        }
//        
//        let size = boundingRect(with: constrainedSize, font: font, lineSpacing: lineSpacing)
//        if lines == 0 {
//            return size
//        }
//        
//        let currentLineSpacing = (lineSpacing == nil) ? (font.lineHeight - font.pointSize) : lineSpacing!
//        let maximumHeight = font.lineHeight*CGFloat(lines) + currentLineSpacing*CGFloat(lines - 1)
//        if size.height >= maximumHeight {
//            return CGSize(width: size.width, height: maximumHeight)
//        }
//        
//        return size
//    }
    
    func nsRange(from range: Range<String.Index>) -> NSRange? {
        
        let utf16view = self.utf16
        
        if let from = range.lowerBound.samePosition(in: utf16view), let to = range.upperBound.samePosition(in: utf16view) {
            
            return NSMakeRange(utf16view.distance(from: utf16view.startIndex, to: from), utf16view.distance(from: from, to: to))
            
        }
        
        return nil
        
    }
    
    func ga_widthForComment(fontSize: UIFont, height: CGFloat = 15) -> CGFloat {
        
        let rect = NSString(string: self).boundingRect(with: CGSize(width: CGFloat(MAXFLOAT), height: height), options: .usesLineFragmentOrigin, attributes: [NSAttributedStringKey.font: fontSize], context: nil)
        return ceil(rect.width)
    }
    
    func ga_heightForComment(fontSize: CGFloat, width: CGFloat) -> CGFloat {
        let font = UIFont.systemFont(ofSize: fontSize)
        let rect = NSString(string: self).boundingRect(with: CGSize(width: width, height: CGFloat(MAXFLOAT)), options: .usesLineFragmentOrigin, attributes: [NSAttributedStringKey.font: font], context: nil)
        return ceil(rect.height)
    }
    
    func ga_heightForCommentFont(fontSize: UIFont, width: CGFloat) -> CGFloat {
        let rect = NSString(string: self).boundingRect(with: CGSize(width: width, height: CGFloat(MAXFLOAT)), options: .usesLineFragmentOrigin, attributes: [NSAttributedStringKey.font: fontSize], context: nil)
        return ceil(rect.height)
    }
    
    
    
    
    
    func ga_heightForComment(fontSize: CGFloat, width: CGFloat, maxHeight: CGFloat) -> CGFloat {
        let font = UIFont.systemFont(ofSize: fontSize)
        let rect = NSString(string: self).boundingRect(with: CGSize(width: width, height: CGFloat(MAXFLOAT)), options: .usesLineFragmentOrigin, attributes: [NSAttributedStringKey.font: font], context: nil)
        return ceil(rect.height)>maxHeight ? maxHeight : ceil(rect.height)
    }
  
    func dataToDictionary(data:Data) ->Dictionary<String, Any>?{
        do{
            let json = try JSONSerialization.jsonObject(with: data, options: .mutableContainers)
            let dic = json as! Dictionary<String, Any>
            return dic
        }catch _ {
            print("失败")
            return nil
        }
    }
    
}

