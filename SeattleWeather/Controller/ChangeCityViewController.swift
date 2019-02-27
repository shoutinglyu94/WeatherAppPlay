//
//  ChangeCityViewController.swift
//  SeattleWeather
//
//  Created by Shouting Lyu on 2/26/19.
//  Copyright © 2019 Shouting Lyu. All rights reserved.
//

import UIKit

class ChangeCityViewController: UIViewController {
    var delegate: ChangeCityProtocol?
    
    @IBOutlet weak var textCityName: UITextField!
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }
    
    @IBAction func backToWeather(_ sender: UIButton) {
    }
    

    @IBAction func changeCityPressedAgain(_ sender: UIButton) {
        let cityName = textCityName.text!
        delegate?.ChangeCityFunction(cityName: cityName)
        self.dismiss(animated: true, completion: nil)
    }
}
