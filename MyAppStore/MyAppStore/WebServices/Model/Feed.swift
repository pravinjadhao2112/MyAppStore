//
//  ErrorResponce.swift
//  AppStore
//
//  Created by Pravin Jadhao on 17/10/19.
//  Copyright © 2019 Pravin Jadhao. All rights reserved.
//

import Foundation
struct Feed : Codable {
	let author : Author?
	let entry : [Entry]?
	let updated : Updated?
	let rights : Rights?
	let title : Title?
	let icon : Icon?
	let link : [Link]?
	let id : Id?

	enum CodingKeys: String, CodingKey {

		case author = "author"
		case entry = "entry"
		case updated = "updated"
		case rights = "rights"
		case title = "title"
		case icon = "icon"
		case link = "link"
		case id = "id"
	}

	init(from decoder: Decoder) throws {
		let values = try decoder.container(keyedBy: CodingKeys.self)
		author = try values.decodeIfPresent(Author.self, forKey: .author)
		entry = try values.decodeIfPresent([Entry].self, forKey: .entry)
		updated = try values.decodeIfPresent(Updated.self, forKey: .updated)
		rights = try values.decodeIfPresent(Rights.self, forKey: .rights)
		title = try values.decodeIfPresent(Title.self, forKey: .title)
		icon = try values.decodeIfPresent(Icon.self, forKey: .icon)
		link = try values.decodeIfPresent([Link].self, forKey: .link)
		id = try values.decodeIfPresent(Id.self, forKey: .id)
	}

}
