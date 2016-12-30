unit ufpgCtrlEmissaoDocProcNaoDistribuidoFake;

{*****************************************************************************
Projeto/Sistema: FPG / Componentes
Objetivo: Classe controle Fake emissão documento sem distribuição
Criação: 16/12/2014 - douglas.delapria
*****************************************************************************}

interface

uses
  ufpgCtrlEmissaoDocProcNaoDistribuido, Classes, SysUtils, usajConstante;

type
  TfpgCtrlEmissaoDocProcNaoDistribuidoFake = class(TfpgCtrlEmissaoDocProcNaoDistribuido)
  private
    FsNuProtocolo: string;
    FnOrigemProtocolo: integer;
    FnValorExpediente: integer;

    /// <summary>
    ///  Seta valor para a propriedade número protocolo
    /// </summary>
    /// <param name="Value">
    /// </param>
    /// <returns>
    ///  None
    /// </returns>
    /// <remarks>
    /// 16/12/2014 - Douglas.Delapria - SALT: 156525/1
    /// </remarks>
    procedure SetfpgNuProtocolo(const Value: string);
    /// <summary>
    ///  Seta valor para a propriedade origem protocolo
    /// </summary>
    /// <param name="Value">
    /// </param>
    /// <returns>
    ///  None
    /// </returns>
    /// <remarks>
    /// 16/12/2014 - Douglas.Delapria - SALT: 156525/1
    /// </remarks>
    procedure SetfpgOrigemProtocolo(const Value: integer);
    /// <summary>
    ///  Seta valor para a propriedade expediente
    /// </summary>
    /// <param name="Value">
    /// </param>
    /// <returns>
    ///  None
    /// </returns>
    /// <remarks>
    /// 16/12/2014 - Douglas.Delapria - SALT: 156525/1
    /// </remarks>
    procedure SetfpgValorExpediente(const Value: integer);

  protected
    /// <summary>
    ///  Retorna número do protocolo do processo
    /// </summary>
    /// <returns>
    ///  string
    /// </returns>
    /// <remarks>
    /// 15/12/2014 - Douglas.Delapria - SALT: 156525/1
    /// </remarks>
    function ConsultarNumeroProtocolo: string; override;
    /// <summary>
    ///  Retorna origem do protocolo
    /// </summary>
    /// <param name="psNuProtocolo">
    /// </param>
    /// <returns>
    ///  integer
    /// </returns>
    /// <remarks>
    /// 15/12/2014 - Douglas.Delapria - SALT: 156525/1
    /// </remarks>
    function ConsultarOrigemProtocolo(const psNuProtocolo: string): integer; override;
    /// <summary>
    ///  Retona valor parametro de expediente
    /// </summary>
    /// <returns>
    ///  integer
    /// </returns>
    /// <remarks>
    /// 16/12/2014 - Douglas.Delapria - SALT: 156525/1
    /// </remarks>
    function RetornarValorParametroExpediente: integer; override;
  public
    /// <summary>
    ///  Instancia variáveis locais do método
    /// </summary>
    /// <returns>
    ///  None
    /// </returns>
    /// <remarks>
    /// 04/12/2014 - Pio.Neto - Salt: 156525/1
    /// </remarks>
    constructor Create(const poTipoRegistro: TTiposRegistros);
  published
    /// <summary>
    ///  Valor do protocolo
    /// </summary>
    /// <value>
    ///  Value
    /// </value>
    /// <remarks>
    /// 16/12/2014 - Douglas.Delapria - SALT: 156525/1
    /// </remarks>
    property fpgNuProtocolo: string read FsNuProtocolo write SetfpgNuProtocolo;
    /// <summary>
    ///  Valor da origem do protocolo
    /// </summary>
    /// <returns>
    ///  string
    /// </returns>
    /// <remarks>
    /// 16/12/2014 - Douglas.Delapria - SALT: 156525/1
    /// </remarks>
    property fpgOrigemProtocolo: integer read FnOrigemProtocolo write SetfpgOrigemProtocolo;
    /// <summary>
    ///  Valor parâmetro expediente
    /// </summary>
    /// <value>
    ///  Value
    /// </value>
    /// <remarks>
    /// 16/12/2014 - Douglas.Delapria - SALT: 156525/1
    /// </remarks>
    property fpgValorExpediente: integer read FnValorExpediente write SetfpgValorExpediente;
  end;

implementation

{ TfpgCtrlEmissaoDocProcNaoDistribuidoFake }

// 16/12/2014 - Douglas.Delapria - SALT: 156525/1
function TfpgCtrlEmissaoDocProcNaoDistribuidoFake.ConsultarNumeroProtocolo: string;
begin
  result := FsNuProtocolo;
end;

// 16/12/2014 - Douglas.Delapria - SALT: 156525/1
function TfpgCtrlEmissaoDocProcNaoDistribuidoFake.ConsultarOrigemProtocolo(
  const psNuProtocolo: string): integer;
begin
  result := FnOrigemProtocolo;
end;

// 16/12/2014 - Douglas.Delapria - SALT: 156525/1
constructor TfpgCtrlEmissaoDocProcNaoDistribuidoFake.Create(const poTipoRegistro: TTiposRegistros);
begin
  inherited Create(poTipoRegistro);
end;

// 17/12/2014 - Douglas.Delapria - SALT: 156525/1
function TfpgCtrlEmissaoDocProcNaoDistribuidoFake.RetornarValorParametroExpediente: integer;
begin
  result := FnValorExpediente;
end;

// 16/12/2014 - Douglas.Delapria - SALT: 156525/1
procedure TfpgCtrlEmissaoDocProcNaoDistribuidoFake.SetfpgNuProtocolo(const Value: string);
begin
  FsNuProtocolo := Value;
end;

// 16/12/2014 - Douglas.Delapria - SALT: 156525/1
procedure TfpgCtrlEmissaoDocProcNaoDistribuidoFake.SetfpgOrigemProtocolo(const Value: integer);
begin
  FnOrigemProtocolo := Value;
end;

// 16/12/2014 - Douglas.Delapria - SALT: 156525/1
procedure TfpgCtrlEmissaoDocProcNaoDistribuidoFake.SetfpgValorExpediente(const Value: integer);
begin
  FnValorExpediente := Value;
end;

end.

