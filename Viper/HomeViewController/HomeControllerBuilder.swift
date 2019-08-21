//
//  HomeControllerBuilder.swift
//  Viper
//
//  Created by MyGlamm on 8/19/19.
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



class HomeViewInteractor : HomeUseCase{

    //Fetching using Dao
    //having dao is better than directly interacting entity so it can be reused
    var appColorDao : AppColorDao?
    
    init(dao : AppColorDao = AppColorDao()){
        appColorDao = dao
    }
    
    func loadCurrentColor() -> (CGFloat,CGFloat,CGFloat) {
        let currentRGB = appColorDao?.fetch()
        return currentRGB!
        
    }
    
    func saveCurrentColor(rgb : (CGFloat,CGFloat,CGFloat)) -> (){
        appColorDao?.save(rgb: (Float(rgb.0),Float(rgb.1),Float(rgb.2)))
    }
    
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
    
    func showColorValue(with color: (Float,Float,Float), from view: UIViewController) ->()
}

//On color change can be delegated to presentator , can ask Interactor to save changes
class HomeViewPresenter : HomeViewPresentation{
    weak var view : HomeView? //weak To avoid memory cycle
    var router : HomeViewWireframe? // as we dont except anything //delegation,Rx subscription,closure for return of value if required
    var interactor : HomeUseCase?
    
    
    func loadCurrentColor(){
        
        DispatchQueue.global(qos: .background).async {
            
            [weak self] in
            
            guard let `self` = self else{return}
            
            let currentRGB = self.interactor?.loadCurrentColor()
            
            
            DispatchQueue.main.async {
                self.view?.onLoadCurrentColor(rgb : currentRGB!)
            }
        }
        
        
    }
    
    //It delegates the save work to presentor
    func onColorValueChanged(rgb: (CGFloat, CGFloat, CGFloat)){
     
        
        
        DispatchQueue.global(qos: .background).async {
            
            [weak self] in
            
            guard let `self` = self else{return}
            
           self.interactor?.saveCurrentColor(rgb: rgb)

        }
        
        
        
    }
    
    func showColorValue(with color: (Float,Float,Float), from view: UIViewController) ->(){
        
        router?.pushToColorViewController(rgb: color)
        
    }
    
}


//Will inject E which is UserDefault in this case


//Viper R
protocol HomeViewWireframe : class{
    
    var viewController : UIViewController? {get}
    
    func pushToColorViewController(rgb : (Float,Float,Float))-> ()
    
}
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
