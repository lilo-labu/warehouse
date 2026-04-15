Rails.application.routes.draw do
  root "pages#home"

  get "offer",    to: "pages#offer"
  get "opening",  to: "pages#opening"

  # позже здесь будут защищённые страницы
end
