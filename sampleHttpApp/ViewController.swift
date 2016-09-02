//
//  ViewController.swift
//  sampleHttpApp
//
//  Created by Muneharu Onoue on 2016/09/02.
//  Copyright © 2016年 Muneharu Onoue. All rights reserved.
//

import UIKit
import Alamofire

class ViewController: UIViewController {

    @IBOutlet weak var statusLabel: UILabel!
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }


    // You should also update Info.plist.
    @IBAction func httpGet(sender: AnyObject) {
        Alamofire.request(.GET, "http://testhost.com/get")
        .responseJSON { res in
            print(res.request)  // original URL request
            print(res.response) // URL response
            print(res.data)     // server data
            print(res.result)   // result of response serialization
            
            if let JSON = res.result.value {
                print("JSON: \(JSON)")
            }
        }
        

    }

    @IBAction func httpPost(sender: AnyObject) {
        let fileURL = NSBundle.mainBundle().URLForResource("test_local", withExtension: "mp4")
        guard let cFileUrl = fileURL else {
            return
        }
        Alamofire.upload(
            .POST,
            "http://testhost.com/post",
            multipartFormData: { multipartFormData in
                multipartFormData.appendBodyPart(fileURL: cFileUrl, name: "file")
            },
            encodingCompletion: { encodingResult in
                switch encodingResult {
                case .Success(let upload, _, _):
                    upload.responseJSON { res in
                        NSLog("\(res.response?.statusCode)")
                        debugPrint(res)
                    }
                case .Failure(let encodingError):
                    print(encodingError)
                }
            }
        )
    }
}

