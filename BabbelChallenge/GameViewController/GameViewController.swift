//
//  GameViewController.swift
//  BabbelChallenge
//
//  Created by Onur Avsar on 22.07.2022.
//

import UIKit

class GameViewController: BaseViewController {
    
    @IBOutlet weak var correctAttemptsAmountLabel: UILabel!
    @IBOutlet weak var wrongAttemptsAmountLabel: UILabel!
    @IBOutlet weak var spanishWordLabel: UILabel!
    @IBOutlet weak var englishWordLabel: UILabel!
    
    var viewModel: GameViewModelProtocol?

    //MARK: - View Lifecycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    //MARK: - Button Actions

    @IBAction func correctButtonTapped(_ sender: Any) {
        
    }
    
    @IBAction func wrongButtonTapped(_ sender: Any) {
        
    }
}
