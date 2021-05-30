//
//  UnifyAlertView.swift
//  Unify-iOS
//
//  Created by Melvin Asare on 14/05/2021.
//

import UIKit

class UnifyAlertView: UIViewController {

    private lazy var containerView: UIView = {
        let view = UIView()
        view.backgroundColor = .systemBackground
        view.layer.cornerRadius = 16
        view.layer.borderWidth = 2
        view.layer.borderColor = UIColor.white.cgColor
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()

    private lazy var titleLabel: UnifyTitleLabel = {
        let label = UnifyTitleLabel()
        label.configure(textAlignment: .center, fontSize: 30, titleText: alertTitle ?? "Something went wrong" )
        label.textColor = .black
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()

    private lazy var messageLabel: UnifyTitleLabel = {
        let label = UnifyTitleLabel()
        label.configure(textAlignment: .center, fontSize: 24, titleText: message ?? "Unable to complete request")
        label.textColor = .black
        label.numberOfLines = 4
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()

    private lazy var actionButton: UIButton = {
        let button = UIButton()
        button.translatesAutoresizingMaskIntoConstraints = false
        button.setTitle(buttonTitle ?? "Ok", for: .normal)
        button.backgroundColor = .green
        button.addTarget(self, action: #selector(dismissVC), for: .touchUpInside)
        return button
    }()

    public var alertTitle: String?
    public var message: String?
    public var buttonTitle: String?
    let padding: CGFloat = 20

    init(title: String, message: String, buttonTitle: String) {
        super.init(nibName: nil, bundle: nil)
        self.alertTitle     = title
        self.message        = message
        self.buttonTitle    = buttonTitle
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        setup()
    }

    @objc func dismissVC() {
        dismiss(animated: true)
    }
}

private extension UnifyAlertView {
    func setup() {
        view.backgroundColor = UIColor(red: 0, green: 0, blue: 0, alpha: 0.75)

        view.addSubview(containerView)
        containerView.addSubview(titleLabel)
        containerView.addSubview(messageLabel)
        containerView.addSubview(actionButton)

        containerView.centerYAnchor.constraint(equalTo: view.centerYAnchor).isActive = true
        containerView.centerXAnchor.constraint(equalTo: view.centerXAnchor).isActive = true
        containerView.widthAnchor.constraint(equalToConstant: 280).isActive = true
        containerView.heightAnchor.constraint(equalToConstant: 220).isActive = true

        titleLabel.topAnchor.constraint(equalTo: containerView.topAnchor, constant: padding).isActive = true
        titleLabel.leadingAnchor.constraint(equalTo: containerView.leadingAnchor, constant: padding).isActive = true
        titleLabel.trailingAnchor.constraint(equalTo: containerView.trailingAnchor, constant: -padding).isActive = true
        titleLabel.heightAnchor.constraint(equalToConstant: 28).isActive = true

        messageLabel.topAnchor.constraint(equalTo: titleLabel.bottomAnchor, constant: 8).isActive = true
        messageLabel.leadingAnchor.constraint(equalTo: containerView.leadingAnchor, constant: padding).isActive = true
        messageLabel.trailingAnchor.constraint(equalTo: containerView.trailingAnchor, constant: -padding).isActive = true
        messageLabel.bottomAnchor.constraint(equalTo: actionButton.topAnchor, constant: -12).isActive = true

        actionButton.bottomAnchor.constraint(equalTo: containerView.bottomAnchor, constant: -padding).isActive = true
        actionButton.leadingAnchor.constraint(equalTo: containerView.leadingAnchor, constant: padding).isActive = true
        actionButton.trailingAnchor.constraint(equalTo: containerView.trailingAnchor, constant: -padding).isActive = true
        actionButton.heightAnchor.constraint(equalToConstant: 44).isActive = true
    }
}
