//
//  ChatMessage.swift
//  DeepSeekChatAPIDemo
//
//  Created by devlink on 2025/8/31.
//

import SwiftUI

struct ChatMessage: Identifiable, Equatable {
    let id = UUID()
    let role: MessageRole
    var content: String
    let timestamp: Date
    
    init(role: MessageRole, content: String, timestamp: Date = Date()) {
        self.role = role
        self.content = content
        self.timestamp = timestamp
    }
}

enum MessageRole: String {
    case user = "user"
    case system = "system"
    case assistant = "assistant"
    
    var alignment: HorizontalAlignment {
        switch self {
        case .user:
            return .trailing
        default:
            return .leading
        }
    }
    
    var background: Color {
        switch self {
        case .user:
            return .blue
        default:
            return Color.gray.opacity(0.2)
        }
    }
    
    var foreground: Color {
        switch self {
        case .user:
            return .white
        default:
            return .primary
        }
    }
}
