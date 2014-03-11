# encoding: UTF-8
require 'simplecov'
SimpleCov.start
require 'test_helper'

# Clase de pruebas de unidad: Post
class PostsCommentsTest < ActionController::TestCase
  def setup
    @post = posts(:one)
  end

  # Pruebas de creacion de posts:
  test 'debe agregar un comentario' do
    get :new
    assert_response :success
  end

  # Pruebas para mostrar un post
  test 'debe mostrar un comentario' do
    get :show, id: @post.id
    assert_response :success
  end

  # Pruebas de obtencion de la pagina principal
  test 'obtener el index' do
    get :index
    assert_response :success
  end

  # Pruebas para eliminar un post
  test 'debe destruir un comentario' do
    assert_difference('Post.count', -1) do
      delete :destroy, id: @post.id
    end
    assert_redirected_to posts_path
  end
end
