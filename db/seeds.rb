# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rake db:seed (or created alongside the db with db:setup).
#
# Examples:
#
#   cities = City.create([{ name: 'Chicago' }, { name: 'Copenhagen' }])
#   Mayor.create(name: 'Emanuel', city: cities.first)

PromptCategory.create([
	{text: "The title (or subtitle) must include the word/phrase"},
	{text: "One of the characters must be"}
])

category1 = PromptCategory.first
category2 = PromptCategory.last

PromptItem.create([
	{text: "\"a raw deal\"", hashtag: "raw", prompt_category: category1},
	{text: "\"a night to remember\"", hashtag: "remember", prompt_category: category1},
	{text: "\"return of the ninjs\"", hashtag: "ninja", prompt_category: category1},
	{text: "\"last night was _____\"", hashtag: "lastnight", prompt_category: category1},
	{text: "\"a crisis in _____\"", hashtag: "crisis", prompt_category: category1},
	{text: "a pirate", hashtag: "raw", prompt_category: category2},
	{text: "a fish", hashtag: "fish", prompt_category: category2},
	{text: "a superhero", hashtag: "hero", prompt_category: category2},
	{text: "a femme fatale", hashtag: "fefatale", prompt_category: category2},
	{text: "a black-hatted villain", hashtag: "blackhat", prompt_category: category2},
])