//
//  GradientView.swift
//  SmackChat
//
//  Created by David Ortiz on 8/30/17.
//  Copyright © 2017 David Ortiz. All rights reserved.
//

import UIKit

@IBDesignable
class GradientView: UIView {

    @IBInspectable var topColor: UIColor = #colorLiteral(red: 0.2901960784, green: 0.3019607843, blue: 0.8470588235, alpha: 1) { didSet{//colors of the background gradient
            self.setNeedsLayout()
        }
    }
    
    @IBInspectable var bottomColor: UIColor = #colorLiteral(red: 0.1725490196, green: 0.831372549, blue: 0.8470588235, alpha: 1) { didSet{//color
        self.setNeedsLayout()
        }
    }
    
    override func layoutSubviews() {//making the gradient as a subview
        let gradientLayer = CAGradientLayer()
        gradientLayer.colors = [topColor.cgColor, bottomColor.cgColor]//arrays of colors
        gradientLayer.startPoint = CGPoint(x: 0, y: 0)//start point
        gradientLayer.endPoint = CGPoint(x: 1, y: 1)//end point they go by 0 to 1
        gradientLayer.frame = self.bounds//size full screen of any device
        self.layer.insertSublayer(gradientLayer, at: 0)//adding the layer to the view (0) meand the position as Zposition
    }

}
