# frozen_string_literal: true

class ApplicationRecord < ActiveRecord::Base
  self.abstract_class = true
  def self.search(place, method, word)
    @result = if place == 'place_user'
                if method == 'forward_match'
                  User.where('name LIKE? or introduction LIKE?', "#{word}%", "#{word}%")
                elsif method == 'backward_match'
                  User.where('name LIKE? or introduction LIKE?', "%#{word}", "%#{word}")
                elsif method == 'partial_match'
                  User.where('name LIKE? or introduction LIKE?', "%#{word}%", "%#{word}%")
                elsif method == 'perfect_match'
                  User.where('name LIKE? or introduction LIKE?', word.to_s, word.to_s)
                else
                  User.all
                          end
              elsif place == 'place_book'
                if method == 'forward_match'
                  Book.where('title LIKE? or body LIKE?', "#{word}%", "#{word}%")
                elsif method == 'backward_match'
                  Book.where('title LIKE? or body LIKE?', "%#{word}", "%#{word}")
                elsif method == 'partial_match'
                  Book.where('title LIKE? or body LIKE?', "%#{word}%", "%#{word}%")
                elsif method == 'perfect_match'
                  Book.where('title LIKE? or body LIKE?', word.to_s, word.to_s)
                else
                  Book.all
                          end
              else
                User.all
              end
end
end
