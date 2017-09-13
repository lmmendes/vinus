class CreateVinusVendors < ActiveRecord::Migration
  def change
    # Create vinus table
    create_table :vinus_vendors do |t|
      t.timestamps
    end

    # reset the active record class cache
    Vinus::Vendor.reset_column_information

    # create the translations
    reversible do |dir|
      dir.up do
        Vinus::Vendor.create_translation_table! name: :string,
                                         description: :text,
                                         permalink: :string
      end

      dir.down do
        Vinus::Vendor.drop_translation_table!
      end

    end
  end
end
