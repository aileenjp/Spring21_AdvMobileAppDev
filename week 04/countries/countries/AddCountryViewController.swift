//
//  AddCountryViewController.swift
//  countries
//
//  Created by Aileen Pierce
//

import UIKit

class AddCountryViewController: UIViewController {
    
    var addedCountry = String()

    @IBOutlet weak var countryTextfield: UITextField!
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "doneSegue"{
            //only add a country if there is text in the textfield
            if countryTextfield.text?.isEmpty == false{
                addedCountry=countryTextfield.text!
            }
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}
