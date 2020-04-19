import Foundation

public final class Promise<T, E: Error> {
    
    private var state: State<T, E>
    
    public init() {
        self.state = .pending(future: [])
    }
    
}
