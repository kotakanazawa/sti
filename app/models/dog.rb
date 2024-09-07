class Dog < Animal
  validates :bark_volume, presence: true

  scope :loud_barkers, -> { where("bark_volume > ?", 80) }

  def speak
    'woof'
  end
end
