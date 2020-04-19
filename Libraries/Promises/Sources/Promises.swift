import Foundation

public typealias Fulfill<T> = (T) -> Void
public typealias Reject<E: Error> = (E) -> Void

public final class Promise<T, E: Error> {
    
    private var state: State<T, E>
    private let lockQueue = DispatchQueue(label: "promise.lock.queue", qos: .userInitiated)
    
    public init() {
        self.state = .pending(callbacks: [])
    }
    
    public init(value: T) {
        self.state = .fulfilled(value: value)
    }
    
    public init(error: E) {
        self.state = .rejected(error: error)
    }
    
    public convenience init(on queue: Queue = DispatchQueue.global(qos: .userInitiated), _ work: @escaping (Future<T, E>) -> Void) {
        self.init()
        queue.execute {
            work(Future(fulfill: self.fulfill, reject: self.reject))
        }
    }
    
    @discardableResult
    public func then<NewValue>(on queue: Queue = DispatchQueue.main,
                               _ mapValue: @escaping (T) throws -> NewValue) -> Promise<NewValue, E> {
        map(
            on: queue,
            mapValue: { Promise<NewValue, E>(value: try mapValue($0)) },
            mapError: { Promise<NewValue, E>(error: $0) }
        )
    }
    
    @discardableResult
    public func `catch`<NewError: Error>(on queue: Queue = DispatchQueue.main,
                                         _ mapError: @escaping (E) -> NewError) -> Promise<T, NewError> {
        map(
            on: queue,
            mapValue: { Promise<T, NewError>(value: $0) },
            mapError: { Promise<T, NewError>(error: mapError($0)) }
        )
    }
    
    @discardableResult
    public func map<NewValue, NewError: Error>(on queue: Queue = DispatchQueue.main,
                                               mapValue: @escaping (T) throws -> Promise<NewValue, NewError>,
                                               mapError: @escaping (E) -> Promise<NewValue, NewError>) -> Promise<NewValue, NewError> {
        Promise<NewValue, NewError> { future in
            self.then(
                on: queue,
                fulfill: { oldValue in
                    do {
                        try mapValue(oldValue).then(on: queue, fulfill: future.fulfill, reject: future.reject)
                    } catch let error {
                        future.reject(error as! NewError)
                    }
                },
                reject: { oldError in
                    mapError(oldError).then(on: queue, fulfill: future.fulfill, reject: future.reject)
                }
            )
        }
    }
    
    @discardableResult
    private func then(on queue: Queue = DispatchQueue.main, fulfill: @escaping (T) -> Void, reject: @escaping (E) -> Void = { _ in }) -> Promise<T, E> {
        addCallback(callback: Callback(on: queue, fulfill: fulfill, reject: reject))
        return self
    }
    
    private func fulfill(with value: T) {
        lockQueue.async {
            guard case .pending(let callbacks) = self.state else { return }
            self.state = .fulfilled(value: value)
            callbacks.forEach { $0.fulfill(value) }
        }
    }

    private func reject(with error: E) {
        lockQueue.async {
            guard case .pending(let callbacks) = self.state else { return }
            self.state = .rejected(error: error)
            callbacks.forEach { $0.reject(error) }
        }
    }
    
    private func addCallback(callback: Callback<T, E>) {
        lockQueue.async {
            switch self.state {
            case .pending(let callbacks):
                self.state = .pending(callbacks: callbacks + [callback])
            case .fulfilled(let value):
                callback.fulfill(value)
            case .rejected(let error):
                callback.reject(error)
            }
        }
    }
    
}
