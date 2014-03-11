# encoding: UTF-8
# Clase Bob
require "json"
require "selenium-webdriver"

require "test/unit"

class VerComentariosSeltest < Test::Unit::TestCase

  def setup
    @driver = Selenium::WebDriver.for :phantomjs
    @base_url = "http://localhost:9292/posts"
    @accept_next_alert = true
    @driver.manage.timeouts.implicit_wait = 30
    @verification_errors = []  end
  
  def teardown
    @driver.quit
    assert_equal [], @verification_errors
  end
  
  def test_ver_comentarios_sel
    @driver.get(@base_url)
    @driver.find_element(:link, "Crear artículo").click
    @driver.find_element(:id, "post_titulo").clear
    @driver.find_element(:id, "post_titulo").send_keys "mostrar comentario"
    @driver.find_element(:id, "post_texto").clear
    @driver.find_element(:id, "post_texto").send_keys "texto del atriculo para mostrar comentarios"
    @driver.find_element(:name, "commit").click
    @driver.find_element(:id, "comment_commenter").clear
    @driver.find_element(:id, "comment_commenter").send_keys "comentario uno"
    @driver.find_element(:id, "comment_body").clear
    @driver.find_element(:id, "comment_body").send_keys "comentario uno comm"
    @driver.find_element(:name, "commit").click
    @driver.find_element(:link, "Volver").click
    @driver.find_element(:xpath, "(//a[contains(text(),'Mostrar')])[last()]").click
    assert_equal "Usuario: comentario uno", @driver.find_element(:xpath, "//p[3]").text
    assert_equal "Comentario: comentario uno comm", @driver.find_element(:xpath, "//p[4]").text
  end
  
  def element_present?(how, what)
    @driver.find_element(how, what)
    true
  rescue Selenium::WebDriver::Error::NoSuchElementError
    false
  end
  
  def alert_present?()
    @driver.switch_to.alert
    true
  rescue Selenium::WebDriver::Error::NoAlertPresentError
    false
  end
  
  def verify(&blk)
    yield
  rescue Test::Unit::AssertionFailedError => ex
    @verification_errors << ex
  end
  
  def close_alert_and_get_its_text(how, what)
    alert = @driver.switch_to().alert()
    alert_text = alert.text
    if (@accept_next_alert) then
      alert.accept()
    else
      alert.dismiss()
    end
    alert_text
  ensure
    @accept_next_alert = true
  end
end
