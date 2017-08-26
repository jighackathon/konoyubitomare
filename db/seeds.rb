# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: 'Star Wars' }, { name: 'Lord of the Rings' }])
#   Character.create(name: 'Luke', movie: movies.first)


user = User.new(email: 'user@example.com', password: 'password')

project = Project.new(title: '小学生向けライバル探し', detail: '年齢を入力するとその年齢以下のコンテストで優秀な成績を残し得ている子の情報を一覧表示する。')
s1 = Skill.new(skill: 'rails')
s2 = Skill.new(skill: 'css')
s3 = Skill.new(skill: 'html')
s4 = Skill.new(skill: 'javascript')

ProjectSkill.new(project_id: project.id, s1)
ProjectSkill.new(project_id: project.id, s2)
ProjectSkill.new(project_id: project.id, s3)
ProjectSkill.new(project_id: project.id, s4)

