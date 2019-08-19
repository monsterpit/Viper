//
//  ViewController.swift
//  Viper
//
//  Created by MyGlamm on 8/19/19.
//  Copyright © 2019 MyGlamm. All rights reserved.
//

import UIKit

protocol ColorValueDelegate{
   func onColorValueChanged() -> ()
}


class HomeViewController: UIViewController {

    @IBOutlet weak var redSlider: UISlider!
    
    @IBOutlet weak var greenSlider: UISlider!
    
    @IBOutlet weak var blueSlider: UISlider!
    
    @IBOutlet weak var rgbColorValue: UILabel!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        
        
        let rgb = loadCurrentColor()
        
        rgbColorValue.text = "RGB value (\(rgb.0),\(rgb.1),\(rgb.2))"
        
        
        redSlider.value = Float(rgb.0)
        
        blueSlider.value = Float(rgb.1)
        
        greenSlider.value = Float(rgb.2)
        
        view.backgroundColor = UIColor(red: rgb.0/255, green : rgb.1/255, blue: rgb.2/255, alpha: 1)
    }

    @IBAction func redSliderValueChanged(_ sender: UISlider) {
        onColorValueChanged()
    }
    
    
    @IBAction func greenSliderValueChanged(_ sender: UISlider) {
        onColorValueChanged()
    }
    
    @IBAction func blueSliderValueChanged(_ sender: UISlider) {
        onColorValueChanged()
    }
    
    
    func saveCurrentColor(rgb : (CGFloat,CGFloat,CGFloat) ) -> (){
        
        UserDefaults.standard.set(rgb.0, forKey: "Red")
        UserDefaults.standard.set(rgb.1, forKey: "Green")
        UserDefaults.standard.set(rgb.2, forKey: "Blue")
        print("Current Color are saved")
    }
    
    func loadCurrentColor() -> (CGFloat,CGFloat,CGFloat){
        
        let red = UserDefaults.standard.float(forKey: "Red")
        let green = UserDefaults.standard.float(forKey: "Green")
        let blue = UserDefaults.standard.float(forKey: "Green")
        print("Current Color are loaded")
        return (CGFloat(red),CGFloat(green),CGFloat(blue))
        
    }
    
    
}


extension HomeViewController : ColorValueDelegate{
    
    func onColorValueChanged() {
        
        let step : Float = 1
        
        let red = CGFloat(round(redSlider.value/step) * step)
        
        let green = CGFloat(round(greenSlider.value/step) * step)
        
        let blue = CGFloat(round(blueSlider.value/step) * step)
        
        rgbColorValue.text = "RGB value (\(red),\(green),\(blue))"
        
        saveCurrentColor(rgb: (red, green, blue))
        
        view.backgroundColor = UIColor(red: red/255, green : green/255, blue: blue/255, alpha: 1)
    }

    
}


//Color Change to interactor
//No Ui presentator
//navigation Router
//Entity is database persistence of data
