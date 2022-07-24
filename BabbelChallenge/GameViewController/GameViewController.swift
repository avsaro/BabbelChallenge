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
    @IBOutlet weak var spanishWordVerticalCenterLayoutConstraint: NSLayoutConstraint!
    
    var viewModel: GameViewModelProtocol!
    var timer: Timer?

    //MARK: - View Lifecycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        viewModel = GameViewModel()
        bindViewModel()
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        viewModel.gameStarted()
    }
    
    deinit {
        stopTimer()
    }
    
    private func bindViewModel() {
        viewModel.changeHandler = { [unowned self] change in
            switch change {
                case .roundStarted(quizPair: let quizPair):
                    self.englishWordLabel.text = quizPair.englishWord
                    self.spanishWordLabel.text = quizPair.spanishWord
                    self.startTimer()
                    self.startAnimation()
                case .statsUpdated:
                    self.correctAttemptsAmountLabel.text = "\(self.viewModel.correctAttempts)"
                    self.wrongAttemptsAmountLabel.text = "\(self.viewModel.wrongAttempts)"
                case .gameEnded(gameWon: let gameWon):
                    showGameEndPopup(gameWon: gameWon)
            }
        }
    }
    
    //MARK: - Helpers
    
    private func startAnimation() {
        spanishWordLabel.layer.removeAllAnimations()
        let targetConstantValue = spanishWordVerticalCenterLayoutConstraint.constant
        let startingConstantValue = (spanishWordLabel.superview?.frame.height ?? 0) / -2
        spanishWordVerticalCenterLayoutConstraint.constant = startingConstantValue
        spanishWordLabel.superview?.layoutIfNeeded()
        UIView.animate(withDuration: viewModel.roundTimeInterval, delay: 0, options: .allowAnimatedContent, animations: { [unowned self] in
            self.spanishWordVerticalCenterLayoutConstraint.constant = targetConstantValue
            self.spanishWordLabel.superview?.layoutIfNeeded()
        }, completion: nil)
    }
    
    private func startTimer() {
        guard timer == nil else {
            return
        }
        
        timer =  Timer.scheduledTimer(timeInterval: viewModel.roundTimeInterval, target: self, selector: #selector(timeIsUp), userInfo: nil, repeats: false)
    }
    
    @objc private func timeIsUp() {
        stopTimer()
        viewModel.roundCompleted(withResponse: nil)
    }
    
    private func stopTimer() {
        timer?.invalidate()
        timer = nil
    }
    
    private func showGameEndPopup(gameWon: Bool) {
        spanishWordLabel.layer.removeAllAnimations()
        
        let alertController = UIAlertController(title: getGameEndPopupTitle(gameWon), message: getGameEndPopupMessage(), preferredStyle: .alert)
        
        let restartAction = UIAlertAction(title: "Restart", style: .default, handler: { [unowned self] (action) in
            self.viewModel.gameRestarted()
        })
        alertController.addAction(restartAction)
        
        let quitAction = UIAlertAction(title: "Quit", style: .destructive, handler: { (action) in
            exit(0)
        })
        alertController.addAction(quitAction)
        
        self.present(alertController, animated: true, completion: nil)
    }
    
    private func getGameEndPopupTitle(_ gameWon: Bool) -> String {
        return gameWon ? "You Won!" : "You Lost!"
    }
    
    private func getGameEndPopupMessage() -> String {
        return "Correct Attempts: \(self.viewModel.correctAttempts)\nWrong Attempts: \(self.viewModel.wrongAttempts)"
    }
    
    //MARK: - Button Actions

    @IBAction func correctButtonTapped(_ sender: Any) {
        stopTimer()
        viewModel.roundCompleted(withResponse: .correct)
    }
    
    @IBAction func wrongButtonTapped(_ sender: Any) {
        stopTimer()
        viewModel.roundCompleted(withResponse: .wrong)
    }
}
