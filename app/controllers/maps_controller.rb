class MapsController < ApplicationController
  layout 'blank'

  def show
    map('especificos', 1, 'left:569px;top:463px;width:217px;height:181px;')
    map('manuales', 2, 'left:322px;top:461px;width:199px;height:141px;')
    map('poesia/grafica', 3, 'left:853px;top:626px;width:178px;height:152px;')
    map('distropias', 4, 'left:841px;top:370px;width:260px;height:140px;')
    map('antecedentes', 5, 'left:318px;top:248px;width:168px;height:190px;')
    map('reveladores', 6, 'left:443px;top:671px;width:251px;height:164px;')
    map('a las barricadas', 8, 'left:527px;top:300px;width:113px;height:150px;')
    map('ficcion', 20, 'left:833px;top:777px;width:169px;height:143px;')
    map('miedo y asco', 21, 'left:940px;top:515px;width:143px;height:121px;')
    map('contraculturas', 22, 'left:273px;top:593px;width:190px;height:171px;')
    map('literaturas yo', 25, 'left:723px;top:607px;width:167px;height:139px;')
    map('infantil', 28, 'left:1063px;top:522px;width:153px;height:159px;')
    map('tecnologias', 29, 'left:166px;top:394px;width:156px;height:113px;')
    map('economia', 31, 'left:681px;top:303px;width:203px;height:132px;')
    map('ciencia', 33, 'left:1004px;top:704px;width:172px;height:115px;')
    map('el ruido', 34, 'left:695px;top:766px;width:135px;height:142px;')
    map('el futuro', 35, 'left:145px;top:478px;width:157px;height:130px;')

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

