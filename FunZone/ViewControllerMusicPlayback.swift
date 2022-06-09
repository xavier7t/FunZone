//
//  ViewControllerMusicPlayback.swift
//  FunZone
//
//  Created by Xavier on 6/3/22.
//

import UIKit
import AVFoundation
class ViewControllerMusicPlayback: UIViewController {
    var audioPlayer : AVAudioPlayer?
    
    let song = albumArr[sectionMusic!].songArr[rowMusic!]
    var timer : Timer?
    
    var buttonPlayPauseIsPlay = true //bool for checking button is play/pause
    @IBAction func buttonPlayPauseDidTouchUpInside(_ sender: Any) {
        buttonPlayPauseDidTouchUpInside()
    }


    @IBOutlet weak var buttonPlayPause: UIButton!
    @IBOutlet weak var progressViewPlaybackProgress: UIProgressView!
    @IBOutlet weak var labelAlbum: UILabel!
    @IBOutlet weak var labelSongSinger: UILabel!
    @IBOutlet weak var imageViewAlbum: UIImageView!
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        //initiate audio player with file path
        let musicFilePath = Bundle.main.path(forResource: song.songName, ofType: "mp3")
        let musicURL = URL(fileURLWithPath: musicFilePath!)
        do {
            audioPlayer = try AVAudioPlayer(contentsOf: musicURL)
        } catch {
            print("Music not found")
        }
        
        viewDidLoad_LoadViewControllerElements()
        
        //update background image wiht alpha
        let backgroundImage = UIImageView(frame: UIScreen.main.bounds)
        backgroundImage.contentMode = UIView.ContentMode.scaleAspectFill
        backgroundImage.isOpaque = true
        backgroundImage.alpha = 0.2
        backgroundImage.image = UIImage(named: song.imageName)
        let cgPoint = CGPoint(x: 7, y: 7)
        let bgColor = backgroundImage.image?.getColorOfPixel(position: cgPoint)
//        view.backgroundColor = UIColor(patternImage: backgroundImage.image!)
        view.backgroundColor = bgColor
        
    }
    
    override func viewDidDisappear(_ animated: Bool) {
        super.viewWillDisappear(true)
        audioPlayer?.stop()
    }
//
//    override func viewWillAppear(_ animated: Bool) {
//        //stop music playback while users leave the page
//        super.viewWillAppear(animated)
//        audioPlayer?.stop()
//    }
//

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}

extension ViewControllerMusicPlayback {
    func viewDidLoad_LoadViewControllerElements() {
        labelAlbum.text = song.album
        labelSongSinger.text = "\(song.songName) - \(song.singer)"
        imageViewAlbum.layer.cornerRadius = 14
        imageViewAlbum.clipsToBounds = true
        imageViewAlbum.image = UIImage(named: song.imageName)
    }
    func buttonPlayPauseDidTouchUpInside() {
        if buttonPlayPauseIsPlay {
            buttonPlayPauseIsPlay = false
            buttonPlayPause.setImage(UIImage(systemName: "pause.fill"), for: .normal)
            audioPlayer?.play()
            timer = Timer.scheduledTimer(timeInterval: 1.0, target: self, selector: #selector(updateTime), userInfo: nil, repeats: true)
            print("Playing \(song.songName)")
        } else {
            buttonPlayPauseIsPlay = true
            buttonPlayPause.setImage(UIImage(systemName: "play.fill"), for: .normal)
            audioPlayer?.stop()
            print("\(song.songName) stopped playing.")
        }
    }
    
    //display progress in the progress view
    @objc func updateTime() {
        progressViewPlaybackProgress.progress = Float(audioPlayer!.currentTime) / Float(audioPlayer!.duration)
    }
}


extension UIImage {
    func getColorOfPixel(position: CGPoint) -> UIColor { //obtain a pixel color for background color
        let pixelData = self.cgImage!.dataProvider!.data
        let data: UnsafePointer<UInt8> = CFDataGetBytePtr(pixelData)
        let pixelInfo: Int =
            ((Int(self.size.width) * Int(position.y)) + Int(position.x)) * 4
        let r = CGFloat(data[pixelInfo]) / CGFloat(255.0)
        let g = CGFloat(data[pixelInfo+1]) / CGFloat(255.0)
        let b = CGFloat(data[pixelInfo+2]) / CGFloat(255.0)
        let a = CGFloat(data[pixelInfo+3]) / CGFloat(255.0)
        return UIColor(red: r, green: g, blue: b, alpha: a)
    }
}
