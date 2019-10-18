//
//  ViewController.swift
//  MyAppStore
//
//  Created by Pravin Jadhao on 18/10/19.
//  Copyright © 2019 Pravin Jadhao. All rights reserved.
//

import Foundation
public struct MyAppInfoResponseDTO : Codable {
	let feed : Feed?

	enum CodingKeys: String, CodingKey {

		case feed = "feed"
	}

    public init(from decoder: Decoder) throws {
		let values = try decoder.container(keyedBy: CodingKeys.self)
		feed = try values.decodeIfPresent(Feed.self, forKey: .feed)
	}

}
