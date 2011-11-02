class MapsController < ApplicationController
  layout 'blank'

  def show
    map('especificos', 1, 'left:674px;top:558px;width:281px;height:220px;')
    map('manuales', 2, 'left:385px;top:554px;width:248px;height:180px;')
    map('poesia/grafica', 3, 'left:1037px;top:783px;width:227px;height:187px;')
    map('distropias', 4, 'left:1024px;top:447px;width:311px;height:175px;')
    map('antecedentes', 5, 'left:393px;top:300px;width:204px;height:236px;')
    map('reveladores', 6, 'left:546px;top:817px;width:297px;height:187px;')
    map('a las barricadas', 8, 'left:629px;top:366px;width:156px;height:175px;')
    map('ficcion', 20, 'left:1095px;top:939px;width:228px;height:166px;')
    map('miedo y asco', 21, 'left:1135px;top:620px;width:182px;height:156px;')
    map('contraculturas', 22, 'left:333px;top:718px;width:225px;height:206px;')
    map('literaturas yo', 25, 'left:924px;top:673px;width:194px;height:182px;')
    map('infantil', 28, 'left:1295px;top:598px;width:169px;height:210px;')
    map('tecnologias', 29, 'left:205px;top:475px;width:178px;height:139px;')
    map('economia', 31, 'left:830px;top:370px;width:249px;height:156px;')
    map('ciencia', 33, 'left:1255px;top:811px;width:226px;height:144px;')
    map('el ruido', 34, 'left:873px;top:987px;width:184px;height:140px;')
    map('el futuro', 35, 'left:182px;top:583px;width:187px;height:158px;')
    map('cuidados', 36, 'left:846px;top:825px;width:202px;height:155px;')

    @lists = Shelf.find @ids
  end

  protected
  def map(name, id, position)
    @ids ||= []
    @ids << id
    @map ||= {}
    @map[id] = position
  end
end

