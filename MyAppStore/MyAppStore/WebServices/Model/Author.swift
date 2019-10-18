//
//  ErrorResponce.swift
//  AppStore
//
//  Created by Pravin Jadhao on 17/10/19.
//  Copyright © 2019 Pravin Jadhao. All rights reserved.
//
import Foundation
struct Author : Codable {
	let name : Name?
	let uri : Uri?

	enum CodingKeys: String, CodingKey {

		case name = "name"
		case uri = "uri"
	}

	init(from decoder: Decoder) throws {
		let values = try decoder.container(keyedBy: CodingKeys.self)
		name = try values.decodeIfPresent(Name.self, forKey: .name)
		uri = try values.decodeIfPresent(Uri.self, forKey: .uri)
	}

}
