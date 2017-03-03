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
	private var _castDownloadURL : String!
	private var _castType : String!
	
	var castTitle : String {
		return _castTitle
	}
	
	var castLink : String {
		return _castLink
	}
	
	var castDescription : String {
		return _castDescription
	}
	
	var castDownloadURL : String {
		return _castDownloadURL
	}
	
	var castType : String {
		return _castType
	}
	
	init(title: String, link: String, description: String, downloadURL: String, type: String) {
		self._castTitle = title
		self._castLink = link
		self._castDescription = description
		self._castDownloadURL = downloadURL
		self._castType = type
	}
	
}
