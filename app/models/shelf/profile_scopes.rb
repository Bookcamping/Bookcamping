# Profile scopes
module Shelf::ProfileScopes
  ROLES = ['like_it', 'read_later', 'my_references']
  SLUGS = ['favoritos', 'para_leer', 'aportaciones']
  ROL_TO_SLUG = Hash[ROLES.zip(SLUGS)]
  SLUG_TO_ROL = Hash[SLUGS.zip(ROLES)]

  def by_rol(rol)
    where(rol: rol).first
  end

  def by_slug(param)
    if SLUGS.include?(param)
      by_rol(SLUG_TO_ROL[param])
    else
      by_rol('-')
    end
  end

end

