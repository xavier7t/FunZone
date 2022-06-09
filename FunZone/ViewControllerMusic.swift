//
//  ViewControllerMusic.swift
//  FunZone
//
//  Created by Xavier on 6/3/22.
//

import UIKit

var albumArr = [Album]()

class ViewControllerMusic: UIViewController {
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        viewDidLoad_InstantiateSongs()

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

//define class for song and album
class Song {
    var songName : String
    var singer : String
    var album : String
    var duration : Int
    var imageName : String
    init(songName : String, singer : String, album : String, duration : Int) {
        self.imageName = "\(singer)-\(songName)"
        self.songName = songName
        self.singer = singer
        self.album = album
        self.duration = duration
    }
}
class Album {
    var albumName : String
    var songArr : [Song]
    init(albumName : String, songArr : [Song]) {
        self.albumName = albumName
        self.songArr = songArr
    }
}
extension ViewControllerMusic {
    //prepare data of album and songs
    func viewDidLoad_InstantiateSongs(){
        albumArr.append(Album.init(albumName: "Wildblood", songArr: [
            Song.init(songName: "Wildblood", singer: "Hipper", album: "Wildblood", duration: 34)
        ]))
        albumArr.append(Album.init(albumName: "Autoreverse", songArr: [
            Song.init(songName: "Autoreverse", singer: "Twins Music", album: "Autoreverse", duration: 121)
        ]))
        albumArr.append(Album.init(albumName: "Gravity", songArr: [
            Song.init(songName: "Afterlight", singer: "Andy Bird", album: "Gravity", duration: 152),
            Song.init(songName: "Gravity", singer: "Andy Bird", album: "Gravity", duration: 140),
            Song.init(songName: "World On Fire", singer: "Andy Bird", album: "Gravity", duration: 155)
        ]))
        albumArr.append(Album.init(albumName: "Don't Forget", songArr: [
            Song.init(songName: "Don't Forget", singer: "Yari", album: "Don't Forget", duration: 145)
        ]))
    }
}

extension ViewControllerMusic : UITableViewDataSource {
    //configure number of sections, which should be number of albums
    func numberOfSections(in tableView: UITableView) -> Int {
        return albumArr.count
    }
    //configure number of rows in each section, which should be number of elements in album.songarr
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return albumArr[section].songArr.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cellMusic = tableView.dequeueReusableCell(withIdentifier: "cellMusic", for: indexPath) as! TableViewCellMusic
        let song = albumArr[indexPath.section].songArr[indexPath.row]
        cellMusic.labelSongNameSingerName.text = "\(song.songName)-\(song.singer)"
        cellMusic.imageViewArtwork.image = UIImage(named: song.imageName)
        cellMusic.labelAlbumName.text = song.album
        let duration = albumArr[indexPath.section].songArr[indexPath.row].duration
        cellMusic.labelDuration.text = lengthToString(length: duration)
        return cellMusic
    }
    //configure title for section headers, to show album names
    func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        return "Album: \(albumArr[section].albumName)"
    }
    
    func lengthToString(length : Int) -> String {
        let lengthSec = length % 60
        let lengthMinL = (length - lengthSec) / 60
        if lengthMinL > 60 {
            let lengthHour = lengthMinL % 60
            let lengthMinS = lengthMinL - lengthHour * 60
            return "\(timingIntToString(length: lengthHour)):\(timingIntToString(length: lengthMinS)):\(timingIntToString(length: lengthSec))"
        } else {
            return "\(timingIntToString(length: lengthMinL)):\(timingIntToString(length: lengthSec))"
        }
    }
    func timingIntToString(length : Int) -> String { //populate a zero for one-digit hms vars
        if length < 10 {
            return "0" + String(length)
        } else {
            return String(length)
        }
    }
    //configure total duration for section footers
    func tableView(_ tableView: UITableView, titleForFooterInSection section: Int) -> String? { //config footer: Album total length
        let songArr = albumArr[section].songArr
        var totalLength = 0
        for song in songArr {
            totalLength += song.duration
        }
        return "Total " + lengthToString(length: totalLength)
    }
}
extension ViewControllerMusic : UITableViewDelegate {
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        rowMusic = indexPath.row
        sectionMusic = indexPath.section
        performSegue(withIdentifier: "MusicToPlay", sender: self) //open the audioplayer page
    }
}

var rowMusic : Int?
var sectionMusic : Int?
