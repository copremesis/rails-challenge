# frozen_string_literal: true

class Connection < ApplicationRecord
  belongs_to :member
  belongs_to :friend, class_name: 'Member'
  after_create :mutual_association

  private

  def mutual_association
    Connection.find_or_create_by!(member_id: friend_id, friend_id: member_id)
  end
end
