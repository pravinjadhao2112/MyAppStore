//
//  ErrorResponce.swift
//  AppStore
//
//  Created by Pravin Jadhao on 17/10/19.
//  Copyright © 2019 Pravin Jadhao. All rights reserved.
//

import Foundation
struct Attributes : Codable {
	let rel : String?
	let type : String?
	let href : String?
    let term : String?
    let scheme : String?
    let label : String?
    let id : Int?
    
    let amount : String?
    let currency : String?

	enum CodingKeys: String, CodingKey {

		case rel = "rel"
		case type = "type"
		case href = "href"
        case term = "term"
        case scheme = "scheme"
        case label = "label"
        case id = "id"
        case amount = "amount"
        case currency = "currency"


	}

	init(from decoder: Decoder) throws {
		let values = try decoder.container(keyedBy: CodingKeys.self)
		rel = try values.decodeIfPresent(String.self, forKey: .rel)
		type = try values.decodeIfPresent(String.self, forKey: .type)
		href = try values.decodeIfPresent(String.self, forKey: .href)
        term = try values.decodeIfPresent(String.self, forKey: .term)
        scheme = try values.decodeIfPresent(String.self, forKey: .scheme)
        label = try values.decodeIfPresent(String.self, forKey: .label)
        id = try values.decodeIfPresent(Int.self, forKey: .id)
        amount = try values.decodeIfPresent(String.self, forKey: .amount)
        currency = try values.decodeIfPresent(String.self, forKey: .currency)

	}

}
