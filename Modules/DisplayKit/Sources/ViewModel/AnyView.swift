//
//  AnyView.swift
//  DisplayKit
//
//  Created by Juli Alonso on 23/04/2020.
//

import Foundation

public final class AnyView<State>: StatefulView {
    
    private let _render: (State) -> Void
    private let identifier: String
    
    public init<V: StatefulView>(view: V) where V.State == State {
        _render = { view.render(state: $0) }
        identifier = String(describing: view)
    }
    
    public func render(state: State) {
        DispatchQueue.main.async { self._render(state) }
    }
    
}

extension AnyView: Hashable {
    public func hash(into hasher: inout Hasher) {
        hasher.combine(identifier)
    }
    
    public static func == (lhs: AnyView, rhs: AnyView) -> Bool {
        lhs.identifier == rhs.identifier
    }
}
