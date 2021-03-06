class CreateVinusProductTranslationTable < ActiveRecord::Migration
  def up
    Vinus::Product.create_translation_table! name: :string, permalink: :string, description: :text, short_description: :text

    Vinus::Product.all.each do |p|
      l = p.translations.new
      l.locale = 'en'
      l.name = p.name
      l.permalink = p.permalink
      l.description = p.description
      l.short_description = p.short_description
      l.save!
    end
  end

  def down
    Vinus::Product.drop_translation_table!
  end
end
