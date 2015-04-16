class Article < ActiveRecord::Base
  has_many :comments, dependent: :destroy

  has_and_belongs_to_many :tags

  validates :title, presence: true,
                    length: { minimum: 5 }

  def find_and_create_tags
    body_scan = text.scan(/#[@|@@|\$]?\w+/)
    body_scan.each { |tag_term| self.tags << Tag.create(term: tag_term.tr('#', '')) }
    Tag.all.map { |tag| tag if tag.articles.empty? }.each { |tag| tag.delete! unless tag.nil? }
    self.save!
  end
end
