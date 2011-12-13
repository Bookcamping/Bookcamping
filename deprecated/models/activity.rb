# Activity
#
# La actividad esta referida a un usuario y a un objecto (resource)
# Se diferencia de las versiones en que no tienen el contenido del cambio
# ni se aplica a cualquier elemento (de momento referencias y estanterias)
#
# La idea es que se renderice rápido y no ocupe mucho sitio
#
# create_table "activities", :force => true do |t|
#   t.integer  "user_id"
#   t.string   "user_name"
#   t.string   "user_url"
#   t.integer  "resource_id"
#   t.string   "resource_type"
#   t.string   "action",        :limit => 16
#   t.string   "title",         :limit => 200
#   t.string   "url",           :limit => 200
#   t.datetime "activity_at"
#   t.datetime "created_at"
#   t.datetime "updated_at"
# end
#
class Activity < ActiveRecord::Base
  belongs_to :user
  belongs_to :version
  belongs_to :resource, polymorphic: true

  validates_presence_of :user_id, :resource_id, :resource_type, :action, :title, :url, :activity_at, :version_id
end
