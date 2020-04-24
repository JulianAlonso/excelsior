//
//  AnyViewModel.swift
//  DisplayKit
//
//  Created by Juli Alonso on 23/04/2020.
//

import Foundation

public final class AnyViewModel<State, Action> {
    
    public var state: State {
        get { viewModel.state }
    }
    private let viewModel: ViewModel<State, Action>
    
    public init(viewModel: ViewModel<State, Action>) {
        self.viewModel = viewModel
    }
    
    public func handle(_ action: Action) {
        viewModel.handle(action)
    }
    
    public func subscribe<V: StatefulView>(view: V) where V.State == State {
        viewModel.subscribe(view: view)
    }
    
}
