//
//  ChatMessage.swift
//  DeepSeekChatAPIDemo
//
//  Created by devlink on 2025/8/31.
//

import Foundation

struct ChatMessage: Identifiable, Equatable {
    let id = UUID()
    let role: String
    var content: String
    let timestamp: Date
    
    init(role: String, content: String, timestamp: Date = Date()) {
        self.role = role
        self.content = content
        self.timestamp = timestamp
    }
}
