class User < ApplicationRecord
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable

  has_many :user_services, dependent: :destroy
  has_many :services, through: :user_services

  enum :gender, { man: 0, woman: 1, non_binary: 2 }
  enum :seeking, { seeking_man: 0, seeking_woman: 1, seeking_non_binary: 2, seeking_all: 3 }, prefix: :seeking
  enum :status, { under_review: 0, accepted: 1, please_contact: 2 }
  enum :life_stage, { actively_seeking: 0, open_to_dating: 1, recently_single: 2, taking_a_break: 3, newly_divorced: 4, other_life_stage: 5 }
  enum :political_view, { liberal: 0, moderate: 1, conservative: 2, libertarian: 3, apolitical: 4, none_of_the_above: 5 }
  enum :alcohol_use, { alcohol_never: 0, alcohol_occasionally: 1, alcohol_regularly: 2 }, prefix: :alcohol
  enum :smoking, { no_smoking: 0, occasional_smoking: 1, yes_smoking: 2 }
  enum :marijuana_use, { marijuana_never: 0, marijuana_occasionally: 1, marijuana_regularly: 2 }, prefix: :marijuana
  enum :neurodivergent, { neurodivergent_yes: 0, neurodivergent_no: 1, prefer_not_to_say: 2 }, prefix: :nd
  enum :open_to_relocating, { relocating_yes: 0, relocating_no: 1, relocating_maybe: 2 }, prefix: :relocating
  enum :interest_level, { seriously_interested: 0, curious: 1, just_exploring: 2 }
  enum :open_to_zoom_consultation, { zoom_yes: 0, zoom_no: 1, zoom_maybe: 2 }, prefix: :zoom

  def password_required?
    encrypted_password.present? ? super : false
  end

  def full_name
    "#{first_name} #{last_name}".strip
  end
end
