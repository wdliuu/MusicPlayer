//
//  ViewController.swift
//  Wendio
//
//  Created by Wendy on 11/13/20.
//

import UIKit

class ViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {
    
    @IBOutlet var table: UITableView!
    
    var songs = [Song]()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        configureSongs()
        
        table.delegate = self
        table.dataSource = self
    }
    //Table
    
    func configureSongs(){
        songs.append(Song(name: "Valsas Op 39.",
                          albumName: "album name: B",
                          artistName: "Brahms",
                          imageName: "cover1",
                          trackName: "song1"))
        songs.append(Song(name: "12 Etude Op 10.",
                          albumName: "album name: C",
                          artistName: "Chopin",
                          imageName: "cover2",
                          trackName: "song2"))
        songs.append(Song(name: "12 Variations in C Major",
                          albumName: "album name: M",
                          artistName: "Mozart",
                          imageName: "cover3",
                          trackName: "song3"))
        songs.append(Song(name: "Valsas Op 39.",
                          albumName: "album name: B",
                          artistName: "Brahms",
                          imageName: "cover1",
                          trackName: "song1"))
        songs.append(Song(name: "12 Etude Op 10.",
                          albumName: "album name: C",
                          artistName: "Chopin",
                          imageName: "cover2",
                          trackName: "song2"))
        songs.append(Song(name: "12 Variations in C Major",
                          albumName: "album name: M",
                          artistName: "Mozart",
                          imageName: "cover3",
                          trackName: "song3"))
        songs.append(Song(name: "Valsas Op 39.",
                          albumName: "album name: B",
                          artistName: "Brahms",
                          imageName: "cover1",
                          trackName: "song1"))
        songs.append(Song(name: "12 Etude Op 10.",
                          albumName: "album name: C",
                          artistName: "Chopin",
                          imageName: "cover2",
                          trackName: "song2"))
        songs.append(Song(name: "12 Variations in C Major",
                          albumName: "album name: M",
                          artistName: "Mozart",
                          imageName: "cover3",
                          trackName: "song3"))
    }
    
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return songs.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath)
        let song = songs[indexPath.row]
        //configure
        cell.textLabel?.text = song.name
        cell.detailTextLabel?.text = song.albumName
        cell.accessoryType = .disclosureIndicator
        cell.imageView?.image = UIImage(named: song.imageName)
        
        cell.textLabel?.font = UIFont(name: "Helvetica-Bold", size: 20)
        cell.detailTextLabel?.font = UIFont(name: "Helvetica", size: 18
        )

        return cell
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 100
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
        
        //present the player
        let position = indexPath.row
        //songs
        guard let vc = storyboard?.instantiateViewController(identifier: "player") as? PlayerViewController else{
            return
        }
        vc.songs = songs
        vc.position = position
        
        
        present(vc, animated: true)
    }
}


struct Song{
    let name: String
    let albumName: String
    let artistName: String
    let imageName: String
    let trackName: String
}
