//
//  ColorViewBuilder.swift
//  Viper
//
//  Created by MyGlamm on 8/21/19.
//  Copyright © 2019 MyGlamm. All rights reserved.
//

import UIKit


//create whole module and returns viewcontroller
//while assembling this VC its assigning element of viper to VC
class ColorViewBuilder {
    
    
    static func assembleModule() -> ColorViewController?{
        
        let storyboard = UIStoryboard.init(name: "Main", bundle: nil)
        
        
        
        let view = storyboard.instantiateViewController(withIdentifier: "ColorViewController") as? ColorViewController
        
        let presenter = ColorViewPresenter()
        
        let interactor = ColorViewInteractor()
        
        let router = ColorViewRouter()
        
        
        view?.presenter = presenter
        
        presenter.view = view
        presenter.interactor = interactor
        presenter.router = router
        
        //Router must know about view for navigation but indirectly through as it must be generic
        router.viewController = view
        
        return view
    }
}
