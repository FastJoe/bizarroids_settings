# encoding: utf-8

module Bizarroids::Settings
  class OptionUploader < CarrierWave::Uploader::Base
    include CarrierWave::MiniMagick

    storage :file

    def store_dir
      File.join Bizarroids::Settings.files_storage_dir, model.key
    end

    # Process files as they are uploaded:
    # process :scale => [200, 300]
    #
    # def scale(width, height)
    #   # do something
    # end

    # Create different versions of your uploaded files:
    # version :thumb do
    #   process :resize_to_fit => [50, 50]
    # end

    def extension_white_list
      Bizarroids::Settings.options[model.sym_key][:extension_white_list]
    end
  end
end
