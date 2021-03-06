//
//  ViewModel.swift
//  DisplayKit
//
//  Created by Juli Alonso on 23/04/2020.
//

import Foundation

public protocol StatefulView: AnyObject {
    associatedtype State
    
    func render(state: State)
}

open class ViewModel<State, Action> {
    
    public private(set) var state: State
    private var views = Set<AnyStatefulView<State>>()
    
    public init(state: State) {
        self.state = state
    }
    
    open func handle(_ action: Action) { fatalError("Calling not implemented handle") }
    
    final public func update(state: State) {
        self.state = state
        views.forEach { $0.render(state: state) }
    }
    
    final public func subscribe<V: StatefulView>(view: V) where V.State == State {
        views.insert(AnyStatefulView(view: view))
    }
}
