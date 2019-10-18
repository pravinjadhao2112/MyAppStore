//
//  ErrorResponce.swift
//  AppStore
//
//  Created by Pravin Jadhao on 17/10/19.
//  Copyright © 2019 Pravin Jadhao. All rights reserved.
//

import Foundation
struct Artist : Codable {
	let label : String?
	let attributes : Attributes?

	enum CodingKeys: String, CodingKey {

		case label = "label"
		case attributes = "attributes"
	}

	init(from decoder: Decoder) throws {
		let values = try decoder.container(keyedBy: CodingKeys.self)
		label = try values.decodeIfPresent(String.self, forKey: .label)
		attributes = try values.decodeIfPresent(Attributes.self, forKey: .attributes)
	}

}
