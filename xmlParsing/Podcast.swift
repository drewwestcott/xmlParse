//
//  Podcast.swift
//  xmlParsing
//
//  Created by Drew Westcott on 01/03/2017.
//  Copyright © 2017 Drew Westcott. All rights reserved.
//

import Foundation

class Podcast {
	
	private var _castTitle : String!
	private var _castLink : String!
	private var _castDescription : String!
	
	var castTitle : String {
		return _castTitle
	}
	
	var castLink : String {
		return _castLink
	}
	
	var castDescription : String {
		return _castDescription
	}
	
	init(title: String, link: String, description: String) {
		self._castTitle = title
		self._castLink = link
		self._castDescription = description
	}
	
}
