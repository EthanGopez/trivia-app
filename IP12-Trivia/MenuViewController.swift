//
//  MenuViewController.swift
//  IP12-Trivia
//
//  Created by Gopez, Ethan A on 1/25/24.
//next task as of 2/6: complete the last segue for the congrats

import UIKit

class MenuViewController: UIViewController, UIPickerViewDelegate, UIPickerViewDataSource {
    
    
    
    @IBOutlet var menuPicker: UIPickerView!
    
    
    @IBOutlet var numPicker: UIPickerView!
    
    let keys = TriviaBank.getQuestions().keys
    
    let numData = ["1", "2", "3", "4", "5", "6", "7", "8", "9", "10"]
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        
        self.menuPicker.delegate = self
        self.menuPicker.dataSource = self
        
        self.numPicker.delegate = self
        self.numPicker.dataSource = self
        
        var currentPick = numData[numPicker.selectedRow(inComponent: 0)]
        print(currentPick)
        
    }
    
    public func getCurrentCount() -> String {
        return numData[numPicker.selectedRow(inComponent: 0)]
    }
    
    public func getCurrentCategory() -> String {
        var x = 0
        for k in keys {
            if x == menuPicker.selectedRow(inComponent: 0) {
                return k
            }
            x+=1
        }
        return "Sports"
    }
    
    
    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        return 1
    }
    
    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        if pickerView.isEqual(menuPicker) {
            return keys.count
        }
        if pickerView.isEqual(numPicker) {
            return numData.count
        }
        return -1
    }
    
    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        if pickerView.isEqual(numPicker) {
            return numData[row]
        }
        if pickerView.isEqual(menuPicker) {
            var x = 0
            for k in keys {
                if x == row {
                    return k
                }
                x+=1
            }
        }
        return nil
        
    }

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}
