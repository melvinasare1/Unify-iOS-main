//
//  Message.swift
//  Unify-iOS
//
//  Created by Melvin Asare on 08/06/2021.
//

import MessageKit

struct Messages: MessageType {
    var sender: SenderType
    var messageId: String
    var sentDate: Date
    var kind: MessageKind
}
