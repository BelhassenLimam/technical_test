//
//  Stories.swift
//  technical_test
//
//  Created by Belhassen LIMAM on 08/03/2025.
//

import Foundation

class Stories: Codable {
    let page, perPage: Int?
    let photos: [Story]?
    let totalResults: Int?
    let nextPage: String?

    enum CodingKeys: String, CodingKey {
        case page
        case perPage = "per_page"
        case photos
        case totalResults = "total_results"
        case nextPage = "next_page"
    }

    init(page: Int?, perPage: Int?, photos: [Story]?, totalResults: Int?, nextPage: String?) {
        self.page = page
        self.perPage = perPage
        self.photos = photos
        self.totalResults = totalResults
        self.nextPage = nextPage
    }
}

// MARK: - Photo
class Story: Codable {
    let id, width, height: Int?
    let url: String?
    let photographer: String?
    let photographerURL: String?
    let photographerID: Int?
    let avgColor: String?
    let src: Src?
    let liked: Bool?
    let alt: String?

    enum CodingKeys: String, CodingKey {
        case id, width, height, url, photographer
        case photographerURL = "photographer_url"
        case photographerID = "photographer_id"
        case avgColor = "avg_color"
        case src, liked, alt
    }

    init(id: Int?, width: Int?, height: Int?, url: String?, photographer: String?, photographerURL: String?, photographerID: Int?, avgColor: String?, src: Src?, liked: Bool?, alt: String?) {
        self.id = id
        self.width = width
        self.height = height
        self.url = url
        self.photographer = photographer
        self.photographerURL = photographerURL
        self.photographerID = photographerID
        self.avgColor = avgColor
        self.src = src
        self.liked = liked
        self.alt = alt
    }
}

// MARK: - Src
class Src: Codable {
    let original, large2X, large, medium: String?
    let small, portrait, landscape, tiny: String?

    enum CodingKeys: String, CodingKey {
        case original
        case large2X = "large2x"
        case large, medium, small, portrait, landscape, tiny
    }

    init(original: String?, large2X: String?, large: String?, medium: String?, small: String?, portrait: String?, landscape: String?, tiny: String?) {
        self.original = original
        self.large2X = large2X
        self.large = large
        self.medium = medium
        self.small = small
        self.portrait = portrait
        self.landscape = landscape
        self.tiny = tiny
    }
}
