//
//  ResultVC.swift
//  QuizApp
//
//  Created by Necati Alperen IŞIK on 20.01.2024.
//

import UIKit

class ResultVC: UIViewController {
    var score = 0
    
    
    @IBOutlet weak var resultLabel: UILabel!
    override func viewDidLoad() {
        super.viewDidLoad()

        resultLabel.text = "Your Score : \(score)"
    }
    

    @IBAction func mainMenuClicked(_ sender: Any) {
        performSegue(withIdentifier: "toStart", sender: nil)
        score = 0
    }
    
}
