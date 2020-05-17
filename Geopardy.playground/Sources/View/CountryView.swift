//
//  CountryView.swift
//  Dummy
//
//  Created by Bryan Oppong-Boateng on 10.05.20.
//  Copyright © 2020 Bryan Oppong-Boateng. All rights reserved.
//

import UIKit

class CountryView: UIView {
    
    private let shapeLayer: CAShapeLayer
    var country: CountryGeometry? {
        didSet {
            self.setNeedsDisplay()
        }
    }
    
    override init(frame: CGRect) {
        shapeLayer = CAShapeLayer()
        super.init(frame: frame)
        
        let aspectRatioConstraint = NSLayoutConstraint(item: self,attribute: .height, relatedBy: .equal, toItem: self,attribute: .width, multiplier: (1.0 / 1.0), constant: 0)
        addConstraint(aspectRatioConstraint)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    
    override func draw(_ rect: CGRect) {
        super.draw(rect)
        
        layer.addSublayer(shapeLayer)
        
        
        if let safeCountry = country {
            draw(safeCountry)
        }
    }
    
    private func draw(_ country: CountryGeometry) {
        shapeLayer.lineWidth = 2
        
        let myColor = UIColor.systemGreen
        shapeLayer.strokeColor = myColor.cgColor
        shapeLayer.fillColor = myColor.withAlphaComponent(0.2).cgColor
        

        var versions: [UIBezierPath] = []
        for shape in country.shapes {
            
            let minX = shape.min { (a, b) -> Bool in
                a.x < b.x
            }!.x
                        
            let coordinates = shiftedToLeft(shapes: country.shapes, by: minX)
            let combinedPath = bezierPath(for: coordinates)
            versions.append(combinedPath)
        }

        let smallestVersion = versions.min { (a, b) -> Bool in
            return a.bounds.width < b.bounds.width
        }!
        resize(smallestVersion)

        shapeLayer.path = smallestVersion.cgPath
    }
    
    private func shiftedToLeft(shapes: [Shape], by amount: Double) -> [Shape] {
        let coordinates = shapes.map { (shape) -> Shape in
            let returnCoors = shape.map { (coordinate) -> Coordinate in
                return Coordinate(x: (coordinate.x - amount).remainder(dividingBy: 360), y: coordinate.y)
            }
            return returnCoors
        }
        return coordinates
    }
    
    private func bezierPath(for coordinates: [[Coordinate]])  -> UIBezierPath {
        let combinedPath = UIBezierPath()
        for coors in coordinates {
            let path = UIBezierPath()

            path.move(to: CGPoint(x: coors[0].x, y: coors[0].y))
            for coordinate in coors.dropFirst() {
                path.addLine(to: CGPoint(x: coordinate.x, y: coordinate.y))
            }
            path.close()
            combinedPath.append(path)
        }
        combinedPath.close()
        
        return combinedPath
    }
    
    private func resize(_ path: UIBezierPath) {
        assert(frame.width == frame.height)
        let d = frame.width / max(path.bounds.width, path.bounds.height)
        
        let midFrame = frame.width / 2
        
        path.apply(CGAffineTransform(scaleX: d, y: -d))
        path.apply(CGAffineTransform(translationX: midFrame - path.bounds.midX, y: midFrame - path.bounds.midY))
    }
}
