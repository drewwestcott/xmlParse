//
//  PlayerVC.swift
//  xmlParsing
//
//  Created by Drew Westcott on 02/03/2017.
//  Copyright © 2017 Drew Westcott. All rights reserved.
//

import UIKit

class PlayerVC: UIViewController {

	@IBOutlet weak var playerImage: UIImageView!
	@IBOutlet weak var playerTitle: UILabel!
	@IBOutlet weak var playerDetail: UITextView!
	
	var pod : Podcast?
	
    override func viewDidLoad() {
        super.viewDidLoad()

		if pod != nil {
			playerTitle.text = pod?.castTitle
			playerDetail.text = pod?.castDescription
		} else {
			print("No podcast")
		}
		
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
	

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
