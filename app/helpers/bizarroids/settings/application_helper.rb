module Bizarroids::Settings
  module ApplicationHelper
    def edit_button obj
      link_to([:edit, obj], class: 'btn btn-link btn-xs text-primary') do
        content_tag :span, '', class: 'glyphicon glyphicon-pencil'
      end
    end

    def bizarroids_t key
      t key, scope: :bizarroids
    end
  end
end
