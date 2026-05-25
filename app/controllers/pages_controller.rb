class PagesController < ApplicationController
  def home
    @projects = GoogleSheetsService.fetch_projects
    @insumos = GoogleSheetsService.fetch_insumos
  rescue StandardError => e
    Rails.logger.error(e.message)
    @projects = []
    @insumos = []
  end

  def viviendas; end
  def donaciones; end
  def voluntariado; end
  def gastos; end
  def documentos; end
end