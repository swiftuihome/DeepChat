//
//  APIResponse.swift
//  DeepSeekChatAPIDemo
//
//  Created by devlink on 2025/8/31.
//

import Foundation

struct APIResponse: Codable {
    let id: String
    let object: String
    let created: Int
    let model: String
    let choices: [Choice]
    let usage: Usage?
    
    struct Choice: Codable {
        let index: Int
        let delta: Delta
        let logprobs: String?
        let finishReason: String?
        
        enum CodingKeys: String, CodingKey {
            case index, delta, logprobs
            case finishReason = "finish_reason"
        }
    }
    
    struct Delta: Codable {
        let role: String?
        let content: String?
    }
    
    struct Usage: Codable {
        let promptTokens: Int
        let completionTokens: Int
        let totalTokens: Int
        
        enum CodingKeys: String, CodingKey {
            case promptTokens = "prompt_tokens"
            case completionTokens = "completion_tokens"
            case totalTokens = "total_tokens"
        }
    }
}
