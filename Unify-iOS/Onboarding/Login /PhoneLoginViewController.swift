////
////  PhoneLoginViewController.swift
////  Unify-iOS
////
////  Created by Melvin Asare on 04/04/2021.
////
//
//import UIKit
//import FirebaseAuth
//
//class PhoneLoginViewController: UIViewController {
//
//    var userTelephoneNumber: UITextField = {
//        let label = UITextField()
//        label.placeholder = "Enter Number +44"
//        label.textAlignment = .center
//        label.textColor = .white
//        label.keyboardType = .numberPad
//        label.layer.cornerRadius = 12
//        label.backgroundColor = .lightGray
//        label.translatesAutoresizingMaskIntoConstraints = false
//        return label
//    }()
//
//    var verificationCode: UITextField = {
//        let label = UITextField()
//        label.textAlignment = .center
//        label.backgroundColor = .lightGray
//        label.placeholder = "Enter Your verification code"
//        label.layer.cornerRadius = 12
//        label.textAlignment = .center
//        label.translatesAutoresizingMaskIntoConstraints = false
//        return label
//    }()
//
//    @objc func requestVerificationPressed() {
//        guard let userNumber = userTelephoneNumber.text else { return }
//        if verificationCode.isHidden == true {
//            PhoneAuthProvider.provider().verifyPhoneNumber(userNumber, uiDelegate: nil) { (verificationId, error) in
//                if error == nil {
//                    guard let veryId = verificationId else { return }
//                    self.userDefeaults.set(veryId, forKey: "verificationId")
//                    self.userDefeaults.synchronize()
//
//                    self.verificationCode.isHidden = false
//                    self.requestVerificationCode.isHidden = true
//                    self.proceedToQuizPage.isHidden = false
//                    self.userName.isHidden = true
//                    self.userTelephoneNumber.isHidden = true
//                } else {
//                    print("didnt work")
//                }
//            }
//        }
//    }
//
//    @objc func oneTimePasscode() {
//        guard let otp = verificationCode.text else { return }
//        guard let verificationID = userDefeaults.string(forKey: "verificationId") else { return }
//
//        let credential = PhoneAuthProvider.provider().credential(withVerificationID: verificationID, verificationCode: otp)
//
//        Auth.auth().signIn(with: credential) { (success, error) in
//            if error == nil {
//                self.transitionToQuizPage()
//            } else {
//                self.createMyAlert(title: "Error", message: "Couldnt log in")
//            }
//        }
//
//    }
//
//    override func viewDidLoad() {
//        super.viewDidLoad()
//    }
//}
