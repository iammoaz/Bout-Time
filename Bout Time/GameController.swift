//
//  ViewController.swift
//  Bout Time
//
//  Created by Muhammad Moaz on 1/27/17.
//  Copyright © 2017 Muhammad Moaz. All rights reserved.
//

import UIKit
import SafariServices

class GameController: UIViewController {
    
    @IBOutlet weak var roundNumberLabel: UILabel!
    @IBOutlet weak var tableView: UITableView!
    @IBOutlet weak var timerLabel: UILabel!
    @IBOutlet weak var feedbackLabel: UILabel!
    @IBOutlet weak var finalResultLabel: UILabel!
    @IBOutlet weak var nextRoundButton: UIButton!
    @IBOutlet weak var footerLabel: UILabel!
    
    // MARK: - Variables and Constants
    
    fileprivate var currentRound: [Event] = []
    fileprivate var game = Game()
    fileprivate let sound = Sound()
    
    private var timer: Timer?
    private var timerCount: Int = 60
    
    private var roundNumber: Int = 0 {
        didSet {
            configureRound()
        }
    }

    override func viewDidLoad() {
        super.viewDidLoad()

        self.roundNumber = 0
        
        self.tableView.dataSource = self
        self.tableView.delegate = self
        self.tableView.separatorStyle = .none
        self.tableView.isScrollEnabled = false
        self.tableView.allowsSelection = true
    }
    
    // MARK: - Motion Recognizer
    
    override func motionEnded(_ motion: UIEventSubtype, with event: UIEvent?) {
        if motion == .motionShake {
            configureViewForFeedbackWith(game.checkAnswerFor(round: self.currentRound))
        }
    }
    
    // MARK: - View Configuration
    
    func configureRound() {
        if (self.roundNumber + 1) == game.rounds.count {
            self.roundNumberLabel.text = "Final Round"
            self.nextRoundButton.setTitle("FINISH", for: .normal)
        } else {
            self.roundNumberLabel.text = "Round \((self.roundNumber + 1).asWord)"
        }
        
        self.currentRound = game.rounds[roundNumber]
        self.nextRoundButton.isHidden = true
        self.timerLabel.isHidden = false
        self.feedbackLabel.isHidden = true
        self.footerLabel.text = "Shake to check answer"
        self.tableView.setEditing(true, animated: true)
        self.tableView.reloadData()
        startTimer()
    }
    
    func configureViewForFeedbackWith(_ value: Bool) {
        stopTimer()
        self.tableView.setEditing(false, animated: true)
        self.nextRoundButton.isHidden = false
        self.footerLabel.text = "Tap events to learn more"
        self.timerLabel.isHidden = true
        
        if value {
            sound.playCorrectSound()
            self.nextRoundButton.backgroundColor = Theme.correctAnswerColor
            self.feedbackLabel.text = "Correct!"
            self.feedbackLabel.textColor = Theme.correctAnswerColor
            self.feedbackLabel.isHidden = false
        } else {
            sound.playIncorrectSound()
            self.nextRoundButton.backgroundColor = Theme.wrongAnswerColor
            self.feedbackLabel.text = "Incorrect!"
            self.feedbackLabel.textColor = Theme.wrongAnswerColor
            self.feedbackLabel.isHidden = false
        }
    }
    
    func configureViewForFinalResult() {
        self.roundNumberLabel.text = "Your Score"
        self.finalResultLabel.text = "\(game.numberOfCorrectAnswers)/\(game.rounds.count)"
        self.nextRoundButton.isHidden = true
        self.feedbackLabel.isHidden = true
        self.tableView.isHidden = true
        self.footerLabel.isHidden = true
        dismissController()
    }
    
    // MARK: - Helper Methods
    
    func dismissController() {
        DispatchQueue.main.asyncAfter(deadline: DispatchTime.now() + 3) {
            self.dismiss(animated: true, completion: nil)
        }
    }
    
    func startTimer() {
        timerCount = 60
        timerLabel?.text = "\(timerCount)"
        guard timer == nil else { return }
        timer = Timer.scheduledTimer(timeInterval: 1.0, target: self, selector: #selector(self.updateTimerLabel), userInfo: nil, repeats: true)
    }
    
    func stopTimer() {
        guard timer != nil else { return }
        timer?.invalidate()
        timer = nil
    }
    
    @objc func updateTimerLabel() {
        if timerCount > 0 {
            timerCount -= 1
            self.timerLabel?.text = "\(timerCount)"
        } else if timerCount == 0 {
            stopTimer()
            configureViewForFeedbackWith(game.checkAnswerFor(round: self.currentRound))
        }
        
        if timerCount < 10 {
            timerLabel?.textColor = Theme.wrongAnswerColor
        }
    }
    
    // MARK: - Actions
    
    @IBAction func nextRoundButton(sender: UIButton) {
        if (self.roundNumber + 1) < game.rounds.count {
            self.roundNumber += 1
        } else if (self.roundNumber + 1) >= game.rounds.count {
            configureViewForFinalResult()
        }
    }
}

// MARK: - TableView - DataSource

extension GameController: UITableViewDataSource {
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return currentRound.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: GameCell.identifier, for: indexPath) as! GameCell
        let event = self.currentRound[indexPath.row]
        cell.event = event
        
        let eventIndex = self.currentRound.index { (event: Event) -> Bool in
            return event.id == cell.event?.id
        }
        
        cell.indexLabel.text = "\(eventIndex!)"
        return cell
    }
}

// MARK: - TableView - Delegate

extension GameController: UITableViewDelegate {
    func tableView(_ tableView: UITableView, canMoveRowAt indexPath: IndexPath) -> Bool {
        return true
    }
    
    func tableView(_ tableView: UITableView, moveRowAt sourceIndexPath: IndexPath, to destinationIndexPath: IndexPath) {
        let event = self.currentRound[sourceIndexPath.row]
        self.currentRound.remove(at: sourceIndexPath.row)
        self.currentRound.insert(event, at: destinationIndexPath.row)
    }
    
    func tableView(_ tableView: UITableView, editingStyleForRowAt indexPath: IndexPath) -> UITableViewCellEditingStyle {
        return .none
    }
    
    func tableView(_ tableView: UITableView, shouldIndentWhileEditingRowAt indexPath: IndexPath) -> Bool {
        return false
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let cell = tableView.cellForRow(at: indexPath) as! GameCell
        let event = cell.event
        let url = URL(string: (event?.url)!)
        presentWebView(url: url!)
        self.tableView.deselectRow(at: indexPath, animated: true)
    }
}

// MARK: - SFSafariView - Delegate

extension GameController: SFSafariViewControllerDelegate {
    func presentWebView(url: URL) {
        let webController = WebController(url: url, entersReaderIfAvailable: true)
        self.present(webController, animated: true, completion: nil)
    }
    
    func safariViewControllerDidFinish(_ controller: SFSafariViewController) {
        controller.dismiss(animated: true, completion: nil)
    }
}


