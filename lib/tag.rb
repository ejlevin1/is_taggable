class Tag < ActiveRecord::Base
  class << self
    def find_or_initialize_with_name_like_and_kind(name, kind)
      with_name_like_and_kind(name, kind).first || new(:name => name, :kind => kind)
    end
  end

  has_many :taggings, :dependent => :destroy

  validates_presence_of :name
  validates_uniqueness_of :name, :scope => :kind

  def self.with_name_like_and_kind(name, kind)
    where('name like ? AND kind like ?', name, kind)
  end

  def self.of_kind(kind)
    where(:kind => kind)
  end

end
