# frozen_string_literal: true

class Accounts::ConfirmationsController < Devise::ConfirmationsController
  def show
    self.resource = resource_class.confirm_by_token(params[:confirmation_token])
    yield resource if block_given?

    if resource.errors.empty?
      set_flash_message!(:notice, :confirmed)
      respond_with_navigational(resource) { redirect_to after_confirmation_path_for(resource_name, resource) }
    else

      # TODO: use `error_status` when the default changes to `:unprocessable_entity`.
      respond_with_navigational(resource.errors, status: :unprocessable_entity) { redirect_to new_account_session_path, notice: resource.errors.full_messages.join("") }
    end
  end
end
