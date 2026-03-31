//
//  Moon3DView.swift
//  Lilith
//
//  Created by GE-Developer
//

import SwiftUI
import SceneKit

struct Moon3DView: UIViewRepresentable {

    func makeUIView(context: Context) -> SCNView {
        let scnView = SCNView()
        scnView.backgroundColor = .clear
        scnView.allowsCameraControl = false
        scnView.autoenablesDefaultLighting = false
        scnView.antialiasingMode = .multisampling4X
        scnView.isUserInteractionEnabled = false

        let scene = SCNScene()
        scene.background.contents = UIColor.clear

        // Moon sphere
        let sphere = SCNSphere(radius: 1.0)
        sphere.segmentCount = 64

        let material = SCNMaterial()
        material.diffuse.contents = Image.custom.moonTexture
        material.diffuse.intensity = 0.7
        material.ambient.contents = Color.moon.materialAmbient
        material.specular.contents = Color.moon.materialSpecular
        material.shininess = 0.02
        sphere.materials = [material]

        let moonNode = SCNNode(geometry: sphere)
        scene.rootNode.addChildNode(moonNode)

        // Moon rotation
        let rotation = SCNAction.rotateBy(x: 0, y: .pi * 2, z: 0, duration: 60)
        moonNode.runAction(.repeatForever(rotation))

        // Orbital rings
        addOrbitalRings(to: scene)

        // Camera (orthographic — sphere fills the view exactly)
        let cameraNode = SCNNode()
        cameraNode.camera = SCNCamera()
        cameraNode.camera?.usesOrthographicProjection = true
        cameraNode.camera?.orthographicScale = 1.08
        cameraNode.position = SCNVector3(0, 0, 5)
        scene.rootNode.addChildNode(cameraNode)

        // Directional light — dimmer for darker moon
        let lightNode = SCNNode()
        lightNode.light = SCNLight()
        lightNode.light?.type = .directional
        lightNode.light?.intensity = 700
        lightNode.light?.color = Color.moon.directionalLight
        lightNode.eulerAngles = SCNVector3(-0.3, -0.5, 0)
        scene.rootNode.addChildNode(lightNode)

        // Ambient light — very dim
        let ambientNode = SCNNode()
        ambientNode.light = SCNLight()
        ambientNode.light?.type = .ambient
        ambientNode.light?.intensity = 80
        ambientNode.light?.color = Color.moon.ambientLight
        scene.rootNode.addChildNode(ambientNode)

        scnView.scene = scene
        return scnView
    }

    func updateUIView(_ uiView: SCNView, context: Context) {}

    // MARK: - Orbital Rings

    private func addOrbitalRings(to scene: SCNScene) {
        let accentOne = Color.moon.accentOne
        let accentTwo = Color.moon.accentTwo
        let accentMix = Color.moon.accentMix

        let configs: [(radius: CGFloat, pipe: CGFloat, tilt: SCNVector3, speed: TimeInterval, color: UIColor)] = [
            (1.04, 0.009, SCNVector3(0.5, 0.3, 0.2),  6, accentOne),
            (1.07, 0.008, SCNVector3(-0.4, 0.6, -0.3), 8, accentTwo),
            (1.10, 0.007, SCNVector3(0.2, -0.5, 0.4),  7, accentMix),
        ]

        for (i, config) in configs.enumerated() {
            let torus = SCNTorus(ringRadius: config.radius, pipeRadius: config.pipe)
            torus.ringSegmentCount = 100
            torus.pipeSegmentCount = 12

            let mat = SCNMaterial()
            mat.diffuse.contents = config.color.withAlphaComponent(0.15)
            mat.emission.contents = config.color
            mat.emission.intensity = 0.7
            mat.transparency = 0.35
            mat.isDoubleSided = true
            mat.writesToDepthBuffer = false
            torus.materials = [mat]

            let ringNode = SCNNode(geometry: torus)
            ringNode.eulerAngles = config.tilt
            scene.rootNode.addChildNode(ringNode)

            let dir: CGFloat = i % 2 == 0 ? .pi * 2 : -.pi * 2
            let action = SCNAction.rotateBy(
                x: dir * 0.2,
                y: dir,
                z: dir * 0.1,
                duration: config.speed
            )
            ringNode.runAction(.repeatForever(action))
        }

        // Soft accent light for rings
        let accentLight = SCNNode()
        accentLight.light = SCNLight()
        accentLight.light?.type = .directional
        accentLight.light?.intensity = 150
        accentLight.light?.color = Color.moon.accentMix
        accentLight.eulerAngles = SCNVector3(0.3, 0.5, 0)
        scene.rootNode.addChildNode(accentLight)
    }
}
