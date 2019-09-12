class Gram < ApplicationRecord
	belongs_to :user

	mount_uploader :picture, PictureUploader

	validates :message, presence: true
	validates :picture, presence: true

end