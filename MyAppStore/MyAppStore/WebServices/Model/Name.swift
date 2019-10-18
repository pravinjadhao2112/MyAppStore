//
//  ErrorResponce.swift
//  AppStore
//
//  Created by Pravin Jadhao on 17/10/19.
//  Copyright © 2019 Pravin Jadhao. All rights reserved.
//

import Foundation
struct Name : Codable {
	let label : String?

	enum CodingKeys: String, CodingKey {

		case label = "label"
	}

	init(from decoder: Decoder) throws {
		let values = try decoder.container(keyedBy: CodingKeys.self)
		label = try values.decodeIfPresent(String.self, forKey: .label)
	}

}
