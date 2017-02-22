//
//  SettingsViewController.swift
//  Tip Calculator
//
//  Created by Kaamel Kermaani on 2/18/17.
//  Copyright © 2017 Kaamel Kermaani. All rights reserved.
//

import UIKit

class SettingsViewController: UIViewController {

    @IBOutlet weak var okField: UITextField!
    @IBOutlet weak var goodField: UITextField!
    @IBOutlet weak var excellentField: UITextField!
    @IBOutlet weak var minTipField: UITextField!
    @IBOutlet weak var maxTipField: UITextField!

    @IBOutlet weak var roundControl: UISegmentedControl!
    
    @IBOutlet weak var roundUpDownControl: UISegmentedControl!
    

    @IBOutlet weak var example1Label: UILabel!
    @IBOutlet weak var example2Label: UILabel!
    
    static var rounding = [1,1];
 
    static var okTip = "17";
    static var goodTip = "20";
    static var excellentTip = "25";
    
    static var maxTip = "-1";
    static var minTip = "0";
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        let defaults = UserDefaults.standard
        let tips = defaults.object(forKey: "tips") as? [String] ?? [
            SettingsViewController.okTip,
            SettingsViewController.goodTip,
            SettingsViewController.excellentTip
        ]
        
        SettingsViewController.rounding = defaults.object(forKey: "rounding") as? [Int] ?? SettingsViewController.rounding
        roundControl.selectedSegmentIndex = SettingsViewController.rounding[0];
        roundUpDownControl.selectedSegmentIndex = SettingsViewController.rounding[1];
        showHideUpDownRounding()
        
        let maxTip = Double(defaults.object(forKey: "maxTip") as? String ?? SettingsViewController.maxTip) ?? -1
        let minTip = Double(defaults.object(forKey: "minTip") as? String ?? SettingsViewController.minTip) ?? 0

        maxTipField.text = ""
        if (maxTip > 0) {
            maxTipField.text = maxTip.currency
        }
        
        minTipField.text = ""
        if (minTip > 0) {
            minTipField.text = minTip.currency        }
        
        okField.text = tips[0]
        goodField.text = tips[1]
        excellentField.text = tips[2]
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    override func viewDidDisappear(_ animated: Bool) {
        super.viewDidDisappear(animated)
        print("settings view did disappear")
        
        let defaults = UserDefaults.standard
        let ok = okField.text ?? SettingsViewController.okTip
        let good = goodField.text ?? SettingsViewController.goodTip
        let excellent = excellentField.text ?? SettingsViewController.excellentTip
        let tips = [ok, good, excellent]
        
        defaults.set(SettingsViewController.rounding, forKey: "rounding")
        defaults.set(tips, forKey: "tips")
        
        SettingsViewController.maxTip = "\(maxTipField.text?.doubleValue ?? -1)"
        SettingsViewController.minTip = "\(minTipField.text?.doubleValue ?? 0)"
        defaults.set(SettingsViewController.maxTip, forKey: "maxTip")
        defaults.set(SettingsViewController.minTip, forKey: "minTip")
        
    }
    
    @IBAction func onRounding(_ sender: Any) {
        onRoundingChange()
    }
    @IBAction func onUpDown(_ sender: Any) {
        onRoundingChange()
    }
    func onRoundingChange() {
        SettingsViewController.rounding = [
            roundControl.selectedSegmentIndex,
            roundUpDownControl.selectedSegmentIndex
        ]
        showHideUpDownRounding()
    }
    
    func showHideUpDownRounding() {
        if (roundControl.selectedSegmentIndex == 1) {
            roundUpDownControl.isHidden = true;
            example1Label.isHidden = true;
            example2Label.isHidden = true;
        }
        else {
            roundUpDownControl.isHidden = false;
            example1Label.isHidden = false;
            example2Label.isHidden = false;
        }
        let exa1 = [27.24.rounded(.down).currency, 27.24.rounded().currency, 27.24.rounded(.up).currency]
        let exa2 = [27.61.rounded(.down).currency, 27.61.rounded().currency, 27.61.rounded(.up).currency]
        let upDown1 = ["down", "down", "up"]
        let upDown2 = ["down", "up", "up"]
        example1Label.text = "Example 1: \(27.24.currency) is rounded \(upDown1[roundUpDownControl.selectedSegmentIndex]) to \(exa1[roundUpDownControl.selectedSegmentIndex])"
        example2Label.text = "Example 2: \(27.61.currency) is rounded \(upDown2[roundUpDownControl.selectedSegmentIndex]) to \(exa2[roundUpDownControl.selectedSegmentIndex])"
    }

    @IBAction func onTap(_ sender: Any) {
        view.endEditing(true)
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        super.prepare(for: segue, sender: sender)
    }

}
