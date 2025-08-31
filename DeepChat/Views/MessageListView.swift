//
//  MessageListView.swift
//  DeepSeekChatAPIDemo
//
//  Created by devlink on 2025/8/31.
//

import SwiftUI

struct MessageListView: View {
    let messages: [ChatMessage]
    
    var body: some View {
        ScrollViewReader { proxy in
            List {
                ForEach(messages.filter { $0.role != .system }) { message in
                    MessageBubble(message: message)
                        .listRowSeparator(.hidden)
                        .listRowInsets(EdgeInsets())
                }
            }
            .listStyle(.plain)
            .onChange(of: messages) { _, _ in
                scrollToBottom(proxy: proxy)
            }
        }
    }
    
    private func scrollToBottom(proxy: ScrollViewProxy) {
        if let lastMessage = messages.filter({ $0.role != .system }).last {
            withAnimation {
                proxy.scrollTo(lastMessage.id, anchor: .bottom)
            }
        }
    }
}
