class Member < ApplicationRecord
  has_many :tags
  has_many :connections, :class_name => 'Connection', :foreign_key => 'friend_id'

  after_create :get_meta_data

  def friends
    friend_ids = *connections.map(&:member_id) || []
    (friend_ids.size > 0)? Member.find(friend_ids) : []
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
