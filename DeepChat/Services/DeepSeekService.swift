//
//  DeepSeekService.swift
//  DeepSeekChatAPIDemo
//
//  Created by devlink on 2025/8/31.
//

import Foundation

class DeepSeekService {
    private let apiKey = "your-api-key" // 替换为你的实际API密钥
    private let endpoint = "https://api.deepseek.com/chat/completions"
    
    func sendMessage(messages: [ChatMessage]) async throws -> AsyncThrowingStream<String, Error> {
        var request = URLRequest(url: URL(string: endpoint)!)
        request.httpMethod = "POST"
        request.setValue("application/json", forHTTPHeaderField: "Content-Type")
        request.setValue("Bearer \(apiKey)", forHTTPHeaderField: "Authorization")
        
        let apiRequest = APIRequest(messages: messages)
        request.httpBody = try JSONEncoder().encode(apiRequest)
        
        let (result, response) = try await URLSession.shared.bytes(for: request)
        
        guard let httpResponse = response as? HTTPURLResponse else {
            throw URLError(.badServerResponse)
        }
        
        guard httpResponse.statusCode == 200 else {
            throw URLError(.badServerResponse)
        }
        
        return AsyncThrowingStream { continuation in
            Task {
                do {
                    for try await line in result.lines {
                        guard line.hasPrefix("data: "),
                              !line.contains("[DONE]") else { continue }
                        
                        let jsonString = line.dropFirst(6)
                        guard !jsonString.isEmpty else { continue }
                        
                        if let data = jsonString.data(using: .utf8),
                           let response = try? JSONDecoder().decode(APIResponse.self, from: data),
                           let content = response.choices.first?.delta.content {
                            continuation.yield(content)
                        }
                    }
                    continuation.finish()
                } catch {
                    continuation.finish(throwing: error)
                }
            }
        }
    }
}
