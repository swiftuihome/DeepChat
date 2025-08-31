//
//  InputView.swift
//  DeepSeekChatAPIDemo
//
//  Created by devlink on 2025/8/31.
//

import SwiftUI

struct InputView: View {
    @Binding var currentInput: String
    let isSending: Bool
    let onSend: () -> Void
    @FocusState var isInputFocused: Bool
    
    var body: some View {
        HStack(spacing: 12) {
            TextField("请输入问题...", text: $currentInput, axis: .vertical)
                .focused($isInputFocused)
                .textFieldStyle(RoundedBorderTextFieldStyle())
                .padding(.vertical, 8)
                .lineLimit(1...4)
                .disabled(isSending)
            
            Button(action: onSend) {
                if isSending {
                    ProgressView()
                        .progressViewStyle(CircularProgressViewStyle())
                } else {
                    Image(systemName: "paperplane.fill")
                }
            }
            .buttonStyle(SendButtonStyle())
            .disabled(currentInput.trimmingCharacters(in: .whitespacesAndNewlines).isEmpty || isSending)
        }
        .padding()
        .background(.background)
    }
}

// 发送按钮样式
struct SendButtonStyle: ButtonStyle {
    func makeBody(configuration: Configuration) -> some View {
        configuration.label
            .foregroundColor(.white)
            .frame(width: 35, height: 35)
            .background(
                Circle()
                    .fill(configuration.isPressed ? Color.blue.opacity(0.8) : Color.blue)
            )
            .scaleEffect(configuration.isPressed ? 0.95 : 1.0)
            .animation(.easeInOut(duration: 0.2), value: configuration.isPressed)
    }
}
