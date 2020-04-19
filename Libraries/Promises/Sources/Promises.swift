import Foundation

public final class Promise<T, E: Error> {
    
    private var state: State<T, E>
    private let lockQueue = DispatchQueue(label: "promise.lock.queue", qos: .userInitiated)
    
    public init() {
        self.state = .pending(futures: [])
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

    private func fulfill(with value: T) {
        lockQueue.async {
            guard case .pending(let futures) = self.state else { return }
            self.state = .fulfilled(value: value)
            futures.forEach { $0.fulfill(value) }
        }
    }

    private func reject(with error: E) {
        lockQueue.async {
            guard case .pending(let futures) = self.state else { return }
            self.state = .rejected(error: error)
            futures.forEach { $0.reject(error) }
        }
    }
    
    private func addFuture(future: Future<T, E>) {
        lockQueue.async {
            switch self.state {
            case .pending(let futures):
                self.state = .pending(futures: futures + [future])
            case .fulfilled(let value):
                future.fulfill(value)
            case .rejected(let error):
                future.reject(error)
            }
        }
    }
    
}
