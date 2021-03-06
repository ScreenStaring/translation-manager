class Translation < ActiveRecord::Base
  belongs_to :source, inverse_of: :translations

  validates :text, presence: true
  validates :language, presence: true, locale: true
  validates :language, uniqueness: { scope: :source_id, if: ->(t) { t.source } }

  default_scope -> { order('language asc') }
end
