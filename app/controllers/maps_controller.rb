class MapsController < ApplicationController
  layout 'blank'

  def show
    map('especificos', 1, 'left:674px;top:558px;width:281px;height:220px;')
    map('manuales', 2, 'left:385px;top:554px;width:248px;height:180px;')
    map('poesia/grafica', 3, 'left:1036px;top:762px;width:220px;height:186px;')
    map('distropias', 4, 'left:1024px;top:447px;width:311px;height:175px;')
    map('antecedentes', 5, 'left:393px;top:300px;width:204px;height:236px;')
    map('reveladores', 6, 'left:546px;top:817px;width:297px;height:187px;')
    map('a las barricadas', 8, 'left:629px;top:366px;width:156px;height:175px;')
    map('ficcion', 20, 'left:1012px;top:946px;width:206px;height:175px;')
    map('miedo y asco', 21, 'left:1141px;top:624px;width:171px;height:152px;')
    map('contraculturas', 22, 'left:333px;top:718px;width:225px;height:206px;')
    map('literaturas yo', 25, 'left:881px;top:736px;width:209px;height:175px;')
    map('infantil', 28, 'left:1285px;top:633px;width:187px;height:197px;')
    map('tecnologias', 29, 'left:205px;top:475px;width:178px;height:139px;')
    map('economia', 31, 'left:830px;top:370px;width:249px;height:156px;')
    map('ciencia', 33, 'left:1218px;top:861px;width:213px;height:134px;')
    map('el ruido', 34, 'left:847px;top:929px;width:162px;height:181px;')
    map('el futuro', 35, 'left:182px;top:583px;width:187px;height:158px;')

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

