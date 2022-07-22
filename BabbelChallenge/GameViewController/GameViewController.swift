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
    
    var viewModel: GameViewModelProtocol!

    //MARK: - View Lifecycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        viewModel = GameViewModel()
        bindViewModel()
        viewModel.gameStarted()
    }
    
    private func bindViewModel() {
        viewModel.changeHandler = { [unowned self] change in
            switch change {
                case .roundStarted(quizPair: let quizPair):
                    self.englishWordLabel.text = quizPair.englishWord
                    self.spanishWordLabel.text = quizPair.spanishWord
                case .statsUpdated:
                    self.correctAttemptsAmountLabel.text = "\(self.viewModel.correctAttempts)"
                    self.wrongAttemptsAmountLabel.text = "\(self.viewModel.wrongAttempts)"
                case .gameEnded:
                    exit(0)
            }
        }
    }
    
    //MARK: - Button Actions

    @IBAction func correctButtonTapped(_ sender: Any) {
        viewModel.roundCompleted(withResponse: .correct)
    }
    
    @IBAction func wrongButtonTapped(_ sender: Any) {
        viewModel.roundCompleted(withResponse: .wrong)
    }
}
