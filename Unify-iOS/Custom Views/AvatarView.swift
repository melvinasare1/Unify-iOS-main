//
//  AvatarView.swift
//  Unify-iOS
//
//  Created by Melvin Asare on 02/03/2021.
//

import UIKit

class AvatarView: UIImageView {

    override init(image: UIImage?) {
        super.init(image: image)
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    override func layoutSubviews() {
        super.layoutSubviews()
        layer.cornerRadius = bounds.width / 2.0
    }
}


private extension AvatarView {
    func setup() {
        translatesAutoresizingMaskIntoConstraints = false
        isUserInteractionEnabled = true
        backgroundColor = .red
//        clipsToBounds = true
        layer.masksToBounds = true
    }
}
