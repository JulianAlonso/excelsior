//
//  CharacterDetailContainerPresenter.swift
//  CharacterDetailKit
//
//  Created by Rafael Bartolome on 22/03/2020.
//  Copyright © 2020 Rafael Bartolome. All rights reserved.
//

import Foundation
import DisplayKit

final class CharacterDetailContainerViewModel: ViewModel<CharacterDetailState, CharacterDetailAction> {
    private let getCharacterDetail: GetCharacterDetail
    private let characterId: CharacterId
    
    private var searchString: String?
    private var offset = 0
    
    init(state: CharacterDetailState,
         getCharacterDetail: GetCharacterDetail,
         characterId: CharacterId) {
        self.getCharacterDetail = getCharacterDetail
        self.characterId = characterId
        super.init(state: state)
    }
    
    override func handle(_ action: CharacterDetailAction) {
        switch action {
        case .load: load()
        }
    }
}

private extension CharacterDetailContainerViewModel {
    func loadCharacterDetail() {
        getCharacterDetail.execute(with: characterId) { result in
            switch result {
            case .success(let characterDetail):
                self.getCharactersFinished(with: characterDetail)
            case .failure(let error):
                self.getCharactersFinished(with: error)
            }
        }
    }
    
    func getCharactersFinished(with characterDetail: CharacterDetail) {
        update(state: .loaded(characterDetail))
    }
    
    func getCharactersFinished(with error: CharacterDetailError) {
        update(state: .loadError(title: "Something went wrong", description: error.localizedDescription, delegate: self))
    }
    
    func load() {
        update(state: .loading("Loading character detail"))
        loadCharacterDetail()
    }
}

extension CharacterDetailContainerViewModel: RetryViewControllerDelegate {
    func retryViewDidTapOnButton() {
        load()
    }
}
