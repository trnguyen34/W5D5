# == Schema Information
#
# Table name: comments
#
#  id                :bigint           not null, primary key
#  body              :text             not null
#  author_id         :bigint           not null
#  post_id           :bigint           not null
#  parent_comment_id :bigint
#  created_at        :datetime         not null
#  updated_at        :datetime         not null
#
class Comment < ApplicationRecord
  validates :body, presence: true

  # Rails would look for an `authors` table if you didn't tell it that
  # `author_id` refers to a `User`.
  belongs_to :author, class_name: "User"
  # SELECT *
  #   FROM users
  #  WHERE users.id = #{self.author_id}

  belongs_to :post
  # SELECT *
  #   FROM posts
  #  WHERE posts.id = #{self.post_id}

  # Rails would look for `parent_id`, if you didn't give it the foreign key name
  # explicitly. Reminder: a *foreign key* is a database column whose entries are
  # primary keys (ids) in another table.
  belongs_to :parent,
    class_name: "Comment",
    foreign_key: "parent_comment_id",
    optional: true
  # SELECT *
  #   FROM comments
  #  WHERE comment.id = #{self.parent_comment_id}

  has_many :replies,
    class_name: "Comment",
    foreign_key: "parent_comment_id",
    dependent: :destroy
  # SELECT *
  #   FROM comments
  #  WHERE comments.parent_comment_id = #{self.id}

  def self.reply_to_post(post, user, body)
    # Use the defined associations to assign values
    Comment.create!(
      body: body,
      author: user,
      post: post,
      parent_comment_id: nil)
  end

  def self.reply_to_comment(comment, user, body)
    # Use the defined associations to assign values
    Comment.create!(
      body: body,
      author: user,
      post: comment.post,
      parent: comment)
  end
end