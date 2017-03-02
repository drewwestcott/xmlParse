//
//  ViewController.swift
//  xmlParsing
//
//  Created by Drew Westcott on 28/02/2017.
//  Copyright © 2017 Drew Westcott. All rights reserved.
//
// Images() podcast by Jamison Wieser from the Noun Project

import UIKit

class ViewController: UIViewController, XMLParserDelegate, UITableViewDelegate, UITableViewDataSource {
	
	// Mark: Properties
	//let url = URL(string: "http://feeds.99percentinvisible.org/99percentinvisible")
	let url = URL(string: "http://www.bbc.co.uk/programmes/p002w6r2/episodes/downloads.rss")
	
	var selectedPodcast : Podcast?
	var episodeFound = false
	var episodeTitle = String()
	var episodeDescription = String()
	var episodeLink = String()
	var epTitle = String()
	var epNext = String()
	var currentElement = ""
	var elementName = ""
	var counter = 0
	
	@IBOutlet weak var tableView: UITableView!
	
	var Podcasts = [Podcast]()
	var foundCharacters = ""

	override func viewDidLoad() {
		super.viewDidLoad()
		
		tableView.delegate = self
		tableView.dataSource = self

		if let parser = XMLParser(contentsOf: url!) {
			parser.delegate = self
			parser.parse()
		}
		
		print(Podcasts.count)
		print("Title:\(Podcasts[0].castTitle)")
		print("Desc:\(Podcasts[0].castDescription)")
		print("Link:\(Podcasts[0].castLink)")
//		for pod in Podcasts {
//			print(pod.castTitle)
//		}
	
	}

	func parser(_ parser: XMLParser, didStartElement elementName: String, namespaceURI: String?, qualifiedName qName: String?, attributes attributeDict: [String : String] = [:]) {


	}
	
	func parser(_ parser: XMLParser, didEndElement elementName: String, namespaceURI: String?, qualifiedName qName: String?) {

		let cleanedElement = self.foundCharacters.trimmingCharacters(in: .whitespacesAndNewlines)
		if elementName == "title" {
			self.episodeTitle = cleanedElement
			//print("title found")
		}
		
		if elementName == "itunes:subtitle" {
			self.episodeDescription = cleanedElement
		}
		
		if elementName == "link" {
			self.episodeLink = cleanedElement
			//print("***\(self.foundCharacters)***")
		}
		
		if elementName == "item" {
			
			let pod = Podcast(title: episodeTitle, link: episodeLink, description: episodeDescription)
			Podcasts.append(pod)
		}
		self.foundCharacters = ""
	
	}
	
	func parser(_ parser: XMLParser, foundCharacters string: String) {
		
		self.foundCharacters += string
		
	}
	
	func numberOfSections(in tableView: UITableView) -> Int {
		return 1
	}
	
	func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
		return Podcasts.count
	}
	
	func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
		
		let pod = Podcasts[indexPath.row]
		let cell = tableView.dequeueReusableCell(withIdentifier: "castCell", for: indexPath) as! CastCell
		cell.castTitle.text = pod.castTitle
		return cell
	}
	
	func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
	
		selectedPodcast = Podcasts[indexPath.row]
		print(selectedPodcast)

		performSegue(withIdentifier: "playerDetail", sender: nil)
		
	}
	
	override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
		if segue.identifier == "playerDetail" {
			let playerVC = segue.destination as? PlayerVC
			playerVC?.pod = selectedPodcast
		}
	}
	
}

