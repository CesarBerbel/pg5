unit ufpgNumeroProcessoRegrasTests;

interface

uses
  TestFrameWork, ufpgNumeroProcessoRegrasFake, ufpgNumeroProcessoFake, usajConstante,
  Classes, ufpgRegrasCartorioUnico, ufpgRegrasCartorioUnicoFake,
  ufpgRegrasLotacaoUnificadaFake, uspForm, ufpgAdapterLotacaoUnica;

type
  TspFormTeste = class(TspForm)
    FoNumProcessoTeste: TfpgNumeroProcessoFake;
  public
    constructor Create(oDono: TComponent); override;
    destructor Destroy; override;
  end;

  TfpgNumeroProcessoRegrasTests = class(TTestCase)
  private
    FoNumeroProcessoRegrasFake: TfpgNumeroProcessoRegrasFake;
    FoFormTeste: TspFormTeste;
    FoControleCartorioUnicoFake: TfpgRegrasCartorioUnicoFake;
    FoControleLotacaoFake: TfpgRegrasLotacaoUnificadaFake;
    procedure LimparNumeroProcessoRegrasFake;
    procedure ExecutarRegraAntesValidarProcesso;
  protected
    procedure SetUp; override;
    procedure TearDown; override;
  published
    procedure TestarProcessoEhDigital;
    procedure TestarProcessoEhFisico;
    procedure TestarProcessoEhHibrido;
    procedure TestarProcessoNaoEhDigital;

    procedure TestarCabecalhoDetalhesProcessoDigital;
    procedure TestarCabecalhoDetalhesProcessoFisico;
    procedure TestarCabecalhoDetalhesProcessoHibrido;
    procedure TestarCabecalhoDetalhesProcessoNaoDigital;

    //Novos testes para cobrir 100% da unit

    // Teste método ExecutarRegraAntesValidarProcesso
    procedure TestExecutarRegraAntesValidarProcessoComExcecaoPararExecucao;
    procedure TestExecutarRegraAntesValidarProcessoComExcecaoRegraNegocio;
    procedure TestExecutarRegraAntesValidarProcessoComExcecaoExcecaoGenerica;
    procedure TestExecutarRegraAntesValidarProcessoSemPermissaoTela;
    procedure TestarAlternarLotacaoUsuarioComPermissaoTela;

    procedure TestarTelaNaoTrabalhaComoCartorioUnico;
    procedure TestarTelaTrabalhaComoCartorioUnicoMasUsuarioNaoLotadoEmCartorio;
    procedure TestarSistemaHabilitadoParaNaoTrabalharComoCartorioUnico;
    procedure TestarAlternarLotacaoUsuarioSemPerguntarAoInformarProcessoLotacaoInvalida;
    procedure TestarAlternarLotacaoUsuarioMesmaLotacao;
    procedure TestarAlternarLotacaoUsuarioSemPermissaoTela;

    procedure TestarHintBotaoRefreshNumeroProcessoDepoisLimpar;
    procedure TestarQuantidadeDeImagensGlyphBotaoRefreshNumeroProcessoDepoisLimpar;
    procedure TestarComponenteProcessoVazio;
    procedure TestarNumeroPaginaInicialHibridoAtualizarPropriedadeProcessoTornadoDigital;
    procedure TestarFlProcVirtualAtualizarPropriedadeProcessoTornadoDigital;
    procedure TestarFlProcHibridoAtualizarPropriedadeProcessoTornadoDigital;
    procedure TestarNumeroPaginaInicialHibridoAtualizarPropriedadeProcessoComCPHCorrigida;
    procedure TestarFlProcVirtualAtualizarPropriedadeProcessoComCPHCorrigida;
    procedure TestarFlProcHibridoAtualizarPropriedadeProcessoComCPHCorrigida;

    //procedure TestarAlternarLotacaoUsuarioSemPerguntarAoInformarProcessoSemFuncaoAutorizada;
  end;

implementation

uses
  SysUtils, usajLotacao, uspExcecao;

const
  sHINT_NUM_PROCESSO_HIBRIDO = 'Processo Híbrido';
  sHINT_NUM_PROCESSO_DIGITAL = 'Processo Digital';
  sHINT_NUM_PROCESSO_FISICO = 'Processo Físico';

  sNUM_PROCESSO_MASCARADO = '0000093-17.2014.8.26.0666';

  sHINT_NUM_PROCESSO_REFRESH = 'Último número';
  nIMG_QTDE_IMAGENS = 4;

  nNOVAPAGINACPH = 10;

  sUSUARIO1 = 'SOFTPLAN';
  sUSUARIO2 = 'SAJ';

procedure TfpgNumeroProcessoRegrasTests.SetUp;
begin
  inherited;
  FoFormTeste := TspFormTeste.Create(nil); //PC_OK

  FoNumeroProcessoRegrasFake := TfpgNumeroProcessoRegrasFake.Create(FoFormTeste.FoNumProcessoTeste);
  //PC_OK

  // 03/06/2014 - cleber.gomes - SALT: 125791/1
  // Obs.: Garantir que não haverá controle criado pelo teste de interface.
  // TfpgRegrasCartorioUnicoFake.DestruirInstanciaControleCartorioUnico;

  // TfpgRegrasCartorioUnicoFake.CriarInstanciaControleCartorioUnico(null); //PC_OK

  // FoControleCartorioUnicoFake := TfpgRegrasCartorioUnicoFake(
  //   TfpgRegrasCartorioUnicoFake.PegarControleCartorioUnico);

  FoControleCartorioUnicoFake.AtualizarPropriedades(nil);

  FoControleLotacaoFake := TfpgRegrasLotacaoUnificadaFake.Create; //PC_OK
end;

procedure TfpgNumeroProcessoRegrasTests.TearDown;
begin
  inherited;

  FreeAndNil(FoFormTeste); //PC_OK
  LimparNumeroProcessoRegrasFake;
  FreeAndNil(FoControleLotacaoFake); //PC_OK

  // TfpgRegrasCartorioUnicoFake.DestruirInstanciaControleCartorioUnico;
end;

procedure TfpgNumeroProcessoRegrasTests.TestarCabecalhoDetalhesProcessoDigital;
begin
  FoFormTeste.FoNumProcessoTeste.prpFlagProcVirtual := sFLAG_SIM;
  FoFormTeste.FoNumProcessoTeste.prpFlagProcHibrido := sFLAG_NAO;

  FoNumeroProcessoRegrasFake.ExecutarRegraDepoisValidarProcesso;

  CheckTrue(sNUM_PROCESSO_MASCARADO + ' - ' + sHINT_NUM_PROCESSO_DIGITAL =
    FoNumeroProcessoRegrasFake.FormatarCabecalhoDetalhesDoProcesso);
end;

procedure TfpgNumeroProcessoRegrasTests.TestarCabecalhoDetalhesProcessoFisico;
begin
  FoFormTeste.FoNumProcessoTeste.prpFlagProcVirtual := sFLAG_NAO;
  FoFormTeste.FoNumProcessoTeste.prpFlagProcHibrido := sFLAG_NAO;

  FoNumeroProcessoRegrasFake.ExecutarRegraDepoisValidarProcesso;

  CheckTrue(sNUM_PROCESSO_MASCARADO + ' - ' + sHINT_NUM_PROCESSO_FISICO =
    FoNumeroProcessoRegrasFake.FormatarCabecalhoDetalhesDoProcesso);
end;

procedure TfpgNumeroProcessoRegrasTests.TestarCabecalhoDetalhesProcessoHibrido;
begin
  FoFormTeste.FoNumProcessoTeste.prpFlagProcVirtual := sFLAG_SIM;
  FoFormTeste.FoNumProcessoTeste.prpFlagProcHibrido := sFLAG_SIM;

  FoNumeroProcessoRegrasFake.ExecutarRegraDepoisValidarProcesso;

  CheckTrue(sNUM_PROCESSO_MASCARADO + ' - ' + sHINT_NUM_PROCESSO_HIBRIDO =
    FoNumeroProcessoRegrasFake.FormatarCabecalhoDetalhesDoProcesso);
end;

procedure TfpgNumeroProcessoRegrasTests.TestarCabecalhoDetalhesProcessoNaoDigital;
begin
  FoFormTeste.FoNumProcessoTeste.prpFlagProcVirtual := sFLAG_SIM;
  FoFormTeste.FoNumProcessoTeste.prpFlagProcHibrido := sFLAG_SIM;

  FoNumeroProcessoRegrasFake.ExecutarRegraDepoisValidarProcesso;

  CheckFalse(sNUM_PROCESSO_MASCARADO + ' - ' + sHINT_NUM_PROCESSO_DIGITAL =
    FoNumeroProcessoRegrasFake.FormatarCabecalhoDetalhesDoProcesso);
end;

procedure TfpgNumeroProcessoRegrasTests.TestarProcessoEhDigital;
begin
  FoFormTeste.FoNumProcessoTeste.prpFlagProcVirtual := sFLAG_SIM;
  FoFormTeste.FoNumProcessoTeste.prpFlagProcHibrido := sFLAG_NAO;

  FoNumeroProcessoRegrasFake.ExecutarRegraDepoisValidarProcesso;

  CheckTrue(FoFormTeste.FoNumProcessoTeste.FpbApresentarUltimoNumero.Hint =
    sHINT_NUM_PROCESSO_DIGITAL);
end;

procedure TfpgNumeroProcessoRegrasTests.TestarProcessoEhFisico;
begin
  FoFormTeste.FoNumProcessoTeste.prpFlagProcVirtual := sFLAG_NAO;
  FoFormTeste.FoNumProcessoTeste.prpFlagProcHibrido := sFLAG_NAO;

  FoNumeroProcessoRegrasFake.ExecutarRegraDepoisValidarProcesso;

  CheckTrue(FoFormTeste.FoNumProcessoTeste.FpbApresentarUltimoNumero.Hint =
    sHINT_NUM_PROCESSO_FISICO);
end;

procedure TfpgNumeroProcessoRegrasTests.TestarProcessoEhHibrido;
begin
  FoFormTeste.FoNumProcessoTeste.prpFlagProcVirtual := sFLAG_SIM;
  FoFormTeste.FoNumProcessoTeste.prpFlagProcHibrido := sFLAG_SIM;

  FoNumeroProcessoRegrasFake.ExecutarRegraDepoisValidarProcesso;

  CheckTrue(FoFormTeste.FoNumProcessoTeste.FpbApresentarUltimoNumero.Hint =
    sHINT_NUM_PROCESSO_HIBRIDO);
end;

procedure TfpgNumeroProcessoRegrasTests.TestarProcessoNaoEhDigital;
begin
  FoFormTeste.FoNumProcessoTeste.prpFlagProcVirtual := sFLAG_SIM;
  FoFormTeste.FoNumProcessoTeste.prpFlagProcHibrido := sFLAG_SIM;

  FoNumeroProcessoRegrasFake.ExecutarRegraDepoisValidarProcesso;

  CheckFalse(FoFormTeste.FoNumProcessoTeste.FpbApresentarUltimoNumero.Hint =
    sHINT_NUM_PROCESSO_DIGITAL);
end;

procedure TfpgNumeroProcessoRegrasTests.TestarHintBotaoRefreshNumeroProcessoDepoisLimpar;
begin
  FoNumeroProcessoRegrasFake.ExecutarRegraDepoisLimparProcesso;

  CheckEqualsString(sHINT_NUM_PROCESSO_REFRESH,
    FoFormTeste.FoNumProcessoTeste.FpbApresentarUltimoNumero.Hint);
end;

procedure TfpgNumeroProcessoRegrasTests.
TestarQuantidadeDeImagensGlyphBotaoRefreshNumeroProcessoDepoisLimpar;
begin
  FoNumeroProcessoRegrasFake.ExecutarRegraDepoisLimparProcesso;

  CheckEquals(nIMG_QTDE_IMAGENS, FoFormTeste.FoNumProcessoTeste.
    FpbApresentarUltimoNumero.NumGlyphs);
end;

procedure TfpgNumeroProcessoRegrasTests.TestarComponenteProcessoVazio;
begin
  FoFormTeste.FoNumProcessoTeste.prpFlagProcVirtual := STRING_INDEFINIDO;
  FoFormTeste.FoNumProcessoTeste.prpFlagProcHibrido := STRING_INDEFINIDO;

  FoNumeroProcessoRegrasFake.ExecutarRegraDepoisValidarProcesso;

  CheckEqualsString(sHINT_NUM_PROCESSO_REFRESH,
    FoFormTeste.FoNumProcessoTeste.FpbApresentarUltimoNumero.Hint);
end;

procedure TfpgNumeroProcessoRegrasTests.
TestarNumeroPaginaInicialHibridoAtualizarPropriedadeProcessoTornadoDigital;
begin
  FoNumeroProcessoRegrasFake.AtualizarPropriedadesMeioProcesso(0, True);
  CheckEquals(NUMERO_INDEFINIDO, FoFormTeste.FoNumProcessoTeste.prpNuPagInicialHibr);
end;

procedure TfpgNumeroProcessoRegrasTests.
TestarFlProcVirtualAtualizarPropriedadeProcessoTornadoDigital;
begin
  FoNumeroProcessoRegrasFake.AtualizarPropriedadesMeioProcesso(0, True);
  CheckEqualsString(sFLAG_SIM, FoFormTeste.FoNumProcessoTeste.prpFlagProcVirtual);
end;

procedure TfpgNumeroProcessoRegrasTests.
TestarFlProcHibridoAtualizarPropriedadeProcessoTornadoDigital;
begin
  FoNumeroProcessoRegrasFake.AtualizarPropriedadesMeioProcesso(0, True);
  CheckEqualsString(sFLAG_NAO, FoFormTeste.FoNumProcessoTeste.prpFlagProcHibrido);
end;

procedure TfpgNumeroProcessoRegrasTests.
TestarNumeroPaginaInicialHibridoAtualizarPropriedadeProcessoComCPHCorrigida;
begin
  FoNumeroProcessoRegrasFake.AtualizarPropriedadesMeioProcesso(nNOVAPAGINACPH, False);
  CheckEquals(nNOVAPAGINACPH, FoFormTeste.FoNumProcessoTeste.prpNuPagInicialHibr);
end;

procedure TfpgNumeroProcessoRegrasTests.
TestarFlProcVirtualAtualizarPropriedadeProcessoComCPHCorrigida;
begin
  FoNumeroProcessoRegrasFake.AtualizarPropriedadesMeioProcesso(nNOVAPAGINACPH, False);
  CheckEqualsString(sFLAG_NAO, FoFormTeste.FoNumProcessoTeste.prpFlagProcVirtual);
end;

procedure TfpgNumeroProcessoRegrasTests.
TestarFlProcHibridoAtualizarPropriedadeProcessoComCPHCorrigida;
begin
  FoNumeroProcessoRegrasFake.AtualizarPropriedadesMeioProcesso(nNOVAPAGINACPH, False);
  CheckEqualsString(sFLAG_SIM, FoFormTeste.FoNumProcessoTeste.prpFlagProcHibrido);
end;


procedure TfpgNumeroProcessoRegrasTests.TestarTelaNaoTrabalhaComoCartorioUnico;
begin
  FoNumeroProcessoRegrasFake.fpgTipoRegraLotacaoUnica := trcuNaoSeAplica;
  CheckFalse(FoNumeroProcessoRegrasFake.AlternarLotacaoCartorioPublico,
    'Teste para verificar que não será alterada a lotação com regra trcuNaoSeAplica');
end;

procedure TfpgNumeroProcessoRegrasTests.
TestarTelaTrabalhaComoCartorioUnicoMasUsuarioNaoLotadoEmCartorio;
begin
  FoNumeroProcessoRegrasFake.fpgTipoRegraLotacaoUnica := trcuTrocarLotacao;
  FoNumeroProcessoRegrasFake.FenTipoLotacao := tlVara;
  CheckFalse(FoNumeroProcessoRegrasFake.AlternarLotacaoCartorioPublico,
    'Teste para verificar que não será alterada a lotação com lotação diferente de cartorio');

end;

procedure TfpgNumeroProcessoRegrasTests.TestarSistemaHabilitadoParaNaoTrabalharComoCartorioUnico;
begin
  FoNumeroProcessoRegrasFake.fpgTipoRegraLotacaoUnica := trcuTrocarLotacao;
  FoNumeroProcessoRegrasFake.FenTipoLotacao := tlCartorio;

  // TfpgRegrasCartorioUnicoFake(TfpgRegrasCartorioUnicoFake.PegarControleCartorioUnico).
  //   DefinirUtilizaCartorioUnico(False);

  CheckFalse(FoNumeroProcessoRegrasFake.AlternarLotacaoCartorioPublico,
    'Teste para garantir que não será alternada a lotação para quando não trabalha com cartório único'
    );
end;

procedure TfpgNumeroProcessoRegrasTests.
TestarAlternarLotacaoUsuarioSemPerguntarAoInformarProcessoLotacaoInvalida;
begin
  FoNumeroProcessoRegrasFake.fpgTipoRegraLotacaoUnica := trcuTrocarLotacao;
  FoNumeroProcessoRegrasFake.FenTipoLotacao := tlCartorio;

  FoNumeroProcessoRegrasFake.FnNuSeqLotacao := NUMERO_INDEFINIDO;

  // TfpgRegrasCartorioUnicoFake(TfpgRegrasCartorioUnicoFake.PegarControleCartorioUnico).
  //   DefinirUtilizaCartorioUnico(True);

  CheckFalse(FoNumeroProcessoRegrasFake.AlternarLotacaoCartorioPublico,
    'Teste para garantir que a lotação não foi trocada quando utilizado um sequencial de lotação inválido.'
    );
end;

procedure TfpgNumeroProcessoRegrasTests.TestarAlternarLotacaoUsuarioMesmaLotacao;
const
  nCdForoValido = 23;
  nCdVaraValida = 5;
  nNuSeqLotacaoAtual = 44;
  sUsuarioValido = 'USUARIO3';
begin
  FoNumeroProcessoRegrasFake.FncdForo := nCdForoValido;
  FoNumeroProcessoRegrasFake.FncdVara := nCdVaraValida;

  FoControleCartorioUnicoFake.DefinirUtilizaCartorioUnico(True);
  FoControleCartorioUnicoFake.FnNuSeqLotacao := nNuSeqLotacaoAtual;

  FoNumeroProcessoRegrasFake.fpgTipoRegraLotacaoUnica := trcuTrocarLotacao;
  FoNumeroProcessoRegrasFake.FenTipoLotacao := tlCartorio;
  FoControleCartorioUnicoFake.FbRespostaUsuarioTrocaLotacao := True;
  TfpgRegrasLotacaoUnificadaFake(FoControleCartorioUnicoFake.prpControleLotacao)
    .FbUsuarioPossuiFuncaoAutorizada := True;
  FoControleCartorioUnicoFake.FsUsuario := 'USUARIO3';

  ExecutarRegraAntesValidarProcesso;

  Check(TfpgRegrasLotacaoUnificadaFake(
    FoControleCartorioUnicoFake.prpControleLotacao).fpgNuSeqLotacao = nNuSeqLotacaoAtual,
    'Teste para garantir que a lotação não foi trocada por ser o mesmo sequencial de lotacao.');
end;

procedure TfpgNumeroProcessoRegrasTests.TestarAlternarLotacaoUsuarioSemPermissaoTela;
const
  nCdForoValido = 23;
  nCdVaraValida = 1;
  nNuSeqLotacaoAtual = 2;
  sUsuarioValido = 'USUARIO3';
begin
  FoNumeroProcessoRegrasFake.FncdForo := nCdForoValido;
  FoNumeroProcessoRegrasFake.FncdVara := nCdVaraValida;

  FoControleCartorioUnicoFake.DefinirUtilizaCartorioUnico(True);
  FoControleCartorioUnicoFake.FnNuSeqLotacao := nNuSeqLotacaoAtual;

  FoNumeroProcessoRegrasFake.fpgTipoRegraLotacaoUnica := trcuTrocarLotacao;
  FoNumeroProcessoRegrasFake.FenTipoLotacao := tlCartorio;
  FoNumeroProcessoRegrasFake.FbTelaTemPermissao := False;
  FoControleCartorioUnicoFake.FbRespostaUsuarioTrocaLotacao := True;
  TfpgRegrasLotacaoUnificadaFake(FoControleCartorioUnicoFake.prpControleLotacao)
    .FbUsuarioPossuiFuncaoAutorizada := True;
  FoControleCartorioUnicoFake.FsUsuario := 'USUARIO3';

  CheckException(ExecutarRegraAntesValidarProcesso, Eabort,
    'Teste para verificar que a lotação será trocada porém será disparada exceção por o usuário não ter acesso a tela'
    );
end;

procedure TfpgNumeroProcessoRegrasTests.TestarAlternarLotacaoUsuarioComPermissaoTela;
const
  nCdForoValido = 23;
  nCdVaraValida = 1;
  nNuSeqLotacaoAposTrocarLotacao = 1;
  nNuSeqLotacaoAtual = 2;
  sUsuarioValido = 'USUARIO3';
begin
  FoNumeroProcessoRegrasFake.FncdForo := nCdForoValido;
  FoNumeroProcessoRegrasFake.FncdVara := nCdVaraValida;

  FoControleCartorioUnicoFake.DefinirUtilizaCartorioUnico(True);
  FoControleCartorioUnicoFake.FnNuSeqLotacao := nNuSeqLotacaoAtual;

  FoNumeroProcessoRegrasFake.fpgTipoRegraLotacaoUnica := trcuTrocarLotacao;
  FoNumeroProcessoRegrasFake.FenTipoLotacao := tlCartorio;
  FoNumeroProcessoRegrasFake.FbTelaTemPermissao := True;
  FoControleCartorioUnicoFake.FbRespostaUsuarioTrocaLotacao := True;
  TfpgRegrasLotacaoUnificadaFake(FoControleCartorioUnicoFake.prpControleLotacao)
    .FbUsuarioPossuiFuncaoAutorizada := True;
  FoControleCartorioUnicoFake.FsUsuario := 'USUARIO3';

  ExecutarRegraAntesValidarProcesso;

  Check(TfpgRegrasLotacaoUnificadaFake(
    FoControleCartorioUnicoFake.prpControleLotacao).fpgNuSeqLotacao =
    nNuSeqLotacaoAposTrocarLotacao,
    'Teste para garantir que a lotação foi trocada com sucesso.');
end;

procedure TfpgNumeroProcessoRegrasTests.
TestExecutarRegraAntesValidarProcessoComExcecaoExcecaoGenerica;
begin
  LimparNumeroProcessoRegrasFake;

  FoNumeroProcessoRegrasFake :=
    TfpgNumeroProcessoRegrasFakeAlternarLotacaoCartorioExcecaoGenerica.Create(nil); //PC_OK
  CheckException(ExecutarRegraAntesValidarProcesso, Exception,
    'Teste para verificar que não está escondendo exceção ao criar a regra de forma errada');
end;

procedure TfpgNumeroProcessoRegrasTests.
TestExecutarRegraAntesValidarProcessoComExcecaoPararExecucao;
begin
  LimparNumeroProcessoRegrasFake;

  FoNumeroProcessoRegrasFake :=
    TfpgNumeroProcessoRegrasFakeAlternarLotacaoCartorioExcecaoPararExecucao.Create(nil); //PC_OK
  CheckException(ExecutarRegraAntesValidarProcesso, Eabort,
    'Teste para garantir que será disparado um abort quando a exceção for do tipo PararExecucao');
end;

procedure TfpgNumeroProcessoRegrasTests.
TestExecutarRegraAntesValidarProcessoComExcecaoRegraNegocio;
begin
  LimparNumeroProcessoRegrasFake;

  FoNumeroProcessoRegrasFake :=
    TfpgNumeroProcessoRegrasFakeAlternarLotacaoCartorioExcecaoRegraNegocio.Create(nil); //PC_OK
  CheckException(ExecutarRegraAntesValidarProcesso, EspRegraNegocio,
    'Teste para verificar que não está escondendo exceção ao criar a regra de forma errada');
end;

procedure TfpgNumeroProcessoRegrasTests.TestExecutarRegraAntesValidarProcessoSemPermissaoTela;
begin
  LimparNumeroProcessoRegrasFake;

  FoNumeroProcessoRegrasFake :=
    TfpgNumeroProcessoRegrasFakeAlternarLotacaoCartorioExcecaoSemPermissao.Create(nil); //PC_OK
  CheckException(ExecutarRegraAntesValidarProcesso, Eabort,
    'Teste para verificar que é disparado exceção quando usuário não tem permissão para acessar a tela na lotação corrente'
    );
end;

procedure TfpgNumeroProcessoRegrasTests.LimparNumeroProcessoRegrasFake;
begin
  if Assigned(FoNumeroProcessoRegrasFake) then
    FreeAndNil(FoNumeroProcessoRegrasFake); //PC_OK
end;

procedure TfpgNumeroProcessoRegrasTests.ExecutarRegraAntesValidarProcesso;
begin
  FoNumeroProcessoRegrasFake.ExecutarRegraAntesValidarProcesso(STRING_INDEFINIDO);
end;

{ TspFormTeste }

constructor TspFormTeste.Create(oDono: TComponent);
begin
  inherited;
  FoNumProcessoTeste := TfpgNumeroProcessoFake.Create(nil); //PC_OK
end;

destructor TspFormTeste.Destroy;
begin
  FreeAndNil(FoNumProcessoTeste); //PC_OK
  inherited;
end;

initialization
  TestFramework.RegisterTest('Unitário\PG5\Componentes\ufpgNumeroProcessoRegrasTests',
    TfpgNumeroProcessoRegrasTests.Suite);

end.
