//
//  UIViewController+Extensions.swift
//  Unify-iOS
//
//  Created by Melvin Asare on 13/05/2021.
//

import UIKit
import SearchTextField
import CDAlertView


extension UIViewController {

    public func add(childViewController: UIViewController, to containerView: UIView) {
        addChild(childViewController)
        containerView.addSubview(childViewController.view)
        childViewController.view.frame = containerView.bounds
        childViewController.didMove(toParent: self)
    }

    public func removeBarButtonItems() {
        let leftBarButton = UIBarButtonItem(title: "", style: .plain, target: nil, action: nil)

        navigationItem.leftBarButtonItem = leftBarButton
        navigationItem.rightBarButtonItem = leftBarButton
    }

    public func safeEmail(emailAddress: String) -> String {
        var safeEmail = emailAddress.replacingOccurrences(of: ".", with: "-")
        safeEmail = safeEmail.replacingOccurrences(of: "@", with: "-")
        return safeEmail
    }

    public func isPasswordValid(password: String) -> Bool {
        let passwordTest = NSPredicate(format: "SELF MATCHES %@ ", "^(?=.*[a-z])(?=.*[0-9])(?=.*[A-Z]).{8,}$")
        return passwordTest.evaluate(with: password)
    }

    public func isEmailValid(_ email: String) -> Bool {
        let emailRegEx = "(?:[a-z0-9!#$%\\&'*+/=?\\^_`{|}~-]+(?:\\.[a-z0-9!#$%\\&'*+/=?\\^_`{|}"+"~-]+)*|\"(?:[\\x01-\\x08\\x0b\\x0c\\x0e-\\x1f\\x21\\x23-\\x5b\\x5d-\\"+"x7f]|\\\\[\\x01-\\x09\\x0b\\x0c\\x0e-\\x7f])*\")@(?:(?:[a-z0-9](?:[a-"+"z0-9-]*[a-z0-9])?\\.)+[a-z0-9](?:[a-z0-9-]*[a-z0-9])?|\\[(?:(?:25[0-5"+"]|2[0-4][0-9]|[01]?[0-9][0-9]?)\\.){3}(?:25[0-5]|2[0-4][0-9]|[01]?[0-"+"9][0-9]?|[a-z0-9-]*[a-z0-9]:(?:[\\x01-\\x08\\x0b\\x0c\\x0e-\\x1f\\x21"+"-\\x5a\\x53-\\x7f]|\\\\[\\x01-\\x09\\x0b\\x0c\\x0e-\\x7f])+)\\])"
        let emailTest = NSPredicate(format:"SELF MATCHES[c] %@", emailRegEx)
        return emailTest.evaluate(with: email)
    }

    public func isUsernameValidLength(_ username: String) -> Bool {
        if username.count < 3 {
            return false
        }
        return true
    }

    static var rootViewController: UserLoginOptionsViewController? {
        guard
            let window = UIApplication.shared.keyWindow,
            let rootViewController = window.rootViewController
        else { return nil }

        return rootViewController as? UserLoginOptionsViewController
    }

    static var topPresented: UIViewController? {
        guard var topController: UIViewController = rootViewController else { return nil }
        while let newTopController = topController.presentedViewController {
            topController = newTopController
        }
        return topController
    }

    func hasSpecChars(text: String) -> Bool {
        var invalidChars = CharacterSet.letters
        invalidChars.insert(charactersIn: " ")
        invalidChars.invert()
        let acceptedChars = text.trimmingCharacters(in: invalidChars)
        return acceptedChars.count < text.count
    }

    @objc func returnToMainPage() {
        let controllers = self.navigationController?.viewControllers
        for vc in controllers! {
            if vc is UserLoginOptionsViewController {
                _ = self.navigationController?.popToViewController(vc as! UserLoginOptionsViewController, animated: true)
            }
        }
    }

    func filterThroughCourses(to filter: [Course], courseTextField: SearchTextField) {
        let courseName = filter.compactMap { $0.name }
        courseTextField.filterStrings(courseName)
        courseTextField.theme.separatorColor = UIColor(red: 0.9, green: 0.9, blue: 0.9, alpha: 0.5)
        courseTextField.theme.fontColor = .darkGray
        courseTextField.theme.font = UIFont.systemFont(ofSize: 18)
        courseTextField.theme.cellHeight = 50
        courseTextField.theme.borderColor  = UIColor (red: 0.9, green: 0.9, blue: 0.9, alpha: 1)
        courseTextField.comparisonOptions = [.caseInsensitive]
    }

    func filterThroughUniversity(to filter: [University], universityTextField: SearchTextField) {
        let universityName = filter.compactMap { $0.name }
        universityTextField.filterStrings(universityName)
        universityTextField.theme.separatorColor = UIColor(red: 0.9, green: 0.9, blue: 0.9, alpha: 0.5)
        universityTextField.theme.fontColor = .darkGray
        universityTextField.theme.font = UIFont.systemFont(ofSize: 18)
        universityTextField.theme.cellHeight = 50
        universityTextField.theme.borderColor  = UIColor (red: 0.9, green: 0.9, blue: 0.9, alpha: 1)
        universityTextField.comparisonOptions = [.caseInsensitive]
    }

    func filterThroughYear(to filter: [StudyYear], studyYearTextField: SearchTextField) {
        let studyYear = filter.compactMap { $0.year }
        studyYearTextField.filterStrings(studyYear)
        studyYearTextField.theme.separatorColor = UIColor(red: 0.9, green: 0.9, blue: 0.9, alpha: 0.5)
        studyYearTextField.theme.fontColor = .darkGray
        studyYearTextField.theme.font = UIFont.systemFont(ofSize: 18)
        studyYearTextField.theme.cellHeight = 50
        studyYearTextField.theme.borderColor  = UIColor (red: 0.9, green: 0.9, blue: 0.9, alpha: 1)
        studyYearTextField.comparisonOptions = [.caseInsensitive]
    }

   public func presentCustomAlert(title: String, message: String, buttonTitle: String) {
        DispatchQueue.main.async {
            let alertVC = UnifyAlertView(title: title, message: message, buttonTitle: buttonTitle)
            alertVC.modalPresentationStyle = .overFullScreen
            alertVC.modalTransitionStyle = .crossDissolve
            self.present(alertVC, animated: true)
        }
    }

    public func presentCDAlert(title: String, message: String, buttonTitle: String, type: CDAlertViewType) {
        DispatchQueue.main.async {
            let alert = CDAlertView(title: title, message: message, type: type)
            let doneAction = CDAlertViewAction(title: buttonTitle)
            alert.add(action: doneAction)
            alert.show()
        }
    }
}
