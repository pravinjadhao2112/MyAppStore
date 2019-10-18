//
//  ErrorResponce.swift
//  AppStore
//
//  Created by Pravin Jadhao on 17/10/19.
//  Copyright © 2019 Pravin Jadhao. All rights reserved.
//
import Foundation
struct Entry : Codable {
	let name : Name?
	let rights : Rights?
	let price : Price?
	let image : [Image]?
	let artist : Artist?
	let title : Title?
	let link : Link?
	let id : Id?
	let contentType : ContentType?
	let category : Category?
	let releaseDate : ReleaseDate?

	enum CodingKeys: String, CodingKey {

		case name = "im:name"
		case rights = "rights"
		case price = "im:price"
		case image = "im:image"
		case artist = "im:artist"
		case title = "title"
		case link = "link"
		case id = "id"
		case contentType = "im:contentType"
		case category = "category"
		case releaseDate = "im:releaseDate"
	}

	init(from decoder: Decoder) throws {
		let values = try decoder.container(keyedBy: CodingKeys.self)
       
        name = try values.decodeIfPresent(Name.self, forKey: .name)
		rights = try values.decodeIfPresent(Rights.self, forKey: .rights)
		price = try values.decodeIfPresent(Price.self, forKey: .price)
		image = try values.decodeIfPresent([Image].self, forKey: .image)
		artist = try values.decodeIfPresent(Artist.self, forKey: .artist)
		title = try values.decodeIfPresent(Title.self, forKey: .title)
		link = try values.decodeIfPresent(Link.self, forKey: .link)
		id = try values.decodeIfPresent(Id.self, forKey: .id)
		contentType = try values.decodeIfPresent(ContentType.self, forKey: .contentType)
		category = try values.decodeIfPresent(Category.self, forKey: .category)
		releaseDate = try values.decodeIfPresent(ReleaseDate.self, forKey: .releaseDate)
	}

}
