//
//  UnifySearchTextField.swift
//  Unify-iOS
//
//  Created by Melvin Asare on 02/03/2021.
//

import SearchTextField

class UnifySearchTextField: SearchTextField {

    private let line: UIView = {
        let view = UIView()
        view.backgroundColor = .darkGray
        view.translatesAutoresizingMaskIntoConstraints = false
        view.isUserInteractionEnabled = true
        return view
    }()

    override init(frame: CGRect) {
        super.init(frame: frame)
        setup()
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    func configure(placeholder: String, color: UIColor, textAlignment: NSTextAlignment) {
        attributedPlaceholder = NSAttributedString(string: placeholder,
                                                             attributes: [NSAttributedString.Key.foregroundColor: color])
        self.textAlignment = textAlignment
    }
}

private extension UnifySearchTextField {
    func setup() {
        translatesAutoresizingMaskIntoConstraints = false
        isUserInteractionEnabled = true
        addSubview(line)

        line.topAnchor.constraint(equalTo: bottomAnchor, constant: 10).isActive = true
        line.heightAnchor.constraint(equalToConstant: 1).isActive = true
        line.widthAnchor.constraint(equalTo: widthAnchor).isActive = true
        line.centerXAnchor.constraint(equalTo: centerXAnchor).isActive = true
    }
}
