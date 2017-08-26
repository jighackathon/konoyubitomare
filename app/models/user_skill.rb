class UserSkill < ApplicationRecord
  belongs_to :user_profile
  belongs_to :skill
end
