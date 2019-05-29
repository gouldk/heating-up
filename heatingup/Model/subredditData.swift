//
//  subredditData.swift
//  heatingup
//
//  Created by Kyle on 1/1/19.
//  Copyright © 2019 Kyle. All rights reserved.
//

// https://www.reddit.com/r/hiphopheads.json
// https://www.youtube.com/watch?v=YY3bTxgxWss

import UIKit

struct Subreddit: Decodable {
    let kind: String?
    var data: SubredditData?
}

class SubredditData: Decodable {
    let modhash: String?
    let dist: Int?
    var children: [PostWrapper]
    let after: String?
    let before: String?
}

class PostWrapper: Decodable {
    let kind: String?
    var data: PostData?
}

class PostData: Decodable {
    let approved_at_utc: String?
    let subreddit: String?
    let selfText: String?
    let author_fullname: String?
    let saved: Bool?
    let mod_reason_title: String?
    let gilded: Int?
    let clicked: Bool?
    var title: String?
    let link_flair_richtext: [richtextflair?]
    let subreddit_name_prefixed: String?
    let hidden: Bool?
    let pwls: Int?
    let link_flair_css_class: String? // eh
    let author_flair_background_color: String?
    let subreddit_type: String?
    let ups: Int?
    let domain: String?
    let media_embed: mediaEmbed?
    let author_flair_template_id: String?
    let is_original_content: Bool?
    let user_reports: [String]?
    let secure_media: media?
    let secure_media_embed: secureMediaEmbed?
    let link_flair_text: String?
    let can_mod_post: Bool?
    let score: Int?
    let approved_by: String? // eh
    let thumbnail: String? //eh
    let edited: edited?
    let author_flair_css_class: String?
    let author_flair_rich_text: String?
    let gildings: Dictionary<String, Int>?
    let content_categories: [String]? // eh
    let is_self: Bool?
    let mod_note: String?
    let created: Int?
    let link_flair_type: String?
    let wls: Int?
    let banned_by: String?
    let author_flair_type: String?
    let contest_mode: Bool?
    let selftext_html: String?
    let likes: String?
    let suggested_sort: String?
    let banned_at_utc: String?
    let view_count: Int?
    let archived: Bool?
    let no_follow: Bool?
    let is_crosspostable: Bool?
    let pinned: Bool?
    let over_18: Bool?
    let media_only: Bool?
    let link_flair_template_id: String? //eh
    let can_gild: Bool?
    let spoiler: Bool?
    let locked: Bool?
    let author_flair_text: String?
    let visited: Bool?
    let num_reports: Int?
    let distinguished: String?
    let subreddit_id: String?
    let mod_reason_by: String?
    let removal_reason: String?
    let link_flair_background_color: String?
    let id: String?
    let is_robot_indexable: Bool?
    let report_reasons: String?
    let author: String?
    let num_crossposts: Int?
    let num_comments: Int?
    let send_replies: Bool?
    let mod_reports: Array<String>?
    let author_patreon_flair: Bool?
    let author_flair_text_color: String?
    let permalink: String?
    let whitelist_status: String?
    let stickied: Bool?
    let url: String?
    let subreddit_subscribers: Int?
    let created_utc: Int?
    let media: media?
    let is_video: Bool?
}

struct mediaEmbed: Decodable {
    let content: String?
    let width: Int?
    let scrolling: Bool?
    let height: Int?
}
struct secureMediaEmbed: Decodable {
    let content: String?
    let width: Int?
    let scrolling: Bool?
    let media_domain_url: String?
    let height: Int?
}

struct media: Decodable {
    let oembed: oembed?
    let type: String?
}

struct oembed: Decodable {
    let provider_url: String?
    let description: String?
    let title: String?
    let type: String?
    let thumbnail_width: Int?
    let height: Int?
    let width: Int?
    let html: String?
    let version: String?
    let provider_name: String?
    let thumbnail_url: String?
    let thumbnail_height: Int?
}

struct richtextflair: Decodable {
    let e: String?
    let t: String?
}

/**
 This struct handles the special 'edited' json field, which is represented by either a boolean value
 or an integer value, and is unknown before fetching.
 */
struct edited: Decodable {
    let edited: Bool?
    let editTime: Int?
    
    init(from decoder: Decoder) throws {
        let container =  try decoder.singleValueContainer()
        
        // Check for a boolean
        do {
            edited = try container.decode(Bool.self)
            editTime = 0
        } catch {
            // Check for an integer
            editTime = try container.decode(Int.self)
            edited = true
        }
    }
}
