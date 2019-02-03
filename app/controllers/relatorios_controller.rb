class RelatoriosController < ApplicationController

  def relatorios

  end

  def baixar_relatorio
    @user = User.second
    @trabalhos = @user.trabalhos
    fname = nome_do_arquivo(@user, @trabalhos)
    render xlsx: "relatorios/baixar_relatorio", formats: [:xlsx], filename: fname
    # respond_to do |format|
    #   format.xlsx {render xlsx: "relatorios/baixar_relatorio", filename: "trabalhos.xlsx"}
    # end
  end

  def nome_do_arquivo(user, trabalhos)
    nome_do_arquivo = trabalhos.last.data.strftime("%d-%m") + "_a_" + trabalhos.first.data.strftime("%d-%m") + "_" + user.username.gsub(/\./, '_') + ".xlsx"
  end

end
