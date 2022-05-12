//
//  ViewController.swift
//  ramenTimer
//
//  Created by 신승재 on 2022/05/12.
//

import UIKit

class ViewController: UIViewController {

    @IBOutlet weak var segmentControl: UISegmentedControl!
    @IBOutlet weak var timerLabel: UILabel!
    @IBOutlet weak var timerButton: UIButton!
    
    var leftSeconds: Int = 0
    var timer: Timer?
    var buttonState = 0 // 0:시작, 1:일시정지, 2:초기화
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.timerButton.layer.cornerRadius = 10
        self.leftSeconds = 180 // 초기 leftSconds는 항상 180이므로
        self.updateTimer()
    }

    @IBAction func segmentValueChanged(_ sender: Any) {
        // 타이머가 돌고 있을때는 기능 정지
        if self.timer != nil {
            return
        }
        self.setTimerMinutes()
    }
    
    @IBAction func buttonClicked(_ sender: Any) {
        if self.buttonState == 0 {
            self.buttonState = 1
            self.timerButton.backgroundColor = UIColor.red
            self.timerButton.setTitle("정지", for: .normal)
            self.timer = Timer.scheduledTimer(withTimeInterval: 1, repeats: true, block: {(t) in
                self.leftSeconds -= 1
                self.updateTimer()
            })
        } else if self.buttonState == 1 {
            self.buttonState = 2
            self.timer?.invalidate() // 정지
            self.timerButton.backgroundColor = UIColor.blue
            self.timerButton.setTitle("초기화", for: .normal)
        } else {
            self.buttonState = 0
            self.timer = nil
            self.timerButton.backgroundColor = UIColor.systemGreen
            self.timerButton.setTitle("타이머 시작하기", for: .normal)
            // segmentValue에 따라 초기 초 바꿔주기
            self.setTimerMinutes()
            
        }
        
       
    }
    
    func updateTimer(){
        let minutes = self.leftSeconds / 60
        let seconds = self.leftSeconds % 60
        
        if self.leftSeconds == 0 {
            self.timer?.invalidate() // 정지
            self.timerLabel.text = "시간 끝 !"
            self.buttonState = 2
            self.timerButton.backgroundColor = UIColor.blue
            self.timerButton.setTitle("초기화", for: .normal)
        } else{
            self.timerLabel.text = String(format: "%02d:%02d", minutes, seconds)
        }
    }
    
    func setTimerMinutes() {
        if segmentControl.selectedSegmentIndex == 0 {
            self.timerLabel.text = "03:00"
            self.leftSeconds = 180
        } else if segmentControl.selectedSegmentIndex == 1 {
            self.timerLabel.text = "04:00"
            self.leftSeconds = 240
        } else {
            self.timerLabel.text = "05:00"
            self.leftSeconds = 300
        }
    }
}

