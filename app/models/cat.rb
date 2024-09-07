class Cat < Animal
  validates :claw_sharpness, presence: true

  scope :sharp_clawed, -> { where('claw_sharpness > ?', 50) }

  def speak
    'meow'
  end
end
