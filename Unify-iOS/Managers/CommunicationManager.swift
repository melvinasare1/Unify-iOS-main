//
//  CommunicationManager.swift
//  Unify-iOS
//
//  Created by Melvin Asare on 15/05/2021.
//

import FirebaseDatabase

class CommunicationManager {

    static let shared = CommunicationManager()

    var messages = [Message]()
    var messagesDictionary = [String: Message]()

    func sendMessages(usersId: String, sentText: String) {
        let reference = Database.database().reference(withPath: Unify.strings.messages)
        let childRefence = reference.childByAutoId()
        let fromId = AccountManager.account.currentUser?.uid
        let timestamp = NSNumber(value: NSDate().timeIntervalSince1970)
        let values = ["toId": usersId,"fromId": fromId!, "text": sentText, "timestamp": timestamp] as [String : Any]
        childRefence.updateChildValues(values)
    }

    func retrieveMessages(_ completion: @escaping ([Messages]) -> Void) {
//        let reference = Database.database().reference(withPath: Unify.strings.messages)
//        reference.observe(.childAdded) { [weak self] snapshot in
//            guard let self = self else { return }
//            if let dictionary = snapshot.value as? [String: AnyObject] {
//                var message = Messages(fromId: "", text: "", timestamp: NSNumber(), toId: "")
//
//                message.fromId = dictionary["fromId"] as? String ?? ""
//                message.text = dictionary["text"] as? String ?? ""
//                message.toId = dictionary["toId"] as? String ?? ""
//                message.timestamp = (dictionary["timestamp"] as? NSNumber)!
//
//                if let toId = message.toId {
//                    self.messagesDictionary[toId] = message
//                    self.messages = Array(self.messagesDictionary.values)
//                }
//
//                self.messages.append(message)
//                completion(self.messages)
//            }
//        } withCancel: { error in
//            print(error)
//        }
    }
}
