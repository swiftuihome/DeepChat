//
//  ChatViewModel.swift
//  DeepSeekChatAPIDemo
//
//  Created by devlink on 2025/8/31.
//

import Foundation
import Observation

@Observable
class ChatViewModel {
    private let deepSeekService = DeepSeekService()
    var messages: [ChatMessage] = []
    var currentInput = ""
    var isSending = false
    var errorMessage: String?
    
    init() {
        // 添加系统消息
        messages.append(ChatMessage(role: .system, content: "You are a helpful assistant."))
    }
    
    func sendMessage() async {
        guard !currentInput.trimmingCharacters(in: .whitespacesAndNewlines).isEmpty else { return }
        
        let userMessage = ChatMessage(role: .user, content: currentInput)
        messages.append(userMessage)
        
        let tempMessage = ChatMessage(role: .assistant, content: "")
        messages.append(tempMessage)
        
        let currentIndex = messages.count - 1
        currentInput = ""
        isSending = true
        errorMessage = nil
        
        do {
            let stream = try await deepSeekService.sendMessage(messages: messages.dropLast())
            
            for try await chunk in stream {
                await MainActor.run {
                    messages[currentIndex].content += chunk
                }
            }
        } catch {
            await MainActor.run {
                errorMessage = error.localizedDescription
                messages.removeLast() // 移除空的助手消息
            }
        }
        
        await MainActor.run {
            isSending = false
        }
    }
    
    func clearConversation() {
        messages = [ChatMessage(role: .system, content: "You are a helpful assistant.")]
        errorMessage = nil
    }
}
