unit ufpgConsSenhaProcessoTests;

interface

uses
  ufpgGUITestCase, ufpgConsSenhaProcessoModelTests, ufpgConsSenhaProcesso,
  ufpgDataModelTests, FutureWindows, ufpgRelOficioSenhaProc;

var
  sCdProcesso: string;
  sNomeCompleto: string;

const
  CS_CADASTRO_SENHA = 'senha';
  CS_IMPRESSAO = 'Impressão';
  CS_IMPRESSAO_PARA_BANCO = 'Impressão de ofício para ';
  CS_EMAIL = 'e-mail';

type
  TffpgConsSenhaProcessoTests = class(TfpgGUITestCase)
  private
    FoTela: TffpgConsSenhaProcesso;
    FoDados: TffpgConsSenhaProcessoModelTests;
    procedure GeracaoDeSenhaProcessoOutros;
    procedure GerarSenha;
    procedure PreencherDados;
    procedure SelecionarProcesso(const poWindow: IWindow);
    function VerificarHistorico(psHistorico: string): boolean;
    procedure ImprimirOficio;
    procedure EnviarEmail;
    procedure VerificarSenhaGerada(FoTelaOficio: TffpgRelOficioSenhaProc);

  public
    function PegarClasseModelTests: TfpgDataModelTestsClass; override;
  published
    procedure TestarGeracaoDeSenhaProcessoOutros_1_4_21;
  end;

implementation

uses
  Windows, Forms, Classes, ufpgFuncoesGuiTestes, uspSendKeys, usajConstante,
  SysUtils, uspInterface, ufpgRelHistSenhaProcesso, usajSelecionaOutroNumero,
  StrUtils, ufpgConsEMailParte, ufpgVariaveisTestesGUI;

{ TffpgConsSenhaProcessoTests }

function TffpgConsSenhaProcessoTests.PegarClasseModelTests: TfpgDataModelTestsClass;
begin
  result := TffpgConsSenhaProcessoModelTests;
end;

procedure TffpgConsSenhaProcessoTests.TestarGeracaoDeSenhaProcessoOutros_1_4_21;
begin
  ExecutarRoteiroTestes(GeracaoDeSenhaProcessoOutros);
end;

procedure TffpgConsSenhaProcessoTests.GeracaoDeSenhaProcessoOutros;
begin
  AbrirTela;
  FoTela := TffpgConsSenhaProcesso(spTela);
  FoDados := TffpgConsSenhaProcessoModelTests(spDataModelTests);

  PreencherDados;

  if FoDados.fpgGerarSenha then
    GerarSenha;

  if FoDados.fpgImpressaoOficio then
    ImprimirOficio;

  if FoDados.fpgEnviarEmail then
    EnviarEmail;
end;

procedure TffpgConsSenhaProcessoTests.SelecionarProcesso(const poWindow: IWindow);
var
  FoTelaOutroNumero: TfsajSelecionaOutroNumero;
begin
  FoTelaOutroNumero := poWindow.asControl as TfsajSelecionaOutroNumero;
  FoTelaOutroNumero.ccCadastro.Execute(acSelecionar);
end;

procedure TffpgConsSenhaProcessoTests.GerarSenha;
begin
  FoTela.pbGeraSenha.Click;
  FoTela.dxbbBotoesSalvar.Click;
  sleep(1000);
  Application.ProcessMessages;

  gsSenhaProcesso := FoTela.grDados.DataSource.DataSet.FieldByName('CC_MASCARASENHA').AsString;
  Check(FoTela.grDados.DataSource.DataSet.FieldByName('CC_MASCARASENHA').AsString
    <> STRING_INDEFINIDO, 'A senha não foi gerada.');

  if FoDados.fpgVerificarHistorico then
  begin

    Check(VerificarHistorico(CS_CADASTRO_SENHA),
      'A geração de senha não foi encontrada na grid de Histórico de Senha do Processo.');

    Check(FoDados.VerificarSenhaGerada(sCdProcesso, sNomeCompleto),
      'A senha não foi gerada no banco de dados.');
  end;
end;

procedure TffpgConsSenhaProcessoTests.PreencherDados;
var
  nNomeComplemento: integer;
begin
  nNomeComplemento := 1;
  if (FoDados.fpgNuProcesso = STRING_INDEFINIDO) then
  begin
    FoDados.fpgNuProcesso := usarProcessoArray;
  end;

  checkTrue(FoDados.fpgNuProcesso <> STRING_INDEFINIDO,
    'Número de Processo principal não encontrado');


  if FoDados.fpgPreencherOutroNumero then
  begin
    TFutureWindows.Expect('TfsajSelecionaOutroNumero').ExecProc(SelecionarProcesso);
    FoTela.sajNumeroProcesso.FdfOutroNumero.SetFocus;
    FoTela.sajNumeroProcesso.FdfOutroNumero.DefineTexto(FoDados.fpgOutroNumero);
    Tab;
  end
  else
    EnterTextInto(FoTela.sajNumeroProcesso.FdfNumeroProcessoExterno, FoDados.fpgNuProcesso);

  check(not FoTela.sajNumeroProcesso.FdfNumeroProcessoExterno.EstaNulo,
    'O processo não foi encontrado');

  sCdProcesso := FoTela.sajNumeroProcesso.prpCdProcesso;

  if True then //FoDados.fpgSelecionarPessoa
  begin
    FoTela.grDados.DataSource.DataSet.Locate('NMOUTROINTERESSADO', 'Justiça Pública', []);
    sNomeCompleto := 'Justiça Pública';  //FoDados.fpgNmParte
  end
  else
  begin
    Randomize;
    nNomeComplemento := Random(999999999);
    sNomeCompleto := FoDados.fpgNmParte + IntToStr(nNomeComplemento);
    FoTela.ccCadastro.Execute(acNovo);
    FoTela.grDados.SelectedIndex := 0;
    EnviarTeclas(FoTela.grDados, '(%{DOWN})' + FoDados.fpgTipoParte + '{ENTER}{TAB}');
    Application.ProcessMessages;
    EnterTextGrid(FoTela.grDados, sNomeCompleto, 1);
    Application.ProcessMessages;
  end;
end;

function TffpgConsSenhaProcessoTests.VerificarHistorico(psHistorico: string): boolean;
var
  FoTelaHistorico: TffpgRelHistSenhaProcesso;
  bEncontrou: boolean;
  steste: string;
begin
  bEncontrou := False;
  FoTela.pbHistoricoOperacoes.Click;
  FoTelaHistorico := PegarTela('ffpgRelHistSenhaProcesso') as TffpgRelHistSenhaProcesso;
  FoTelaHistorico.grDados.DataSource.DataSet.First;
  while not FoTelaHistorico.grDados.DataSource.DataSet.EOF do
  begin
    steste := FoTelaHistorico.grDados.DataSource.DataSet.FieldByName('deOperacao').AsString;
    bEncontrou := (Pos(sNomeCompleto, steste) > 0) and (Pos(psHistorico, steste) > 0);
    if bEncontrou then
      Break;
    FoTelaHistorico.grDados.DataSource.DataSet.Next;
  end;
  result := bEncontrou;
end;

procedure TffpgConsSenhaProcessoTests.ImprimirOficio;
var
  FoTelaOficioSenhaProc: TffpgRelOficioSenhaProc;
begin
  FoTela.pbImprimeOficio.Click;
  FoTelaOficioSenhaProc := PegarTela('ffpgRelOficioSenhaProc') as TffpgRelOficioSenhaProc;
  if FoDados.fpgImprimirOficioParaTodos then
  begin
    FoTelaOficioSenhaProc.spDBGrid.DataSource.DataSet.First;
    FoTelaOficioSenhaProc.spDBGrid.DataSource.DataSet.Edit;
    while not FoTelaOficioSenhaProc.spDBGrid.DataSource.DataSet.EOF do
    begin
      FoTelaOficioSenhaProc.spDBGrid.DataSource.DataSet.FieldByName('CC_SEL').AsString := 'S';
      FoTelaOficioSenhaProc.spDBGrid.DataSource.DataSet.Next;
    end;
    FoTelaOficioSenhaProc.spDBGrid.DataSource.DataSet.Post;
  end
  else
  begin
    FoTelaOficioSenhaProc.spDBGrid.DataSource.DataSet.Locate('NMOUTROINTERESSADO',
      sNomeCompleto, []);
    FoTelaOficioSenhaProc.spDBGrid.DataSource.DataSet.Edit;
    FoTelaOficioSenhaProc.spDBGrid.DataSource.DataSet.FieldByName('CC_SEL').AsString := 'S';
    FoTelaOficioSenhaProc.spDBGrid.DataSource.DataSet.Post;
  end;
  FoTelaOficioSenhaProc.pbImprimir.Click;
  Check(VerificarHistorico(CS_IMPRESSAO), 'O ofício não foi impresso.');
  Check(FoDados.VerificarOficioImpresso(CS_IMPRESSAO_PARA_BANCO + sNomeCompleto),
    'Impressão do ofício não foi gravada no banco de dados.');
  VerificarSenhaGerada(FoTelaOficioSenhaProc);
end;

procedure TffpgConsSenhaProcessoTests.EnviarEmail;
var
  FoTelaEnviarEmail: TffpgConsEMailParte;
begin
  FoTela.pbEnvieEmail.Click;
  FoTelaEnviarEmail := PegarTela('ffpgConsEMailParte') as TffpgConsEMailParte;
  if FoDados.fpgEnviarEmaiParaTodos then
  begin
    FoTelaEnviarEmail.spDBGrid.DataSource.DataSet.First;
    FoTelaEnviarEmail.spDBGrid.DataSource.DataSet.Edit;
    while not FoTelaEnviarEmail.spDBGrid.DataSource.DataSet.EOF do
    begin
      FoTelaEnviarEmail.spDBGrid.DataSource.DataSet.FieldByName('CC_SEL').AsString := 'S';
      EnterTextGrid(FoTelaEnviarEmail.spDBGrid, FoDados.fpgEmail, 2);
      FoTelaEnviarEmail.spDBGrid.DataSource.DataSet.Next;
    end;
    FoTelaEnviarEmail.spDBGrid.DataSource.DataSet.Post;
  end
  else
  begin
    FoTelaEnviarEmail.spDBGrid.DataSource.DataSet.Locate('CC_NMPESSOA', sNomeCompleto, []);
    FoTelaEnviarEmail.spDBGrid.DataSource.DataSet.Edit;
    FoTelaEnviarEmail.spDBGrid.DataSource.DataSet.FieldByName('CC_SEL').AsString := 'S';
    EnterTextGrid(FoTelaEnviarEmail.spDBGrid, FoDados.fpgEmail, 2);
    FoTelaEnviarEmail.spDBGrid.DataSource.DataSet.Post;
  end;
  spVerificadorTelas.RegistrarMensagem('E-mail enviado com sucesso.', 'OK');
  FoTelaEnviarEmail.dxbbBotoesSelecionar.Click;
  Check(VerificarHistorico(CS_EMAIL), 'E-mail não enviado');
  Check(FoDados.VerificarEmailEnviado(sNomeCompleto), 'Envio de e-mail não cadastrado no banco.');
end;

procedure TffpgConsSenhaProcessoTests.VerificarSenhaGerada(FoTelaOficio: TffpgRelOficioSenhaProc);
var
  sNuSeqSenha, sCdProcesso, sSenha: string;
begin
  sNuSeqSenha := FoTelaOficio.efpgSenhaProcesso.FieldByName('nuSeqSenha').AsString;
  sCdProcesso := FoTelaOficio.efpgSenhaProcesso.FieldByName('cdProcesso').AsString;
  sSenha := FoTelaOficio.efpgSenhaProcesso.FieldByName('nmSenha').AsString;
  Check(FoDados.RetornarSenhaProcesso(sCdProcesso, sNuSeqSenha) = sSenha,
    'A senha não foi gerada.');
end;

end.

