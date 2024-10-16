//
//  ResultsViewController.swift
//  IP12-Trivia
//
//  Created by Gopez, Ethan A on 2/12/24.
//

import UIKit

class ResultsViewController: UIViewController {

    @IBOutlet var correctLabel: UILabel!
    
    var vc : GameViewController!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }
    
    func setText(_ text: String) {
        correctLabel.text = text
    }
    func setVS (_ vc : GameViewController) {
        self.vc = vc
    }
    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */
    @IBAction func unwindToGame(unwindSegue: UIStoryboardSegue ) {
       // unwindSegue.source.tabBarController?.selectedIndex = 0
    }
    
    override func viewDidDisappear(_ animated: Bool) {
        if let v = vc {
            v.tabBarController?.selectedIndex = 0
        }
    }
}
