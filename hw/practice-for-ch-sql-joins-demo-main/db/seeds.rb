# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the bin/rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: "Star Wars" }, { name: "Lord of the Rings" }])
#   Character.create(name: "Luke", movie: movies.first)

ActiveRecord::Base.transaction do
  # These `destroy_all` commands are not necessary if you use `rails
  # db:seed:replant`. If they are present when you run `db:seed:replant`,
  # however, the command will essentially just destroy the tables twice,
  # resulting in a small increase in execution time but no other ill effects.
  puts "Destroying tables..."
  Comment.destroy_all
  Post.destroy_all
  User.destroy_all

  # Reset the id (i.e., primary key) counters for each table to start at 1
  # (helpful for debugging)
  puts "Resetting primary keys..."
  %w(users posts comments).each do |table_name|
    ApplicationRecord.connection.reset_pk_sequence!(table_name)
  end

  puts "Seeding database..."
  ned = User.create!(
    user_name: "ruggeri",
    first_name: "Ned",
    last_name: "Ruggeri"
  )
  jonathan = User.create!(
    user_name: "tamboer",
    first_name: "Jonathan",
    last_name: "Tamboer"
  )
  first_post = ned.posts.create!(
    title: "First post!",
    body: "First posting is fun!"
  )
  comment1 = first_post.comments.create!(
    body: "Great job first posting!",
    author: jonathan
  )
  comment2 = comment1.replies.create!(
    body: "Thanks!",
    post: comment1.post,
    author: ned
  )

  puts "Done!"
end