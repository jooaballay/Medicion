Rails.application.routes.draw do
  root "pages#home"

  get "viviendas", to: "pages#viviendas"
  get "donaciones", to: "pages#donaciones"
  get "voluntariado", to: "pages#voluntariado"
  get "gastos", to: "pages#gastos"
  get "documentos", to: "pages#documentos"
end