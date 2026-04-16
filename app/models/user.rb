class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  enum :role, { worker: 1, manager: 2, admin: 3 }
  
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable
end
