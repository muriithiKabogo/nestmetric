class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable and :omniauthable
  devise :database_authenticatable, :registerable,:omniauthable,
         :recoverable, :rememberable, :trackable, :validatable
  has_many :email_templates

    def send_sailed_payment_email
      UserMailer.suscription_payment_failed(self).deliver_now
    end
end
