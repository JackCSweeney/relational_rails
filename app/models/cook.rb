class Cook < ApplicationRecord
  belongs_to :restaurant

  def serv_safe_certification
    return self if self.serv_safe_certified
  end
end