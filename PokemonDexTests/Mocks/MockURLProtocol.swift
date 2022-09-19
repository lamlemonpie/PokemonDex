//
//  MockURLProtocol.swift
//  PokemonDexTests
//
//  Created by Alejandro Larraondo on 9/18/22.
//

import Foundation

class MockURLProtocol: URLProtocol {
    static var stubData: Data?
    static var stubResponse: HTTPURLResponse?
    static var error: Error?

    override class func canInit(with request: URLRequest) -> Bool {
        return true
    }

    override class func canonicalRequest(for request: URLRequest) -> URLRequest {
        return request
    }

    override func startLoading() {
        if let signupError = MockURLProtocol.error {
            self.client?.urlProtocol(self, didFailWithError: signupError)
        } else {
            self.client?.urlProtocol(
                self,
                didReceive: MockURLProtocol.stubResponse ?? HTTPURLResponse(),
                cacheStoragePolicy: .notAllowed)

            self.client?.urlProtocol(self, didLoad: MockURLProtocol.stubData ?? Data())
        }

        self.client?.urlProtocolDidFinishLoading(self)
    }

    override func stopLoading() { }
}
