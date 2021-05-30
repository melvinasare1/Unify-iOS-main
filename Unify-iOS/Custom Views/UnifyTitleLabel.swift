//
//  UnifyTitleLabel.swift
//  Unify-iOS
//
//  Created by Melvin Asare on 26/02/2021.
//

import UIKit

class UnifyTitleLabel: UILabel {

    override init(frame: CGRect) {
        super.init(frame: frame)
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    func configure(textAlignment: NSTextAlignment, fontSize: CGFloat, titleText: String) {
        self.textAlignment = textAlignment
        
        textColor = .unifyBlue
        adjustsFontSizeToFitWidth = true
        minimumScaleFactor = 0.9
        numberOfLines = 0
        lineBreakMode = .byTruncatingTail
        text = titleText
        translatesAutoresizingMaskIntoConstraints = false
        font = .systemFont(ofSize: fontSize, weight: .bold)
     }
}
