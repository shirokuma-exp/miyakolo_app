class Home < ApplicationRecord
  has_one :user, :optional => true
end
