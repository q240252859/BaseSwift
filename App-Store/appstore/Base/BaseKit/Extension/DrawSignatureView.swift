import UIKit

open class DrawSignatureView: UIView {
    
    open var CenterName:UILabel = {
        let lab = UILabel.init()
        lab.text = "请在此签名"
        lab.font = HedMediumFont16
        lab.textColor = ColorRGB_(233)
        lab.sizeToFit()
        return lab
    }()
    // 公共属性
    open var lineWidth: CGFloat = 2.0 {
        didSet {
            self.path.lineWidth = lineWidth
        }
    }
    open var strokeColor: UIColor = UIColor.black
    open var signatureBackgroundColor: UIColor = UIColor.white
    
    // 私有属性
    fileprivate var path = UIBezierPath()
    fileprivate var pts = [CGPoint](repeating: CGPoint(), count: 5)
    fileprivate var ctr = 0
    
    // Init
    override init(frame: CGRect) {
        super.init(frame: frame)
        self.addSubview(CenterName)
        CenterName.easy.layout(
            Center(0)
        )
        self.backgroundColor = self.signatureBackgroundColor
        self.path.lineWidth = self.lineWidth
    }
    
    // Init
    required public init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        
        self.backgroundColor = self.signatureBackgroundColor
        self.path.lineWidth = self.lineWidth
    }
    
    // Draw
    override open func draw(_ rect: CGRect) {
        self.strokeColor.setStroke()
        self.path.stroke()
    }
    
    // 触摸签名相关方法
    override open func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        if let firstTouch = touches.first{
            CenterName.isHidden = true
            let touchPoint = firstTouch.location(in: self)
            self.ctr = 0
            self.pts[0] = touchPoint
        }
    }
    
    override open func touchesMoved(_ touches: Set<UITouch>, with event: UIEvent?) {
        if let firstTouch = touches.first{
            let touchPoint = firstTouch.location(in: self)
            self.ctr += 1
            self.pts[self.ctr] = touchPoint
            if (self.ctr == 4) {
                self.pts[3] = CGPoint(x: (self.pts[2].x + self.pts[4].x)/2.0,
                    y: (self.pts[2].y + self.pts[4].y)/2.0)
                self.path.move(to: self.pts[0])
                self.path.addCurve(to: self.pts[3], controlPoint1:self.pts[1],
                    controlPoint2:self.pts[2])
                
                self.setNeedsDisplay()
                self.pts[0] = self.pts[3]
                self.pts[1] = self.pts[4]
                self.ctr = 1
            }
            
            self.setNeedsDisplay()
        }
    }
    
    override open func touchesEnded(_ touches: Set<UITouch>, with event: UIEvent?) {
        if self.ctr == 0{
            let touchPoint = self.pts[0]
            self.path.move(to: CGPoint(x: touchPoint.x-1.0,y: touchPoint.y))
            self.path.addLine(to: CGPoint(x: touchPoint.x+1.0,y: touchPoint.y))
            self.setNeedsDisplay()
        } else {
            self.ctr = 0
        }
    }
    
    // 签名视图清空
    open func clearSignature() {
        self.path.removeAllPoints()
        CenterName.isHidden = false
        self.setNeedsDisplay()
    }
    
    // 将签名保存为UIImage
    open func getSignature() ->UIImage {
        UIGraphicsBeginImageContext(CGSize(width: self.bounds.size.width,
            height: self.bounds.size.height))
        self.layer.render(in: UIGraphicsGetCurrentContext()!)
        let signature: UIImage = UIGraphicsGetImageFromCurrentImageContext()!
        UIGraphicsEndImageContext()
        return signature
    }
}
