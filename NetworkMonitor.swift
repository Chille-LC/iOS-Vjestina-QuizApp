//
//  NetworkMonitor.swift
//  QuizApp
//
//  Created by Luka Cicak on 30.05.2021..
//

import Foundation
import Network

class NetworkMonitor{
    static let shared = NetworkMonitor()
    private let monitor: NWPathMonitor
    public private(set) var isConnected: Bool = false
    
    init() {
        monitor = NWPathMonitor()
    }
    
    public func startMonitor(){
        monitor.start(queue: DispatchQueue.global())
        monitor.pathUpdateHandler = { [weak self] path in
            self?.isConnected = path.status != .unsatisfied
        }
    }
    
    public func stopMonitor(){
        monitor.cancel()
    }
}
