# ShelfItem
# A item stored inside a section
#
# SCHEMA
#create_table "shelf_items", :force => true do |t|
#  t.integer  "shelf_id"
#  t.integer  "reference_id"
#  t.integer  "user_id"
#  t.datetime "created_at"
#  t.integer  "camp_id"
#end
#
class ShelfItem < ActiveRecord::Base
  belongs_to :user
  belongs_to :shelf
  belongs_to :reference
  belongs_to :camp

  has_paper_trail meta: {title: Proc.new {|item| "'#{item.reference.title}' en #{item.shelf.name}" }, camp_id: :camp_id }


  # Keep it! TODO: check wky...
  belongs_to :camp_shelf, :foreign_key => :shelf_id

  validates :user_id, presence: true
  validates :shelf_id, presence: true
  validates :reference_id, presence: true
  #validates :camp_id, presence: true

  after_create :add_reference_to_shelf
  after_destroy :remove_reference_from_shelf

  def title_name

  end

  protected
  def add_reference_to_shelf
    PaperTrail.enabled = false
    current = shelf.references_count
    shelf.update_attribute(:references_count, current + 1)
    PaperTrail.enabled = true
  end

  def remove_reference_from_shelf
    PaperTrail.enabled = false
    shelf.update_attribute(:references_count, (shelf.references_count - 1))
    PaperTrail.enabled = true
  end
end
