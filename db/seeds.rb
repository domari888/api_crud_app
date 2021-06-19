# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the bin/rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: 'Star Wars' }, { name: 'Lord of the Rings' }])
#   Character.create(name: 'Luke', movie: movies.first)

post_params = [
  {
    title: "React",
    content: "ユーザインターフェース構築のための JavaScript ライブラリ"
  },
  {
    title: "Vue.js",
    content: "The Progressive JavaScript Framework"
  },
  {
    title: "Angular",
    content: "モバイルとデスクトップ，ひとつのフレームワーク"
  }
]

Post.delete_all
Post.create!(post_params)
puts "初期データの投入に成功しました!"