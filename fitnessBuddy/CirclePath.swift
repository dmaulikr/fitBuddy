//
//  CirclePath.swift
//  bezierPath
//
//  Created by Darko Dujmovic on 11/02/2017.
//  Copyright © 2017 Darko Dujmovic. All rights reserved.
//

import UIKit

@IBDesignable class CirclePath: UIControl {
    
    //MARK: - private vars
    private let shapeLayer = CAShapeLayer()
    private let gradLayer =  CAGradientLayer()
    private let backShape = CAShapeLayer()
    let label = UILabel()
    var coeficient: Float?
    
    
    //MARK: - Inspectables
    @IBInspectable var strokeWidth:CGFloat = 10 {
        didSet{
            setNeedsLayout()
        }
    }
    
    @IBInspectable var strokeOffset: CGFloat = 0{
        didSet{
            setNeedsLayout()
        }
    }
    
    @IBInspectable var strokeColor: UIColor = UIColor(white: 1, alpha: 0.5){
        didSet{
            setNeedsLayout()
        }
    }
    
    @IBInspectable var gradientColor2: UIColor = UIColor(red:1.00, green:0.97, blue:0.35, alpha:1.0){
        didSet{
            setNeedsLayout()
            }
    }
    @IBInspectable var gradientColor1: UIColor = UIColor(red: 1.00, green: 0.25, blue: 0.76, alpha: 1.0){
        didSet{
            setNeedsLayout()
        }
    }
    
    @IBInspectable var labelColor:UIColor = UIColor(red:0.40, green:0.20, blue:1.00, alpha:1.0) {
        didSet{
            setNeedsLayout()
        }
    }
    
    @IBInspectable var centerLabelSize: Int = 27{
        didSet{
            setNeedsLayout()
        }
    }
    
    
    
    //let color1:CGColor = UIColor.red.cgColor
    //let color2:CGColor = UIColor.yellow.cgColor
    let color3:CGColor = UIColor.green.cgColor
    let color4:CGColor = UIColor.purple.cgColor
    
    let colorScheme1 = UIColor(red:1.00, green:0.97, blue:0.35, alpha:1.0).cgColor
    let colorScheme2 = UIColor(red:0.02, green:0.18, blue:0.25, alpha:1.0).cgColor
    
    var flValue:Float?
    
    //MARK: - public property, value
    
    var value: Float = 0.8{
        didSet{
            drawPath()
           // print(">->->->-> Value set to \(value)")
        }
    }
    var excerciseDuration:Float?{
        didSet{
            //za svaku sekundu path se mora pomaknuti za sekunda * koeficijent
            //coeficient =   100.00/excerciseDuration!
            //print("Coeficient is \(coeficient!)")
        }
    }
    
    var elapsedTime = "" {
        didSet{
            self.label.text = elapsedTime
            //print("Elapsed time from Circlepath class is \(elapsedTime)")
        }
    }
    
    
    /*
    func secondsToTime(seconds: Int)->(Int, Int, Int){
        var seconds2 = Float(seconds) * coeficient!
        print("I am at 1. \(seconds) and  2.\(seconds2) seconds")
        return (seconds/3600, (seconds%3600) / 60, (seconds%60)%60)
    }*/
  
    
    func drawPath(){
        let strokeEnd = value > 0.001 ? value : 0.0001
        shapeLayer.strokeEnd = CGFloat(strokeEnd)
    }
    
    //MARK: - Init
    
    override init(frame: CGRect){
        super.init(frame: frame)
 
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        

        //setup the object
    }
    
    
    //MARK: - Class overrides
    
    override func layoutSubviews() {
        setup()
    }
    
    
    private var touchX:CGFloat = 0
    private var lastValue: Float = 0
    
    /*
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        let touch = touches.first!
        let location = touch.location(in: self)
        touchX = location.x
        lastValue = value
    }
    
    override func touchesMoved(_ touches: Set<UITouch>, with event: UIEvent?) {
        let touch = touches.first!
        let location = touch.location(in: self)
        let newX = location.x
        let deltaX = (newX - touchX) * 0.004
        print("DeltaX \(deltaX)")
        var newValue = lastValue + Float(deltaX)
        newValue = max(min(newValue, 1), 0)
        value = newValue
        sendActions(for: .valueChanged)
    }
    
    override func touchesEnded(_ touches: Set<UITouch>, with event: UIEvent?) {
        //
    }*/
    
    //MARK: - Private methods
    
    func setup(){
        
        //Setup back layer
        layer.addSublayer(backShape)
        
        
        // Setup gradient
        layer.addSublayer(gradLayer)
        gradLayer.frame = bounds
        gradLayer.colors = [gradientColor1.cgColor, gradientColor2.cgColor]
        gradLayer.startPoint = CGPoint(x: 1, y: 0)
        gradLayer.endPoint = CGPoint(x: 0, y: 0)
        
        
        
        //Setup main stroke
        
        layer.addSublayer(shapeLayer)
        
        //creates a path but you need to apply it
        let path = UIBezierPath()
       
        let cx = bounds.width / 2
        let cy = bounds.height / 2
        var cr = cx < cy ? cx : cy
        cr -= (strokeWidth + strokeOffset) / 2
        
        let c = CGPoint(x: cx, y: cy)
        
        let pi2 = CGFloat(2*M_PI)
        let startPoint = pi2 * (6/8)
        let endPoint = pi2 * (14/8)
        
        path.addArc(withCenter: c, radius: cr, startAngle: startPoint, endAngle: endPoint, clockwise: true)
        
        
        shapeLayer.path = path.cgPath
        shapeLayer.lineWidth = strokeWidth + strokeOffset
        shapeLayer.strokeColor = UIColor.black.cgColor
        shapeLayer.fillColor = UIColor.clear.cgColor
        
        shapeLayer.strokeEnd = CGFloat(value)
        
        //shapeLayer.lineDashPattern = [4,2]
        
        shapeLayer.lineCap = kCALineCapRound
        gradLayer.mask = shapeLayer
        
        
        backShape.path = path.cgPath
        backShape.fillColor = UIColor.clear.cgColor
        backShape.lineWidth = strokeWidth
        backShape.lineCap = kCALineCapRound
        backShape.strokeColor = strokeColor.cgColor
        
        addSubview(label)
        let insetX = bounds.width/4
        let insetY = bounds.height/4
        label.frame = bounds.insetBy(dx: insetX, dy: insetY)
        //label.font = UIFont.systemFont(ofSize: CGFloat(centerLabelSize))
        label.font = label.font.withSize(CGFloat(28))
        label.textColor = labelColor
        label.textAlignment = .center
        //label.text = self.elapsedTime == nil ? "00m00s" : self.elapsedTime!
        label.text = elapsedTime

    
        
        
    
    }
    

    
    /*
    // Only override draw() if you perform custom drawing.
    // An empty implementation adversely affects performance during animation.
    override func draw(_ rect: CGRect) {
        // Drawing code
    }
    */

}
