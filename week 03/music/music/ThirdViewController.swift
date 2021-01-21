//
//  ThirdViewController.swift
//  music
//
//  Created by Aileen Pierce
//

import UIKit

class ThirdViewController: UIViewController, UIPickerViewDataSource, UIPickerViewDelegate {
    @IBOutlet weak var artistPicker: UIPickerView!
    @IBOutlet weak var choiceLabel: UILabel!
    
    var musicData = DataLoader()
    var artists = [String]()
    var albums = [String]()
    let artistComponent = 0
    let albumComponent = 1
    let filename = "artistalbums2"
    
    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        return 2
    }
    
    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        if component == artistComponent {
            return artists.count
        } else {
            return albums.count
        }
    }
    
    //Picker Delegate methods
    //Returns the title for a given row
    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        if component == artistComponent {
            return artists[row]
        } else {
            return albums[row]
        }
    }
    
    //Called when a row is selected
    func pickerView(_ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
        //checks which component was picked
        if component == artistComponent {
            albums = musicData.getAlbums(index: row) //gets the albums for the selected artist
            artistPicker.reloadComponent(albumComponent) //reloads the album component
            artistPicker.selectRow(0, inComponent: albumComponent, animated: true) //set the album component back to 0
        }
        let artistrow = pickerView.selectedRow(inComponent: artistComponent) //gets the selected row for the artist
        let albumrow = pickerView.selectedRow(inComponent: albumComponent) //gets the selected row for the album
        choiceLabel.text="You like \(albums[albumrow]) by \(artists[artistrow])"
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        musicData.loadData(filename: filename)
        artists = musicData.getArtists()
        albums = musicData.getAlbums(index: 0)
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
