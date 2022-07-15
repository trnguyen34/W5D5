# Joins Demo

This app introduces you to all the major concepts of associations, `includes`,
and `joins`.

* First check out __db/schema.rb__ to see the decomposition of the problem:
  `User`s make `Post`s and leave `Comment`s on existing `Post`s.
* __app/models/comment.rb__ has notes on how `belongs_to` and `has_many`
  associations are used to generate SQL queries.
* __app/models/user.rb__ has an example and explanation of a `has_many :through`
  relation.
* `User` also demonstrates various ways to make a query using N+1 `SELECT`s, an
  `includes` to avoid the N+1 problem, and `joins` to avoid fetching all the
  extra data that `includes` brings down.

**MAKE SURE TO UNDERSTAND THIS DEMO IN FULL**