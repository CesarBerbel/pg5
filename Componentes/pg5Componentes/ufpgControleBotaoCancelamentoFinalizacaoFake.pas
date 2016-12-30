unit ufpgControleBotaoCancelamentoFinalizacaoFake;

interface

uses
  SysUtils, Classes, ufpgControleBotaoCancelamentoFinalizacao, uspButton;

type
  TfpgControleBotaoCancelamentoFinalizacaoFake = class(TfpgControleBotaoCancelamentoFinalizacao)
  private
    FsParametroDocumentoControladoFluxo: string;
  protected

    /// <summary>
    /// Pega o valor do parâmetro ??? no banco.
    /// </summary>
    /// <returns> 
    ///  string
    /// </returns>
    /// <remarks>
    /// 13/08/14 - Luiz.Marques - SALT 45123/22
    /// </remarks>
    function PegarValorParametroDocumentoControladoFluxo: string; override;

  public
    property fpgParametroDocumentoControladoFluxo: string   
      read FsParametroDocumentoControladoFluxo write FsParametroDocumentoControladoFluxo;

  end;

implementation


function TfpgControleBotaoCancelamentoFinalizacaoFake.PegarValorParametroDocumentoControladoFluxo: string;
begin
  result := fpgParametroDocumentoControladoFluxo;
end;


end.
