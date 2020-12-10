//
//  faceView.swift
//  Assignment 2
//
//  Created by Temesgen Daniel on 01/11/2020.
//  Copyright © 2020 kustar. All rights reserved.
//


import UIKit
@IBDesignable
class faceView2: UIView {
    @IBInspectable
    var color : UIColor = UIColor.black
    var color2 :  UIColor = UIColor.white
    var color3 : UIColor = UIColor.black
    private enum Eye {
        case Left
        case Right
    }
    var skullRadius : CGFloat {
        return min(bounds.size.width,bounds.size.height)/2
    }
    var skullCenter : CGPoint{
        
        return CGPoint( x: bounds.midX, y: bounds.midY)
    }
    
    var scale: CGFloat = 0.90 { didSet { setNeedsDisplay() } }
    var mouthCurvature: Double = 1.0
    
    var colorNUM: Double = 1.0
    
    var eyesOpen: Bool = true {didSet { setNeedsDisplay() }}
    
    var skullForm: Bool = true {didSet { setNeedsDisplay() }}
    
    var eyeShape: Bool = false {didSet{setNeedsDisplay() }}
    
    var eyeBrowTilt: Double = -0.75
      
    var lineWidth: CGFloat = 8.0
    
    
    
    func pathForNose()->UIBezierPath{
        let path = UIBezierPath()
        path.move(to: skullCenter)
        path.addLine(to: CGPoint(x: skullCenter.x + 25, y: skullCenter.y) )
        path.addLine(to: CGPoint(x: skullCenter.x, y: skullCenter.y - 25) )
        path.addLine(to: CGPoint(x: skullCenter.x - 25, y: skullCenter.y) )
        path.addLine(to: skullCenter)
        path.lineWidth = lineWidth
        return path
    }
    
    private func getEyeCenter(eye: Eye) -> CGPoint
    {
        let eyeOffset = skullRadius / Ratios.SkullRadiusToEyeOffset
        var eyeCenter = skullCenter
        eyeCenter.y -= eyeOffset
        switch eye {
        case .Left: eyeCenter.x -= eyeOffset
        case .Right: eyeCenter.x += eyeOffset
        }
        return eyeCenter
    }
    
    private func pathForEye(eye: Eye) -> UIBezierPath
    {
        let eyeRadius = skullRadius / Ratios.SkullRadiusToEyeRadius
        let eyeCenter = getEyeCenter(eye: eye)
    
            
        if eyesOpen {
            if eyeShape{
              return pathForCircleCenteredAtPoint(midPoint: eyeCenter, withRadius: eyeRadius)
            }
            else
            {
                 let squarePath = UIBezierPath(rect: CGRect(x: eyeCenter.x - eyeRadius, y: eyeCenter.y, width: 2*eyeRadius, height: 2*eyeRadius))
                         
                         return squarePath
                
            }
            
        } else {
            let path = UIBezierPath()
            path.move(to: CGPoint(x: eyeCenter.x - eyeRadius, y: eyeCenter.y))
            path.addLine(to: CGPoint(x: eyeCenter.x + eyeRadius, y: eyeCenter.y))
            path.lineWidth = lineWidth
            return path
        }
    }
        
    
    
     private func pathForCircleCenteredAtPoint(midPoint: CGPoint, withRadius radius: CGFloat) -> UIBezierPath
     {
        
              let path = UIBezierPath(
                  arcCenter: midPoint,
                  radius: radius,
                  startAngle: 0.0,
                  endAngle: CGFloat(2*(Double.pi)),
                  clockwise: false
              )
              path.lineWidth = 1
              return path
          
    
    }
    
    private func pathForSquare() -> UIBezierPath
    {
        let squarePath = UIBezierPath(rect: CGRect(x: 0, y: 0, width: bounds.size.width, height: bounds.size.height))
        
        return squarePath
        
    }
      private func pathForMouth() -> UIBezierPath
         {
             let mouthWidth = skullRadius / Ratios.SkullRadiusToMouthWidth
             let mouthHeight = skullRadius / Ratios.SkullRadiusToMouthHeight
             let mouthOffset = skullRadius / Ratios.SkullRadiusToMouthOffset

             let mouthRect = CGRect(x: skullCenter.x - mouthWidth/2, y: skullCenter.y + mouthOffset, width: mouthWidth, height: mouthHeight)
             
             let smileOffset = CGFloat(max(-1, min(mouthCurvature, 1))) * mouthRect.height
             let start = CGPoint(x: mouthRect.minX, y: mouthRect.minY)
             let end = CGPoint(x: mouthRect.maxX, y: mouthRect.minY)
             let cp1 = CGPoint(x: mouthRect.minX + mouthRect.width / 3, y: mouthRect.minY + smileOffset)
             let cp2 = CGPoint(x: mouthRect.maxX - mouthRect.width / 3, y: mouthRect.minY + smileOffset)
             
             let path = UIBezierPath()
             path.move(to: start)
             path.addCurve(to: end, controlPoint1: cp1, controlPoint2: cp2)
             path.lineWidth = lineWidth
             
             return path
         }
                
    private func pathForBrow(eye: Eye) -> UIBezierPath
     {
         var tilt = eyeBrowTilt
         switch eye {
         case .Left: tilt *= -1.0
         case .Right: break
         }
         var browCenter = getEyeCenter(eye: eye)
         browCenter.y -= skullRadius / Ratios.SkullRadiusToBrowOffset
         let eyeRadius = skullRadius / Ratios.SkullRadiusToEyeRadius
         let tiltOffset = CGFloat(max(-1, min(tilt, 1))) * eyeRadius / 2
         let browStart = CGPoint(x: browCenter.x - eyeRadius, y: browCenter.y - tiltOffset)
         let browEnd = CGPoint(x: browCenter.x + eyeRadius, y: browCenter.y + tiltOffset)
         let path = UIBezierPath()
         path.move(to: browStart)
         path.addLine(to: browEnd)
         path.lineWidth = lineWidth
         return path
     }
    
    
    // Only override draw() if you perform custom drawing.
    // An empty implementation adversely affects performance during animation.
    
     override func draw(_ rect: CGRect) {
        // Drawing code
        
        
        if colorNUM == 1.0 {
            color = UIColor.systemBlue
            
        }
        else if colorNUM == -1.0{
            color = UIColor.systemYellow
            
        }
            
        else {
            color = UIColor.systemPurple
            
        }
        color.set()
        
        if skullForm {
        pathForCircleCenteredAtPoint(midPoint: skullCenter, withRadius: skullRadius).fill()
        }
        else {
            //pathForSquare().stroke()
            pathForSquare().fill()
        }
        if (eyesOpen){
        color2 = UIColor.white
        color2.set()
        pathForEye(eye: .Left).fill()
        pathForEye(eye: .Right).fill()
        }
        else{
            color2 = UIColor.black
            color2.set()
            pathForEye(eye: .Left).stroke()
            pathForEye(eye: .Right).stroke()
            
        }
        color3.set ()
        
        pathForMouth().stroke()
        pathForBrow(eye: .Left).stroke()
        pathForBrow(eye: .Right).stroke()
        color2 = UIColor.black
        color2.set()
        pathForNose().fill()
        
    }
    
   private struct Ratios {
       static let SkullRadiusToEyeOffset: CGFloat = 3
       static let SkullRadiusToEyeRadius: CGFloat = 10
       static let SkullRadiusToMouthWidth: CGFloat = 1
       static let SkullRadiusToMouthHeight: CGFloat = 3
       static let SkullRadiusToMouthOffset: CGFloat = 3
       static let SkullRadiusToBrowOffset: CGFloat = 5
   }

}
