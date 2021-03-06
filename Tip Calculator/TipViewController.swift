//
//  ViewController.swift
//  Tip Calculator
//
//  Created by Kaamel Kermaani on 2/18/17.
//  Copyright © 2017 Kaamel Kermaani. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    @IBOutlet weak var tipLabel: UILabel!
    @IBOutlet weak var totalLabel: UILabel!
    
    @IBOutlet weak var billFeild: UITextField!
    @IBOutlet weak var tipControl: UISegmentedControl!
    
    static var minTip = 0.0;
    static var maxTip = 0.0;
    static var rounding = SettingsViewController.rounding;
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        print("view did load")
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        print("view will appear")
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        print("view did appear")
        
        billFeild.becomeFirstResponder()
        
        let defaults = UserDefaults.standard
        let tips = defaults.object(forKey: "tips") as? [Double] ?? [
            SettingsViewController.okTip,
            SettingsViewController.goodTip,
            SettingsViewController.excellentTip
        ]
        
        let ok = tips[0].percent
        let good = tips[1].percent
        let excellent = tips[2].percent
        
        tipControl.setTitle("OK \(ok)", forSegmentAt: 0)
        tipControl.setTitle("Good \(good)", forSegmentAt: 1)
        tipControl.setTitle("Excellent \(excellent)", forSegmentAt: 2)
        ViewController.rounding = defaults.object(forKey: "rounding") as? [Int] ?? SettingsViewController.rounding
        
        ViewController.maxTip = defaults.object(forKey: "maxTip") as? Double ?? SettingsViewController.maxTip
        ViewController.minTip = defaults.object(forKey: "minTip") as? Double ?? SettingsViewController.minTip

        if ((AppDelegate.lastBillAmount) != nil) {
            billFeild.text = AppDelegate.lastBillAmount?.currencyNoSymbol
            AppDelegate.lastBillAmount = nil
        }
        if (billFeild.text != nil) {
            calculate(Any.self)
        }
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        if (billFeild != nil) {
            let defaults = UserDefaults.standard
            defaults.set(billFeild.text?.doubleValue, forKey: "lastBillAmount")
            let time = NSDate().timeIntervalSince1970
            defaults.set(time, forKey: "lastBillTime")
        }
        print("view will disappear")
    }
    
    override func viewDidDisappear(_ animated: Bool) {
        super.viewDidDisappear(animated)
        print("view did disappear")
    }

    @IBAction func onTap(_ sender: Any) {
        view.endEditing(true)
    }

    @IBAction func onTipChanged(_ sender: Any) {
        calculate(Any.self)
    }
    //@IBAction 
    func calculate(_ sender: Any) {
        let tipPercentages = [SettingsViewController.okTip, SettingsViewController.goodTip, SettingsViewController.excellentTip]
        
        let bill = billFeild.text?.doubleValue ?? 0

        var tip = bill * tipPercentages[tipControl.selectedSegmentIndex] / 100.00
        if (ViewController.rounding[0] == 0) {
            tip = roundMe(what: tip, how: ViewController.rounding[1])
        }
        var total = bill + tip
        if (ViewController.rounding[0] == 2) {
            total = roundMe(what: total, how: ViewController.rounding[1])
            if (total < bill) {
                total = bill + tip;
            }
            tip = total - bill
        }
        if (tip < ViewController.minTip) {
            tip = ViewController.minTip
            total = tip + bill
        }
        if (ViewController.maxTip > ViewController.minTip) {
            if (tip > ViewController.maxTip) {
                tip = ViewController.maxTip
                total = tip + bill
            }
        }
        
        if (bill == 0) {
            tip = 0
            total = 0
        }
        
        tipLabel.alpha = 0
        tipLabel.text = tip.currency
        totalLabel.alpha = 0
        totalLabel.text = total.currency
        UIView.animate(withDuration: 1, animations: {
            self.tipLabel.alpha = 1
            self.totalLabel.alpha = 1
        })
    }
    
    func roundMe(what: Double, how: Int) -> Double {
        var result = what;
        if (how == 0) {
            result = what.rounded(.down)
        }
        else if (how == 2) {
            result = what.rounded(.up)
        }
        else {
            result = round(what)
        }
        return result
    }
}
