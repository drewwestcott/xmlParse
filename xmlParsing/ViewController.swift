//
//  ViewController.swift
//  xmlParsing
//
//  Created by Drew Westcott on 28/02/2017.
//  Copyright © 2017 Drew Westcott. All rights reserved.
//

import UIKit

class ViewController: UIViewController, XMLParserDelegate, UITableViewDelegate, UITableViewDataSource {
	
	// Mark: Properties
	let url = URL(string: "http://feeds.99percentinvisible.org/99percentinvisible")
	var episodeFound = false
	var episodeTitle = [String]()
	var epTitle = String()
	var epNext = String()
	var currentElement = ""
	var elementName = ""
	var counter = 0
	
	@IBOutlet weak var tableView: UITableView!

	override func viewDidLoad() {
		super.viewDidLoad()
		
		tableView.delegate = self
		tableView.dataSource = self

		if let parser = XMLParser(contentsOf: url!) {
			parser.delegate = self
			parser.parse()
		}
	
	}

	func parser(_ parser: XMLParser, didStartElement elementName: String, namespaceURI: String?, qualifiedName qName: String?, attributes attributeDict: [String : String] = [:]) {

		currentElement = elementName
		
		if elementName == "item" {
			episodeFound = true
		}

	}
	
	func parser(_ parser: XMLParser, didEndElement elementName: String, namespaceURI: String?, qualifiedName qName: String?) {
		//print("Ended: \(elementName)")
		
		if episodeFound == true && currentElement == "item" {
			episodeFound = false
		}
	}
	
	func parser(_ parser: XMLParser, foundCharacters string: String) {
		
		let data = string.trimmingCharacters(in: NSCharacterSet.whitespacesAndNewlines)

		if currentElement == "title" && episodeFound == true {
			epTitle = data
			print("\(currentElement): \(data)")
			episodeTitle.append(data)
		}
		if currentElement == "itunes:author" && episodeFound == true {
			print("Author: \(data)")
		}

	}
	
	func numberOfSections(in tableView: UITableView) -> Int {
		return 1
	}
	
	func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
		return episodeTitle.count
	}
	
	func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
		
		let cell = tableView.dequeueReusableCell(withIdentifier: "castCell", for: indexPath) as! CastCell
		cell.castTitle.text = episodeTitle[indexPath.row]
		return cell
	}
	
	
}

