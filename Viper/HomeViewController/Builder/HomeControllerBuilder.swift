//
//  HomeControllerBuilder.swift
//  Viper
//
//  Created by MyGlamm on 8/19/19.
//  Copyright © 2019 MyGlamm. All rights reserved.
//

import UIKit




//Module Builder
//create whole module and returns viewcontroller
//while assembling this VC its assigning element of viper to VC
class HomeViewBuilder {
    
    
    static func assembleModule() -> HomeViewController?{
        
        let storyboard = UIStoryboard.init(name: "Main", bundle: nil)
        
        
        
        let view = storyboard.instantiateViewController(withIdentifier: "homeViewController") as? HomeViewController
        
        let presenter = HomeViewPresenter()
        
        let interactor = HomeViewInteractor()
        
        let router = HomeViewRouter()
        
        
        view?.presenter = presenter
        
        presenter.view = view
        presenter.interactor = interactor
        presenter.router = router
        
        //Router must know about view for navigation but indirectly through as it must be generic
        router.viewController = view
        
        return view
    }
}


//layers should be accessed only using protocols not concrete classes
