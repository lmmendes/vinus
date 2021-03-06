namespace :vinus do
  desc 'Load seed data for the Vinus'
  task seed: :environment do
    require File.join(Vinus.root, 'db', 'seeds')
  end

  desc 'Create a default admin user'
  task create_default_user: :environment do
    Vinus::User.create(email_address: 'admin@example.com', password: 'password', password_confirmation: 'password', first_name: 'Default', last_name: 'Admin')
    puts
    puts '    New user has been created successfully.'
    puts
    puts '    E-Mail Address..: admin@example.com'
    puts '    Password........: password'
    puts
  end

  desc 'Import default set of countries'
  task import_countries: :environment do
    Vinus::CountryImporter.import
  end

  desc 'Run the key setup tasks for a new application'
  task setup: :environment do
    Rake::Task['vinus:import_countries'].invoke    if Vinus::Country.all.empty?
    Rake::Task['vinus:create_default_user'].invoke if Vinus::User.all.empty?
  end

  desc 'Converts nifty-attachment attachments to Vinus Attachments'
  task attachments: :environment do
    require 'nifty/attachments'

    attachments = Nifty::Attachments::Attachment.all

    attachments.each do |attachment|
      object = attachment.parent_type.constantize.find(attachment.parent_id)

      attach = object.attachments.build
      attach.role = attachment.role
      attach.file_name = attachment.file_name

      tempfile = Tempfile.new("attach-#{attachment.token}")
      tempfile.binmode
      tempfile.write(attachment.data)
      uploaded_file = ActionDispatch::Http::UploadedFile.new(tempfile: tempfile, filename: attachment.file_name, type: attachment.file_type)

      attach.file = uploaded_file
      attach.save!
    end
  end
end
