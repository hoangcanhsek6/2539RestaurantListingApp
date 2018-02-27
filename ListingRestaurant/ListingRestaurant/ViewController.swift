//
//  ViewController.swift
//  ListingRestaurant
//
//  Created by Tran Hoang Canh on 27/2/18.
//  Copyright © 2018 Tran Hoang Canh. All rights reserved.
//

import UIKit
import RxSwift
import CT_RESTAPI

class ViewController: UIViewController {
    
    let disposeBag = DisposeBag()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        //        testAPI()
        //        testBoltsFlowWithRxSwift()
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        testAPIWithResponseArray()
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    
    func testAPI() {
        let apiManager = RESTApiClient(subPath: "login", functionName: "", method: .POST, endcoding: .URL)
        apiManager.setQueryParam(LoginParam(email: "hoangcanhsek6@gmail.com", password: "Hoangcanh1").dictionary)
        let obserable: Observable<User?> = apiManager.requestObject()
        obserable.subscribe(onNext: { (item) in
            print("Success")
        }, onError: { (error) in
            print("Error \(error)")
        }).disposed(by: disposeBag)
    }
    
    
    func testAPIWithResponseArray() {
        let apiManager = RESTApiClient(subPath: "get_categories", functionName: "", method: .POST, endcoding: .JSON)
        
        let obserable: Observable<BaseCategory?> = apiManager.requestObject()
        obserable.subscribe(onNext: { (item) in
            print("Success")
        }, onError: { (error) in
            print("Error")
        }).disposed(by: disposeBag)
    }
    
    func testBoltsFlowWithRxSwift() {
        let testBoltsObservable = Observable<Any>.just("0")
        let continueTask = Observable<Any>.just("1")
        
        testBoltsObservable.continueWithSuccessClosure { (result) -> Observable<Any> in
            return testBoltsObservable
            }.continueWithSuccessClosure { (result) -> Observable<Any> in
                return continueTask
            }.subscribe(onNext: { (value) in
                print(value)
            }).disposed(by: disposeBag)
    }
    
    
    
    
}

class LoginParam: Codable {
    
    @objc var email: String = "hoangcanhsek6@gmail.com"
    @objc var password: String = "hoangcanh1"
    
    init(email: String, password: String) {
        self.email = email
        self.password = password
    }
}




struct BaseCategory: Codable {
    var categories: [Category]
    var status: Bool
    var message: String
}

struct Category: Codable {
    var category_id: String?
    var category_name: String?
}