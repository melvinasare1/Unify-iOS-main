//
//  MessagesTableViewCell.swift
//  Unify-iOS
//
//  Created by Melvin Asare on 08/05/2021.
//

import UIKit

class ConversationsTableViewCell: UITableViewCell {

    private let profileImageView: AvatarView = {
        let imageView = AvatarView(image: UIImage(named: "solidblue"))
        imageView.translatesAutoresizingMaskIntoConstraints = false
        imageView.clipsToBounds = true
        return imageView
    }()
    
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
        addSubview(profileImageView)

        profileImageView.centerYAnchor.constraint(equalTo: contentView.centerYAnchor).isActive = true
        profileImageView.heightAnchor.constraint(equalToConstant: 60).isActive = true
        profileImageView.widthAnchor.constraint(equalToConstant: 60).isActive = true
        profileImageView.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 15).isActive = true

        userNameLabel.leadingAnchor.constraint(equalTo: profileImageView.trailingAnchor, constant: 20).isActive = true
        userNameLabel.centerYAnchor.constraint(equalTo: profileImageView.centerYAnchor, constant: -25).isActive = true
        userNameLabel.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -20).isActive = true

        userMessageLabel.topAnchor.constraint(equalTo: userNameLabel.bottomAnchor, constant: 8).isActive = true
        userMessageLabel.leadingAnchor.constraint(equalTo: profileImageView.trailingAnchor, constant: 20).isActive = true
        userMessageLabel.trailingAnchor.constraint(equalTo: userNameLabel.trailingAnchor).isActive = true

        timeLabel.trailingAnchor.constraint(equalTo: self.trailingAnchor, constant: -10).isActive = true
        timeLabel.centerYAnchor.constraint(equalTo: userNameLabel.centerYAnchor, constant: 0).isActive = true
        timeLabel.widthAnchor.constraint(equalToConstant: 100).isActive = true
        timeLabel.heightAnchor.constraint(equalTo: userNameLabel.heightAnchor, constant: 0).isActive = true
    }
}
