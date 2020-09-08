//
//  GradientView.swift
//  VkNewsFeed
//
//  Created by Анастасия Леонтьева on 08.09.2020.
//  Copyright © 2020 lagarnas. All rights reserved.
//

import Foundation
import UIKit

class GradientView: UIView {
  
  @IBInspectable private var startColor: UIColor? {
    didSet {
      setupGradientColors()
    }
  }
  @IBInspectable private var endColor: UIColor? {
    didSet {
      setupGradientColors()
    }
  }
  
  private let gradientLayer = CAGradientLayer()
  
  
  override init(frame: CGRect) {
    super.init(frame: frame)
  }
  
  required init?(coder: NSCoder) {
    super.init(coder: coder)
    setupGradient()
  }
  
  override func layoutSubviews() {
    super.layoutSubviews()
    gradientLayer.frame = bounds
  }
  
  private func setupGradient() {
    self.layer.addSublayer(gradientLayer)
    setupGradientColors()
    gradientLayer.startPoint = CGPoint(x: 0, y: 0)
    gradientLayer.endPoint = CGPoint(x: 1, y: 1)
    
  }
  
  private func setupGradientColors() {
    guard
      let startColor = startColor,
      let endColor = endColor else { return }
    gradientLayer.colors = [startColor.cgColor, endColor.cgColor]
  }
  
}

