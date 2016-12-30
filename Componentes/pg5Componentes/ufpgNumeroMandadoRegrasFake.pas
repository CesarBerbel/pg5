unit ufpgNumeroMandadoRegrasFake;

interface

uses
  SysUtils, Classes, ufpgNumeroMandadoRegras, ufpgRegrasCartorioUnico, usajLotacao,
  uspTestCase, uspForm;

type
  TfpgNumeroMandadoRegrasFake = class(TfpgNumeroMandadoRegras)
  private
    FoFormPaiFake: TspForm;
  public
    FenTipoLotacao: TTipoLotacao;
    FnCdForo: integer;
    FnCdVara: integer;
    FbTelaTemPermissao: boolean;

    constructor Create(poNumeroMandado: TObject); override;
    destructor Destroy; override;
    function PegarTipoLotacaoDoUsuario: TTipoLotacao; override;
    function PegarNomeFormOwnerNumeroMandado: string; override;
    function PegarCdVaraDaReferenciaDaRegra: integer; override;
    function PegarCdForoDaReferenciaDaRegra: integer; override;
    // function PegarControleCartorioUnico: TfpgRegrasCartorioUnico; override;
    function TestarTelaAtualTemPermissaoLotacaoAtual: boolean; override;
    function AlternarLotacaoCartorioPublico: boolean;
    procedure ExecutarRegrasTelaSemPermissao(pnCdErro: integer); override;
  end;

  /// <summary>
  ///  Esta classe fake foi criada para garantir o tratamento de exce��o correto
  ///  do m�todo ExecutarAntesDeValidarMandado quando emitido uma exce��o de regra de neg�cio
  /// </summary>
  /// <remarks>
  ///  20/05/2014 - MARCOS.KLEIN - SALT: 125791/1
  /// </remarks>    
  TfpgNumeroMandadoRegrasFakeAlternarLotacaoCartorioExcecaoRegraNegocio = class(
    TfpgNumeroMandadoRegrasFake)
  protected
    function AlternarLotacaoUnificada: boolean; override;
  end;

  /// <summary>
  ///  Esta classe fake foi criada para garantir o tratamento de exce��o correto
  ///  do m�todo ExecutarAntesDeValidarMandado quando emitido uma exce��o espec�fica
  ///  para parar a excecu��o.
  /// </summary>
  /// <remarks>
  ///  20/05/2014 - MARCOS.KLEIN - SALT: 125791/1
  /// </remarks>
  TfpgNumeroMandadoRegrasFakeAlternarLotacaoCartorioExcecaoPararExecucao =
    class(TfpgNumeroMandadoRegrasFake)
  protected
    function AlternarLotacaoUnificada: boolean; override;
  end;


  /// <summary>
  ///  Esta classe fake foi criada para garantir o tratamento de exce��o correto
  ///  do m�todo ExecutarAntesDeValidarMandado quando emitido uma exce��o gen�rica
  /// </summary>
  /// <remarks>
  ///  20/05/2014 - MARCOS.KLEIN - SALT: 125791/1
  /// </remarks> 
  TfpgNumeroMandadoRegrasFakeAlternarLotacaoCartorioExcecaoGenerica = class(
    TfpgNumeroMandadoRegrasFake)
  protected
    function AlternarLotacaoUnificada: boolean; override;
  end;

  /// <summary>
  ///  Esta classe fake foi criada para garantir o tratamento de exce��o correto
  ///  do m�todo ExecutarAntesDeValidarProcesso quando emitido uma exce��o espec�fica
  ///  para avisar que a tela n�o pode ser aberta na lota��o corrente.
  /// </summary>
  /// <remarks>
  ///  26/05/2014 - MARCOS.KLEIN - SALT: 125791/1
  /// </remarks>
  TfpgNumeroMandadoRegrasFakeAlternarLotacaoCartorioExcecaoSemPermissao = class(
    TfpgNumeroMandadoRegrasFake)
  protected
    function AlternarLotacaoUnificada: boolean; override;
  end;

implementation

uses
  usajConstante, uspExcecao, ufpgRegrasCartorioUnicoFake, ufpgMensagem3;

function TfpgNumeroMandadoRegrasFake.AlternarLotacaoCartorioPublico: boolean;
begin
  result := AlternarLotacaoUnificada;
end;

constructor TfpgNumeroMandadoRegrasFake.Create(poNumeroMandado: TObject);
begin
  FoNumeroMandado := poNumeroMandado;

  FoFormPaiFake := TspForm.Create(nil); //PC_OK

  FbPermiteAlternarLotacao := True;
  FoFormPai := FoFormPaiFake;
end;

destructor TfpgNumeroMandadoRegrasFake.Destroy;
begin
  FreeAndNil(FoFormPaiFake); //PC_OK

  inherited;
end;

procedure TfpgNumeroMandadoRegrasFake.ExecutarRegrasTelaSemPermissao(pnCdErro: integer);
begin
  Exit;
end;

function TfpgNumeroMandadoRegrasFake.PegarCdForoDaReferenciaDaRegra: integer;
begin
  result := FnCdForo;
end;

function TfpgNumeroMandadoRegrasFake.PegarCdVaraDaReferenciaDaRegra: integer;
begin
  result := FnCdVara;
end;

// function TfpgNumeroMandadoRegrasFake.PegarControleCartorioUnico: TfpgRegrasCartorioUnico;
// begin
//   result := TfpgRegrasCartorioUnicoFake.PegarControleCartorioUnico;
// end;

function TfpgNumeroMandadoRegrasFake.PegarNomeFormOwnerNumeroMandado: string;
begin
  result := inherited PegarNomeFormOwnerNumeroMandado;
end;

function TfpgNumeroMandadoRegrasFake.PegarTipoLotacaoDoUsuario: TTipoLotacao;
begin
  result := FenTipoLotacao;
end;

function TfpgNumeroMandadoRegrasFakeAlternarLotacaoCartorioExcecaoRegraNegocio.
AlternarLotacaoUnificada: boolean;
begin
  result := False;
  TspExcecao.EmitirExcecaoRegraNegocio(NUMERO_INDEFINIDO, 'exce��o regra de neg�cio indefinida');
end;

function TfpgNumeroMandadoRegrasFakeAlternarLotacaoCartorioExcecaoPararExecucao.
AlternarLotacaoUnificada: boolean;
begin
  result := False;
  TspExcecao.EmitirExcecaoRegraNegocio(nCOD_EXCECAO_PARAR_OPERACOES_APOS_TROCA_LOTACAO,
    'As opera��es ap�s a troca de lota��o foram interrompidas');
end;

function TfpgNumeroMandadoRegrasFakeAlternarLotacaoCartorioExcecaoGenerica.AlternarLotacaoUnificada:
boolean;
begin
  raise Exception.Create('Erro gen�rico');
end;

function TfpgNumeroMandadoRegrasFake.TestarTelaAtualTemPermissaoLotacaoAtual: boolean;
begin
  result := FbTelaTemPermissao;
end;

{ TfpgNumeroMandadoRegrasFakeAlternarLotacaoCartorioExcecaoSemPermissao }

function TfpgNumeroMandadoRegrasFakeAlternarLotacaoCartorioExcecaoSemPermissao.
AlternarLotacaoUnificada: boolean;
begin
  result := False;
  TspExcecao.EmitirExcecaoRegraNegocio(n_avFPGTelaNaoTemPermissaoAcessoCartorioUnico,
    'N�o � permitido acessar esta tela na lota��o corrente');
end;

end.
