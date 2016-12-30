// 21/12/2015 - cesar.almeida - SALT: 186660/23/2
// Refatoração da classe
unit ufpgCadEntranhamentoTests;

interface

uses
  ufpgGUITestCase, ufpgDataModelTests, ufpgCadEntranhamentoModelTests, ufpgCadEntranhamento;

type
  TffpgCadEntranhamentoTests = class(TfpgGUITestCase)
  private
    FoTela: TffpgCadEntranhamento;
    FoDados: TffpgCadEntranhamentoModelTests;
    procedure CadastrarEntranhamento;
    procedure DesentranharProcesssos;
    procedure PreencherDadosEntranhamento;
    procedure PreencherDadosDesentranhamento;
  public
    function PegarClasseModelTests: TfpgDataModelTestsClass; override;
    procedure TearDown; override;
  published
    procedure TestarCadastroEntranhamento;
    procedure TestarCadastroDesentranhamento;
  end;

implementation

uses
  TestFramework, uspInterface, SysUtils, Forms, usajConstante, ufpgVariaveisTestesGUI,
  ufpgConstanteGUITests, FutureWindows, ufpgFuncoesGUITestes;

var
  sCdProcessoPrincipal: string;
  sCdProcessoEntranhar: string;

const
  CS_ENTRANHAMENTO = 'PA.DTAPENSAMENTO';
  CS_DESENTRANHAMENTO = 'PA.DTDESAPENSAMENTO';

{ ufpgCadEntranhamentoTests }

procedure TffpgCadEntranhamentoTests.CadastrarEntranhamento;
begin
  AbrirTela;
  FoTela := TffpgCadEntranhamento(spTela);
  FoDados := TffpgCadEntranhamentoModelTests(spDataModelTests);

  PreencherDadosEntranhamento;

  FoTela.ccCadastro.Execute(acSalvar);

  //    check(FoDados.Verificar(FoDados.fpgCDTipoMVProcesso, CS_ENTRANHAMENTO,
  //      sCdProcessoPrincipal, sCdProcessoEntranhar), 'Os Processos não foram entranhados')
end;

function TffpgCadEntranhamentoTests.PegarClasseModelTests: TfpgDataModelTestsClass;
begin
  result := TffpgCadEntranhamentoModelTests;
end;

procedure TffpgCadEntranhamentoTests.TestarCadastroEntranhamento;
begin
  ExecutarRoteiroTestes(CadastrarEntranhamento);
end;

procedure TffpgCadEntranhamentoTests.PreencherDadosEntranhamento;
begin
  if (FoDados.fpgNuProcesso = STRING_INDEFINIDO) or
    (FoDados.fpgNuProcessoApensar = STRING_INDEFINIDO) then
  begin
    FoDados.fpgNuProcesso := usarProcessoArray;
    checkTrue(FoDados.fpgNuProcesso <> STRING_INDEFINIDO,
      'Número de Processo principal não encontrado');
    FoDados.fpgNuProcessoApensar := usarProcessoArray;
    checkTrue(FoDados.fpgNuProcessoApensar <> STRING_INDEFINIDO,
      'Número de Processo para entranhar não foi encontrado');
  end;

  TFutureWindows.Expect('TfsajAssistente', 1000).ExecCloseWindow;
  EnterTextInto(FoTela.dfNuProcesso.FdfNumeroProcessoExterno, FoDados.fpgNuProcesso, False);

  TFutureWindows.Expect('TfsajAssistente', 1000).ExecCloseWindow;
  EnterTextInto(FoTela.dfNuProcessoApenso.FdfNumeroProcessoExterno,
    FoDados.fpgNuProcessoApensar, False);

  sCdProcessoPrincipal := FoTela.dfNuProcesso.prpCdProcesso;
  sCdProcessoEntranhar := FoTela.dfNuProcessoApenso.prpCdProcesso;
end;

procedure TffpgCadEntranhamentoTests.DesentranharProcesssos;
begin
  AbrirTela;
  FoTela := TffpgCadEntranhamento(spTela);
  FoDados := TffpgCadEntranhamentoModelTests(spDataModelTests);

  PreencherDadosDesentranhamento;

  FoTela.ccCadastro.Execute(acSalvar);
  //    check(FoDados.Verificar(FoDados.fpgCDTipoMVProcesso, CS_DESENTRANHAMENTO,
  //      sCdProcessoPrincipal, sCdProcessoEntranhar), 'Os Processos não foram Desentranhados');
end;


procedure TffpgCadEntranhamentoTests.TestarCadastroDesentranhamento;
begin
  ExecutarRoteiroTestes(DesentranharProcesssos);
end;

procedure TffpgCadEntranhamentoTests.PreencherDadosDesentranhamento;
begin
  if (FoDados.fpgNuProcesso = STRING_INDEFINIDO) or
    (FoDados.fpgNuProcessoApensar = STRING_INDEFINIDO) then
  begin
    FoDados.fpgNuProcesso := usarProcessoArray;
    checkTrue(FoDados.fpgNuProcesso <> STRING_INDEFINIDO,
      'Número de Processo principal não encontrado');
    FoDados.fpgNuProcessoApensar := usarProcessoArray;
  end;

  TFutureWindows.Expect('TfsajAssistente', 1000).ExecCloseWindow;
  EnterTextInto(FoTela.dfNuProcesso.FdfNumeroProcessoExterno, FoDados.fpgNuProcesso, False);

  FoTela.tvRegistros.Items.Item[0].Selected := True;
  FoTela.tvRegistrosChange(FoTela.tvRegistros, FoTela.tvRegistros.Selected);

  EnterTextInto(FoTela.dfdtDesapensamento, FormatDateTime(CS_MASCARA_DATA_CURTA, Now), False);
  FoTela.efpgProcessoApenso.Edit;
  FoTela.efpgProcessoApenso.FieldByName('dtDesapensamento').AsString :=
    FormatDateTime(CS_MASCARA_DATA_CURTA, Now);
  FoTela.efpgProcessoApenso.Post;  
end;

procedure TffpgCadEntranhamentoTests.TearDown;
begin
  FecharTela;
  inherited;
end;

end.

