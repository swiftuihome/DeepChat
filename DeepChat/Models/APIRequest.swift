//
//  APIRequest.swift
//  DeepSeekChatAPIDemo
//
//  Created by devlink on 2025/8/31.
//

import Foundation

struct APIRequest: Codable {
    let model: String
    var messages: [[String: String]]
    let stream: Bool
    
    init(messages: [ChatMessage]) {
        self.model = "deepseek-chat"
        self.messages = messages.map { ["role": $0.role.rawValue, "content": $0.content] }
        self.stream = true
    }
}
