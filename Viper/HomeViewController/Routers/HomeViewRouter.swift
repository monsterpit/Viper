//
//  HomeViewRouter.swift
//  Viper
//
//  Created by MyGlamm on 8/21/19.
//  Copyright © 2019 MyGlamm. All rights reserved.
//

import UIKit


//Router for navigation , alerts
//protocol HomeViewWireframe : class,BaseWireFrame
//class router : BaseViewRouter,HomeViewWireframe    BaseViewRouter for embedding mini wireframes
class HomeViewRouter : HomeViewWireframe{
    
    var viewController: UIViewController?
    
    func pushToColorViewController(rgb: (Float, Float, Float)) {
        
        let colorViewController = ColorViewBuilder.assembleModule()
        
        colorViewController?.presenter?.labelValue = rgb
        
        viewController?.navigationController?.pushViewController(colorViewController!, animated: true)
    }
    
}
