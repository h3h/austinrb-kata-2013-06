$:.unshift File.dirname(File.expand_path(__FILE__))

require 'rubygems'
require 'bundler/setup'
require 'goliath'
require 'em-synchrony/activerecord'
require 'grape'
require 'rabl'
require 'oj'

require 'user'
require 'achievement'
require 'user_achievement'


Rabl.configure do |config|
  # Commented as these are defaults
  # config.cache_all_output = false
  # config.cache_sources = Rails.env != 'development' # Defaults to false
  # config.cache_engine = Rabl::CacheEngine.new # Defaults to Rails cache
  # config.perform_caching = false
  # config.escape_all_output = false
  # config.json_engine = nil # Class with #dump class method (defaults JSON)
  # config.msgpack_engine = nil # Defaults to ::MessagePack
  # config.bson_engine = nil # Defaults to ::BSON
  # config.plist_engine = nil # Defaults to ::Plist::Emit
  # config.include_json_root = true
  # config.include_msgpack_root = true
  # config.include_bson_root = true
  # config.include_plist_root = true
  # config.include_xml_root  = false
  # config.include_child_root = true
  # config.enable_json_callbacks = false
  # config.xml_options = { :dasherize  => true, :skip_types => false }
  config.view_paths = ['./']
  # config.raise_on_missing_attribute = true # Defaults to false
  # config.replace_nil_values_with_empty_strings = true # Defaults to false
end

class Application < Goliath::API

  def response(env)
    ::API.call(env)
  end

end


module APIv1
  class Achievements < Grape::API

    version 'v1', using: :path, format: :json

    resource :achievements do

      # GET /achievements/1.json
      desc "return achievement"
      get "/:id" do
        achievement = Achievement.find(params[:id])
        Rabl::Renderer.new('achievement_show', achievement,  { format: 'json' }).render
      end

    end

  end

  class Users < Grape::API

    version 'v1', using: :path, format: :json

    resource :users do

      # GET /user/1.json
      desc "return user"
      get "/:id" do
        user = User.find(params[:id])
        Rabl::Renderer.new('user_show', user,  { format: 'json' }).render
      end

      desc 'add achievement to user'
      params do
        requires :id, type: String, desc: "Status ID."
        requires :achievement_id, type: String, desc: "Achievement id you want to add"
      end
      put ':id' do
        user = User.find params[:id]
        achievement = Achievement.find params[:achievement_id]
        user.achievements << achievement
      end

    end

  end

end

class API < Grape::API

  mount APIv1::Achievements
  mount APIv1::Users

end
