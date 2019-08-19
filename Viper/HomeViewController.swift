//
//  ViewController.swift
//  Viper
//
//  Created by MyGlamm on 8/19/19.
//  Copyright © 2019 MyGlamm. All rights reserved.
//

import UIKit

protocol HomeViewDelegate : class{
   func onColorValueChanged() -> ()
    func onColorLoad(rgb : (CGFloat,CGFloat,CGFloat)) -> ()
}


class HomeViewController: UIViewController {

    @IBOutlet weak var redSlider: UISlider!
    
    @IBOutlet weak var greenSlider: UISlider!
    
    @IBOutlet weak var blueSlider: UISlider!
    
    @IBOutlet weak var rgbColorValue: UILabel!
    

    
    var viewModel : HomeViewModel?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        
        viewModel = HomeViewModel(parentView : self)

        onColorLoad(rgb: viewModel!.currentColor!)
        
        
        
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
    
    
    
}


extension HomeViewController : HomeViewDelegate{
    
    
    func onColorValueChanged() {
        
        let step : Float = 1
        
        let red = CGFloat(round(redSlider.value/step) * step)
        
        let green = CGFloat(round(greenSlider.value/step) * step)
        
        let blue = CGFloat(round(blueSlider.value/step) * step)
        
        
        rgbColorValue.text = "RGB value (\(red),\(green),\(blue))"
        
        viewModel?.saveColor(rgb: (Float(red), Float(green), Float(blue)))
        
        view.backgroundColor = UIColor(red: red/255, green : green/255, blue: blue/255, alpha: 1)
    }
    
    
    
    func onColorLoad(rgb: (CGFloat, CGFloat, CGFloat)) {
        
        
        rgbColorValue.text = "RGB value (\(rgb.0),\(rgb.1),\(rgb.2))"
        
        redSlider.value = Float(rgb.0)
        
        greenSlider.value = Float(rgb.1)
        
        blueSlider.value = Float(rgb.2)
        
        
        view.backgroundColor = UIColor(red: rgb.0/255, green : rgb.1/255, blue: rgb.2/255, alpha: 1)
    }
    


    
}


