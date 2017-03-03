//
//  PlayerVC.swift
//  xmlParsing
//
//  Created by Drew Westcott on 02/03/2017.
//  Copyright © 2017 Drew Westcott. All rights reserved.
//

import UIKit
import AVFoundation

class PlayerVC: UIViewController, URLSessionDownloadDelegate, AVAudioPlayerDelegate {

	@IBOutlet weak var playerImage: UIImageView!
	@IBOutlet weak var playerTitle: UILabel!
	@IBOutlet weak var playerDetail: UITextView!
	@IBOutlet weak var playButton: UIButton!
	@IBOutlet weak var downloadingLabel: UILabel!
	
	var pod : Podcast?
	
	var downloadTask: URLSessionTask!
	var backgroundSession: URLSession!
	
	var player : AVAudioPlayer!
	var keepPath : String!
	var isPlaying = false
	
    override func viewDidLoad() {
        super.viewDidLoad()

		if pod != nil {
			playerTitle.text = pod?.castTitle
			playerDetail.text = pod?.castDescription
		} else {
			print("No podcast")
		}
		let backgroundSessionConfig = URLSessionConfiguration.background(withIdentifier: "dlPod")
		backgroundSession = URLSession(configuration: backgroundSessionConfig, delegate: self, delegateQueue: OperationQueue.main)

		playButton.isHidden = true

		let downloadURL = URL(string: (pod?.castDownloadURL)!)
		downloadTask = backgroundSession.downloadTask(with: downloadURL!)
		downloadTask.resume()
		
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
	
	func urlSession(_ session: URLSession, downloadTask: URLSessionDownloadTask, didFinishDownloadingTo location: URL) {
		
		
		let path = NSSearchPathForDirectoriesInDomains(FileManager.SearchPathDirectory.documentDirectory, FileManager.SearchPathDomainMask.userDomainMask, true)
		let documentDirectoryPath: String = path[0]
		let fileManager = FileManager()
		let destinationURLForFile = URL(fileURLWithPath: documentDirectoryPath.appendingFormat("/download.m4a"))
		print(destinationURLForFile)
		keepPath = destinationURLForFile.path
		
		if fileManager.fileExists(atPath: destinationURLForFile.path) {
			print("File already Downloaded")
			playButton.isHidden = false
			downloadingLabel.text = ""
		} else {
			print("Moving file")
			do {
				try fileManager.moveItem(at: location, to: destinationURLForFile)
				playButton.isHidden = false
			} catch {
				print("Error!")
			}
		}
		
	}

	func urlSession(_ session: URLSession, downloadTask: URLSessionDownloadTask, didWriteData bytesWritten: Int64, totalBytesWritten: Int64, totalBytesExpectedToWrite: Int64) {
	let percentage = Double(totalBytesWritten) / Double(totalBytesExpectedToWrite) * 100.0
	downloadingLabel.text = "Downloading... \(Int(percentage))% Complete"
		print("\(percentage)-\(totalBytesWritten) : \(totalBytesExpectedToWrite)")
	}
	
	@IBAction func playButtonTapped(_ sender: Any) {
		if isPlaying == false {
			playFileWithPath(path: keepPath)
		} else {
			player.pause()
			isPlaying = false
		}
	}
	
	@IBAction func exTapped(_ sender: Any) {
		player.pause()
		
	}
	func playFileWithPath(path: String){
		let isFileFound:Bool? = FileManager.default.fileExists(atPath: path)
		if isFileFound == true{
			let podcast = URL(fileURLWithPath: path)
			
			//var podcast = NSURL(fileURLWithPath: Bundle.main.path(forResource: "file", ofType: "m4a")!)
			
			var error : NSError?
			do {
				player = try AVAudioPlayer(contentsOf:  podcast as URL)
				player.play()
				isPlaying = true
				
			} catch {
				print("Error '(error)")
			}
			
			//			viewer.delegate = self
			//			viewer.presentPreview(animated: true)
		}
	}

}
