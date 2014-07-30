require_dependency "bizarroids/settings/application_controller"

module Bizarroids::Settings
  class OptionsController < parent_controller.constantize
    helper 'bizarroids/settings/options'

    respond_to :html
    inherit_resources
    actions :index, :edit, :update

    if Bizarroids::Settings.use_cancancan
      authorize_resource class: "Bizarroids::Settings::Option", param_method: :permitted_params
    end

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
