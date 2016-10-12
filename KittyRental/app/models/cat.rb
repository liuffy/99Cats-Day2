class Cat < ActiveRecord::Base
  CAT_COLORS = %w(black white gray orange brown pink)
  validates :color, presence: true, inclusion: CAT_COLORS
  validates :sex, presence: true, inclusion: %w(M F)
  validates :birth_date, :name, :user_id, presence: true

  has_many :rental_requests, class_name: "CatRentalRequest", dependent: :destroy
  belongs_to :owner, class_name: "User", foreign_key: :user_id

  def age
    age = Date.today.year - self.birth_date.year
  end
end
