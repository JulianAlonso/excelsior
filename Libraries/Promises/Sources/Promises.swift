import Foundation

public final class Promise<T, E: Error> {
    
    private var state: State<T, E>
    
    public init() {
        self.state = .pending(futures: [])
    }
    
    public init(value: T) {
        self.state = .fulfilled(value: value)
    }
    
    public init(error: E) {
        self.state = .rejected(error: error)
    }
    
    public convenience init(on queue: Queue, _ work: @escaping (Future<T, E>) -> Void) {
        self.init()
        queue.execute {
            work(Future(fulfill: self.fulfill, reject: self.reject))
        }
    }

    private func fulfill(with value: T) {
        guard case .pending(let futures) = state else { return }
        state = .fulfilled(value: value)
        futures.forEach { $0.fulfill(value) }
    }

    private func reject(with error: E) {
        guard case .pending(let futures) = state else { return }
        state = .rejected(error: error)
        futures.forEach { $0.reject(error) }
    }
    
    private func addFuture(future: Future<T, E>) {
        switch state {
        case .pending(let futures):
            state = .pending(futures: futures + [future])
        case .fulfilled(let value):
            future.fulfill(value)
        case .rejected(let error):
            future.reject(error)
        }
    }
    
}
