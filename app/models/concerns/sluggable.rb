module Sluggable
  extend ActiveSupport::Concern

  included do
    validates :slug, slug: true, presence: true, allow_blank: true
  end

  def to_param
    slug
  end

  module ClassMethods
    def find(*args)
      id = args.first
      return super if args.count != 1 || id.to_s =~ /\A\d+\z/

      find_by_slug(id) or raise ActiveRecord::RecordNotFound
    end
  end
end
