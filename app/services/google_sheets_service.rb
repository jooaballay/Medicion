require "httparty"
require "csv"
require "uri"

class GoogleSheetsService
  SPREADSHEET_ID = "1qBOCfbruLYvnz_91H2HTj571LdehDYrG"
  PROJECTS_SHEET = "Solo uso informático"
  INSUMOS_SHEET = "Proyectos emergencia VF"

  def self.fetch_projects
    rows_from(PROJECTS_SHEET).map do |row|
      {
        area: find_value(row, [ "Area", "Área", "AREA", "area" ]),
        nombre: find_value(row, [ "Nombre intervención", "Nombre intervencion", "Proyecto" ]),
        descripcion: find_value(row, [ "Descripción", "Descripcion" ]),
        avance: find_value(row, [ "% de avance", "% avance", "%AVANCE", "Avance" ]),
        presupuesto: find_value(row, [ "Presupuesto", "Presupuesto ejecutado", "PRESUPUESTO EJECUTADO" ]),
        beneficiarios: find_value(row, [ "Beneficiarios", "N° de BENEFICIARIOS", "N° Beneficiarios" ]),
        latitud: find_value(row, [ "Latitud", "latitud" ]),
        longitud: find_value(row, [ "Longitud", "longitud" ])
      }
    end.reject { |p| p[:nombre].blank? }
  end

  def self.fetch_insumos
    rows_from(INSUMOS_SHEET).map do |row|
      {
        categoria: find_value(row, [ "Categoría", "Categoria" ]),
        financiamiento: find_value(row, [ "Financiamiento" ]),
        estado: find_value(row, [ "Estado" ]),
        cantidad: find_value(row, [ "Cantidad" ]),
        detalle: find_value(row, [ "Detalle" ])
      }
    end.reject { |i| i.values.all?(&:blank?) }
  end

  def self.rows_from(sheet_name)
    url = "https://docs.google.com/spreadsheets/d/#{SPREADSHEET_ID}/gviz/tq?tqx=out:csv&sheet=#{URI.encode_www_form_component(sheet_name)}&t=#{Time.now.to_i}"
    response = HTTParty.get(url)

    body = response.body.to_s.encode(
      "UTF-8",
      invalid: :replace,
      undef: :replace,
      replace: ""
    )

    CSV.parse(body, headers: true)
  end

  def self.find_value(row, possible_names)
    normalized_headers = row.headers.index_by { |header| normalize(header) }

    possible_names.each do |name|
      match = normalized_headers[normalize(name)]
      return row[match].to_s.strip if match
    end

    ""
  end

  def self.normalize(text)
    text.to_s
        .downcase
        .tr("áéíóúñ", "aeioun")
        .gsub(/\s+/, "")
        .strip
  end
end
