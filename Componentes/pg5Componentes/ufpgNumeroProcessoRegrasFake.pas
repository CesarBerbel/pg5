unit ufpgNumeroProcessoRegrasFake;

interface

uses
  SysUtils, ufpgNumeroProcessoRegras, usajNumeroProcesso, uspConsulta, usajLotacao, Classes;

type
  TfpgNumeroProcessoRegrasFake = class(TfpgNumeroProcessoRegras)
  protected
    procedure ExecutarRegrasTelaSemPermissao(pnCdErro: integer); override;
  public
    FenTipoLotacao: TTipoLotacao;
    FnNuSeqLotacao: integer;
    FncdForo: integer;
    FncdVara: integer;
    FbTelaTemPermissao: boolean;

    constructor Create(poNumeroProcesso: TspConsulta); override;

    procedure AtualizarPropriedadesNumProcesso; override;

    procedure DefinirPropriedadesMeioTramitacaoNumProcesso; override;

    procedure DefinirPropriedadesRefreshProcesso; override;

    function TestarTelaAtualTemPermissaoLotacaoAtual: boolean; override;

    function PegarTipoLotacaoDoUsuario: TTipoLotacao; override;
    function PegarSequencialDeLotacaoDoUsuario: integer; override;
    procedure PegarCdForoCdVaraNuProcesso(var pncdForo, pncdVara: integer;
      const psNuProcesso: string); override;
    function AlternarLotacaoCartorioPublico: boolean;
  end;

  /// <summary>
  ///  Esta classe fake foi criada para garantir o tratamento de exce��o correto
  ///  do m�todo ExecutarAntesDeValidarProcesso quando emitido uma exce��o de regra de neg�cio
  /// </summary>
  /// <remarks>
  ///  26/05/2014 - MARCOS.KLEIN - SALT: 125791/1
  /// </remarks>
  TfpgNumeroProcessoRegrasFakeAlternarLotacaoCartorioExcecaoRegraNegocio =
    class(TfpgNumeroProcessoRegrasFake)
  protected
    function AlternarLotacaoUnificada(const psNuProcesso: string): boolean; override;
  end;

  /// <summary>
  ///  Esta classe fake foi criada para garantir o tratamento de exce��o correto
  ///  do m�todo ExecutarAntesDeValidarProcesso quando emitido uma exce��o espec�fica
  ///  para parar a excecu��o.
  /// </summary>
  /// <remarks>
  ///  26/05/2014 - MARCOS.KLEIN - SALT: 125791/1
  /// </remarks>
  TfpgNumeroProcessoRegrasFakeAlternarLotacaoCartorioExcecaoPararExecucao =
    class(TfpgNumeroProcessoRegrasFake)
  protected
    function AlternarLotacaoUnificada(const psNuProcesso: string): boolean; override;
  end;

  /// <summary>
  ///  Esta classe fake foi criada para garantir o tratamento de exce��o correto
  ///  do m�todo ExecutarAntesDeValidarProcesso quando emitido uma exce��o gen�rica
  /// </summary>
  /// <remarks>
  ///  26/05/2014 - MARCOS.KLEIN - SALT: 125791/1
  /// </remarks>
  TfpgNumeroProcessoRegrasFakeAlternarLotacaoCartorioExcecaoGenerica = class(
    TfpgNumeroProcessoRegrasFake)
  protected
    function AlternarLotacaoUnificada(const psNuProcesso: string): boolean; override;
  end;

  /// <summary>
  ///  Esta classe fake foi criada para garantir o tratamento de exce��o correto
  ///  do m�todo ExecutarAntesDeValidarProcesso quando emitido uma exce��o espec�fica
  ///  para avisar que a tela n�o pode ser aberta na lota��o corrente.
  /// </summary>
  /// <remarks>
  ///  26/05/2014 - MARCOS.KLEIN - SALT: 125791/1
  /// </remarks>
  TfpgNumeroProcessoRegrasFakeAlternarLotacaoCartorioExcecaoSemPermissao =
    class(TfpgNumeroProcessoRegrasFake)
  protected
    function AlternarLotacaoUnificada(const psNuProcesso: string): boolean; override;
  end;

implementation

uses
  usajConstante, uspExcecao, ufpgMensagem3;


{ TfpgNumeroProcessoRegrasFake }

function TfpgNumeroProcessoRegrasFake.AlternarLotacaoCartorioPublico: boolean;
begin
  result := AlternarLotacaoUnificada(STRING_INDEFINIDO);
end;

procedure TfpgNumeroProcessoRegrasFake.ExecutarRegrasTelaSemPermissao(pnCdErro: integer);
begin
  Exit;
end;

procedure TfpgNumeroProcessoRegrasFake.AtualizarPropriedadesNumProcesso;
begin
  inherited;
end;

constructor TfpgNumeroProcessoRegrasFake.Create(poNumeroProcesso: TspConsulta);
begin
  FoNumeroProcesso := poNumeroProcesso;
  fpgPermiteAlternarLotacao := True;
end;

procedure TfpgNumeroProcessoRegrasFake.DefinirPropriedadesMeioTramitacaoNumProcesso;
begin
  inherited;
end;

procedure TfpgNumeroProcessoRegrasFake.DefinirPropriedadesRefreshProcesso;
begin
  inherited;
end;

function TfpgNumeroProcessoRegrasFake.PegarSequencialDeLotacaoDoUsuario: integer;
begin
  result := FnNuSeqLotacao;
end;

function TfpgNumeroProcessoRegrasFake.PegarTipoLotacaoDoUsuario: TTipoLotacao;
begin
  result := FenTipoLotacao;
end;

function TfpgNumeroProcessoRegrasFakeAlternarLotacaoCartorioExcecaoRegraNegocio.
AlternarLotacaoUnificada(const psNuProcesso: string): boolean;
begin
  result := False;
  TspExcecao.EmitirExcecaoRegraNegocio(NUMERO_INDEFINIDO, 'exce��o regra de neg�cio indefinida');
end;

function TfpgNumeroProcessoRegrasFakeAlternarLotacaoCartorioExcecaoPararExecucao.
AlternarLotacaoUnificada(const psNuProcesso: string): boolean;
begin
  result := False;
  TspExcecao.EmitirExcecaoRegraNegocio(nCOD_EXCECAO_PARAR_OPERACOES_APOS_TROCA_LOTACAO,
    'As opera��es ap�s a troca de lota��o foram interrompidas');
end;

function TfpgNumeroProcessoRegrasFakeAlternarLotacaoCartorioExcecaoGenerica.
AlternarLotacaoUnificada(
  const psNuProcesso: string): boolean;
begin
  raise Exception.Create('Erro gen�rico');
end;

function TfpgNumeroProcessoRegrasFakeAlternarLotacaoCartorioExcecaoSemPermissao.
AlternarLotacaoUnificada(const psNuProcesso: string): boolean;
begin
  result := False;
  TspExcecao.EmitirExcecaoRegraNegocio(n_avFPGTelaNaoTemPermissaoAcessoCartorioUnico,
    'N�o � permitido acessar esta tela na lota��o corrente');
end;

procedure TfpgNumeroProcessoRegrasFake.PegarCdForoCdVaraNuProcesso(
  var pncdForo, pncdVara: integer; const psNuProcesso: string);
begin
  pncdForo := FncdForo;
  pncdVara := FncdVara;
end;

function TfpgNumeroProcessoRegrasFake.TestarTelaAtualTemPermissaoLotacaoAtual: boolean;
begin
  result := FbTelaTemPermissao;
end;

end.
