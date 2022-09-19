//
//  MockApolloClient.swift
//  PokemonDexTests
//
//  Created by Alejandro Larraondo on 9/19/22.
//

import Foundation
import Apollo

class MockApolloClient: ApolloClientProtocol {
    var data: Any?
    var error: Error?

    let networkTransport: NetworkTransport

    var store: Apollo.ApolloStore

    var cacheKeyForObject: Apollo.CacheKeyForObject?

    public init(networkTransport: NetworkTransport, store: ApolloStore) {
        self.networkTransport = networkTransport
        self.store = store
    }

    public convenience init(url: URL) {
        let store = ApolloStore(cache: InMemoryNormalizedCache())
        let provider = DefaultInterceptorProvider(store: store)
        let transport = RequestChainNetworkTransport(
        interceptorProvider: provider,
        endpointURL: url)

        self.init(networkTransport: transport, store: store)
    }

    func clearCache(callbackQueue: DispatchQueue, completion: ((Result<Void, Error>) -> Void)?) {
    }

    func fetch<Query>(query: Query, cachePolicy: Apollo.CachePolicy, contextIdentifier: UUID?, queue: DispatchQueue, resultHandler: Apollo.GraphQLResultHandler<Query.Data>?) -> Apollo.Cancellable where Query: Apollo.GraphQLQuery {
        let result: Result<GraphQLResult<Query.Data>, Error> = {
            if let error = error {
                return .failure(error)
            }

            if let data = data {
                let queryData = data as! Query.Data
                let queryResult = GraphQLResult(data: queryData, extensions: nil, errors: nil, source: .server, dependentKeys: nil)

                return .success(queryResult)
            }

            return .failure(TestError.unexpectedBehavior)
        }()

        resultHandler?(result)
        return Apollo.EmptyCancellable()
    }

    func watch<Query>(query: Query, cachePolicy: Apollo.CachePolicy, callbackQueue: DispatchQueue, resultHandler: @escaping Apollo.GraphQLResultHandler<Query.Data>) -> Apollo.GraphQLQueryWatcher<Query> where Query: Apollo.GraphQLQuery {
        Apollo.GraphQLQueryWatcher(client: self, query: query, resultHandler: resultHandler)
    }

    func perform<Mutation>(mutation: Mutation, publishResultToStore: Bool, queue: DispatchQueue, resultHandler: Apollo.GraphQLResultHandler<Mutation.Data>?) -> Apollo.Cancellable where Mutation: Apollo.GraphQLMutation {
        Apollo.EmptyCancellable()
    }

    func upload<Operation>(operation: Operation, files: [Apollo.GraphQLFile], queue: DispatchQueue, resultHandler: Apollo.GraphQLResultHandler<Operation.Data>?) -> Apollo.Cancellable where Operation: Apollo.GraphQLOperation {
        Apollo.EmptyCancellable()
    }

    func subscribe<Subscription>(subscription: Subscription, queue: DispatchQueue, resultHandler: @escaping Apollo.GraphQLResultHandler<Subscription.Data>) -> Apollo.Cancellable where Subscription: Apollo.GraphQLSubscription {
        Apollo.EmptyCancellable()
    }
}
