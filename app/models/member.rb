# frozen_string_literal: true

class Member < ApplicationRecord
  has_many :tags
  has_many :connections, class_name: 'Connection', foreign_key: 'friend_id'

  after_create :get_meta_data

  def friends
    friend_ids = *connections.map(&:member_id) || []
    !friend_ids.empty? ? Member.find(friend_ids) : []
  end

  # search stuff

  def keyword_search(word)
    tags.map(&:text).grep(/#{word.downcase}/i)
  end

  def friends_with_common(word)
    @member_has_common_terms = []
    friends.each do |member|
      if member.keyword_search(word).count > 0
        @member_has_common_terms << member
      end
    end
    @member_has_common_terms
  end

  def bread_crumbs_from(word)
    found_paths = []
    friends.each do |middleman|
      (middleman.friends_with_common(word) - [self] - friends).each do |friend|
        bc_payload = {
          liason_chain: [self, middleman, friend],
          heading_matches: friend.keyword_search(word)
        }
        found_paths << bc_payload
      end
    end
    found_paths
  end

  private

  def get_meta_data
    populate_tags
    populate_short_url
  end

  def populate_tags
    Util.scrape_tags(self)
  end

  def populate_short_url
    update_attributes(short_url: Shorty.shorten(original_url))
  end
end
