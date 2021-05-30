//
//  LoadingIndicatorView.swift
//
//  Created by Melvin Asare on 16/11/2020.
//

import UIKit

class LoadingIndicatorView: UIView {

    private lazy var loadingImageView: UIImageView = {
        let imageView = UIImageView(image: UIImage(named: "loading_image"))
        imageView.translatesAutoresizingMaskIntoConstraints = false
        imageView.isUserInteractionEnabled = false
        imageView.contentMode = .scaleAspectFit
        return imageView
    }()

    func startAnimation() {
        let rotationAnimation = CABasicAnimation(keyPath: "transform.rotation")
        rotationAnimation.fromValue = 0.0
        rotationAnimation.toValue = Double.pi * 2
        rotationAnimation.duration = 2.0
        rotationAnimation.repeatCount = .infinity
        loadingImageView.layer.anchorPoint = CGPoint(x: 1.0, y: 0.0)
        loadingImageView.layer.add(rotationAnimation, forKey: "rotate-animation")
    }

    func stopAnimation() {
        loadingImageView.isHidden = true
    }

    init() {
        super.init(frame: .zero)
        setup()
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

private extension LoadingIndicatorView {
    func setup() {
        addSubview(loadingImageView)
        loadingImageView.widthAnchor.constraint(equalToConstant: Constants.loadingIndicatorWidth).isActive = true
        loadingImageView.heightAnchor.constraint(equalToConstant: Constants.loadingIndicatorWidth).isActive = true
        loadingImageView.centerYAnchor.constraint(equalTo: centerYAnchor).isActive = true
        loadingImageView.centerXAnchor.constraint(equalTo: centerXAnchor).isActive = true
    }

    struct Constants {
        static let loadingIndicatorWidth: CGFloat = 50
    }
}
