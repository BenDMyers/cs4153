//
//  PlateViewController.swift
//  MW_01_myers_ben
//
//  Created by MYERS BENJAMIN D on 10/18/17.
//  Copyright © 2017 MYERS BENJAMIN D. All rights reserved.
//

import UIKit
import WebKit

class PlateViewController: UIViewController {
    
    @IBOutlet weak var web: WKWebView!
    public var state = ""
    public var plateURL = ""
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        
        title = state

        navigationController?.setToolbarHidden(true, animated: true)
        
        DispatchQueue(label: "Web Queue").async {
            if let url = URL(string: self.plateURL) {
                do {
                    let data = try Data(contentsOf: url)
                    DispatchQueue.main.async {
                        self.web.load(data, mimeType: "image/jpeg", characterEncodingName: "", baseURL: url)
                    }
                }
                catch {
                    print("HTML error")
                }
            } else {
                print("Not a valid url")
            }
        }
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

}
