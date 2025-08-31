//
//  ChatView.swift
//  DeepSeekChatAPIDemo
//
//  Created by devlink on 2025/8/31.
//

import SwiftUI

struct ChatView: View {
    @State private var viewModel = ChatViewModel()
    @FocusState private var isInputFocused: Bool
    
    var body: some View {
        NavigationStack {
            VStack {
                MessageListView(messages: viewModel.messages)
                
                InputView(
                    currentInput: $viewModel.currentInput,
                    isSending: viewModel.isSending,
                    onSend: { Task { await viewModel.sendMessage() } },
                    isInputFocused: _isInputFocused
                )
            }
            .navigationTitle("DeepSeek Chat")
            .navigationBarTitleDisplayMode(.inline)
            .toolbar {
                ToolbarItem(placement: .navigationBarTrailing) {
                    Button("Clear", systemImage: "trash") {
                        viewModel.clearConversation()
                    }
                    .disabled(viewModel.isSending)
                }
            }
            .alert("Error", isPresented: .constant(viewModel.errorMessage != nil)) {
                Button("OK", role: .cancel) {
                    viewModel.errorMessage = nil
                }
            } message: {
                if let error = viewModel.errorMessage {
                    Text(error)
                }
            }
        }
    }
}

#Preview {
    ChatView()
}
