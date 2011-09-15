class MapsController < ApplicationController
  layout 'blank'

  def show
    map('especificos', 1, 'left:875px;top:718px;width:343px;height:288px;')
    map('manuales', 2, 'left:515px;top:718px;width:307px;height:223px;')
    map('poesia/grafica', 3, 'left:1360px;top:976px;width:244px;height:228px;')
    map('distropias', 4, 'left:1311px;top:559px;width:333px;height:238px;')
    map('antecedentes', 5, 'left:511px;top:392px;width:285px;height:286px;')
    map('reveladores', 6, 'left:791px;top:1056px;width:292px;height:254px;')
    map('a las barricadas', 8, 'left:808px;top:449px;width:212px;height:243px;')
    map('ficcion', 20, 'left:1358px;top:1201px;width:284px;height:213px;')
    map('miedo y asco', 21, 'left:1463px;top:818px;width:214px;height:192px;')
    map('contraculturas', 22, 'left:419px;top:922px;width:305px;height:267px;')
    map('literaturas yo', 25, 'left:1126px;top:960px;width:230px;height:227px;')
    map('infantil', 28, 'left:1677px;top:832px;width:227px;height:210px;')
    map('tecnologias', 29, 'left:282px;top:590px;width:217px;height:201px;')
    map('economia', 31, 'left:1056px;top:445px;width:242px;height:235px;')
    map('ciencia', 33, 'left:1621px;top:1065px;width:281px;height:168px;')
    map('el ruido', 34, 'left:1118px;top:1209px;width:209px;height:189px;')
    map('el futuro', 35, 'left:223px;top:745px;width:259px;height:193px;')

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

