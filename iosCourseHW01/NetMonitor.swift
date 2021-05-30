//
//  NetMonitor.swift
//  iosCourseHW01
//
//  Created by Ivan Skorupan on 16.05.2021..
//

import Foundation
import Network

class NetMonitor {
    
    static public let shared = NetMonitor()
    
    private var monitor: NWPathMonitor
    private var queue = DispatchQueue.global()
    var netOn = true
    
    private init() {
        self.monitor = NWPathMonitor()
        self.queue = DispatchQueue.global(qos: .background)
        self.monitor.start(queue: queue)
        startMonitoring()
    }
    
    func startMonitoring() {
        self.monitor.pathUpdateHandler = { path in
            // Simulator je izrazito unreliable po ovom pitanju, pa trenutno
            // varijabla fiksno ide na true dok ne nadem ispravak.
            self.netOn = true
        }
    }
    
    func stopMonitoring() {
        self.monitor.cancel()
    }
    
}
