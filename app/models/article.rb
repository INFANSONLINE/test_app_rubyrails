class Article < ApplicationRecord

    belongs_to :user
    
    validates :title, presence: true, length: {minimum:6}
    validates :client_name, presence: true

end
