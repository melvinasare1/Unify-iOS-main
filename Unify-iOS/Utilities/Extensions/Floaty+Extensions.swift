//
//  Floaty+Extensions.swift
//  Unify-iOS
//
//  Created by Melvin Asare on 13/05/2021.
//

import Floaty
import UIKit

extension Floaty {

    struct Consts {
        static let floatingButtonWidth: CGFloat = 52.0
        static let floatingButtonPadding: CGFloat = 28.0
    }
    func addUnifyAction(title: String, color: UIColor,  _ handler: @escaping () -> Void) {
        let item = FloatyItem()
        let label = item.titleLabel
        item.title = title
        item.titleColor = .white
        item.titleLabel.clipsToBounds = true
        item.titleLabel.textAlignment = .center
        item.titleLabel.backgroundColor = color
        item.titleLabel.font = UIFont.boldSystemFont(ofSize: 18)
        item.titleLabel.layer.frame = CGRect(origin: label.frame.origin,
                                             size: CGSize(width: label.bounds.width + 40,
                                                          height: label.bounds.height + 26))
        item.titleLabel.layer.cornerRadius = item.titleLabel.layer.frame.height / 2.0
        item.titleLabel.layer.anchorPoint.x = 0.54
        item.buttonColor = .clear
        item.tintColor = .clear
        item.size = 40.0
        item.handler = { _ in handler() }
        addItem(item: item)
    }
}
