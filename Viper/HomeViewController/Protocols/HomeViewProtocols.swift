//
//  HomeViewProtocols.swift
//  Viper
//
//  Created by MyGlamm on 8/21/19.
//  Copyright © 2019 MyGlamm. All rights reserved.
//

import UIKit


//V
//representation of VC
//We are not letting any other layer directly know of VC but can only know through View
protocol HomeView : class{
    func onLoadCurrentColor(rgb : (CGFloat,CGFloat,CGFloat)) -> ()
}


//I
//Has validations No UI
//Interactor shouldnt know about view at all
protocol HomeUseCase : class {
    
    func loadCurrentColor() -> (CGFloat,CGFloat,CGFloat)
    
    func saveCurrentColor(rgb : (CGFloat,CGFloat,CGFloat)) -> ()
    
    
}



//Viper P
//Does all delegation work , it get work from VC and start giving work to different guys like like asking router to navigate or show alert
//Presentator can ask interactor to solve some usecase like saving current color
//Presentator should know about view through protocol not directly but VC can know about presentator as there's a direct association
protocol  HomeViewPresentation : class {
    var view : HomeView? {get}
    var router : HomeViewWireframe? {get}
    var interactor : HomeUseCase? {get}
    
    func loadCurrentColor() -> ()
    func onColorValueChanged(rgb: (CGFloat, CGFloat, CGFloat)) -> ()
    
    //func showColorValue(with color: (Float,Float,Float), from view: UIViewController) ->()
    func showColorValue(with color: (Float,Float,Float)) ->()
}


//Will inject E which is UserDefault in this case




//Viper R
protocol HomeViewWireframe : class{
    
    var viewController : UIViewController? {get}
    
    func pushToColorViewController(rgb : (Float,Float,Float))-> ()
    
}
