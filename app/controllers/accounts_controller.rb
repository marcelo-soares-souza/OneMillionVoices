# frozen_string_literal: true

class AccountsController < ApplicationController
  before_action :set_account, only: %i[show edit update destroy]
  before_action :authenticate_account!, except: %i[show index]
  before_action -> { check_owner Account.friendly.find(params[:id]).id }, only: %i[edit update destroy]

  def index
    @accounts = Account.order("updated_at DESC").load_async.page(params[:page])
  end

  def show; end

  def edit; end

  def update
    respond_to do |format|
      if @account.update(account_params)
        format.html { redirect_to @account, notice: "Usuário foi atualizado." }
        format.json { render :show, status: :ok, location: @account }
      else
        format.html { render :edit }
        format.json { render json: @account.errors, status: :unprocessable_entity }
      end
    end
  end

  def destroy
    @account.destroy
    respond_to do |format|
      format.html { redirect_to accounts_url, notice: "Usuário foi removido." }
      format.json { head :no_content }
    end
  end

  private
    def set_account
      @account = Account.friendly.find(params[:id])
    end

    def account_params
      params.require(:account).permit(:id, :email, :name, :about, :website, :slug, :imagem)
    end
end
