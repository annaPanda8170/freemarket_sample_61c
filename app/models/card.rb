class Card < ApplicationRecord
  belongs_to :user, optional: true
  validates :number, :name, :validated_date_year, :validated_date_month, :security_number, presence: ture
end
