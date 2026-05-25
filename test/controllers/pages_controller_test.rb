require "test_helper"

class PagesControllerTest < ActionDispatch::IntegrationTest
  test "should get home" do
    get pages_home_url
    assert_response :success
  end

  test "should get viviendas" do
    get pages_viviendas_url
    assert_response :success
  end

  test "should get donaciones" do
    get pages_donaciones_url
    assert_response :success
  end

  test "should get voluntariado" do
    get pages_voluntariado_url
    assert_response :success
  end

  test "should get gastos" do
    get pages_gastos_url
    assert_response :success
  end

  test "should get documentos" do
    get pages_documentos_url
    assert_response :success
  end
end
