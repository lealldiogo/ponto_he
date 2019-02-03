class RelatoriosController < ApplicationController

  def relatorios

  end

  def baixar_relatorio
    @user = User.second
    @trabalhos = @user.trabalhos
    render xlsx: "relatorios/baixar_relatorio", formats: [:xlsx] #, filename: "trabalhos.xlsx"
    # respond_to do |format|
    #   format.xlsx {render xlsx: "relatorios/baixar_relatorio", filename: "trabalhos.xlsx"}
    # end
  end

end
