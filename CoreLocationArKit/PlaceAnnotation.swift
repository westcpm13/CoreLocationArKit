//
//  PlaceAnnotation.swift
//  CoreLocationArKit
//
//  Created by Paweł Trojan on 21.10.2017.
//  Copyright © 2017 Paweł Trojan. All rights reserved.
//

import Foundation
import ARCL
import CoreLocation
import SceneKit

class PlaceAnnotation: LocationNode {
    var title: String!
    var annotationNode: SCNNode
    
    init(location: CLLocation?, title: String) {
        self.annotationNode = SCNNode()
        self.title = title
        super.init(location: location)
        self.initializeUI()
    }
    
    private func center(node: SCNNode) {
        let (min,max) = node.boundingBox
        let dx = min.x + 0.5 * (max.x - min.x)
        let dy = min.y + 0.5 * (max.y - min.y)
        let dz = min.z + 0.5 * (max.z - min.z)
        node.pivot = SCNMatrix4MakeTranslation(dx, dy, dz)
    }
    
    
    private func initializeUI() {
        
        let plane = SCNPlane(width: 5, height: 5)
        plane.cornerRadius = 0.2
        plane.firstMaterial?.diffuse.contents = UIColor.yellow
        
        let text = SCNText(string: self.title, extrusionDepth: 0)
        text.containerFrame = CGRect(x: 0, y: 0, width: 5, height: 3)
        text.font = UIFont(name: "Futura", size: 1.0)
        text.isWrapped = true
        text.firstMaterial?.diffuse.contents = UIColor.white
        text.firstMaterial?.specular.contents = UIColor.red
        let textNode = SCNNode(geometry: text)
        textNode.position = SCNVector3(0,0,0.2)
        self.center(node: textNode)
        
        let planeNode = SCNNode(geometry: plane)
        planeNode.addChildNode(textNode)
        
        self.annotationNode.scale = SCNVector3(3,3,3)
        self.annotationNode.addChildNode(planeNode)
        
        let billboardContriant = SCNBillboardConstraint()
        billboardContriant.freeAxes = SCNBillboardAxis.Y
        constraints = [billboardContriant]
        self.addChildNode(self.annotationNode)
        
    }
        required init?(coder aDecoder: NSCoder) {
        fatalError("Init(coder:) has not been implemented")
    }
    
}
