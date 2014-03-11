# encoding: UTF-8
# Clase de controlador: Aplications
class ApplicationController < ActionController::Base
  protect_from_forgery with: :exception
end
