module Users::Create

 def create_profile_shelves
    PaperTrail.enabled = false
    unless like_it_shelf
      user_shelves.create!(slug: 'favoritos', name: 'FAVORITOS',
                visibility: :public, rol: 'like_it', color: '#44adc6')
      like_it_shelf(true) # reload association
    end

    unless read_later_shelf
      user_shelves.create!(slug: 'para_leer', name: 'PARA LEER',
                visibility: :private, rol: 'read_later', color: '#67c095')
      read_later_shelf(true) # reload 
    end

    unless my_references_shelf
      user_shelves.create!(slug: 'mis_aportaciones', name: 
          'MIS APORTACIONES', visibility: :public, rol: 'my_references', 
          color: '#e7de21')
      my_references_shelf(true) # reload
    end

    PaperTrail.enabled = true
  end
end

