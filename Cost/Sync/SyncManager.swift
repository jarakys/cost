//
//  SyncManager.swift
//  Cost
//
//  Created by Kirill on 10/7/19.
//  Copyright © 2019 com.cost.app. All rights reserved.
//

import Foundation
import Reachability

struct SyncManager {
    let requestManager = RequestManager()
    let reachability = Reachability()!
    func sync() {
        reachability.whenReachable = { reachability in
            self.syncWithServer()
        }
        
        reachability.whenUnreachable = { reachability in
            self.addToDatabase()
        }
    }
    
    func syncData() {
        
        switch reachability.connection {
        case .wifi:
            fallthrough
        case .cellular:
            syncWithServer()
        case .none:
            addToDatabase()
        }
    }
    
    private func syncWithServer() {
    
    }
    
    private func addToDatabase() {
        
    }
    
}
