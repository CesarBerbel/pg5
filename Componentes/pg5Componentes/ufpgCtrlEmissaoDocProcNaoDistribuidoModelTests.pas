unit ufpgCtrlEmissaoDocProcNaoDistribuidoModelTests;

{*****************************************************************************
Projeto/Sistema: FPG / Componentes
Objetivo: Classe Model para teste controller emissão de documentos para processos sem distribuição
Criação: 16/12/2014 - douglas.delapria
*****************************************************************************}

interface

uses
  uspDataModelTests;

type
  TfpgCtrlEmissaoDocProcNaoDistribuidoModelTests = class(TspDataModelTests)
  private
    FnOrigemProtocolo: integer;
    FnValorExpediente: integer;
    FsNuProtocolo: string;
    FbResultado: boolean;
    FsMsgErro: string;
    FnExpediente1: integer;
    FnExpediente2: integer;
    FbHabilita: boolean;
    FnCdCategoria: integer;
    FsFlDistribuido: string;
    FsNuProcesso: string;
    FsCdProcesso: string;
    FbResultadoDados: boolean;

    /// <summary>
    ///  Seta valor para propriedade número protocolo
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
    ///  Seta valor para propriedade origem do protocolo
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
    ///  Seta valor para propriedade valor expediente
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
    /// <summary>
    ///  Seta valor para propriedade resultado esperado
    /// </summary>
    /// <param name="Value">
    /// </param>
    /// <returns>
    ///  None
    /// </returns>
    /// <remarks>
    /// 16/12/2014 - Douglas.Delapria - SALT: 156525/1
    /// </remarks>
    procedure SetfpgResultado(const Value: boolean);
    /// <summary>
    ///  seta valor para propriedade mensagem de aviso
    /// </summary>
    /// <param name="Value">
    /// </param>
    /// <returns>
    ///  None
    /// </returns>
    /// <remarks>
    /// 16/12/2014 - Douglas.Delapria - SALT: 156525/1
    /// </remarks>
    procedure SetfpgMsgErro(const Value: string);
    /// <summary>
    ///  seta valor para propriedade valor expediente1
    /// </summary>
    /// <param name="Value">
    /// </param>
    /// <returns>
    ///  None
    /// </returns>
    /// <remarks>
    /// 16/12/2014 - Douglas.Delapria - SALT: 156525/1
    /// </remarks>
    procedure SetfpgExpediente1(const Value: integer);
    /// <summary>
    ///  seta valor para propriedade valor expediente2
    /// </summary>
    /// <param name="Value">
    /// </param>
    /// <returns>
    ///  None
    /// </returns>
    /// <remarks>
    /// 16/12/2014 - Douglas.Delapria - SALT: 156525/1
    /// </remarks>
    procedure SetfpgExpediente2(const Value: integer);
    /// <summary>
    ///  Atribui valor para a propriedade habilita
    /// </summary>
    /// <param name="Value">
    /// </param>
    /// <returns>
    ///  None
    /// </returns>
    /// <remarks>
    /// 16/12/2014 - Douglas.Delapria - SALT: 156525/1
    /// </remarks>
    procedure SetfpgHabilita(const Value: boolean);
    /// <summary>
    ///  Seta valor para propriedade CdCategoria
    /// </summary>
    /// <param name="Value">
    /// </param>
    /// <returns>
    ///  None
    /// </returns>
    /// <remarks>
    /// 17/12/2014 - Douglas.Delapria - SALT: 156525/1
    /// </remarks>
    procedure SetfpgCdCategoria(const Value: integer);
    /// <summary>
    ///  Seta valor para a propriedade cdProcesso
    /// </summary>
    /// <param name="Value">
    /// </param>
    /// <returns>
    ///  None
    /// </returns>
    /// <remarks>
    /// 17/12/2014 - Douglas.Delapria - SALT: 156525/1
    /// </remarks>
    procedure SetfpgCdProcesso(const Value: string);
    /// <summary>
    ///  Seta valor para a propriedade flDistribuído
    /// </summary>
    /// <param name="Value">
    /// </param>
    /// <returns>
    ///  None
    /// </returns>
    /// <remarks>
    /// 17/12/2014 - Douglas.Delapria - SALT: 156525/1
    /// </remarks>
    procedure SetfpgFlDistribuido(const Value: string);
    /// <summary>
    ///  Seta valor para a propriedade nuProcesso
    /// </summary>
    /// <param name="Value">
    /// </param>
    /// <returns>
    ///  None
    /// </returns>
    /// <remarks>
    /// 17/12/2014 - Douglas.Delapria - SALT: 156525/1
    /// </remarks>
    procedure SetfpgNuProcesso(const Value: string);
    /// <summary>
    ///  Seta valor para a propriedade resultado dados processo
    /// </summary>
    /// <param name="Value">
    /// </param>
    /// <returns>
    ///  None
    /// </returns>
    /// <remarks>
    /// 17/12/2014 - Douglas.Delapria - SALT: 156525/1
    /// </remarks>
    procedure SetfpgResultadoDados(const Value: boolean);

  published
    /// <summary>
    ///  Seta valor para propriedade número protocolo
    /// </summary>
    /// <value>
    ///  Value
    /// </value>
    /// <remarks>
    /// 16/12/2014 - Douglas.Delapria - SALT: 156525/1
    /// </remarks>
    property fpgNuProtocolo: string read FsNuProtocolo write SetfpgNuProtocolo;
    /// <summary>
    ///  Seta valor para propriedade origem do protocolo
    /// </summary>
    /// <value>
    ///  Value
    /// </value>
    /// <remarks>
    /// 16/12/2014 - Douglas.Delapria - SALT: 156525/1
    /// </remarks>
    property fpgOrigemProtocolo: integer read FnOrigemProtocolo write SetfpgOrigemProtocolo;
    /// <summary>
    ///  Seta valor para propriedade valor expediente
    /// </summary>
    /// <value>
    ///  Value
    /// </value>
    /// <remarks>
    /// 16/12/2014 - Douglas.Delapria - SALT: 156525/1
    /// </remarks>
    property fpgValorExpediente: integer read FnValorExpediente write SetfpgValorExpediente;
    /// <summary>
    ///  Propriedade resultado esperado
    /// </summary>
    /// <param name="Value">
    /// </param>
    /// <returns>
    ///  None
    /// </returns>
    /// <remarks>
    /// 16/12/2014 - Douglas.Delapria - SALT: 156525/1
    /// </remarks>
    property fpgResultado: boolean read FbResultado write SetfpgResultado;
    /// <summary>
    ///  Propriedade mensagem aviso 
    /// </summary>
    /// <param name="Value">
    /// </param>
    /// <returns>
    ///  None
    /// </returns>
    /// <remarks>
    /// 16/12/2014 - Douglas.Delapria - SALT: 156525/1
    /// </remarks>
    property fpgMsgErro: string read FsMsgErro write SetfpgMsgErro;
    /// <summary>
    ///  Valor do expediente 1
    /// </summary>
    /// <value>
    ///  Value
    /// </value>
    /// <remarks>
    /// 16/12/2014 - Douglas.Delapria - SALT: 156525/1
    /// </remarks>
    property fpgExpediente1: integer read FnExpediente1 write SetfpgExpediente1;
    /// <summary>
    ///  Valor do expediente 2
    /// </summary>
    /// <value>
    ///  Value
    /// </value>
    /// <remarks>
    /// 16/12/2014 - Douglas.Delapria - SALT: 156525/1
    /// </remarks>
    property fpgExpediente2: integer read FnExpediente2 write SetfpgExpediente2;
    /// <summary>
    ///  Habilita ou não quando processo digital
    /// </summary>
    /// <value>
    ///  Value
    /// </value>
    /// <remarks>
    /// 16/12/2014 - Douglas.Delapria - SALT: 156525/1
    /// </remarks>
    property fpgHabilita: boolean read FbHabilita write SetfpgHabilita;
    /// <summary>
    ///  Valor da categoria
    /// </summary>
    /// <value>
    ///  Value
    /// </value>
    /// <remarks>
    /// 17/12/2014 - Douglas.Delapria - SALT: 156525/1
    /// </remarks>
    property fpgCdCategoria: integer read FnCdCategoria write SetfpgCdCategoria;
    /// <summary>
    ///  Campo código do processo
    /// </summary>
    /// <value>
    ///  Value
    /// </value>
    /// <remarks>
    /// 17/12/2014 - Douglas.Delapria - SALT: 156525/1
    /// </remarks>
    property fpgCdProcesso: string read FsCdProcesso write SetfpgCdProcesso;
    /// <summary>
    ///  Campo flag distribuído
    /// </summary>
    /// <value>
    ///  Value
    /// </value>
    /// <remarks>
    /// 17/12/2014 - Douglas.Delapria - SALT: 156525/1
    /// </remarks>
    property fpgFlDistribuido: string read FsFlDistribuido write SetfpgFlDistribuido;
    /// <summary>
    ///  Campo número processo
    /// </summary>
    /// <value>
    ///  Value
    /// </value>
    /// <remarks>
    /// 17/12/2014 - Douglas.Delapria - SALT: 156525/1
    /// </remarks>
    property fpgNuProcesso: string read FsNuProcesso write SetfpgNuProcesso;
    /// <summary>
    ///  Resultado esperado para dados processo
    /// </summary>
    /// <value>
    ///  Value
    /// </value>
    /// <remarks>
    /// 17/12/2014 - Douglas.Delapria - SALT: 156525/1
    /// </remarks>
    property fpgResultadoDados: boolean read FbResultadoDados write SetfpgResultadoDados;
  end;

implementation

{ TfpgCtrlEmissaoDocProcNaoDistribuidoModelTests }

// 16/12/2014 - Douglas.Delapria - SALT: 156525/1
procedure TfpgCtrlEmissaoDocProcNaoDistribuidoModelTests.SetfpgCdCategoria(const Value: integer);
begin
  FnCdCategoria := Value;
end;

// 17/12/2014 - Douglas.Delapria - SALT: 156525/1
procedure TfpgCtrlEmissaoDocProcNaoDistribuidoModelTests.SetfpgCdProcesso(const Value: string);
begin
  FsCdProcesso := Value;
end;

// 17/12/2014 - Douglas.Delapria - SALT: 156525/1
procedure TfpgCtrlEmissaoDocProcNaoDistribuidoModelTests.SetfpgExpediente1(const Value: integer);
begin
  FnExpediente1 := Value;
end;

// 16/12/2014 - Douglas.Delapria - SALT: 156525/1
procedure TfpgCtrlEmissaoDocProcNaoDistribuidoModelTests.SetfpgExpediente2(const Value: integer);
begin
  FnExpediente2 := Value;
end;

// 16/12/2014 - Douglas.Delapria - SALT: 156525/1
procedure TfpgCtrlEmissaoDocProcNaoDistribuidoModelTests.SetfpgFlDistribuido(const Value: string);
begin
  FsFlDistribuido := Value;
end;

// 17/12/2014 - Douglas.Delapria - SALT: 156525/1
procedure TfpgCtrlEmissaoDocProcNaoDistribuidoModelTests.SetfpgHabilita(const Value: boolean);
begin
  FbHabilita := Value;
end;

// 16/12/2014 - Douglas.Delapria - SALT: 156525/1
procedure TfpgCtrlEmissaoDocProcNaoDistribuidoModelTests.SetfpgMsgErro(const Value: string);
begin
  FsMsgErro := Value;
end;

// 16/12/2014 - Douglas.Delapria - SALT: 156525/1
procedure TfpgCtrlEmissaoDocProcNaoDistribuidoModelTests.SetfpgNuProcesso(const Value: string);
begin
  FsNuProcesso := Value;
end;

// 17/12/2014 - Douglas.Delapria - SALT: 156525/1
procedure TfpgCtrlEmissaoDocProcNaoDistribuidoModelTests.SetfpgNuProtocolo(const Value: string);
begin
  FsNuProtocolo := Value;
end;

// 16/12/2014 - Douglas.Delapria - SALT: 156525/1
procedure TfpgCtrlEmissaoDocProcNaoDistribuidoModelTests.SetfpgOrigemProtocolo(
  const Value: integer);
begin
  FnOrigemProtocolo := Value;
end;

// 16/12/2014 - Douglas.Delapria - SALT: 156525/1
procedure TfpgCtrlEmissaoDocProcNaoDistribuidoModelTests.SetfpgResultado(const Value: boolean);
begin
  FbResultado := Value;
end;

// 16/12/2014 - Douglas.Delapria - SALT: 156525/1
procedure TfpgCtrlEmissaoDocProcNaoDistribuidoModelTests.SetfpgResultadoDados(
  const Value: boolean);
begin
  FbResultadoDados := Value;
end;

// 17/12/2014 - Douglas.Delapria - SALT: 156525/1
procedure TfpgCtrlEmissaoDocProcNaoDistribuidoModelTests.SetfpgValorExpediente(
  const Value: integer);
begin
  FnValorExpediente := Value;
end;

end.

