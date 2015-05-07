class AddIndexToLinksShortUrl < ActiveRecord::Migration
  def change
    add_index :links, :short_url
  end
end
