//
//  MessagesTableViewCell.swift
//  Unify-iOS
//
//  Created by Melvin Asare on 08/05/2021.
//

import UIKit

class ConversationsTableViewCell: UITableViewCell {

    var userNameLabel: UILabel = {
        let name = UILabel()
        name.textColor = .black
        name.translatesAutoresizingMaskIntoConstraints = false
        return name
    }()

    var userMessageLabel: UILabel = {
        let name = UILabel()
        name.textColor = .black
        name.translatesAutoresizingMaskIntoConstraints = false
        return name
    }()

    var timeLabel: UILabel = {
        let name = UILabel()
        name.textColor = .black
        name.text = "hh:mm:ss"
        name.textColor = .lightGray
        name.font = UIFont.systemFont(ofSize: 14)
        name.translatesAutoresizingMaskIntoConstraints = false
        return name
    }()

    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        setup()
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

private extension ConversationsTableViewCell {
    func setup() {

        addSubview(userNameLabel)
        addSubview(userMessageLabel)
        addSubview(timeLabel)

        userNameLabel.centerYAnchor.constraint(equalTo: self.centerYAnchor, constant: 0).isActive = true
        userNameLabel.centerXAnchor.constraint(equalTo: self.centerXAnchor, constant: 0).isActive = true

        userMessageLabel.centerYAnchor.constraint(equalTo: userNameLabel.centerYAnchor, constant: 30).isActive = true
        userMessageLabel.centerXAnchor.constraint(equalTo: self.centerXAnchor, constant: 0).isActive = true

        timeLabel.trailingAnchor.constraint(equalTo: self.trailingAnchor, constant: -10).isActive = true
        timeLabel.centerYAnchor.constraint(equalTo: userNameLabel.centerYAnchor, constant: 0).isActive = true
        timeLabel.widthAnchor.constraint(equalToConstant: 100).isActive = true
        timeLabel.heightAnchor.constraint(equalTo: userNameLabel.heightAnchor, constant: 0).isActive = true
    }
}
