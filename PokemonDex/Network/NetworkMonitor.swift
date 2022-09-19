//
//  NetworkMonitor.swift
//  PokemonDex
//
//  Created by Alejandro Larraondo on 9/18/22.
//

import Foundation
import Network

class NetworkMonitor: NetworkProtocol, ObservableObject {
    private let monitor = NWPathMonitor()
    private let queue = DispatchQueue(label: "Monitor")

    @Published var status: NetworkStatus = .connected
    var statusPublished: Published<NetworkStatus> { _status }
    var statusPublisher: Published<NetworkStatus>.Publisher { $status }

    init() {
        monitor.pathUpdateHandler = { [weak self] path in
            guard let self = self else { return }

            // Monitor runs on a background thread so we need to publish
            // on the main thread
            DispatchQueue.main.async {
                if path.status == .satisfied {
                    self.status = .connected
                } else {
                    self.status = .disconnected
                }
            }
        }
        monitor.start(queue: queue)
    }
}
