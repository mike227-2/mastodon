# frozen_string_literal: true

module Admin
  class RolesController < BaseController
    before_action :set_user

    def promote
      authorize @user, :promote?
      @user.promote!
      log_action :promote, @user
      redirect_to admin_account_path(@user.account_id)
    end

    def allow_upload
      authorize @user, :set_upload?
      @user.allow_upload!
      log_action :allow_upload, @user
      redirect_to admin_account_path(@user.account_id)
    end

    def revoke_upload
      authorize @user, :revoke_upload?
      @user.revoke_upload!
      log_action :revoke_upload, @user
      redirect_to admin_account_path(@user.account_id)
    end

    def demote
      authorize @user, :demote?
      @user.demote!
      log_action :demote, @user
      redirect_to admin_account_path(@user.account_id)
    end
  end
end
