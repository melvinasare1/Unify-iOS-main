//
//  NetworkManager.swift
//  Unify-iOS
//
//  Created by Melvin Asare on 20/10/2020.
//

import FirebaseAuth
import FirebaseDatabase
import FirebaseStorage
import FirebaseFirestore
import SwiftyJSON

class NetworkManager {
    
    public static let shared = NetworkManager()
    private let database = Database.database().reference()
    private let userDefaults = UserDefaults()
    
    var users = [User]()
    var universities = [University]()
    var userId: String?
    
    var reset = false
}

// MARK: - Fetch User Data

extension NetworkManager {
    func fetchUserProfile(_ completion: @escaping ([User])-> Void) {
        Database.database().reference(withPath: Unify.strings.users).observe(.childAdded) { [weak self] (snapshot) in
            guard let self = self else { return }
            if let dictionary = snapshot.value as? [String: AnyObject] {
                if self.reset {
                    self.reset = false
                    self.users = [User]()
                }
                var user = User(name: "", email: "", profile_picture_url: "", toId: "", is_Online: true, university: University(name: "", location: "", picture: "profileImage1"), course: Course(name: ""), studyYear: StudyYear(year: ""))
                
                user.name = dictionary["name"] as? String ?? ""
                user.profile_picture_url = dictionary["profile_picture"] as? String ?? ""
                user.email = dictionary["email"] as! String
                user.university.name = dictionary["university_name"] as? String ?? ""
                user.course.name = dictionary["course"] as? String ?? ""
                user.studyYear.year = dictionary["year"] as? String ?? ""
                user.toId = dictionary["toId"] as? String ?? ""
                self.users.append(user)
                completion(self.users)
            }
        } withCancel: { error in
            print("error")
        }
    }
    
    func fetchUnivertyData(_ completion: @escaping ([University]) -> Void) {
        Database.database().reference(withPath: "Universities").observe(.childAdded) { [weak self] (snapshot) in
            guard let self = self else { return }
            if let dictionary = snapshot.value as? [String: AnyObject] {
                var university = University(name: "", location: "", picture: "")
                
                university.picture = dictionary["picture"] as? String ?? ""
                university.location = dictionary["location"] as? String ?? ""
                university.name = dictionary["name"] as? String ?? ""
                
                self.universities.append(university)
                completion(self.universities)
            }
        } withCancel: { error in
            print("there is an issue")
        }
    }

    func saveUserID(id: String) {
        UserDefaults.standard.set(id, forKey: "Id")
    }

    func saveUserName(name: String) {
        UserDefaults.standard.set(name, forKey: "Name")
    }

    func saveUserUniversity(university: String) {
        UserDefaults.standard.set(university, forKey: "University")
    }

    func saveUserCourse(course: String) {
        UserDefaults.standard.set(course, forKey: "Course")
    }

    func saveUserYear(year: String) {
        UserDefaults.standard.set(year, forKey: "Year")
    }

    func saveUserAvatar(avatar: String) {
        UserDefaults.standard.set(avatar, forKey: "Avatar")
    }
}

// MARK: - Account Creation

extension NetworkManager {

    func signInWithEmail(email: String, password: String,_ completion: @escaping (Bool) -> Void?) {
        Auth.auth().signIn(withEmail: email, password: password) { (result, _) in
            guard let _ = result else {
                 completion(false)
                return
            }
            completion(true)
        }
    }

    func createUserWithEmail(email: String, password: String, _ completion: @escaping (AuthDataResult) -> Void) {
        Auth.auth().createUser(withEmail: email, password: password) { [weak self] (result, error) in
            guard let result = result,
                  let self = self
            else { return }

            self.userId = result.user.uid
            self.addUserEmailToDatabase(email: email, userId: result.user.uid)
            self.signInWithEmail(email: email, password: password) { _ in }
            completion(result)
        }
        
    }

    func addUserToDatabase(userId: String, name: String, university_name: String, course: String, yearOfStudy: String,_ completion: @escaping (Bool) -> Void) {
        if let uid = Auth.auth().currentUser?.uid {
            print("we have the current user id ")

            let reference = Database.database().reference().child(Unify.strings.users)
            let userReference = reference.child(userId)
            let values = ["name": name, "university_name": university_name, "course": course, "year": yearOfStudy, "toId": userId]
            userReference.updateChildValues(values) { (error, reference) in
                if error != nil {
                    completion(false)
                }
                completion(true)
            }
        }
    }
    
    func addUserEmailToDatabase(email: String, userId: String) {
        if let uid = Auth.auth().currentUser?.uid {
            print("we have the current user id ")

            let reference = Database.database().reference().child(Unify.strings.users)
            let userReference = reference.child(uid)
            let values = ["email": email]
            userReference.updateChildValues(values) { error, reference in
                if error != nil {
                    print("Saving user to database failed")
                }
            }
        }
    }
    
    func addUserNameToDatabase(name: String, userId: String) {
        if let uid = Auth.auth().currentUser?.uid {
            print("we have the current user id ")

            let reference = Database.database().reference().child(Unify.strings.users)
            let userReference = reference.child(userId)
            let values = ["name": name]
            userReference.updateChildValues(values) { (error, reference) in
                if error != nil {
                    print("adding username failed")
                }
            }
        }
    }
    
    func addUniversityToDatabase(universityName: String, universityLocation: String, userId: String) {
        if let uid = Auth.auth().currentUser?.uid {
            print("we have the current user id ")

            let reference = Database.database().reference(withPath: "Users")
            let universityNameReference = reference.child(universityName).child(userId)
            let universityLocationReference = reference.child(universityLocation).child(userId)
            let universityNameValue = ["university_name": universityName]
            let universityLocationValue = ["university_location": universityLocation]

            universityLocationReference.updateChildValues(universityLocationValue) { (error, reference) in
                if error != nil {
                    print("Adding university location failed")
                }
                print("adding university location worked")
            }

            universityNameReference.updateChildValues(universityNameValue) { (error, reference) in
                if error != nil {
                    print("Adding university name failed")
                }
            }
        }
    }

    func addCourseToDatabase(course: String, userId: String) {
        if let uid = Auth.auth().currentUser?.uid {
            print("we have the current user id ")

            let reference = Database.database().reference(withPath: "Users")
            let userReference = reference.child(course).child(userId)
            let value = ["course": course]
            userReference.updateChildValues(value) { (error, reference) in
                if error != nil {
                    print("Adding course failed")
                }
            }
        }
    }
    
    func addYearToDatabase(year: String, userId: String) {
        if let uid = Auth.auth().currentUser?.uid {
            print("we have the current user id ")

            let reference = Database.database().reference(withPath: "Users")
            let userReference = reference.child(year).child(userId)
            let value = ["year": year]
            userReference.updateChildValues(value) { (error, reference) in
                if error != nil {
                    print("Adding year failed")
                }
                print("adding year worked")
            }
        }
    }

    func retrieveUsersFromUniversity(_ completion: @escaping ([User]) -> Void) {

    }

    func uploadImageToFirebaseStorage(avatarView: UIImageView, userId: String) {
        guard
            let profileImage = avatarView.image,
            let data = profileImage.jpegData(compressionQuality: 0.5)
        else {
            return
        }
        let imageName = UUID().uuidString
        let imageReference = Storage.storage().reference().child(Unify.strings.profile_picture).child(imageName)

        imageReference.putData(data, metadata: nil) { (metadata, error) in
            if error != nil { return }

            imageReference.downloadURL { (url, error) in
                if error != nil { return }


                guard let url = url else { return }

                let dataReference = Firestore.firestore().collection(Unify.strings.profile_picture).document()
                let documentUid = dataReference.documentID
                let urlString = url.absoluteString

                let userReference = Database.database().reference(withPath: Unify.strings.users).child(userId)

                let values = [Unify.strings.profile_picture: urlString]
                print("Here is your image String \(values)")
                userReference.updateChildValues(values) { (error, reference) in
                    if error != nil {
                        print(" Here is your error and why it didnt work \(error!)")
                    } else {
                        print("Profile Picture Saved")
                    }
                }

                let data = [Unify.strings.profile_picture_uid: documentUid, Unify.strings.profile_url: url.absoluteString] as [String : Any]
                dataReference.setData(data) { (error) in
                    if error != nil { return }

                    self.userDefaults.set(documentUid, forKey: Unify.strings.profile_picture_uid)
                    avatarView.image = UIImage()
                }
            }
        }
    }
}
