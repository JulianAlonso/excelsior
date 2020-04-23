//
//  AnyView.swift
//  DisplayKit
//
//  Created by Juli Alonso on 23/04/2020.
//

import Foundation

public final class AnyView<State>: StatefulView {
    
    private let _render: (State) -> Void
    
    public init<V: StatefulView>(view: V) where V.State == State {
        _render = { view.render(state: $0) }
    }
    
    public func render(state: State) {
        DispatchQueue.main.async { self._render(state) }
    }
    
}
