//
//  ColorViewController.swift
//  Viper
//
//  Created by MyGlamm on 8/21/19.
//  Copyright © 2019 MyGlamm. All rights reserved.
//

import UIKit


class ColorViewController: UIViewController {

    //We should on expose presentator through protocol defined
    var presenter : ColorViewPresentation?
    
    @IBOutlet weak var label: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        
        presenter?.viewDidLoad()
        // Do any additional setup after loading the view.
    }
    
    @IBAction func backButtonPressed(_ sender: UIButton) {
        
        presenter?.goBack()
    }
    

}

//Conformance so VIPER components consider it as a View
extension ColorViewController : ColorView{
    func showLabelValue(rgb: String?) {
        label.text = rgb
    }
    

    
    
}
