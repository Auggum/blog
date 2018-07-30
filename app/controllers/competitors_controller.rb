class CompetitorsController < ApplicationController

  def index
    @competitors = Competitor.all
  end


  def show
    @competitors = Competitor.find(params[:id])
  end


  def new
    @competitors = Competitor.new
  end


  def edit
    @competitors = Competitor.find(params[:id])
  end


  def create
    @competitors = Competitor.new(competitor_params)

    if @competitors.save
      redirect_to @competitors
    else
      render 'new'
    end
  end

  def update
    @competitors = Competitor.find(params[:id])

    if @competitors.update(competitor_params)
      redirect_to @competitors
    else
      render 'edit'
    end
  end

  def destroy
    @competitors = Competitor.find(params[:id])
    @competitors.destroy

    redirect_to competitors_path
  end

  def find_info
    @params = params

    #competitor = Competitor.find(params[:id])
    #url_path = competitor.url_path
    url_path = 'minted'

    require "net/http"
    require "uri"
    require "open-uri"
    require 'nokogiri'

    page = Nokogiri::HTML(open("https://www.instagram.com/#{url_path}/"))
    page2 = Nokogiri::HTML(open("https://twitter.com/#{url_path}"))
    following2 = page2.css("span[class='ProfileNav-value']")
    @twitter = ("Twitter  - #{following2.to_s[140..145]} Following, #{following2.to_s[225..231]} Followers, #{following2.to_s[308..313]} Likes")
    following = page.css("meta")[16]
    @instagram = ("Instagram - #{following.to_s[41..85]}") # => Posts , Followers, Followings

  end

  private

  def article_params
    params.require(:competitors).permit(:title, :text)
  end

end