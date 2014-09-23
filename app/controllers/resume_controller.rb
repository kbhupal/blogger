class ResumeController < ApplicationController

  include ApplicationHelper
  skip_before_filter :authenticate_user!, :only => [:index, :show]

  def index
    @posts = current_user ? (current_user.is_admin? ? Post.all : (Post.published + current_user.posts)) : Post.published
  end

  def new
    @post = Post.new
  end

  def create
    post = Post.new
    @errors = []
    ActiveRecord::Base.transaction do
      update_new_post post, params["resume"]
    end
    redirect_to create_redirector_path if @errors.blank?
  end


  def published
    @posts = Post.published
  end

  def drafts
    @posts = Post.drafts
  end

  def publish_draft
    post = Post.find(params["post_id"].to_i)
    post.draft = false
    post.save!
    flash[:success] = "The article has been successfully published."
    redirect_to posts_drafts_path
  end

  def show
    post = Post.find(params["id"].to_i)
    render :partial => "show_post", :locals => {:resume => post}
  end

  private

  def update_new_post post, new_post_hash
    post.update_attributes(new_post_hash)
    if post.errors.blank?
      post.owner_id = current_user.id
      current_user.can_publish? ? (post.draft = false) : (post.draft = true)
      post.save!
    else
      @errors = post.errors.full_messages
      @errors.each do |e|
        flash[:error] = e
      end
      redirect_to new_post_path
    end
  end
end