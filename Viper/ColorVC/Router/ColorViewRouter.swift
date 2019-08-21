//
//  ColorViewRouter.swift
//  Viper
//
//  Created by MyGlamm on 8/21/19.
//  Copyright © 2019 MyGlamm. All rights reserved.
//

import UIKit

//Router for navigation , alerts
//protocol HomeViewWireframe : class,BaseWireFrame
//class router : BaseViewRouter,HomeViewWireframe    BaseViewRouter for embedding mini wireframes
class ColorViewRouter : ColorViewWireframe{
    
    var viewController: UIViewController?
    
    func goPopVC() {
        
        print("VCs \(viewController?.navigationController?.children)")
        viewController?.navigationController?.popViewController(animated: false)
    }
    
}
