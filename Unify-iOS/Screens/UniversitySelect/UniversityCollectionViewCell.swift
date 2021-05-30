//
//  UniversityCollectionViewCell.swift
//  Unify-iOS
//
//  Created by Melvin Asare on 04/03/2021.
//

import UIKit
import SDWebImage

class UniversityCollectionViewCell: UICollectionViewCell {

    private let universityImage: UIImageView = {
        let imageView = UIImageView()
        imageView.translatesAutoresizingMaskIntoConstraints = false
        imageView.clipsToBounds = true
        imageView.layer.cornerRadius = 8
        imageView.layer.backgroundColor = UIColor.unifyBlue.cgColor
        return imageView
    }()

    private let universityName: UILabel = {
        let label = UILabel()
        label.numberOfLines = 0
        label.textAlignment = .center
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()

    private var university: University?

    func configure(university: University) {
        universityName.text = university.name
        universityImage.sd_setImage(with: URL(string: university.picture, relativeTo: nil))
    }

    override init(frame: CGRect) {
        super.init(frame: frame)
        setup()
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

private extension UniversityCollectionViewCell {

    struct Constant {
        static let padding: CGFloat = 8
    }

    func setup() {
        addSubview(universityImage)
        addSubview(universityName)

        universityImage.topAnchor.constraint(equalTo: contentView.topAnchor).isActive = true
        universityImage.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: Constant.padding).isActive = true
        universityImage.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -Constant.padding).isActive = true
        universityImage.heightAnchor.constraint(equalTo: universityImage.widthAnchor).isActive = true

        universityName.bottomAnchor.constraint(equalTo: contentView.bottomAnchor, constant: -Constant.padding).isActive = true
        universityName.leadingAnchor.constraint(equalTo: universityImage.leadingAnchor).isActive = true
        universityName.trailingAnchor.constraint(equalTo: universityImage.trailingAnchor).isActive = true
    }
}
