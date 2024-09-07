class Animal < ApplicationRecord
  validates :name, presence: true

  scope :with_name, ->(name) { where(name: name) }

  def speak
    'some generic animal sound'
  end
end
