require_dependency "bizarroids/settings/application_controller"

module Bizarroids::Settings
  class OptionsController < ApplicationController
    respond_to :html
    inherit_resources
    actions :index, :edit, :update

    def update
      update!(notice: t('bizarroids.settings.option_updated')) { options_url }
    end

    protected

    def resource
      @option ||= end_of_association_chain.user_editable.find_by(key: params[:id])
    end

    def collection
      @options ||= end_of_association_chain.user_editable
    end

    def permitted_params
      params.permit(option: Bizarroids::Settings::VALUE_TYPES.map {|x| :"#{x}_value"})
    end
  end
end
