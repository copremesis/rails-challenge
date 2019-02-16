# frozen_string_literal: true

class MembersController < ApplicationController
  def index
    @members = Member.all
  end

  def create
    name = params[:member][:name]
    url = params[:member][:original_url]
    @member = Member.create(name: name, original_url: url)

    # link selected friends
    params[:member][:friends].compact.map(&:to_i).each do |id|
      @member.connections.create(member_id: id)
    end

    respond_to do |format|
      format.html { redirect_to @member, notice: 'Member was successfully created.' }
    end
  end

  def show
    @member = Member.find(params[:id])
  end

  def search
    member = Member.find(params[:id])
    render json: member.bread_crumbs_from(params[:query])
  end

  # not in spec
  def update
    Member.find(params[:id]).update_attributes(params[:member])
  end

  def delete
    @member = Member.find(params[:id]).destroy
  end

  private

  def member_params
    params.require(:member).permit(:name, :original_url)
  end
end
