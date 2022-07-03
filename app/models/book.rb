# frozen_string_literal: true

class Book < ApplicationRecord
  include FullTextSearch
  include LocationGeocode
  include PeopleCitations
  include Registration

  DETAIL_ATTRIBUTES = { direct: [], associated: [] }

  belongs_to :book_category, inverse_of: :books
  belongs_to :book_field, inverse_of: :books
  belongs_to :publishing_company, class_name: "Organization", inverse_of: :published_books, optional: true
  belongs_to :language, inverse_of: :books, optional: true

  has_many :book_authors, inverse_of: :book, dependent: :destroy
  has_many :authors, through: :book_authors
  has_many :book_iconographies, inverse_of: :book, dependent: :destroy
  has_many :iconographies, through: :book_iconographies

  has_rich_text :description
  has_rich_text :observation

  has_one_attached :pdf
  has_one_attached :image

  validates :title, presence: true, length: { maximum: 255 }
  validates :edition, presence: true
  validates :publishing_year, presence: true, numericality: { only_integer: true }, length: { is: 4 }

  has_paper_trail skip: [:document_ts_vector], on: %i[create destroy update]

  private

  def create_plain_text
    <<~RECORD
      #{self.title}
      #{self.subtitle}
      #{self.location}
      #{self.language&.name}
      #{self.publishing_company&.name}
      #{self.book_category.name}
      #{self.book_field.name}
      #{self.authors.pluck(:first_name, :last_name).map { |name| "#{name[0]} #{name[1]}" }.join('; ')}
      #{self.people_cited.pluck(:first_name, :last_name).map { |name| "#{name[0]} #{name[1]}" }.join('; ')}
      #{self.description.to_plain_text}
      #{self.observation.to_plain_text}
    RECORD
  end
end
