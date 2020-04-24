//
//  CharacterDetailViewController.swift
//  CharacterDetailKit
//
//  Created by Rafael Bartolome on 22/03/2020.
//  Copyright © 2020 Rafael Bartolome. All rights reserved.
//

import UIKit
import Kingfisher
import DisplayKit

protocol CharacterDetailViewControllerProvider: AnyObject {
    func characterDetailViewController(character: CharacterDetail) -> CharacterDetailViewController
}

struct CharacterDetailDisplayModel {
    let name: String
    let bio: String
    let image: URL?
}

final class CharacterDetailViewController: UIViewController {

    @IBOutlet weak var imageView: UIImageView!
    @IBOutlet weak var nameLabel: UILabel!
    @IBOutlet weak var bioLabel: UILabel!
    
    private let viewModel: AnyViewModel<CharacterDetailDisplayModel, Never>
    
    init(viewModel: AnyViewModel<CharacterDetailDisplayModel, Never>) {
        self.viewModel = viewModel
        super.init(nibName: "CharacterDetailViewController", bundle: Bundle(for: CharacterDetailViewController.self))
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.render(state: viewModel.state)
        imageView.accessibilityIdentifier = "CharacterDetailViewController"
    }
}

extension CharacterDetailViewController: StatefulView {
    func render(state: CharacterDetailDisplayModel) {
        setUpName(state.name)
        setUpBio(state.bio)
        setUpImage(state.image)
    }
}

private extension CharacterDetailViewController {
    func setUpName(_ name: String) {
        nameLabel.text = name
    }
    
    func setUpBio(_ bio: String) {
        bioLabel.text = bio
    }
    
    func setUpImage(_ url: URL?) {       
        let placeholder = UIImage(named: "detail-placeholder",
                                  in: Bundle(for: CharacterDetailViewController.self),
                                  compatibleWith: nil)
        if let imageURL = url {
            imageView.kf.setImage(with: imageURL,
                                  placeholder: placeholder)
        } else {
            imageView.image = placeholder
        }
    }
}
