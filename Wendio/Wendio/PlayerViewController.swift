//
//  PlayerViewController.swift
//  Wendio
//
//  Created by Wendy on 11/13/20.
//

import AVFoundation

import UIKit

class PlayerViewController: UIViewController {
    public var position: Int = 0
    public var songs: [Song] = []
    
    
    @IBOutlet var holder: UIView!
    
    var player: AVAudioPlayer?
    
    //user interface elemetns
    
    private let songNameLabel: UILabel = {
        let label = UILabel()
        label.font = label.font.withSize(25)
        label.textAlignment = .center
        label.numberOfLines = 0 //line wrap
        return label
    }()
    
    private let artistNameLabel: UILabel = {
        let label = UILabel()
        label.font = label.font.withSize(30)
        label.textAlignment = .center
        label.numberOfLines = 0 //line wrap
        return label
    }()
    
    private let albumNameLabel: UILabel = {
        let label = UILabel()
        label.font = label.font.withSize(20)
        label.textAlignment = .center
        label.numberOfLines = 0 //line wrap
        return label
    }()
    
    private let albumImageView: UIImageView = {
        //let imageView = UIImageView()
        let imageView = UIImageView(frame: CGRect(x: 0, y: 0, width: 40, height: 40))
        //imageView.contentMode = .scaleAspectFill
        return imageView
    }()
    
    let playPauseButton = UIButton()
    
    override func viewDidLoad() {
        super.viewDidLoad()

    }
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        if holder.subviews.count == 0{
            configure()
        }
    }
    
    func configure(){
        //set up player
        let song = songs[position]
        
        let urlString = Bundle.main.path(forResource: song.trackName, ofType: "mp3")
        
        
        do{
            try AVAudioSession.sharedInstance().setMode(.default)
            try AVAudioSession.sharedInstance().setActive(true, options: .notifyOthersOnDeactivation)
            
            guard let urlString = urlString else{
                return
            }
            player = try AVAudioPlayer(contentsOf: URL(string: urlString)!)
            
            guard let player = player else{
                return
            }
            player.volume = 0.5
            
            player.play()
        }
        catch{
            print("error orrcurred")
        }
        
        //set up user interface elements
        
        //album cover
        albumImageView.frame = CGRect(x: 10,
                                      y: 10,
                                      width: holder.frame.size.width-20,
                                      height: holder.frame.size.width-20)
        albumImageView.image = UIImage(named: song.imageName)
        holder.addSubview(albumImageView)
        //contentMode = .scaleAspectFill
        
        //labels: Song name, album, artist
        songNameLabel.frame = CGRect(x: 10,
                                      y: albumImageView.frame.size.height + 10,
                                      width: holder.frame.size.width-20,
                                      height: 70)
        albumNameLabel.frame = CGRect(x: 10,
                                      y: albumImageView.frame.size.height + 10 + 70,
                                      width: holder.frame.size.width-20,
                                      height: 70)
        artistNameLabel.frame = CGRect(x: 10,
                                      y: albumImageView.frame.size.height + 10 + 140,
                                      width: holder.frame.size.width-20,
                                      height: 70)
        
        songNameLabel.text = song.name
        albumNameLabel.text = song.albumName
        artistNameLabel.text = song.artistName
        
        holder.addSubview(songNameLabel)
        holder.addSubview(albumNameLabel)
        holder.addSubview(artistNameLabel)

        
        //player controls
        let nextButton = UIButton()
        let backButton = UIButton()
        
        //Frame
        let  yPosition = artistNameLabel.frame.origin.y + 70 + 20
        let size: CGFloat = 60
        
        playPauseButton.frame = CGRect(x: (holder.frame.size.width - size)/2.0,
                                       y: yPosition,
                                       width: size,
                                       height: size)
        nextButton.frame = CGRect(x: holder.frame.size.width - size - 20,
                                  y: yPosition,
                                  width: size,
                                  height: size)
        backButton.frame = CGRect(x: 20,
                                  y: yPosition,
                                  width: size,
                                  height: size)
        
        
        //Add actions
        playPauseButton.addTarget(self, action: #selector(didTapPauseButton), for: .touchUpInside)
        nextButton.addTarget(self, action: #selector(didTapNextButton), for: .touchUpInside)
        backButton.addTarget(self, action: #selector(didTapBackButton), for: .touchUpInside)
        
        //Styling
        playPauseButton.setBackgroundImage(UIImage(systemName: "pause.fill"), for: .normal)
        backButton.setBackgroundImage(UIImage(systemName: "backward.fill"), for: .normal)
        nextButton.setBackgroundImage(UIImage(systemName: "forward.fill"), for: .normal)
        
        
        
        playPauseButton.tintColor = .black
        backButton.tintColor = .black
        nextButton.tintColor = .black
        
        holder.addSubview(playPauseButton)
        holder.addSubview(nextButton)
        holder.addSubview(backButton)


        //slider
        let slider = UISlider(frame: CGRect(x: 20,
                                            y: holder.frame.height-60,
                                            width: holder.frame.size.width-40,
                                            height: 50))

        slider.value = 0.5
        slider.addTarget(self,
                         action: #selector(didSlideSlider(_:)),
                         for: .valueChanged)
        holder.addSubview(slider)
        
    }
    @objc func didTapBackButton(){
        if position > 0 {
            position = position - 1
            player?.stop()
            for subview in holder.subviews{
                subview.removeFromSuperview()
            }
            configure()
        }
    }
    
    @objc func didTapNextButton(){
        if position < (songs.count - 1) {
            position = position + 1
            player?.stop()
            for subview in holder.subviews{
                subview.removeFromSuperview()
            }
            configure()
        }
    }
    
    @objc func didTapPauseButton(){
        if player?.isPlaying == true{
            //pause
            player?.pause()
            //show play button
            playPauseButton.setBackgroundImage(UIImage(systemName: "play.fill"), for: .normal)
            
            
            //shrink the cover
            UIView.animate(withDuration: 0.2, animations: {
                self.albumImageView.frame = CGRect(x: 30,
                                                   y: 30,
                                                   width: self.holder.frame.size.width-60,
                                                   height: self.holder.frame.size.width-60)
                
            })
        }else{
            //play
            player?.play()
            playPauseButton.setBackgroundImage(UIImage(systemName: "pause.fill"), for: .normal)
            
            //enlarge the cover img
            UIView.animate(withDuration: 0.2, animations: {
                self.albumImageView.frame = CGRect(x: 10,
                                                   y: 10,
                                                   width: self.holder.frame.size.width-20,
                                                   height: self.holder.frame.size.width-20)
                
            })
        }
    }
    
    
    @objc func didSlideSlider(_ slider: UISlider){
        let value = slider.value
        player?.volume = value
        //adjust player volume
    }
    
    override func viewWillDisappear(_ animated: Bool){
        super.viewWillAppear(animated)
        if let player = player{
            player.stop()
        }
    }

}
