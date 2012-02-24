class Public::InfoPagesController < ApplicationController
  def agradecimientos
    @page = Page.find 3
    render action: 'page'
  end

  def contactar
    @page = Page.find 2
    render action: 'page'
  end

  def nosotras
    @page = Page.find 1
    render action: 'page'
  end

  def colofon
  end

  def como
    @page = Page.find 4
    render action: 'page'
  end

  def visitas
    @page = Page.find 6
    render action: 'page'
  end
end
