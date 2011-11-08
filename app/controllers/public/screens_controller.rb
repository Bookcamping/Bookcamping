class Public::ScreensController < ApplicationController
  layout 'blank'

  def cuatrocientoscuatro
    render layout: 'errors'
  end

  def quinientos
    render layout: 'errors'
  end

  def mapa
    map_area('especificos', 1, 'left:674px;top:558px;width:281px;height:220px;')
    map_area('manuales', 2, 'left:385px;top:554px;width:248px;height:180px;')
    map_area('poesia/grafica', 3, 'left:1037px;top:783px;width:227px;height:187px;')
    map_area('distropias', 4, 'left:1024px;top:447px;width:311px;height:175px;')
    map_area('antecedentes', 5, 'left:393px;top:300px;width:204px;height:236px;')
    map_area('reveladores', 6, 'left:546px;top:817px;width:297px;height:187px;')
    map_area('a las barricadas', 8, 'left:629px;top:366px;width:156px;height:175px;')
    map_area('ficcion', 20, 'left:1095px;top:939px;width:228px;height:166px;')
    map_area('miedo y asco', 21, 'left:1135px;top:620px;width:182px;height:156px;')
    map_area('contraculturas', 22, 'left:333px;top:718px;width:225px;height:206px;')
    map_area('literaturas yo', 25, 'left:924px;top:673px;width:194px;height:182px;')
    map_area('infantil', 28, 'left:1295px;top:598px;width:169px;height:210px;')
    map_area('tecnologias', 29, 'left:205px;top:475px;width:178px;height:139px;')
    map_area('economia', 31, 'left:830px;top:370px;width:249px;height:156px;')
    map_area('ciencia', 33, 'left:1255px;top:811px;width:226px;height:144px;')
    map_area('el ruido', 34, 'left:873px;top:987px;width:184px;height:140px;')
    map_area('el futuro', 35, 'left:182px;top:583px;width:187px;height:158px;')
    map_area('cuidados', 36, 'left:846px;top:825px;width:202px;height:155px;')

    @lists = Shelf.find @ids
  end

  protected
  def map_area(name, id, position)
    @ids ||= []
    @ids << id
    @map ||= {}
    @map[id] = position
  end
end

