unit ufpgCadPecTests;

interface

uses
  ufpgCadPec, ufpgGUITestCase, ufpgCadPecModelTests, ufpgDataModelTests;

type
  TffpgCadPecTests = class(TfpgGUITestCase)
  private
    FoTela: TffpgCadPec;
    FoDados: TffpgCadPecModelTests;
    procedure CadastrarPec;
    procedure PreencherDadosPec;
    procedure DistribuirPec;
  protected
    function PegarClasseModelTests: TfpgDataModelTestsClass; override;
  published
    procedure TestarCadastroDoPEC;
  end;

implementation

uses
  uspInterface, TestFrameWork, ufpgFuncoesGUITestes, usajConstante, Forms,
  SysUtils, ufpgVariaveisTestesGUI;

var
  FsCdProcesso: string;

function TffpgCadPecTests.PegarClasseModelTests: TfpgDataModelTestsClass;
begin
  result := TffpgCadPecModelTests;
end;

procedure TffpgCadPecTests.CadastrarPec;
var
  sMsgConfirmacao, sMsgBanco: string;
begin
  AbrirTela;
  FoTela := TffpgCadPec(spTela);
  FoDados := TffpgCadPecModelTests(spDataModelTests);

  if FoDados.fpgNuProcesso = STRING_INDEFINIDO then
    FoDados.fpgNuProcesso := usarProcessoArray;
  check(FoDados.fpgNuProcesso <> STRING_INDEFINIDO, 'N�mero de processo n�o encontrado.');

  PreencherDadosPec;

  FoTela.ccCadastro.Execute(AcNovo);

  DistribuirPec;

  gsNuPec := FoTela.npPec.PegaTextoMascarado;
  spVerificadorTelas.RegistrarMensagem('O P.E.C. n�mero *', 'N�o');
  FoTela.ccCadastro.Execute(AcSalvar);

  sMsgConfirmacao := 'PEC criado: ' + gsNuPec + ' Usu�rio: ' + FoDados.spUsuario;

  FecharTela;
  sMsgBanco := FoDados.VerificarPecCadastrado(FsCdProcesso);
  Check(StringReplace(sMsgBanco, ''#$D'', ' ', [rfReplaceAll]) = sMsgConfirmacao,
    'N�o foi possivel cadastrar o P.E.C');
end;

procedure TffpgCadPecTests.TestarCadastroDoPEC;
begin
  ExecutarRoteiroTestes(CadastrarPec);
end;

procedure TffpgCadPecTests.PreencherDadosPec;
begin
  EnterTextInto(FoTela.npOrigem.FdfNumeroProcessoExterno, FoDados.fpgNuProcesso);
  Application.ProcessMessages;
  FsCdProcesso := FoTela.npOrigem.prpCdProcesso;
  EnterTextInto(FoTela.saj5TipoCartorioCons.dfCdTipoCartorio, FoDados.fpgCdCompetencia);
  EnterTextInto(FoTela.csClasse.dfCodigo, FoDados.fpgCdClasse);
  EnterTextInto(FoTela.csAssunto.dfCodigo, FoDados.fpgCdAssunto);
  EnterTextInto(FoTela.dfQtdeDoctos, FoDados.fpgQtdeDoctos);
end;

procedure TffpgCadPecTests.DistribuirPec;
begin
  EnterTextInto(FoTela.cbTipoDistribuicao, FoDados.fpgTipoDistribuicao, False);
  EnterTextInto(FoTela.csVaraDistribuicao.dfcdVara, FoDados.fpgCdVara);
  EnterTextInto(FoTela.mbMotivo.spMemo, FoDados.fpgMotivo);
end;

end.

