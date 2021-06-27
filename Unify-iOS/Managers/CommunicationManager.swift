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
    let userId = AccountManager.account.currentUser?.uid

    private func safeEmail(emailAddress: String) -> String {
        var safeEmail = emailAddress.replacingOccurrences(of: ".", with: "-")
        safeEmail = safeEmail.replacingOccurrences(of: "@", with: "-")
        return safeEmail
    }

    public func createNewConversatioon(with otherUserEmail: String, firstMessage: Message, _ completion: @escaping (Bool) -> Void) {
        guard let currentEmail = UserDefaults.standard.value(forKey: "Email") as? String else { return }

        let reference = Database.database().reference(withPath: "Users").child(userId!)
        
        reference.observeSingleEvent(of: .value) { [weak self] snapshot in
            print(snapshot)
            guard var userNode = snapshot.value as? [String: Any] else {
                completion(false)
                return
            }

            let messageDate = firstMessage.sentDate
            let dateString = ChatLogViewController.dateFormatter.string(from: messageDate)
            var message = ""
            switch firstMessage.kind {

            case .text(let messageText):
                message = messageText
            case .attributedText(_):
                break
            case .photo(_):
                break
            case .video(_):
                break
            case .location(_):
                break
            case .emoji(_):
                break
            case .audio(_):
                break
            case .contact(_):
                break
            case .linkPreview(_):
                break
            case .custom(_):
                break
            }

            let conversationId = "conversation_\(firstMessage.messageId)"

            let newConversationData: [String: Any] = [
                "id": conversationId,
                "other_user_email": otherUserEmail,
                "latestMessage": [
                    "date": dateString,
                    "message": message,
                    "is_read": false
                ]
            ]

            if var conversation = userNode["conversations"] as? [[String: Any]] {
                conversation.append(newConversationData)
                userNode["conversations"] = conversation
                reference.setValue(userNode) { [weak self] (error, _) in
                    guard error == nil else {
                        completion(false)
                        return
                    }
                    self?.finishCreatingConversation(conversationId: conversationId, firstMessage: firstMessage, completion)

                }
            } else {
                userNode["conversations"] = [
                    newConversationData
                ]

                reference.setValue(userNode) { [weak self] (error, _) in
                    guard error == nil else {
                        completion(false)
                        return
                    }
                    self?.finishCreatingConversation(conversationId: conversationId, firstMessage: firstMessage, completion)
                }
            }
        } withCancel: { (error) in

        }
    }

    private func finishCreatingConversation(conversationId: String, firstMessage: Message, _ completion: @escaping (Bool)-> Void) {

        let messageDate = firstMessage.sentDate
        let dateString = ChatLogViewController.dateFormatter.string(from: messageDate)

        var message = ""
        switch firstMessage.kind {

        case .text(let messageText):
            message = messageText
        case .attributedText(_):
            break
        case .photo(_):
            break
        case .video(_):
            break
        case .location(_):
            break
        case .emoji(_):
            break
        case .audio(_):
            break
        case .contact(_):
            break
        case .linkPreview(_):
            break
        case .custom(_):
            break
        }


        guard let currentUserEmail = UserDefaults.standard.value(forKey: "Email") as? String else {
            completion(false)
            return
        }

        let safeCurrentEmail = safeEmail(emailAddress: currentUserEmail)

        let messageDictionary: [String: Any] = [
            "id": firstMessage.messageId ,
            "type": firstMessage.kind.messageKindString,
            "content": message,
            "date": dateString,
            "sender_email": safeCurrentEmail,
            "is_read": false
        ]

        let value: [String: Any] = [
            "message": [
                messageDictionary
            ]
        ]

        Database.database().reference().child("\(conversationId)").setValue(value) { (error, reference) in
            guard error == nil else {
                completion(false)
                return
            }
            completion(true)
        }
    }

    public func getAllConversations(for email: String, _ completion: @escaping (Result<String, Error>) -> Void) {

    }

    public func getAllMessagesForConversation(with id: String, _ completion: @escaping (Result<String, Error>) -> Void) {

    }

    public func sendMessagesToConversation(conversation: String, message: Message, _ completion: @escaping (Bool) -> Void) {

    }

    func sendMessages(usersId: String, sentText: String) {
        let reference = Database.database().reference(withPath: Unify.strings.messages)
        let childRefence = reference.childByAutoId()
        let fromId = AccountManager.account.currentUser?.uid
        let timestamp = NSNumber(value: NSDate().timeIntervalSince1970)
        let values = ["toId": usersId,"fromId": fromId!, "text": sentText, "timestamp": timestamp] as [String : Any]
        childRefence.updateChildValues(values)
    }
}
