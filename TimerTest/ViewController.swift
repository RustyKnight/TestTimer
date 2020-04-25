//
//  ViewController.swift
//  TimerTest
//
//  Created by Shane Whitehead on 25/4/20.
//  Copyright © 2020 Shane Whitehead. All rights reserved.
//

import UIKit

class ViewController: UIViewController {
	
	@IBOutlet weak var countdownLabel: UILabel!
	
	lazy var durationFormatter: DateComponentsFormatter = {
		let formatter = DateComponentsFormatter()
		formatter.unitsStyle = .positional
		formatter.allowedUnits = [.second]
		formatter.zeroFormattingBehavior = [.pad]
		return formatter
	}()

	var timer: Timer?
	var startTime: Date?
	var duration: TimeInterval = 5
	
	override func viewDidLoad() {
		super.viewDidLoad()
		// Do any additional setup after loading the view.
	}
	
	override func viewWillAppear(_ animated: Bool) {
		super.viewWillAppear(animated)
		countdownLabel.text = "---"
		
		startTime = Date()
		timer = Timer.scheduledTimer(timeInterval: 0.5, target: self, selector: #selector(tick), userInfo: nil, repeats: true)
	}
	
	@objc func tick() {
		guard let startTime = startTime else { return }
		let diff = Date().timeIntervalSince(startTime)
		guard diff <= duration else {
			timer?.invalidate()
			timer = nil
			// Just a edge case catch
			countdownLabel.text = durationFormatter.string(from: 0)
			return
		}
		countdownLabel.text = durationFormatter.string(from: duration - diff)
	}


}

