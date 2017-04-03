//
//  CWChatManager.swift
//  CWWeChat
//
//  Created by wei chen on 2017/3/30.
//  Copyright © 2017年 cwcoder. All rights reserved.
//

import Foundation

/// 聊天相关回调
public protocol CWChatManagerDelegate: NSObjectProtocol {
    
    // MARK: 会话
    func conversationDidUpdate(_ conversation: CWChatConversation)
    
    // MARK: Message
    /// 消息状态发生变化
    ///
    /// - Parameter message: 状态发生变化的消息
    /// - Parameter error: 错误信息
    func messageStatusDidChange(_ message: CWChatMessage, error: NSError?)
    
    /// 收到消息
    ///
    /// - Parameter message: 消息实体
    func messagesDidReceive(_ message: CWChatMessage)
    
}

// 让协议变成可选
public extension CWChatManagerDelegate {
    func conversationDidUpdate(_ conversation: CWChatConversation) {}
    func messagesDidReceive(_ message: CWChatMessage) {}
    func messageStatusDidChange(_ message: CWChatMessage, error: NSError?) {}
}


public typealias CWMessageCompletionBlock = (_ message: CWChatMessage, _ error: NSError?) -> Void
public typealias CWMessageProgressBlock = (_ progress: Int) -> Void

/// 聊天相关操作
public protocol CWChatManager: NSObjectProtocol {
    
    /// 添加聊天代理
    ///
    /// - Parameter delegate: 代理
    /// - Parameter delegateQueue: 代理执行线程
    func addChatDelegate(_ delegate: CWChatManagerDelegate, delegateQueue: DispatchQueue)
    
    /// 删除聊天代理
    ///
    /// - Parameter delegate: 代理
    func removeChatDelegate(_ delegate: CWChatManagerDelegate)

    // MARK: 获取会话
    func fetchAllConversations() -> [CWChatConversation]
    
    func fecthConversation(chatType: CWChatType, targetId: String) -> CWChatConversation
    
    // MARK: 获取消息
    
    
    
    // MARK: 发送消息相关
    
    /// 发送回执消息
    ///
    /// - Parameters:
    ///   - message: 回执消息
    ///   - completion: 发送完成回调block
    func sendMessageReadAck(message: CWChatMessage,
                            completion: @escaping CWMessageCompletionBlock)
    
    /// 发送消息
    ///
    /// - Parameters:
    ///   - message: 消息
    ///   - progress: 附件上传进度回调block
    ///   - completion: 发送完成回调block
    func sendMessage(_ message: CWChatMessage,
                     progress: @escaping CWMessageProgressBlock,
                     completion: @escaping CWMessageCompletionBlock)
    
    /// 重新发送消息
    ///
    /// - Parameters:
    ///   - message: 消息
    ///   - progress: 附件上传进度回调block
    ///   - completion: 发送完成回调block
    func resendMessage(_ message: CWChatMessage,
                     progress: @escaping CWMessageProgressBlock,
                     completion: @escaping CWMessageCompletionBlock)
    
}