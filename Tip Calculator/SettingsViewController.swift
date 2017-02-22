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
    
    @IBOutlet weak var themeLabel: UILabel!
    @IBOutlet weak var themeSwitch: UISwitch!

    @IBOutlet weak var example1Label: UILabel!
    @IBOutlet weak var example2Label: UILabel!
    
    static var rounding = [1,1];
 
    static var okTip = 17.0;
    static var goodTip = 20.0;
        
    static var excellentTip = 23.0;
    
    static var maxTip = -1.0;
    static var minTip = -1.0;
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        let defaults = UserDefaults.standard
        let tips = defaults.object(forKey: "tips") as? [Double] ?? [
            SettingsViewController.okTip,
            SettingsViewController.goodTip,
            SettingsViewController.excellentTip
        ]
        
        SettingsViewController.rounding = defaults.object(forKey: "rounding") as? [Int] ?? SettingsViewController.rounding
        roundControl.selectedSegmentIndex = SettingsViewController.rounding[0];
        roundUpDownControl.selectedSegmentIndex = SettingsViewController.rounding[1];
        showHideUpDownRounding()
        
        let maxTip = defaults.object(forKey: "maxTip") as? Double ?? SettingsViewController.maxTip
        let minTip = defaults.object(forKey: "minTip") as? Double ?? SettingsViewController.minTip

        maxTipField.text = ""
        if (maxTip > 0) {
            maxTipField.text = maxTip.currency
        }
        
        minTipField.text = ""
        if (minTip > 0) {
            minTipField.text = minTip.currency        }
        
        okField.text = tips[0].percentNoSymbol
        goodField.text = tips[1].percentNoSymbol
        excellentField.text = tips[2].percentNoSymbol
        
        let theme = defaults.object(forKey: "theme") as? String ?? "Light"
        themeLabel.text = theme
        themeSwitch.setOn(themeLabel.text == "Light", animated: false)
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    override func viewDidDisappear(_ animated: Bool) {
        super.viewDidDisappear(animated)
        print("settings view did disappear")
        
        let defaults = UserDefaults.standard
        SettingsViewController.okTip = okField.text?.doubleValue ?? SettingsViewController.okTip
        SettingsViewController.goodTip = goodField.text?.doubleValue ?? SettingsViewController.goodTip
        SettingsViewController.excellentTip = excellentField.text?.doubleValue ?? SettingsViewController.excellentTip
        let tips = [SettingsViewController.okTip, SettingsViewController.goodTip, SettingsViewController.excellentTip]
        
        defaults.set(SettingsViewController.rounding, forKey: "rounding")
        defaults.set(tips, forKey: "tips")
        
        SettingsViewController.maxTip = (maxTipField.text?.doubleValue)!
        SettingsViewController.minTip = (minTipField.text?.doubleValue)!
        if (SettingsViewController.maxTip <= 0) {
            SettingsViewController.maxTip = -1
        }
        if (SettingsViewController.minTip <= 0) {
            SettingsViewController.minTip = -1
        }
        defaults.set(SettingsViewController.maxTip, forKey: "maxTip")
        defaults.set(SettingsViewController.minTip, forKey: "minTip")
        
        defaults.set(themeLabel.text, forKey: "theme")
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
    
    @IBAction func onThemeChanged(_ sender: Any) {
        if (themeSwitch.isOn) {
            themeLabel.text = "Light"
        }
        else {
            themeLabel.text = "Dark"
        }
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
