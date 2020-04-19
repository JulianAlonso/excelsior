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
        
    }

    private func reject(with error: E) {
        
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
