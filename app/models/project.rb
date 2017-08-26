class Project < ApplicationRecord
  has_many :project_skills
  has_many :skills, through: :project_skills

  has_many :chat_messages
  has_many :project_members

  belongs_to :user
  # accepts_nested_attributes_for :project_skills
end
